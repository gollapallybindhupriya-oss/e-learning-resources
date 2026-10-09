
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

// ================= CUSTOM STYLES =================

class AppStyles {
  static const Color primary = Color(0xFF3157A4);
  static const Color accent = Color(0xFF00A6A6);
  static const Color background = Color(0xFFF5F7FC);
  static const Color cardColor = Colors.white;
  static const Color textColor = Color(0xFF202A44);
  static const Color subtitleColor = Color(0xFF64748B);

  static const TextStyle appTitle = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static const TextStyle heading = TextStyle(
    fontSize: 25,
    fontWeight: FontWeight.bold,
    color: textColor,
  );

  static const TextStyle subtitle = TextStyle(
    fontSize: 15,
    color: subtitleColor,
  );

  static const TextStyle resourceTitle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: textColor,
  );

  static const TextStyle body = TextStyle(
    fontSize: 16,
    color: textColor,
  );

  static const TextStyle buttonText = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );
}

// ================= PROVIDER STATE =================

class LearningState extends ChangeNotifier {
  int completedResources = 0;

  void markAsLearned() {
    completedResources++;
    notifyListeners();
  }
}

// ================= APP THEME =================

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'E-Learning Resources',

      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppStyles.primary,
          primary: AppStyles.primary,
          secondary: AppStyles.accent,
          surface: AppStyles.cardColor,
        ),
        scaffoldBackgroundColor: AppStyles.background,

        appBarTheme: const AppBarTheme(
          backgroundColor: AppStyles.primary,
          foregroundColor: Colors.white,
          centerTitle: false,
          titleTextStyle: AppStyles.appTitle,
          elevation: 0,
        ),

        cardTheme: CardThemeData(
          color: AppStyles.cardColor,
          elevation: 2,
          margin: const EdgeInsets.all(8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),

        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppStyles.primary,
            foregroundColor: Colors.white,
            textStyle: AppStyles.buttonText,
            padding: const EdgeInsets.symmetric(
              horizontal: 22,
              vertical: 14,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),

        textTheme: const TextTheme(
          headlineSmall: AppStyles.heading,
          titleMedium: AppStyles.resourceTitle,
          bodyLarge: AppStyles.body,
          bodyMedium: AppStyles.subtitle,
        ),

        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
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

// ================= HOME SCREEN =================

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
        padding: EdgeInsets.all(
          isMobile ? 12 : isTablet ? 25 : 40,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const LearningHeader(),

            const SizedBox(height: 25),

            const SectionTitle(
              title: 'Explore Resources',
              subtitle: 'Choose a category to start learning',
            ),

            const SizedBox(height: 12),

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

            const LearningProgressCard(),

            const SizedBox(height: 16),

            CustomActionButton(
              text: 'View All Resources',
              icon: Icons.library_books,
              onPressed: () {
                Navigator.pushNamed(context, '/resources');
              },
            ),

            const SizedBox(height: 25),

            const SectionTitle(
              title: 'Available Resources',
              subtitle: 'Explore the learning materials',
            ),

            const SizedBox(height: 10),

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

            const CounterWidget(),
          ],
        ),
      ),
    );
  }
}

// ================= HEADER WIDGET =================

class LearningHeader extends StatelessWidget {
  const LearningHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = width < 600 ? 180.0 : 260.0;

    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.network(
            'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg',
            height: height,
            width: double.infinity,
            fit: BoxFit.cover,
            errorBuilder: (_, error, stackTrace) {
              return Container(
                height: height,
                color: AppStyles.primary,
                child: const Center(
                  child: Icon(
                    Icons.school,
                    size: 70,
                    color: Colors.white,
                  ),
                ),
              );
            },
          ),
          Container(
            height: height,
            width: double.infinity,
            color: Colors.black38,
          ),
          Text(
            'Learn Flutter',
            style: TextStyle(
              color: Colors.white,
              fontSize: width < 600 ? 28 : 36,
              fontWeight: FontWeight.bold,
              shadows: const [
                Shadow(
                  color: Colors.black45,
                  blurRadius: 8,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ================= SECTION TITLE =================

class SectionTitle extends StatelessWidget {
  final String title;
  final String? subtitle;

  const SectionTitle({
    super.key,
    required this.title,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 5),
          Text(
            subtitle!,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ],
    );
  }
}

// ================= RESOURCE CARD =================

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
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            Navigator.pushNamed(context, route);
          },
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor:
                      AppStyles.primary.withValues(alpha: 0.1),
                  child: Icon(
                    icon,
                    size: 30,
                    color: AppStyles.primary,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 6),
                Text(
                  description,
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                const Text(
                  'Open →',
                  style: TextStyle(
                    color: AppStyles.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ================= CUSTOM ACTION BUTTON =================

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
      ),
    );
  }
}

// ================= PROVIDER PROGRESS CARD =================

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
          color: AppStyles.accent,
          size: 35,
        ),
        title: const Text('Resources Marked as Learned'),
        trailing: Text(
          '$completed',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
    );
  }
}

// ================= RESOURCE INFORMATION TILE =================

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
    return Card(
      child: ListTile(
        leading: Icon(icon, color: AppStyles.primary),
        title: Text(
          title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      ),
    );
  }
}

// ================= SETSTATE COUNTER =================

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
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 10),
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

// ================= RESOURCES SCREEN =================

class ResourcesScreen extends StatelessWidget {
  const ResourcesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('All Resources')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const SectionTitle(
            title: 'Available Resources',
            subtitle: 'Choose what you want to learn',
          ),
          const SizedBox(height: 15),
          const ResourceInfoTile(
            icon: Icons.book,
            title: 'Flutter Basics',
          ),
          const ResourceInfoTile(
            icon: Icons.code,
            title: 'Dart Programming',
          ),
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
          CustomActionButton(
            text: 'Back to Home',
            icon: Icons.home,
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}

// ================= RESOURCE DETAIL SCREEN =================

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
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.school,
                size: 80,
                color: AppStyles.primary,
              ),
              const SizedBox(height: 20),
              Text(
                title,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 12),
              Text(
                'Explore this learning resource.',
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Text(
                'Total resources marked as learned: '
                '${learningState.completedResources}',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge,
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
