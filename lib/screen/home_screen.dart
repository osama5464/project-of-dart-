import 'package:flutter/material.dart';
import 'package:homework3/screen/profile_screen.dart';
import '../osama_router_manager.dart';
import '../routes/app_routes.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Normal Route (Constructor):',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              color: Colors.grey[200],
              padding: const EdgeInsets.all(8),
              child: const Text(
                "osamaRouterManager.go(ProfileScreen(name_2: 'osama', age_2: 23))",
                style: TextStyle(fontFamily: 'monospace'),
              ),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                osamaRouterManager.go(ProfileScreen(name_2: 'osama', age_2: 23));
              },
              child: const Text('Go (Normal Route)'),
            ),

            const SizedBox(height: 24),
            const Text(
              'Named Route (arguments):',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              color: Colors.grey[200],
              padding: const EdgeInsets.all(8),
              child: const Text(
                "osamaRouterManager.goNamed(AppRoutes.profile, arguments: {'name': osama', 'age': 23})",
                style: TextStyle(fontFamily: 'monospace'),
              ),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                osamaRouterManager.goNamed(
                  AppRoutes.profile,
                  arguments: {'name': 'osama', 'age': 23},
                );
              },
              child: const Text('Go (Named Route)'),
            ),
          ],
        ),
      ),
    );
  }
}
