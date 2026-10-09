
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => LearningState(),
      child: const MyApp(),
    ),
  );
}

// PROVIDER STATE
class LearningState extends ChangeNotifier {
  int completedResources = 0;

  void markAsLearned() {
    completedResources++;
    notifyListeners();
  }
}

// APP AND NAMED ROUTES
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'E-Learning Resources',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (_) => const HomePage(),
        '/resources': (_) => const ResourcesScreen(),
        '/courses': (_) =>
            const ResourceDetailScreen(title: 'Courses'),
        '/videos': (_) =>
            const ResourceDetailScreen(title: 'Videos'),
        '/quizzes': (_) =>
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
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 600;
    final isTablet = width >= 600 && width < 1000;

    return Scaffold(
      appBar: AppBar(
        title: const Text('E-Learning Resources'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(isMobile ? 12 : isTablet ? 25 : 40),
        child: Column(
          children: [
            // CUSTOM HEADER WIDGET
            const LearningHeader(),

            const SizedBox(height: 20),

            // CUSTOM SECTION TITLE
            const SectionTitle(title: 'Explore Resources'),

            const SizedBox(height: 15),

            // CUSTOM RESPONSIVE RESOURCE CARDS
            if (isMobile)
              Column(
                children: [
                  ResourceCard(
                    icon: Icons.book,
                    title: 'Courses',
                    description: 'Learn new skills',
                    route: '/courses',
                    fullWidth: true,
                  ),
                  ResourceCard(
                    icon: Icons.video_library,
                    title: 'Videos',
                    description: 'Watch tutorials',
                    route: '/videos',
                    fullWidth: true,
                  ),
                  ResourceCard(
                    icon: Icons.quiz,
                    title: 'Quizzes',
                    description: 'Test your knowledge',
                    route: '/quizzes',
                    fullWidth: true,
                  ),
                ],
              )
            else
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 12,
                runSpacing: 12,
                children: [
                  ResourceCard(
                    icon: Icons.book,
                    title: 'Courses',
                    description: 'Learn new skills',
                    route: '/courses',
                  ),
                  ResourceCard(
                    icon: Icons.video_library,
                    title: 'Videos',
                    description: 'Watch tutorials',
                    route: '/videos',
                  ),
                  ResourceCard(
                    icon: Icons.quiz,
                    title: 'Quizzes',
                    description: 'Test your knowledge',
                    route: '/quizzes',
                  ),
                ],
              ),

            const SizedBox(height: 25),

            // CUSTOM PROVIDER WIDGET
            const LearningProgressCard(),

            const SizedBox(height: 25),

            CustomActionButton(
              text: 'View All Resources',
              icon: Icons.library_books,
              onPressed: () {
                Navigator.pushNamed(context, '/resources');
              },
            ),

            const SizedBox(height: 25),

            const SectionTitle(title: 'Available Resources'),

            const ResourceInfoTile(
              icon: Icons.book,
              title: 'Flutter Basics',
            ),
            const ResourceInfoTile(
              icon: Icons.code,
              title: 'Dart Programming',
            ),
            const ResourceInfoTile(
              icon: Icons.design_services,
              title: 'UI Design',
            ),

            const SizedBox(height: 25),

            // STATEFUL WIDGET EXAMPLE
            const CounterWidget(),
          ],
        ),
      ),
    );
  }
}

// CUSTOM WIDGET 1: HEADER
class LearningHeader extends StatelessWidget {
  const LearningHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = width < 600 ? 180.0 : 260.0;

    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.network(
            'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg',
            height: height,
            width: double.infinity,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                height: height,
                color: Colors.blue.shade100,
                child: const Center(
                  child: Icon(Icons.school, size: 70),
                ),
              );
            },
          ),
          Container(
            width: double.infinity,
            height: height,
            color: Colors.black26,
          ),
          Text(
            'Learn Flutter',
            style: TextStyle(
              color: Colors.white,
              fontSize: width < 600 ? 28 : 36,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

// CUSTOM WIDGET 2: SECTION TITLE
class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 23,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

// CUSTOM WIDGET 3: RESOURCE CARD
class ResourceCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final String route;
  final bool fullWidth;

  const ResourceCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    required this.route,
    this.fullWidth = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: fullWidth ? double.infinity : 190,
      child: Card(
        color: Colors.blue.shade50,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: Colors.blue),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            Navigator.pushNamed(context, route);
          },
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Icon(icon, size: 42, color: Colors.blue),
                const SizedBox(height: 10),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  description,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                const Text(
                  'Open →',
                  style: TextStyle(color: Colors.blue),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// CUSTOM WIDGET 4: REUSABLE ACTION BUTTON
class CustomActionButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback onPressed;

  const CustomActionButton({
    super.key,
    required this.text,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon),
        label: Text(text),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(16),
        ),
      ),
    );
  }
}

// CUSTOM WIDGET 5: PROVIDER PROGRESS CARD
class LearningProgressCard extends StatelessWidget {
  const LearningProgressCard({super.key});

  @override
  Widget build(BuildContext context) {
    final completed =
        context.watch<LearningState>().completedResources;

    return Card(
      child: ListTile(
        leading: const Icon(
          Icons.check_circle,
          color: Colors.green,
          size: 35,
        ),
        title: const Text('Resources Marked as Learned'),
        trailing: Text(
          '$completed',
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

// CUSTOM WIDGET 6: RESOURCE INFORMATION TILE
class ResourceInfoTile extends StatelessWidget {
  final IconData icon;
  final String title;

  const ResourceInfoTile({
    super.key,
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue),
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
    );
  }
}

// STATEFUL WIDGET: SETSTATE
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
            const SectionTitle(title: 'setState() Example'),
            const SizedBox(height: 10),
            Text(
              'Button clicked: $count times',
              style: const TextStyle(fontSize: 18),
            ),
            CustomActionButton(
              text: 'Click Me',
              icon: Icons.touch_app,
              onPressed: () {
                setState(() {
                  count++;
                });
              },
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
          const SectionTitle(title: 'Available Resources'),
          const SizedBox(height: 15),
          ResourceCard(
            icon: Icons.book,
            title: 'Courses',
            description: 'Learn new skills',
            route: '/courses',
          ),
          ResourceCard(
            icon: Icons.video_library,
            title: 'Videos',
            description: 'Watch tutorials',
            route: '/videos',
          ),
          ResourceCard(
            icon: Icons.quiz,
            title: 'Quizzes',
            description: 'Test your knowledge',
            route: '/quizzes',
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
    final learningState = context.watch<LearningState>();

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
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
                'Explore this learning resource.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 15),
              Text(
                'Total resources marked as learned: '
                '${learningState.completedResources}',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 15),
              CustomActionButton(
                text: 'Mark as Learned',
                icon: Icons.check,
                onPressed: () {
                  context.read<LearningState>().markAsLearned();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Resource marked as learned!'),
                    ),
                  );
                },
              ),
              const SizedBox(height: 12),
              CustomActionButton(
                text: 'Back',
                icon: Icons.arrow_back,
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
