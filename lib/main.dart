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
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('E-Learning Resources'),
      ),

      body: LayoutBuilder(
        builder: (context, constraints) {

          // Responsive screen size
          double width = constraints.maxWidth;

          // Different layout for mobile and larger screens
          bool isMobile = width < 600;

          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(isMobile ? 12 : 30),

              child: Column(
                children: [

                  // STACK
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.network(
                        'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg',
                        height: isMobile ? 180 : 280,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),

                      Text(
                        'Learn Flutter',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: isMobile ? 24 : 36,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // CONTAINER
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(isMobile ? 15 : 25),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'Explore E-Learning Resources',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: isMobile ? 20 : 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(height: 25),

                  // RESPONSIVE ROW / COLUMN
                  isMobile
                      ? Column(
                          children: [
                            resourceCard(
                              Icons.book,
                              'Courses',
                              isMobile,
                            ),
                            resourceCard(
                              Icons.video_library,
                              'Videos',
                              isMobile,
                            ),
                            resourceCard(
                              Icons.quiz,
                              'Quizzes',
                              isMobile,
                            ),
                          ],
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            resourceCard(
                              Icons.book,
                              'Courses',
                              isMobile,
                            ),
                            resourceCard(
                              Icons.video_library,
                              'Videos',
                              isMobile,
                            ),
                            resourceCard(
                              Icons.quiz,
                              'Quizzes',
                              isMobile,
                            ),
                          ],
                        ),

                  const SizedBox(height: 30),

                  // RESPONSIVE RESOURCE SECTION
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(isMobile ? 15 : 25),
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Available Resources',
                          style: TextStyle(
                            fontSize: isMobile ? 20 : 26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 15),

                        Text(
                          '• Flutter Basics',
                          style: TextStyle(
                            fontSize: isMobile ? 16 : 20,
                          ),
                        ),

                        Text(
                          '• Dart Programming',
                          style: TextStyle(
                            fontSize: isMobile ? 16 : 20,
                          ),
                        ),

                        Text(
                          '• UI Design',
                          style: TextStyle(
                            fontSize: isMobile ? 16 : 20,
                          ),
                        ),

                        Text(
                          '• Mobile App Development',
                          style: TextStyle(
                            fontSize: isMobile ? 16 : 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // Resource Card
  Widget resourceCard(
    IconData icon,
    String title,
    bool isMobile,
  ) {
    return Container(
      width: isMobile ? double.infinity : 180,
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            size: isMobile ? 40 : 50,
          ),

          const SizedBox(height: 8),

          Text(
            title,
            style: TextStyle(
              fontSize: isMobile ? 17 : 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}