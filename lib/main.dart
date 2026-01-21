import 'package:flutter/material.dart';
import 'package:homework3/routes/app_page.dart';
import 'package:homework3/routes/app_routes.dart';
import 'osama_router_manager.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: osamaRouterManager.navigatorKey,
      debugShowCheckedModeBanner: false,
      routes: AppPages.routes,
      initialRoute :AppRoutes.home,
    );
  }
}
