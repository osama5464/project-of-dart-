import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/category_controller.dart';
import '../controllers/task_controller.dart';
import '../widgets/add_category_dialog.dart';

class CategoryListScreen extends StatelessWidget {
  const CategoryListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final categoryController = Get.find<CategoryController>();
    final taskController = Get.find<TaskController>();

    return Scaffold(
      appBar: AppBar(title: Text('categories'.tr)),
      body: GetBuilder<CategoryController>(
        builder: (_) {
          final categories = categoryController.categories;
          if (categories.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.category, size: 64, color: Colors.grey[400]),
                  const SizedBox(height: 16),
                  Text(
                    'no_categories'.tr,
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ],
              ),
            );
          }
          ;

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];
              final taskCount = taskController.tasks
                  .where((t) => t.categoryId == category.id)
                  .length;

              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  leading: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Color(category.colorValue),
                      shape: BoxShape.circle,
                    ),
                  ),
                  title: Text(
                    category.name,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  subtitle: Text('$taskCount ${'task'.tr}'),
                  trailing: PopupMenuButton(
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        child: Text(
                          'delete'.tr,
                          style: const TextStyle(color: Colors.red),
                        ),
                        onTap: () => _deleteCategory(category.id),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.dialog(AddCategoryDialog(onCategoryAdded: (_) {})),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _deleteCategory(String id) {
    Future.delayed(const Duration(milliseconds: 100), () {
      Get.dialog(
        AlertDialog(
          title: Text('delete'.tr),
          content: Text('delete_confirm'.tr),
          actions: [
            TextButton(onPressed: () => Get.back(), child: Text('cancel'.tr)),
            TextButton(
              onPressed: () {
                final taskController = Get.find<TaskController>();
                for (var task in taskController.tasks) {
                  if (task.categoryId == id) {
                    task.categoryId = null;
                    task.save();
                  }
                }
                taskController.update();
                Get.find<CategoryController>().deleteCategory(id);
                Get.back();
              },
              child: Text(
                'delete'.tr,
                style: const TextStyle(color: Colors.red),
              ),
            ),
          ],
        ),
      );
    });
  }
}
