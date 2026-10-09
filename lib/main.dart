
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => LearningState(),
      child: const MyApp(),
    ),
  );
}

// PROVIDER STATE MANAGEMENT
class LearningState extends ChangeNotifier {
  int completedResources = 0;

  void markAsLearned() {
    completedResources++;
    notifyListeners();
  }
}

// STATELESS WIDGET
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'E-Learning Resources',
      theme: ThemeData(primarySwatch: Colors.blue),
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
    );
  }
}

// HOME SCREEN
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    bool isMobile = width < 600;
    bool isTablet = width >= 600 && width < 1000;

    // Read shared Provider state
    int completed = context.watch<LearningState>().completedResources;

    return Scaffold(
      appBar: AppBar(
        title: const Text('E-Learning Resources'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(isMobile ? 12 : isTablet ? 25 : 40),
          child: Column(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Image.network(
                    'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg',
                    height: isMobile ? 180 : isTablet ? 240 : 280,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Text(
                    'Learn Flutter',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: isMobile ? 24 : isTablet ? 32 : 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.blue.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  'Explore E-Learning Resources',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // PROVIDER: shared state displayed on Home
              Card(
                child: ListTile(
                  leading: const Icon(Icons.check_circle,
                      color: Colors.green),
                  title: const Text('Resources Marked as Learned'),
                  trailing: Text(
                    '$completed',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // RESPONSIVE RESOURCE CARDS
              if (isMobile)
                Column(
                  children: [
                    resourceCard(context, Icons.book, 'Courses', '/courses', true),
                    resourceCard(context, Icons.video_library, 'Videos', '/videos', true),
                    resourceCard(context, Icons.quiz, 'Quizzes', '/quizzes', true),
                  ],
                )
              else if (isTablet)
                Wrap(
                  alignment: WrapAlignment.center,
                  children: [
                    resourceCard(context, Icons.book, 'Courses', '/courses', false),
                    resourceCard(context, Icons.video_library, 'Videos', '/videos', false),
                    resourceCard(context, Icons.quiz, 'Quizzes', '/quizzes', false),
                  ],
                )
              else
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    resourceCard(context, Icons.book, 'Courses', '/courses', false),
                    resourceCard(context, Icons.video_library, 'Videos', '/videos', false),
                    resourceCard(context, Icons.quiz, 'Quizzes', '/quizzes', false),
                  ],
                ),

              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/resources');
                },
                child: const Text('View All Resources'),
              ),

              const SizedBox(height: 25),

              const Text(
                'Available Resources',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const ListTile(
                leading: Icon(Icons.book),
                title: Text('Flutter Basics'),
              ),
              const ListTile(
                leading: Icon(Icons.code),
                title: Text('Dart Programming'),
              ),
              const ListTile(
                leading: Icon(Icons.design_services),
                title: Text('UI Design'),
              ),

              const SizedBox(height: 25),

              // STATEFUL WIDGET: local state using setState()
              const CounterWidget(),
            ],
          ),
        ),
      ),
    );
  }

  Widget resourceCard(
    BuildContext context,
    IconData icon,
    String title,
    String route,
    bool isMobile,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, route);
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
            Icon(icon, size: isMobile ? 40 : 50),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// STATEFUL WIDGET: SETSTATE EXAMPLE
class CounterWidget extends StatefulWidget {
  const CounterWidget({super.key});

  @override
  State<CounterWidget> createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              'setState() Example',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Button clicked: $count times',
              style: const TextStyle(fontSize: 18),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  count++;
                });
              },
              child: const Text('Click Me'),
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
      appBar: AppBar(title: const Text('All Resources')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            'Available Resources',
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),
          ListTile(
            leading: const Icon(Icons.book),
            title: const Text('Courses'),
            onTap: () => Navigator.pushNamed(context, '/courses'),
          ),
          ListTile(
            leading: const Icon(Icons.video_library),
            title: const Text('Videos'),
            onTap: () => Navigator.pushNamed(context, '/videos'),
          ),
          ListTile(
            leading: const Icon(Icons.quiz),
            title: const Text('Quizzes'),
            onTap: () => Navigator.pushNamed(context, '/quizzes'),
          ),
        ],
      ),
    );
  }
}

// RESOURCE DETAIL SCREEN
class ResourceDetailScreen extends StatelessWidget {
  final String title;

  const ResourceDetailScreen({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    // Listen to shared Provider state
    final learningState = context.watch<LearningState>();

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.school, size: 80, color: Colors.blue),
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
                'Explore this learning resource.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 20),

              // PROVIDER: update shared state
              Text(
                'Total resources marked as learned: '
                '${learningState.completedResources}',
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 12),

              ElevatedButton.icon(
                onPressed: () {
                  context.read<LearningState>().markAsLearned();

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Resource marked as learned!'),
                    ),
                  );
                },
                icon: const Icon(Icons.check),
                label: const Text('Mark as Learned'),
              ),

              const SizedBox(height: 12),

              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Back'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
