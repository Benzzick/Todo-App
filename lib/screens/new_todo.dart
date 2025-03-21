import 'package:flutter/material.dart';
import 'package:todo_app/models/todo.dart';

class NewTodo extends StatefulWidget {
  const NewTodo({super.key, required this.addNewTodo});

  final void Function(Todo todo) addNewTodo;

  @override
  State<NewTodo> createState() => _NewTodoState();
}

class _NewTodoState extends State<NewTodo> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  Priority priorityValue = Priority.low;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Column(
        children: [
          TextField(
            controller: titleController,
            decoration: const InputDecoration(hintText: 'Title'),
            enableSuggestions: true,
          ),
          TextField(
            controller: descriptionController,
            decoration: const InputDecoration(
              hintText: 'Description (Optional)',
            ),
            enableSuggestions: true,
            maxLines: 2,
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: Priority.values.map(
                (priority) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        priorityValue = priority;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 50,
                        width: 100,
                        decoration: BoxDecoration(
                          color: priorityValue == priority
                              ? priorityColors[priority]!.withOpacity(0.5)
                              : priorityColors[priority]!.withOpacity(0),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              width: 5, color: priorityColors[priority]!),
                        ),
                        child: Center(
                          child: Text(
                              priority.name.substring(0, 1).toUpperCase() +
                                  priority.name.substring(1)),
                        ),
                      ),
                    ),
                  );
                },
              ).toList()),
          Row(
            children: [
              const Spacer(),
              ElevatedButton.icon(
                onPressed: () {
                  if (titleController.text.trim().isEmpty ||
                      titleController.text.trim().length < 3) {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('No Title Added'),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Ok'))
                          ],
                        );
                      },
                    );
                    return;
                  }
                  widget.addNewTodo(Todo(
                      title: titleController.text,
                      description: descriptionController.text,
                      priority: priorityValue));
                  Navigator.of(context).pop();
                },
                label: const Text('Add Todo'),
                icon: const Icon(Icons.add),
              )
            ],
          )
        ],
      ),
    );
  }
}
