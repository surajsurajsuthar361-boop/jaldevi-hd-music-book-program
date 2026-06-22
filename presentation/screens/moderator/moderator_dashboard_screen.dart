import 'package:flutter/material.dart';

class ModeratorDashboardScreen extends StatelessWidget {
  const ModeratorDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Moderator Dashboard'),
      ),
      body: const Center(
        child: Text('Moderator Dashboard Screen'),
      ),
    );
  }
}
