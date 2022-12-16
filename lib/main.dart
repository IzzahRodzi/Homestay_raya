import 'package:flutter/material.dart';
import 'splashscreen.dart';
import 'views/splashscreen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Homestay Raya',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: const splashScreen(
        user: null,
      ),
    );
  }
}
