import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:admin_panel/services/firebase_service.dart';

class AdminDashboard extends StatefulWidget {
  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  final FirebaseService _firebaseService = FirebaseService();
  String? _downloadUrl;
  int _downloadCount = 0;
  bool _downloadEnabled = true;
  bool _isUploading = false;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final url = await _firebaseService.getDownloadUrl();
    final data = await _firebaseService.getApkData();
    setState(() {
      _downloadUrl = url;
      _downloadCount = data?['downloadCount'] ?? 0;
      _downloadEnabled = data?['downloadEnabled'] ?? true;
    });
  }

  Future<void> _uploadApk() async {
    setState(() {
      _isUploading = true;
    });
    try {
      await _firebaseService.uploadApk();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("APK uploaded successfully!"),
      ));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Failed to upload APK: $e"),
      ));
    }
    setState(() {
      _isUploading = false;
    });
  }

  Future<void> _regenerateUrl() async {
    final newUrl = await _firebaseService.regenerateDownloadUrl();
    setState(() {
      _downloadUrl = newUrl;
    });
  }

  Future<void> _toggleDownloads(bool enabled) async {
    await _firebaseService.setDownloadStatus(enabled);
    setState(() {
      _downloadEnabled = enabled;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Admin Dashboard"),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () => FirebaseAuth.instance.signOut(),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("APK Management", style: Theme.of(context).textTheme.displayMedium),
            SizedBox(height: 20),
            _isUploading
                ? CircularProgressIndicator()
                : ElevatedButton.icon(
                    onPressed: _uploadApk,
                    icon: Icon(Icons.upload_file),
                    label: Text("Upload New APK"),
                  ),
            SizedBox(height: 20),
            Text("Download Link", style: Theme.of(context).textTheme.displayMedium),
            SizedBox(height: 10),
            SelectableText(_downloadUrl ?? "Loading..."),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _regenerateUrl,
              child: Text("Regenerate Link"),
            ),
            SizedBox(height: 20),
            Text("Statistics", style: Theme.of(context).textTheme.displayMedium),
            SizedBox(height: 10),
            Text("Download Count: $_downloadCount"),
            SizedBox(height: 20),
            Text("Settings", style: Theme.of(context).textTheme.displayMedium),
            SwitchListTile(
              title: Text("Enable Downloads"),
              value: _downloadEnabled,
              onChanged: _toggleDownloads,
            ),
          ],
        ),
      ),
    );
  }
}
