import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'controllers/locale_controller.dart';
import 'controllers/theme_controller.dart';
import 'helper/app_page.dart';
import 'helper/routes.dart';
import 'helper/themes.dart';
import 'helper/translations.dart';
import 'models/category.dart';
import 'models/task.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  Hive.registerAdapter(TaskAdapter());
  Hive.registerAdapter(CategoryAdapter());

  await Hive.openBox<Task>('tasks');
  await Hive.openBox<Category>('categories');
  await Hive.openBox('settings');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ThemeController());
    Get.put(LocaleController());

    return GetMaterialApp(
      title: 'Todo App',
      debugShowCheckedModeBanner: false,
      theme: AppThemes.light,
      darkTheme: AppThemes.dark,
      themeMode: Get.find<ThemeController>().themeMode,
      translations: AppTranslations(),
      locale: Get.find<LocaleController>().locale.value,
      fallbackLocale: const Locale('en', 'US'),
      initialRoute: AppRoutes.TASKS,
      getPages: AppPage.page,
    );
  }
}
