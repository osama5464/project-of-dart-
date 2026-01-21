import 'package:flutter/material.dart';
import '../screen/home_screen.dart';
import '../screen/profile_screen.dart';
import '../screen/setting_screen.dart';
import 'app_routes.dart';

class AppPages {
  static Map<String, Widget Function(BuildContext)> routes = {
    AppRoutes.home: (_) => HomeScreen(),
    AppRoutes.profile: (_) => ProfileScreen(),
    AppRoutes.settings: (_) => SettingsScreen(),
  };
}
