
import 'package:flutter/material.dart';
import 'package:todo/services/todo_services.dart';
import 'package:todo/utils/snackbar_helper.dart';
import 'package:todo/widgets/text_fields.dart';


class AddTodoPage extends StatefulWidget {
  final Map? todo;
  const AddTodoPage({
    super.key,
    this.todo,
  });

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  bool isEdit = false;

  @override
  void initState() {
    super.initState();
    final todo = widget.todo;
    if (todo != null) {
      isEdit = true;
      final title = todo['title'];
      final description = todo['description'];
      titleController.text = title;
      descriptionController.text = description;
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? 'Edit To Do' : 'Add ToDo'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          CustomTextField(
            hintText: 'Title',
            controller: titleController,
          ),
          const SizedBox(height: 16.0), // Spacer
          CustomTextField(
            controller: descriptionController,
            hintText: 'Description',
            minLines: 5,
            maxLines: 5,
          ),
          const SizedBox(height: 32.0),
          ElevatedButton(
            onPressed: () async {
              if (isEdit) {
                await updateData();
              } else {
                await submitData();
              }
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              backgroundColor: Colors.blue,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(isEdit ? 'Update' : 'Add ToDo'),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> updateData() async {
    // Get the data from form
    final todo = widget.todo;
    if (todo == null) {
      print('You can not call updated without todo data');
      return;
    }
    final id = todo['_id'];
    
    // Submit updated data to the server
    final isSuccess = await TodoSevices.updateTodo(id, body);

    if (isSuccess) {
      showSuccessMessage(context, message: 'Update successful!');
    } else {
      showErrorMessage(context, message: 'Update Failed: ${response.body}');
    }
  }

  Future<void> submitData() async {
    // Submit data to the server
    try {
      final isSuccess = await TodoSevices.addTodo(body);

      //show success or fail message based on status
      if (isSuccess) {
        showSuccessMessage(context, message: 'ToDo successfully added!');
        titleController.clear();
        descriptionController.clear();
      } else {
        showErrorMessage(context, message:'Failed to add ToDo');
      }
    } catch (e) {
      showErrorMessage(context, message: 'An error occurred: $e');
    }
  }
   // Get the data from form
  Map get body {
     final title = titleController.text.trim();
    final description = descriptionController.text.trim();
    if (title.isEmpty || description.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields.')),
      );
    }
    return {
      "title": title,
      "description": description,
      "is_completed": false,
    };
  }
}
