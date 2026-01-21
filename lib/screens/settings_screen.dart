import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/locale_controller.dart';
import '../controllers/theme_controller.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    final localeController = Get.find<LocaleController>();

    return Scaffold(
      appBar: AppBar(title: Text('settings'.tr)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'theme'.tr,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Card(
            child: Obx(
              () => SwitchListTile(
                title: Text(
                  themeController.isDark.value
                      ? 'dark_mode'.tr
                      : 'light_mode'.tr,
                ),
                subtitle: Text('theme'.tr),
                secondary: Icon(
                  themeController.isDark.value
                      ? Icons.dark_mode_outlined
                      : Icons.light_mode_outlined,
                ),
                value: themeController.isDark.value,
                onChanged: (_) => themeController.toggleTheme(),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'language'.tr,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Card(
            child: Column(
              children: [
                Obx(
                  () => RadioListTile<String>(
                    title: const Text('English'),
                    value: 'en',
                    groupValue: localeController.locale.value.languageCode,
                    onChanged: (_) => localeController.chanageToEnglish(),
                  ),
                ),
                const Divider(height: 1),
                Obx(
                  () => RadioListTile<String>(
                    title: const Text('العربية'),
                    value: 'ar',
                    groupValue: localeController.locale.value.languageCode,
                    onChanged: (_) => localeController.chanageToArabic(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
