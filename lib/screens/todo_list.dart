import 'package:flutter/material.dart';
import 'package:todo/screens/add_page.dart';
import 'package:todo/services/todo_services.dart';
import 'package:todo/utils/snackbar_helper.dart';
import 'package:todo/widget/todo_card.dart';

class TodoLstPage extends StatefulWidget {
  const TodoLstPage({super.key});

  @override
  State<TodoLstPage> createState() => _TodoLstPageState();
}

class _TodoLstPageState extends State<TodoLstPage> {
  bool isLoading = true;
  List items = [];


  @override
  void initState() {
    super.initState();
    fetchTodo();
  }

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
      body: Visibility(
        visible: isLoading,
        replacement: RefreshIndicator(
          onRefresh: fetchTodo,
          child: Visibility(
            visible: items.isNotEmpty,
            replacement: Center(
              child: Text(
                'No Todo Item',
                style: Theme.of(context).textTheme.displaySmall,
              ),
            ),
            child: ListView.builder(
                itemCount: items.length,
                padding: const EdgeInsets.all(6),
                itemBuilder: (context, index) {
                  final item = items[index] as Map;
                  return TodoCard(
                    index: index, 
                    item: item, 
                    navigateEdit: navigateToEditPage, 
                    deleteById: deleteById)
                }),
          ),
        ),
        child: const Center(child: CircularProgressIndicator(),),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: navigateToAddPage,
        label: const Text('Add ToDo'),
      ),
    );
  }

Future<void> navigateToEditPage(Map item)  async{
    final route = MaterialPageRoute(
      builder: (content) => AddTodoPage(todo: item),
    );
      await Navigator.push(context, route);
    setState(() {
      isLoading = true;
    });
    fetchTodo();
  }

  Future<void> navigateToAddPage() async {
    final route = MaterialPageRoute(
      builder: (content) => const AddTodoPage(),
    );
    await Navigator.push(context, route);
    setState(() {
      isLoading = true;
    });
    fetchTodo();
  }

  Future<void> deleteById(String id) async {
  // Delete the item
  
  final isSuccess = await TodoSevices.deleteById(id);
  if (isSuccess) {
    // Remove item from the list
    final filtered = items.where((element) => element['_id'] != id).toList();
    setState(() {
      items = filtered;
    });
  } else {
    showErrorMessage(context, message: 'Deletion Failed');
  }
}

  Future<void> fetchTodo() async {
    final response = await TodoSevices.fetchTodos();
    
    if (response != null) {
      setState(() {
        items = response;
      });
    } else {
      showErrorMessage(context, message: 'Something went wrong');
    }
    setState(() {
      isLoading = false;
    });
  }

}
