import 'package:flutter/material.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/widgets/todo_item.dart';

class TodoList extends StatelessWidget {
  const TodoList(
      {super.key,
      required this.todos,
      required this.deleteTodo,
      required this.completedTodo,
      required this.removecompletedTodo});

  final List<Todo> todos;
  final void Function(Todo todo) deleteTodo;
  final void Function(Todo todo) completedTodo;
  final void Function(Todo todo) removecompletedTodo;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: todos.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [Icon(Icons.add), Text('No Todos added yet')],
              ),
            )
          : ListView.builder(
              itemCount: todos.length,
              itemBuilder: (context, index) {
                return Dismissible(
                  key: ValueKey(todos[index]),
                  onDismissed: (direction) {
                    deleteTodo(todos[index]);
                  },
                  child: TodoItem(
                    todo: todos[index],
                    deleteCard: () {
                      deleteTodo(todos[index]);
                    },
                    completedTodo: completedTodo,
                    removecompletedTodo: removecompletedTodo,
                  ),
                );
              },
            ),
    );
  }
}
