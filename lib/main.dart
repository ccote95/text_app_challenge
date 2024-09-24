import 'package:flutter/material.dart';
import 'package:text_app_challenge/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Text app challenge',
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        home: const HomeScreen());
  }
}
