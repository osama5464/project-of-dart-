import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../controllers/task_controller.dart';
import '../models/task_model.dart';
import '../utils/theme.dart';
import '../widgets/input_field.dart';

class AddTaskScreen extends StatefulWidget {
  final Task? task;
  const AddTaskScreen({super.key, this.task});

  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final TaskController _taskController = Get.find<TaskController>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  String _selectedPriority = "Low";
  List<String> priorityList = ["Low", "Medium", "High"];
  String _selectedCategory = "Work";

  @override
  void initState() {
    super.initState();
    if (widget.task != null) {
      _titleController.text = widget.task!.title ?? "";
      _noteController.text = widget.task!.description ?? "";
      _selectedDate = DateFormat.yMd().parse(widget.task!.dueDate!);
      _selectedPriority = widget.task!.priority ?? "Low";
      _selectedCategory = widget.task!.category ?? "Work";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      appBar: _appBar(context),
      body: Container(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.task == null ? "Add Task" : "Edit Task",
                style: headingStyle,
              ),
              MyInputField(
                title: "Title",
                hint: "Enter your title",
                controller: _titleController,
              ),
              MyInputField(
                title: "Description",
                hint: "Enter your description",
                controller: _noteController,
              ),
              MyInputField(
                title: "Date",
                hint: DateFormat.yMd().format(_selectedDate),
                widget: IconButton(
                  icon: Icon(Icons.calendar_today_outlined, color: Colors.grey),
                  onPressed: () {
                    _getDateFromUser();
                  },
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: MyInputField(
                      title: "Priority",
                      hint: _selectedPriority,
                      widget: DropdownButton(
                        icon: Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.grey,
                        ),
                        iconSize: 32,
                        elevation: 4,
                        style: subTitleStyle,
                        underline: Container(height: 0),
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedPriority = newValue!;
                          });
                        },
                        items: priorityList.map<DropdownMenuItem<String>>((
                          String value,
                        ) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: TextStyle(color: Colors.grey),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: MyInputField(
                      title: "Category",
                      hint: _selectedCategory,
                      widget: Obx(() {
                        return DropdownButton(
                          icon: Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.grey,
                          ),
                          iconSize: 32,
                          elevation: 4,
                          style: subTitleStyle,
                          underline: Container(height: 0),
                          onChanged: (String? newValue) {
                            if (newValue == "+ Add New") {
                              _showAddCategoryDialog();
                            } else {
                              setState(() {
                                _selectedCategory = newValue!;
                              });
                            }
                          },
                          items: [
                            ..._taskController.categoryList
                                .map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  );
                                })
                                .toList(),
                            DropdownMenuItem<String>(
                              value: "+ Add New",
                              child: Text(
                                "+ Add New",
                                style: TextStyle(
                                  color: primaryClr,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        );
                      }),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 18),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () => _validateDate(),
                    child: Container(
                      width: 120,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: primaryClr,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        widget.task == null ? "Create Task" : "Update Task",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  _validateDate() {
    if (_titleController.text.isNotEmpty && _noteController.text.isNotEmpty) {
      if (widget.task == null) {
        _addTaskToDb();
      } else {
        _updateTaskInDb();
      }
      Get.back();
    } else {
      Get.snackbar(
        "Required",
        "All fields are required !",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.white,
        colorText: pinkClr,
        icon: Icon(Icons.warning_amber_rounded, color: Colors.red),
      );
    }
  }

  _addTaskToDb() async {
    int value = await _taskController.addTask(
      task: Task(
        description: _noteController.text,
        title: _titleController.text,
        isCompleted: 0,
        category: _selectedCategory,
        priority: _selectedPriority,
        dueDate: DateFormat.yMd().format(_selectedDate),
        createdAt: DateTime.now().toString(),
      ),
    );
    print("My id is " + "$value");
  }

  _updateTaskInDb() async {
    await _taskController.updateTaskInfo(
      Task(
        id: widget.task!.id,
        description: _noteController.text,
        title: _titleController.text,
        isCompleted: widget.task!.isCompleted,
        category: _selectedCategory,
        priority: _selectedPriority,
        dueDate: DateFormat.yMd().format(_selectedDate),
        createdAt: widget.task!.createdAt,
      ),
    );
  }

  PreferredSizeWidget _appBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: context.theme.scaffoldBackgroundColor,
      leading: GestureDetector(
        onTap: () {
          Get.back();
        },
        child: Icon(
          Icons.arrow_back_ios,
          size: 20,
          color: Get.isDarkMode ? Colors.white : Colors.black,
        ),
      ),
      actions: [
        CircleAvatar(
          child: Icon(Icons.person),
          backgroundColor: Colors.grey[200],
        ),
        SizedBox(width: 20),
      ],
    );
  }

  _getDateFromUser() async {
    DateTime? _pickerDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015),
      lastDate: DateTime(2121),
    );

    if (_pickerDate != null) {
      setState(() {
        _selectedDate = _pickerDate;
      });
    } else {
      print("it's null or something is wrong");
    }
  }

  _showAddCategoryDialog() {
    final TextEditingController _categoryController = TextEditingController();
    Get.defaultDialog(
      title: "Add Category",
      radius: 20,
      content: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _categoryController,
              autofocus: true,
              decoration: InputDecoration(
                hintText: "Enter Category Name",
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: primaryClr, width: 1.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey, width: 1.0),
                ),
              ),
            ),
          ],
        ),
      ),
      textConfirm: "Add",
      textCancel: "Cancel",
      cancelTextColor: Get.isDarkMode ? Colors.white : Colors.black,
      confirmTextColor: Colors.white,
      buttonColor: primaryClr,
      onConfirm: () async {
        if (_categoryController.text.isNotEmpty) {
          String newCat = _categoryController.text.trim();
          if (_taskController.categoryList.contains(newCat)) {
            Get.snackbar(
              "Error",
              "Category already exists",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.red,
              colorText: Colors.white,
            );
            return;
          }
          await _taskController.addCategory(newCat);
          setState(() {
            _selectedCategory = newCat;
          });
          Get.back();
        } else {
          Get.snackbar(
            "Required",
            "Category name is required",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      },
      onCancel: () {},
    );
  }
}
