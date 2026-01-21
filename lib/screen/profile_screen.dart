import 'package:flutter/material.dart';
import 'package:homework3/screen/setting_screen.dart';
import '../osama_router_manager.dart';
import '../routes/app_routes.dart';

class ProfileScreen extends StatelessWidget {
  final int? age_2;
  final String? name_2;
  const ProfileScreen({super.key, this.age_2, this.name_2});

  @override
  Widget build(BuildContext context) {
    final displayName = name_2 ?? 'لم نستخدم ال normal route';
    final displayAge = age_2 ?? 0;

    final args = ModalRoute.of(context)?.settings.arguments as Map?;
    final name = args?['name'] ?? 'لم نستخدم ال named route';
    final age = args?['age'] ?? 'لم نستخدم ال named route';

    return Scaffold(
      appBar: AppBar(title: const Text("Profile Screen")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Normal Route Data:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text('Name: $displayName\nAge: $displayAge'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                osamaRouterManager.go(const SettingsScreen());
              },
              child: const Text('Go to Settings (Normal Route)'),
            ),

            const SizedBox(height: 24),
            const Text(
              'Named Route Data:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text('Name: $name\nAge: $age'),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                osamaRouterManager.goNamed(AppRoutes.settings);
              },
              child: const Text('Go to Settings (Named Route)'),
            ),

            const SizedBox(height: 24),
            Container(
              width: double.infinity,
              color: Colors.grey[200],
              padding: const EdgeInsets.all(8),
              child: const Text(
                "osamaRouterManager.goReplace(SettingsScreen())",
                style: TextStyle(fontFamily: 'monospace'),
              ),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                osamaRouterManager.goReplac(const SettingsScreen());
              },
              child: const Text('Go Replace (Normal Route)'),
            ),

            const SizedBox(height: 24),
            Container(
              width: double.infinity,
              color: Colors.grey[200],
              padding: const EdgeInsets.all(8),
              child: const Text(
                "osamaRouterManager.goReplaceNamed(AppRoutes.settings)",
                style: TextStyle(fontFamily: 'monospace'),
              ),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                osamaRouterManager.goReplaceNamed(AppRoutes.settings);
              },
              child: const Text('Go Replace Named'),
            ),

            const SizedBox(height: 24),
            Container(
              width: double.infinity,
              color: Colors.grey[200],
              padding: const EdgeInsets.all(8),
              child: const Text(
                "osamaRouterManager.goRemoveUntil(SettingsScreen())",
                style: TextStyle(fontFamily: 'monospace'),
              ),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                osamaRouterManager.goAndRemoveUntil(const SettingsScreen());
              },
              child: const Text('Go Remove Until (Normal Route)'),
            ),

            const SizedBox(height: 24),
            Container(
              width: double.infinity,
              color: Colors.grey[200],
              padding: const EdgeInsets.all(8),
              child: const Text(
                "osamaRouterManager.goNamedAndRemoveUntil(AppRoutes.home)",
                style: TextStyle(fontFamily: 'monospace'),
              ),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                osamaRouterManager.goNamedAndRemoveUntil(AppRoutes.home);
              },
              child: const Text('Go Named And Remove Until'),
            ),

            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => osamaRouterManager.back(),
              child: const Text('Back to Previous Screen'),
            ),
          ],
        ),
      ),
    );
  }
}
