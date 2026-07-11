import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_functions/firebase_functions.dart';

class FirebaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFunctions _functions = FirebaseFunctions.instance;

  Future<void> uploadApk() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['apk'],
    );

    if (result != null) {
      final fileBytes = result.files.first.bytes;
      final fileName = 'latest.apk';

      await _storage.ref('apks/$fileName').putData(fileBytes!);
    } else {
      throw Exception("No file selected.");
    }
  }

  Future<String?> getDownloadUrl() async {
    try {
      final HttpsCallable callable = _functions.httpsCallable('getDownloadUrl');
      final result = await callable.call();
      return result.data['downloadUrl'];
    } catch (e) {
      print("Error getting download URL: $e");
      return null;
    }
  }

  Future<String?> regenerateDownloadUrl() async {
    try {
      final HttpsCallable callable = _functions.httpsCallable('regenerateDownloadUrl');
      final result = await callable.call();
      return result.data['newDownloadUrl'];
    } catch (e) {
      print("Error regenerating download URL: $e");
      return null;
    }
  }

  Future<Map<String, dynamic>?> getApkData() async {
    final doc = await _db.collection('apk').doc('latest').get();
    return doc.data();
  }

  Future<void> setDownloadStatus(bool enabled) async {
    await _db.collection('apk').doc('latest').set(
      {
        'downloadEnabled': enabled,
      },
      SetOptions(merge: true),
    );
  }
}
