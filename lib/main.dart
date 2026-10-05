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

// HOME SCREEN
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // MEDIA QUERY
    double screenWidth = MediaQuery.of(context).size.width;

    // BREAKPOINTS
    bool isMobile = screenWidth < 600;
    bool isTablet = screenWidth >= 600 && screenWidth < 1000;
    bool isDesktop = screenWidth >= 1000;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'E-Learning Resources',
          style: TextStyle(
            fontSize: isMobile
                ? 20
                : isTablet
                    ? 24
                    : 28,
          ),
        ),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(
            isMobile
                ? 12
                : isTablet
                    ? 25
                    : 40,
          ),
          child: Column(
            children: [
              // STACK
              Stack(
                alignment: Alignment.center,
                children: [
                  Image.network(
                    'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg',
                    height: isMobile
                        ? 180
                        : isTablet
                            ? 240
                            : 280,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Text(
                    'Learn Flutter',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: isMobile
                          ? 24
                          : isTablet
                              ? 32
                              : 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // CONTAINER
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(
                  isMobile
                      ? 15
                      : isTablet
                          ? 20
                          : 25,
                ),
                decoration: BoxDecoration(
                  color: Colors.blue.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'Explore E-Learning Resources',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: isMobile
                        ? 20
                        : isTablet
                            ? 24
                            : 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 25),

              // RESPONSIVE CARDS
              if (isMobile)
                Column(
                  children: [
                    resourceCard(
                      context,
                      Icons.book,
                      'Courses',
                      true,
                    ),
                    resourceCard(
                      context,
                      Icons.video_library,
                      'Videos',
                      true,
                    ),
                    resourceCard(
                      context,
                      Icons.quiz,
                      'Quizzes',
                      true,
                    ),
                  ],
                )
              else if (isTablet)
                Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 15,
                  runSpacing: 15,
                  children: [
                    resourceCard(
                      context,
                      Icons.book,
                      'Courses',
                      false,
                    ),
                    resourceCard(
                      context,
                      Icons.video_library,
                      'Videos',
                      false,
                    ),
                    resourceCard(
                      context,
                      Icons.quiz,
                      'Quizzes',
                      false,
                    ),
                  ],
                )
              else
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    resourceCard(
                      context,
                      Icons.book,
                      'Courses',
                      false,
                    ),
                    resourceCard(
                      context,
                      Icons.video_library,
                      'Videos',
                      false,
                    ),
                    resourceCard(
                      context,
                      Icons.quiz,
                      'Quizzes',
                      false,
                    ),
                  ],
                ),

              const SizedBox(height: 30),

              // NAVIGATION BUTTON
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const ResourcesScreen(),
                    ),
                  );
                },
                child: const Text('View All Resources'),
              ),

              const SizedBox(height: 25),

              // AVAILABLE RESOURCES
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(
                  isMobile
                      ? 15
                      : isTablet
                          ? 20
                          : 25,
                ),
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
                        fontSize: isMobile
                            ? 20
                            : isTablet
                                ? 24
                                : 26,
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

              const SizedBox(height: 20),

              Text(
                isMobile
                    ? 'Mobile Layout'
                    : isTablet
                        ? 'Tablet Layout'
                        : 'Desktop Layout',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // RESOURCE CARD
  Widget resourceCard(
    BuildContext context,
    IconData icon,
    String title,
    bool isMobile,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                ResourceDetailScreen(title: title),
          ),
        );
      },
      child: Container(
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
      ),
    );
  }
}

// RESOURCES SCREEN
class ResourcesScreen extends StatelessWidget {
  const ResourcesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Resources'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text(
              'Available Resources',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            ListTile(
              leading: const Icon(Icons.book),
              title: const Text('Flutter Basics'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const ResourceDetailScreen(
                      title: 'Flutter Basics',
                    ),
                  ),
                );
              },
            ),

            ListTile(
              leading: const Icon(Icons.code),
              title: const Text('Dart Programming'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const ResourceDetailScreen(
                      title: 'Dart Programming',
                    ),
                  ),
                );
              },
            ),

            ListTile(
              leading: const Icon(Icons.design_services),
              title: const Text('UI Design'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const ResourceDetailScreen(
                      title: 'UI Design',
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Back to Home'),
            ),
          ],
        ),
      ),
    );
  }
}

// DETAIL SCREEN
class ResourceDetailScreen extends StatelessWidget {
  final String title;

  const ResourceDetailScreen({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.school,
              size: 80,
              color: Colors.blue,
            ),

            const SizedBox(height: 20),

            Text(
              title,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            const Text(
              'Learning resources are available here.',
              style: TextStyle(fontSize: 18),
            ),

            const SizedBox(height: 25),

            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Back'),
            ),
          ],
        ),
      ),
    );
  }
}