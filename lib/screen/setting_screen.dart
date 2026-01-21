import 'package:flutter/material.dart';
import '../osama_router_manager.dart';
import '../routes/app_routes.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings Screen')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              'Settings Screen',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const SizedBox(height: 24),
            Container(
              width: double.infinity,
              color: Colors.grey[200],
              padding: const EdgeInsets.all(8),
              child: const Text(
                "osamaRouterManager.goNamed(AppRoutes.home)",
                style: TextStyle(fontFamily: 'monospace'),
              ),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () => osamaRouterManager.goNamed(AppRoutes.home),
              child: const Text('Go to Home (Named Route)'),
            ),

            const SizedBox(height: 24),
            Container(
              width: double.infinity,
              color: Colors.grey[200],
              padding: const EdgeInsets.all(8),
              child: const Text(
                "osamaRouterManager.backTimes(2)",
                style: TextStyle(fontFamily: 'monospace'),
              ),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () => osamaRouterManager.backTimes(2),
              child: const Text('Go back two screens'),
            ),

            Container(
              width: double.infinity,
              color: Colors.grey[200],
              padding: const EdgeInsets.all(8),
              child: const Text(
                "osamaRouterManager.backTimes(1)",
                style: TextStyle(fontFamily: 'monospace'),
              ),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () => osamaRouterManager.backTimes(1),
              child: const Text('Go back one screen'),
            ),
          ],
        ),
      ),
    );
  }
}
