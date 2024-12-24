import 'package:flutter/material.dart';
import 'package:todo/screens/add_page.dart';

class TodoLstPage extends StatefulWidget {
  const TodoLstPage({super.key});

  @override
  State<TodoLstPage> createState() => _TodoLstPageState();
}

class _TodoLstPageState extends State<TodoLstPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Todo List',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: navigateToAddPge,
        label: const Text('Add ToDo'),
      ),
    );
  }

  void navigateToAddPge() {
    final route = MaterialPageRoute(
      builder: (content) => const AddTodoPage(),
    );
    Navigator.push(context, route);
  }
}
