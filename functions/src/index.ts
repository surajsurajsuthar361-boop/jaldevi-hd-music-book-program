import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

admin.initializeApp();

const db = admin.firestore();
const bucket = admin.storage().bucket();

export const downloadApk = functions.https.onRequest(async (req, res) => {
  const userAgent = req.headers["user-agent"]?.toLowerCase() || "";
  const isAndroid = userAgent.includes("android");

  const doc = await db.collection("apk").doc("latest").get();
  const data = doc.data();

  if (!data || !data.downloadEnabled) {
    res.status(403).send("Downloads are currently disabled.");
    return;
  }

  await db.collection("apk").doc("latest").update({
    downloadCount: admin.firestore.FieldValue.increment(1),
  });

  const file = bucket.file("apks/latest.apk");
  const [url] = await file.getSignedUrl({
    action: "read",
    expires: Date.now() + 1000 * 60 * 60, // 1 hour
  });

  if (isAndroid) {
    res.redirect(url);
  } else {
    res.send(`
      <html>
        <body>
          <h1>JALDEVI HD MUSIC BOOK PROGRAM</h1>
          <p>Click the button to download the APK.</p>
          <a href="${url}" download>Download APK</a>
          <hr>
          <h2>Installation Instructions</h2>
          <ol>
            <li>Download the APK.</li>
            <li>You may need to enable "Install unknown apps" in your phone's settings.</li>
            <li>Install the application.</li>
            <li>Open JALDEVI HD MUSIC BOOK PROGRAM from your app drawer.</li>
          </ol>
        </body>
      </html>
    `);
  }
});

export const getDownloadUrl = functions.https.onCall(async (data, context) => {
  if (!context.auth) {
    throw new functions.https.HttpsError(
      "unauthenticated",
      "Only authenticated users can get the download URL."
    );
  }

  const doc = await db.collection("apk").doc("latest").get();
  const docData = doc.data();

  return { downloadUrl: docData?.downloadUrl };
});

export const regenerateDownloadUrl = functions.https.onCall(
  async (data, context) => {
    if (!context.auth) {
      throw new functions.https.HttpsError(
        "unauthenticated",
        "Only authenticated users can regenerate the download URL."
      );
    }

    const newDownloadUrl = `https://${process.env.GCLOUD_PROJECT}.web.app/download?key=${db.collection("apk").doc().id}`;

    await db.collection("apk").doc("latest").set(
      {
        downloadUrl: newDownloadUrl,
      },
      { merge: true }
    );

    return { newDownloadUrl };
  }
);
