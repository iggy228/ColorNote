import 'package:color_note/screens/create_screen.dart';
import 'package:color_note/screens/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      routes: {
        '/': (_) => HomeScreen(),
        '/create': (_) => CreateScreen()
      },
    );
  }
}