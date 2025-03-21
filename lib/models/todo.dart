import 'package:flutter/material.dart';

enum Priority { high, low }

final Map<Priority, Color> priorityColors = {
  Priority.high: Colors.red,
  Priority.low: Colors.yellow
};

class Todo {
  Todo(
      {required this.title, required this.description, required this.priority});
  String title;
  String description;
  Priority priority;
}
