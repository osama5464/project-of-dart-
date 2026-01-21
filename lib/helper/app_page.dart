
import 'package:get/get.dart';
import 'package:homework5/helper/routes.dart';

import '../controllers/category_controller.dart';
import '../controllers/task_controller.dart';
import '../screens/category_list_screen.dart';
import '../screens/settings_screen.dart';
import '../screens/task_list_screen.dart';

class AppPage {
  static final page = [
    GetPage(
      name: AppRoutes.TASKS,
      page: () => const TaskListScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => TaskController());
        Get.lazyPut(() => CategoryController());
      }),
    ),
    GetPage(
      name: AppRoutes.CATEGORIES,
      page: () => const CategoryListScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => CategoryController());
        Get.lazyPut(() => TaskController());
      }),
    ),
    GetPage(name: AppRoutes.SETTINGS, page: () => const SettingsScreen()),
  ];
}
