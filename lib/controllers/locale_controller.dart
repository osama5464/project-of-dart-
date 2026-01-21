import 'dart:ui';

import 'package:get/get.dart';
import 'package:hive/hive.dart';

class LocaleController extends GetxController {
  final locale = const Locale('en', 'US').obs;
  late Box settingsBox;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    settingsBox = Hive.box('settings');
    final saveLang = settingsBox.get('language', defaultValue: 'en');
    locale.value = saveLang == 'ar'
        ? const Locale('ar', 'SA')
        : const Locale('en', 'US');
  }

  void chanageToEnglish() {
    locale.value = const Locale('en', 'US');
    settingsBox.put('language', 'en');
    Get.updateLocale(locale.value);
  }

  void chanageToArabic() {
    locale.value = const Locale('ar', 'SA');
    settingsBox.put('language', 'ar');
    Get.updateLocale(locale.value);
  }

  bool get isArabic => locale.value.languageCode == 'ar';
}
