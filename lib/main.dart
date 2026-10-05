import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text(
            'Screen Width: $screenWidth',
            style: const TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}