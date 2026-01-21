import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class ThemeController extends GetxController {
  final isDark = false.obs;
  late Box settingsBox;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    settingsBox = Hive.box('settings');
    isDark.value = settingsBox.get('isDark', defaultValue: false);
  }

  void toggleTheme() {
    isDark.value = !isDark.value;
    settingsBox.put('isDark', isDark.value);
    Get.changeThemeMode(isDark.value ? ThemeMode.dark : ThemeMode.light);
  }

  ThemeMode get themeMode => isDark.value ? ThemeMode.dark : ThemeMode.light;
}
