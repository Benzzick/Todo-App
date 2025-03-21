import 'package:flutter/material.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/screens/new_todo.dart';
import 'package:todo_app/widgets/todo_list.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Todo> allTodos = [];
  List<Todo> completedTodos = [];

  List<Todo> get pendingTodos {
    List<Todo> pendingTodos = [];
    pendingTodos = allTodos.where(
      (todo) {
        return !completedTodos.contains(todo);
      },
    ).toList();
    return pendingTodos;
  }

  List<Todo> get todos {
    switch (dropdownValue) {
      case 'Completed':
        return completedTodos;
      case 'Pending':
        return pendingTodos;
      default: // 'All'
        return allTodos;
    }
  }

  var dropdownValue = 'All';
  var dropdownValues = ['All', 'Completed', 'Pending'];

  void deleteTodo(Todo todo) {
    setState(() {
      allTodos.remove(todo);
      completedTodos
          .remove(todo); // Ensure it's removed from completedTodos too
    });
  }

  void fillNewTodo() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return NewTodo(
          addNewTodo: addTodo,
        );
      },
    );
  }

  void addTodo(Todo todo) {
    setState(() {
      allTodos.add(todo);
    });
  }

  void completeTodo(Todo todo) {
    setState(() {
      if (!completedTodos.contains(todo)) {
        completedTodos.add(todo);
      }
    });
  }

  void uncompleteTodo(Todo todo) {
    setState(() {
      completedTodos.remove(todo);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('To-Do List.'),
        actions: [
          DropdownButton(
            value: dropdownValue,
            items: dropdownValues.map(
              (value) {
                return DropdownMenuItem(
                  value: value,
                  child: Text(value),
                );
              },
            ).toList(),
            onChanged: (value) {
              if (value == null) {
                return;
              }
              setState(() {
                dropdownValue = value;
              });
            },
          )
        ],
      ),
      body: TodoList(
        todos: todos,
        deleteTodo: deleteTodo,
        completedTodo: completeTodo,
        removecompletedTodo: uncompleteTodo,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: fillNewTodo,
        child: const Icon(Icons.add),
      ),
    );
  }
}
