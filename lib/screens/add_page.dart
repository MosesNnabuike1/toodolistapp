import 'package:flutter/material.dart';
import 'package:todo/widgets/text_fields.dart';

class AddTodoPage extends StatefulWidget {
  const AddTodoPage({super.key});

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add ToDo'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const CustomTextField(hintText: 'Title'),
          const SizedBox(height: 16.0), // Spacer
          const CustomTextField(
            hintText: 'Description',
            minLines: 5,
            maxLines: 5,
          ),
          const SizedBox(height: 32.0),
          ElevatedButton(
            onPressed: () {
              // Add your action here
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('ToDo added!')),
              );
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              backgroundColor: Colors.blue,
            ),
            child: const Text('Add ToDo'),
          ),
        ],
      ),
    );
  }
}
