import 'package:flutter/material.dart';
import 'package:todo_app/screens/main_screen.dart';

final kColorScheme =
    ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 0, 250, 62));

void main() {
  runApp(
    MaterialApp(
        home: const MainScreen(),
        theme: ThemeData(
            colorScheme: kColorScheme,
            appBarTheme: AppBarTheme(backgroundColor: kColorScheme.primary))),
  );
}
