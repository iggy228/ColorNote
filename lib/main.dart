import 'package:color_note/screens/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Color Note',
      routes: {
        '/': (_) => HomeScreen(),
      },
    );
  }
}