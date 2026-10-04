import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'E-Learning Resources',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('E-Learning Resources'),
        ),

        // COLUMN - Arranges widgets vertically
        body: SingleChildScrollView(
          child: Column(
            children: [

              // STACK - Places widgets on top of each other
              Stack(
                alignment: Alignment.center,
                children: [
                  Image.network(
                    'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg',
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),

                  const Text(
                    'Learn Flutter',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // CONTAINER
              Container(
                padding: const EdgeInsets.all(15),
                margin: const EdgeInsets.symmetric(horizontal: 15),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.blue.shade100,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Explore E-Learning Resources',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // ROW - Arranges widgets horizontally
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Icon(Icons.book, size: 40),
                      Text('Courses'),
                    ],
                  ),

                  Column(
                    children: [
                      Icon(Icons.video_library, size: 40),
                      Text('Videos'),
                    ],
                  ),

                  Column(
                    children: [
                      Icon(Icons.quiz, size: 40),
                      Text('Quizzes'),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 25),

              // COLUMN - Another vertical layout
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 15),
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Available Resources',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text('• Flutter Basics'),
                    Text('• Dart Programming'),
                    Text('• UI Design'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}