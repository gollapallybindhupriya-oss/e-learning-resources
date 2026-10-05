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

      // NAMED ROUTES
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/resources': (context) => const ResourcesScreen(),
        '/courses': (context) =>
            const ResourceDetailScreen(title: 'Courses'),
        '/videos': (context) =>
            const ResourceDetailScreen(title: 'Videos'),
        '/quizzes': (context) =>
            const ResourceDetailScreen(title: 'Quizzes'),
      },

      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}

// ================= HOME SCREEN =================

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
                      '/courses',
                    ),
                    resourceCard(
                      context,
                      Icons.video_library,
                      'Videos',
                      true,
                      '/videos',
                    ),
                    resourceCard(
                      context,
                      Icons.quiz,
                      'Quizzes',
                      true,
                      '/quizzes',
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
                      '/courses',
                    ),
                    resourceCard(
                      context,
                      Icons.video_library,
                      'Videos',
                      false,
                      '/videos',
                    ),
                    resourceCard(
                      context,
                      Icons.quiz,
                      'Quizzes',
                      false,
                      '/quizzes',
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
                      '/courses',
                    ),
                    resourceCard(
                      context,
                      Icons.video_library,
                      'Videos',
                      false,
                      '/videos',
                    ),
                    resourceCard(
                      context,
                      Icons.quiz,
                      'Quizzes',
                      false,
                      '/quizzes',
                    ),
                  ],
                ),

              const SizedBox(height: 30),

              // NAMED ROUTE NAVIGATION
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    '/resources',
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
    String route,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          route,
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

// ================= RESOURCES SCREEN =================

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
                Navigator.pushNamed(
                  context,
                  '/courses',
                );
              },
            ),

            ListTile(
              leading: const Icon(Icons.video_library),
              title: const Text('Videos'),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  '/videos',
                );
              },
            ),

            ListTile(
              leading: const Icon(Icons.quiz),
              title: const Text('Quizzes'),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  '/quizzes',
                );
              },
            ),

            const SizedBox(height: 20),

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

// ================= DETAIL SCREEN =================

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