import 'package:flutter/material.dart';
import 'package:todo_app/models/todo.dart';

class TodoItem extends StatefulWidget {
  const TodoItem(
      {super.key,
      required this.todo,
      required this.deleteCard,
      required this.completedTodo,
      required this.removecompletedTodo});

  final Todo todo;
  final void Function() deleteCard;
  final void Function(Todo todo) completedTodo;
  final void Function(Todo todo) removecompletedTodo;

  @override
  State<TodoItem> createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
  bool ischecked = false;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: 100,
          child: Card(
            child: Row(
              children: [
                Checkbox(
                  value: ischecked,
                  onChanged: (value) {
                    setState(() {
                      ischecked = value!;
                    });
                    if (ischecked) {
                      widget.completedTodo(widget.todo);
                    } else {
                      widget.removecompletedTodo(widget.todo);
                    }
                  },
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.todo.title,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          decoration: ischecked
                              ? TextDecoration.lineThrough
                              : TextDecoration.none),
                    ),
                    Text(widget.todo.description),
                  ],
                ),
                const Spacer(),
                IconButton(
                    onPressed: widget.deleteCard,
                    icon: const Icon(Icons.delete))
              ],
            ),
          ),
        ),
        CircleAvatar(
          backgroundColor: priorityColors[widget.todo.priority],
          child: Text(widget.todo.priority.name.substring(0, 1).toUpperCase() +
              widget.todo.priority.name.substring(1)),
        )
      ],
    );
  }
}
