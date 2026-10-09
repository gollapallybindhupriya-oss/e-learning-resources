import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => LearningState(),
      child: const ELearningApp(),
    ),
  );
}

// ==================================================
// PROVIDER STATE MANAGEMENT
// ==================================================

class LearningState extends ChangeNotifier {
  int completedResources = 0;

  void markAsLearned() {
    completedResources++;
    notifyListeners();
  }
}

// ==================================================
// APP STYLES
// ==================================================

class AppStyles {
  static const Color primary = Color(0xFF4F46E5);
  static const Color background = Color(0xFFF6F7FB);
  static const Color text = Color(0xFF20243A);

  static const TextStyle heading = TextStyle(
    fontSize: 26,
    fontWeight: FontWeight.bold,
    color: text,
  );

  static const TextStyle subtitle = TextStyle(
    fontSize: 15,
    color: Colors.black54,
  );
}

// ==================================================
// MAIN APP AND ROUTES
// ==================================================

class ELearningApp extends StatelessWidget {
  const ELearningApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-Learning Resources',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: AppStyles.primary),
        scaffoldBackgroundColor: AppStyles.background,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppStyles.primary,
          foregroundColor: Colors.white,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.black12),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppStyles.primary, width: 2),
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (_) => const HomePage(),
        '/resources': (_) => const ResourcesScreen(),
        '/courses': (_) => const ResourcesScreen(),
        '/videos': (_) => const ResourcesScreen(),
        '/quizzes': (_) => const CounterWidget(),
        '/form': (_) => const CourseFormScreen(),
        '/animations': (_) => const AnimationLabScreen(),
      },
    );
  }
}

// ==================================================
// REUSABLE PAGE FADE AND SLIDE ANIMATION
// ==================================================

class PageEntrance extends StatefulWidget {
  final Widget child;

  const PageEntrance({super.key, required this.child});

  @override
  State<PageEntrance> createState() => _PageEntranceState();
}

class _PageEntranceState extends State<PageEntrance>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fade;
  late final Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    _fade = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);

    _slide = Tween<Offset>(
      begin: const Offset(0, 0.08),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fade,
      child: SlideTransition(position: _slide, child: widget.child),
    );
  }
}

// ==================================================
// REUSABLE WIDGETS
// ==================================================

class LearningHeader extends StatelessWidget {
  final String title;
  final String subtitle;

  const LearningHeader({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppStyles.heading),
        const SizedBox(height: 8),
        Text(subtitle, style: AppStyles.subtitle),
      ],
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Text(
        title,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class CustomActionButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onPressed;

  const CustomActionButton({
    super.key,
    required this.label,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      ),
    );
  }
}

// ==================================================
// ANIMATED RESOURCE CARD
// Hover, scale, shadow, and Hero animations
// ==================================================

class ResourceCard extends StatefulWidget {
  final String title;
  final String description;
  final IconData icon;
  final VoidCallback onTap;

  const ResourceCard({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
    required this.onTap,
  });

  @override
  State<ResourceCard> createState() => _ResourceCardState();
}

class _ResourceCardState extends State<ResourceCard> {
  bool _hovered = false;
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() {
        _hovered = false;
        _pressed = false;
      }),
      child: GestureDetector(
        onTapDown: (_) => setState(() => _pressed = true),
        onTapCancel: () => setState(() => _pressed = false),
        onTapUp: (_) => setState(() => _pressed = false),
        onTap: widget.onTap,
        child: AnimatedScale(
          scale: _pressed ? 0.97 : (_hovered ? 1.025 : 1.0),
          duration: const Duration(milliseconds: 180),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOut,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: _hovered
                    ? AppStyles.primary.withValues(alpha: 0.6)
                    : Colors.black12,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppStyles.primary.withValues(
                    alpha: _hovered ? 0.15 : 0.04,
                  ),
                  blurRadius: _hovered ? 18 : 5,
                  offset: Offset(0, _hovered ? 8 : 2),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: _hovered
                          ? AppStyles.primary
                          : AppStyles.primary.withValues(alpha: 0.10),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Hero(
                      tag: 'resource-icon-${widget.title}',
                      child: Icon(
                        widget.icon,
                        size: 30,
                        color: _hovered ? Colors.white : AppStyles.primary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    widget.title,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: Text(
                      widget.description,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                  const Align(
                    alignment: Alignment.bottomRight,
                    child: Icon(Icons.arrow_forward),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ==================================================
// ANIMATED LEARNING PROGRESS
// ==================================================

class LearningProgressCard extends StatelessWidget {
  const LearningProgressCard({super.key});

  @override
  Widget build(BuildContext context) {
    final completed = context.watch<LearningState>().completedResources;

    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Row(
          children: [
            const Icon(Icons.emoji_events, color: AppStyles.primary, size: 38),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Your learning progress',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 400),
                    transitionBuilder: (child, animation) {
                      return FadeTransition(
                        opacity: animation,
                        child: SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(0, 0.25),
                            end: Offset.zero,
                          ).animate(animation),
                          child: child,
                        ),
                      );
                    },
                    child: Text(
                      '$completed resources marked as learned',
                      key: ValueKey<int>(completed),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ResourceInfoTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const ResourceInfoTile({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: AppStyles.primary),
      title: Text(title),
      subtitle: Text(description),
    );
  }
}

// ==================================================
// HOME PAGE
// ==================================================

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('E-Learning Resources'),
        actions: [
          IconButton(
            tooltip: 'Explore animations',
            icon: const Icon(Icons.animation),
            onPressed: () => Navigator.pushNamed(context, '/animations'),
          ),
          IconButton(
            tooltip: 'Register for a course',
            icon: const Icon(Icons.app_registration),
            onPressed: () => Navigator.pushNamed(context, '/form'),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: AppStyles.primary),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(Icons.school, color: Colors.white, size: 42),
                  SizedBox(height: 10),
                  Text(
                    'E-Learning',
                    style: TextStyle(color: Colors.white, fontSize: 22),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.menu_book),
              title: const Text('Resources'),
              onTap: () => Navigator.pushNamed(context, '/resources'),
            ),
            ListTile(
              leading: const Icon(Icons.app_registration),
              title: const Text('Course Registration'),
              onTap: () => Navigator.pushNamed(context, '/form'),
            ),
            ListTile(
              leading: const Icon(Icons.animation),
              title: const Text('Animation Lab'),
              onTap: () => Navigator.pushNamed(context, '/animations'),
            ),
            ListTile(
              leading: const Icon(Icons.quiz),
              title: const Text('Counter Demo'),
              onTap: () => Navigator.pushNamed(context, '/quizzes'),
            ),
          ],
        ),
      ),
      body: PageEntrance(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isMobile = constraints.maxWidth < 600;
            final columns = constraints.maxWidth >= 1000
                ? 3
                : constraints.maxWidth >= 600
                ? 2
                : 1;

            return SingleChildScrollView(
              padding: EdgeInsets.all(isMobile ? 16 : 28),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1150),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const LearningHeader(
                        title: 'Learn something new!',
                        subtitle:
                            'Explore courses, videos, notes and animations.',
                      ),
                      const SizedBox(height: 22),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(18),
                        child: Image.network(
                          'https://images.unsplash.com/photo-1516321318423-f06f85e504b3'
                          '?auto=format&fit=crop&w=1200&q=80',
                          height: isMobile ? 170 : 260,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Container(
                            height: 180,
                            color: Colors.indigo.shade50,
                            child: const Center(
                              child: Icon(Icons.school, size: 70),
                            ),
                          ),
                        ),
                      ),
                      const SectionTitle('Explore Learning'),
                      GridView.count(
                        crossAxisCount: columns,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisSpacing: 14,
                        mainAxisSpacing: 14,
                        childAspectRatio: isMobile ? 1.45 : 1.35,
                        children: [
                          ResourceCard(
                            title: 'Study Resources',
                            description: 'Read notes and learning materials.',
                            icon: Icons.menu_book,
                            onTap: () =>
                                Navigator.pushNamed(context, '/resources'),
                          ),
                          ResourceCard(
                            title: 'Online Courses',
                            description: 'Explore your learning topics.',
                            icon: Icons.school,
                            onTap: () =>
                                Navigator.pushNamed(context, '/courses'),
                          ),
                          ResourceCard(
                            title: 'Video Learning',
                            description: 'Explore video learning resources.',
                            icon: Icons.play_circle,
                            onTap: () =>
                                Navigator.pushNamed(context, '/videos'),
                          ),
                          ResourceCard(
                            title: 'Practice',
                            description: 'Try the interactive counter demo.',
                            icon: Icons.quiz,
                            onTap: () =>
                                Navigator.pushNamed(context, '/quizzes'),
                          ),
                          ResourceCard(
                            title: 'Animation Lab',
                            description: 'Experiment with fade, slide, scale and rotation.',
                            icon: Icons.animation,
                            onTap: () =>
                                Navigator.pushNamed(context, '/animations'),
                          ),
                        ],
                      ),
                      const SectionTitle('Learning Progress'),
                      const LearningProgressCard(),
                      const SizedBox(height: 18),
                      CustomActionButton(
                        label: 'Register for a Course',
                        icon: Icons.app_registration,
                        onPressed: () => Navigator.pushNamed(context, '/form'),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

// ==================================================
// ANIMATION LAB
// Try fade, slide, scale, rotation, container,
// and AnimatedSwitcher transitions interactively.
// ==================================================

class AnimationLabScreen extends StatefulWidget {
  const AnimationLabScreen({super.key});

  @override
  State<AnimationLabScreen> createState() => _AnimationLabScreenState();
}

class _AnimationLabScreenState extends State<AnimationLabScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _rotationController;
  late final Animation<double> _rotation;

  bool _showFade = true;
  bool _slideRight = false;
  bool _enlarged = false;
  bool _containerChanged = false;
  bool _showFirstMessage = true;

  @override
  void initState() {
    super.initState();

    _rotationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _rotation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _rotationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _rotationController.dispose();
    super.dispose();
  }

  Widget _demoCard({
    required String title,
    required String description,
    required Widget demo,
    required Widget action,
  }) {
    return Card(
      color: Colors.white,
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            Text(description, style: AppStyles.subtitle),
            const SizedBox(height: 18),
            Center(
              child: SizedBox(height: 115, child: Center(child: demo)),
            ),
            const SizedBox(height: 12),
            Center(child: action),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter Animation Lab')),
      body: PageEntrance(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final columns = constraints.maxWidth >= 1000
                ? 3
                : constraints.maxWidth >= 650
                ? 2
                : 1;

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1100),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const LearningHeader(
                        title: 'Experiment with Animations',
                        subtitle:
                            'Tap the buttons to see each animation in action.',
                      ),
                      const SizedBox(height: 20),
                      GridView.count(
                        crossAxisCount: columns,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisSpacing: 14,
                        mainAxisSpacing: 14,
                        childAspectRatio: columns == 1 ? 1.2 : 0.9,
                        children: [
                          // FADE ANIMATION
                          _demoCard(
                            title: '1. Fade',
                            description: 'Change opacity to make an element appear or disappear.',
                            demo: AnimatedOpacity(
                              opacity: _showFade ? 1 : 0.08,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeInOut,
                              child: const Icon(
                                Icons.lightbulb,
                                size: 72,
                                color: Colors.amber,
                              ),
                            ),
                            action: ElevatedButton(
                              onPressed: () {
                                setState(() => _showFade = !_showFade);
                              },
                              child: Text(_showFade ? 'Fade Out' : 'Fade In'),
                            ),
                          ),

                          // SLIDE ANIMATION
                          _demoCard(
                            title: '2. Slide',
                            description: 'Move a widget horizontally with AnimatedSlide.',
                            demo: AnimatedSlide(
                              offset: _slideRight
                                  ? const Offset(0.5, 0)
                                  : Offset.zero,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeInOutCubic,
                              child: const Icon(
                                Icons.school,
                                size: 68,
                                color: AppStyles.primary,
                              ),
                            ),
                            action: ElevatedButton(
                              onPressed: () {
                                setState(() => _slideRight = !_slideRight);
                              },
                              child: const Text('Move Icon'),
                            ),
                          ),

                          // SCALE ANIMATION
                          _demoCard(
                            title: '3. Scale',
                            description:
                                'Increase or decrease the widget size.',
                            demo: AnimatedScale(
                              scale: _enlarged ? 1.5 : 0.8,
                              duration: const Duration(milliseconds: 400),
                              curve: Curves.elasticOut,
                              child: const Icon(
                                Icons.favorite,
                                size: 58,
                                color: Colors.pink,
                              ),
                            ),
                            action: ElevatedButton(
                              onPressed: () {
                                setState(() => _enlarged = !_enlarged);
                              },
                              child: const Text('Change Size'),
                            ),
                          ),

                          // ROTATION ANIMATION
                          _demoCard(
                            title: '4. Rotation',
                            description:
                                'Rotate an icon using AnimationController.',
                            demo: RotationTransition(
                              turns: _rotation,
                              child: const Icon(
                                Icons.settings,
                                size: 70,
                                color: Colors.teal,
                              ),
                            ),
                            action: Wrap(
                              alignment: WrapAlignment.center,
                              spacing: 8,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    _rotationController.forward();
                                  },
                                  child: const Text('Rotate'),
                                ),
                                OutlinedButton(
                                  onPressed: () {
                                    _rotationController.reset();
                                  },
                                  child: const Text('Reset'),
                                ),
                              ],
                            ),
                          ),

                          // ANIMATED CONTAINER
                          _demoCard(
                            title: '5. Container',
                            description:
                                'Animate color, width and border radius.',
                            demo: AnimatedContainer(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeInOut,
                              width: _containerChanged ? 150 : 95,
                              height: _containerChanged ? 75 : 95,
                              decoration: BoxDecoration(
                                color: _containerChanged
                                    ? Colors.orange
                                    : AppStyles.primary,
                                borderRadius: BorderRadius.circular(
                                  _containerChanged ? 30 : 8,
                                ),
                              ),
                              child: const Icon(
                                Icons.auto_awesome,
                                color: Colors.white,
                                size: 38,
                              ),
                            ),
                            action: ElevatedButton(
                              onPressed: () {
                                setState(
                                  () => _containerChanged = !_containerChanged,
                                );
                              },
                              child: const Text('Change Container'),
                            ),
                          ),

                          // ANIMATED SWITCHER
                          _demoCard(
                            title: '6. AnimatedSwitcher',
                            description:
                                'Replace content with a smooth transition.',
                            demo: AnimatedSwitcher(
                              duration: const Duration(milliseconds: 450),
                              transitionBuilder: (child, animation) {
                                return ScaleTransition(
                                  scale: animation,
                                  child: FadeTransition(
                                    opacity: animation,
                                    child: child,
                                  ),
                                );
                              },
                              child: Icon(
                                _showFirstMessage
                                    ? Icons.menu_book
                                    : Icons.play_circle_fill,
                                key: ValueKey<bool>(_showFirstMessage),
                                size: 70,
                                color: _showFirstMessage
                                    ? AppStyles.primary
                                    : Colors.deepOrange,
                              ),
                            ),
                            action: ElevatedButton(
                              onPressed: () {
                                setState(
                                  () => _showFirstMessage = !_showFirstMessage,
                                );
                              },
                              child: const Text('Switch Icon'),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      const ResourceInfoTile(
                        icon: Icons.info_outline,
                        title: 'What you learned',
                        description:
                            'Fade, slide, scale, rotation, AnimatedContainer '
                            'and AnimatedSwitcher.',
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

// ==================================================
// RESOURCES SCREEN
// ==================================================

class ResourcesScreen extends StatelessWidget {
  const ResourcesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final resources = [
      (
        'Programming Fundamentals',
        'Learn the basics of programming.',
        Icons.code,
      ),
      (
        'Web Development',
        'Explore HTML, CSS and responsive design.',
        Icons.web,
      ),
      (
        'Database Management',
        'Understand tables, SQL and databases.',
        Icons.storage,
      ),
      (
        'Data Structures',
        'Study lists, stacks, queues and trees.',
        Icons.account_tree,
      ),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Study Resources')),
      body: PageEntrance(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const LearningHeader(
              title: 'Available Resources',
              subtitle: 'Choose a topic to explore.',
            ),
            const SizedBox(height: 12),
            for (final resource in resources)
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: SizedBox(
                  height: 160,
                  child: ResourceCard(
                    title: resource.$1,
                    description: resource.$2,
                    icon: resource.$3,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              ResourceDetailScreen(title: resource.$1),
                        ),
                      );
                    },
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// ==================================================
// RESOURCE DETAIL SCREEN WITH HERO ANIMATION
// ==================================================

class ResourceDetailScreen extends StatelessWidget {
  final String title;

  const ResourceDetailScreen({super.key, required this.title});

  IconData get resourceIcon {
    switch (title) {
      case 'Programming Fundamentals':
        return Icons.code;
      case 'Web Development':
        return Icons.web;
      case 'Database Management':
        return Icons.storage;
      case 'Data Structures':
        return Icons.account_tree;
      default:
        return Icons.menu_book;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: PageEntrance(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Hero(
              tag: 'resource-icon-$title',
              child: Icon(resourceIcon, size: 85, color: AppStyles.primary),
            ),
            const SizedBox(height: 20),
            Text(title, style: AppStyles.heading),
            const SizedBox(height: 12),
            const Text(
              'Study this topic, review your notes, and practise what '
              'you have learned.',
              style: AppStyles.subtitle,
            ),
            const SizedBox(height: 18),
            const ResourceInfoTile(
              icon: Icons.menu_book,
              title: 'Read the topic',
              description: 'Review your notes and learning materials.',
            ),
            const ResourceInfoTile(
              icon: Icons.edit_note,
              title: 'Make notes',
              description: 'Write down important points and examples.',
            ),
            const ResourceInfoTile(
              icon: Icons.check_circle_outline,
              title: 'Review',
              description: 'Revise the topic after completing it.',
            ),
            const SizedBox(height: 20),
            CustomActionButton(
              label: 'Mark as Learned',
              icon: Icons.check,
              onPressed: () {
                context.read<LearningState>().markAsLearned();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Resource marked as learned!')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

// ==================================================
// COUNTER WITH ANIMATED SWITCHER
// ==================================================

class CounterWidget extends StatefulWidget {
  const CounterWidget({super.key});

  @override
  State<CounterWidget> createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Interactive Counter')),
      body: PageEntrance(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Button pressed:'),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 350),
                transitionBuilder: (child, animation) {
                  return ScaleTransition(
                    scale: animation,
                    child: FadeTransition(opacity: animation, child: child),
                  );
                },
                child: Text(
                  '$count',
                  key: ValueKey<int>(count),
                  style: const TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 10,
                children: [
                  ElevatedButton(
                    onPressed: () => setState(() => count++),
                    child: const Text('Increase'),
                  ),
                  OutlinedButton(
                    onPressed: () => setState(() => count = 0),
                    child: const Text('Reset'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ==================================================
// COURSE REGISTRATION FORM WITH VALIDATION
// ==================================================

class CourseFormScreen extends StatefulWidget {
  const CourseFormScreen({super.key});

  @override
  State<CourseFormScreen> createState() => _CourseFormScreenState();
}

class _CourseFormScreenState extends State<CourseFormScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();

  String? _selectedCourse;
  String? _gender;
  String? _experience;
  DateTime? _dateOfBirth;

  bool _acceptTerms = false;
  bool _showPassword = false;
  bool _isSubmitting = false;

  final List<String> _courses = [
    'Flutter Development',
    'Web Development',
    'Python Programming',
    'Java Programming',
    'Data Structures',
    'Database Management',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String? _validateName(String? value) {
    final name = value?.trim() ?? '';

    if (name.isEmpty) return 'Please enter your full name.';
    if (name.length < 3) {
      return 'Name must contain at least 3 characters.';
    }
    if (!RegExp(r"^[a-zA-Z][a-zA-Z .'-]*$").hasMatch(name)) {
      return 'Enter a valid name using letters only.';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    final email = value?.trim() ?? '';

    if (email.isEmpty) return 'Please enter your email address.';
    if (!RegExp(r'^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$')
        .hasMatch(email)) {
      return 'Enter a valid email, for example name@example.com.';
    }
    return null;
  }

  String? _validatePhone(String? value) {
    final phone = value?.trim() ?? '';

    if (phone.isEmpty) return 'Please enter your phone number.';
    if (!RegExp(r'^[0-9]{10}$').hasMatch(phone)) {
      return 'Phone number must contain exactly 10 digits.';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    final password = value ?? '';

    if (password.isEmpty) return 'Please create a password.';
    if (password.length < 8) {
      return 'Password must contain at least 8 characters.';
    }
    if (!RegExp(r'[A-Z]').hasMatch(password)) {
      return 'Include at least one uppercase letter.';
    }
    if (!RegExp(r'[a-z]').hasMatch(password)) {
      return 'Include at least one lowercase letter.';
    }
    if (!RegExp(r'[0-9]').hasMatch(password)) {
      return 'Include at least one number.';
    }
    return null;
  }

  void _showMessage(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: isError ? Colors.red.shade700 : null,
          behavior: SnackBarBehavior.floating,
        ),
      );
  }

  Future<void> _pickDate() async {
    final today = DateTime.now();

    try {
      final picked = await showDatePicker(
        context: context,
        initialDate: DateTime(today.year - 18, today.month, today.day),
        firstDate: DateTime(1950),
        lastDate: today,
        helpText: 'Select your date of birth',
      );

      if (!mounted || picked == null) return;
      setState(() => _dateOfBirth = picked);
    } catch (_) {
      if (!mounted) return;
      _showMessage(
        'Unable to open the date picker. Please try again.',
        isError: true,
      );
    }
  }

  Future<void> _submitForm() async {
    if (_isSubmitting) return;

    final isFormValid = _formKey.currentState?.validate() ?? false;
    final missingItems = <String>[];

    if (_selectedCourse == null) missingItems.add('select a course');
    if (_gender == null) missingItems.add('select your gender');
    if (_dateOfBirth == null) {
      missingItems.add('select your date of birth');
    }
    if (_experience == null) {
      missingItems.add('select your experience level');
    }
    if (!_acceptTerms) {
      missingItems.add('accept the terms and conditions');
    }

    if (!isFormValid || missingItems.isNotEmpty) {
      setState(() {});
      _showMessage(
        missingItems.isEmpty
            ? 'Please correct the errors in the form.'
            : 'Please ${missingItems.join(', ')}.',
        isError: true,
      );
      return;
    }

    setState(() => _isSubmitting = true);

    try {
      // Demo delay. Replace with your backend/API request.
      await Future<void>.delayed(const Duration(milliseconds: 800));

      if (!mounted) return;
      setState(() => _isSubmitting = false);

      await showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (dialogContext) => AlertDialog(
          icon: const Icon(Icons.check_circle, color: Colors.green, size: 48),
          title: const Text('Registration Successful'),
          content: Text(
            'Thank you, ${_nameController.text.trim()}!\n\n'
            'Course: $_selectedCourse\n'
            'Email: ${_emailController.text.trim()}\n\n'
            'Your form passed validation successfully.',
          ),
          actions: [
            FilledButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Done'),
            ),
          ],
        ),
      );

      if (!mounted) return;
      _clearForm();
      _showMessage('Registration completed successfully.');
    } catch (_) {
      if (!mounted) return;
      setState(() => _isSubmitting = false);
      _showMessage('Registration failed. Please try again.', isError: true);
    }
  }

  void _clearForm() {
    _formKey.currentState?.reset();
    _nameController.clear();
    _emailController.clear();
    _phoneController.clear();
    _passwordController.clear();

    setState(() {
      _selectedCourse = null;
      _gender = null;
      _experience = null;
      _dateOfBirth = null;
      _acceptTerms = false;
      _showPassword = false;
      _isSubmitting = false;
    });
  }

  String _formatDate(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    return '$day/$month/${date.year}';
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, top: 16),
      child: Text(text, style: const TextStyle(fontWeight: FontWeight.w600)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Course Registration')),
      body: SafeArea(
        child: PageEntrance(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isMobile = constraints.maxWidth < 600;

              return SingleChildScrollView(
                padding: EdgeInsets.all(isMobile ? 16 : 28),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 700),
                    child: Card(
                      color: Colors.white,
                      elevation: 2,
                      child: Padding(
                        padding: EdgeInsets.all(isMobile ? 16 : 28),
                        child: Form(
                          key: _formKey,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const LearningHeader(
                                title: 'Join a Course',
                                subtitle:
                                    'Complete all required fields to register.',
                              ),
                              _buildLabel('Full Name *'),
                              TextFormField(
                                controller: _nameController,
                                textCapitalization: TextCapitalization.words,
                                maxLength: 60,
                                decoration: const InputDecoration(
                                  hintText: 'Enter your full name',
                                  prefixIcon: Icon(Icons.person_outline),
                                  counterText: '',
                                ),
                                validator: _validateName,
                              ),
                              _buildLabel('Email Address *'),
                              TextFormField(
                                controller: _emailController,
                                keyboardType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.next,
                                decoration: const InputDecoration(
                                  hintText: 'name@example.com',
                                  prefixIcon: Icon(Icons.email_outlined),
                                ),
                                validator: _validateEmail,
                              ),
                              _buildLabel('Phone Number *'),
                              TextFormField(
                                controller: _phoneController,
                                keyboardType: TextInputType.phone,
                                maxLength: 10,
                                decoration: const InputDecoration(
                                  hintText: 'Enter 10-digit mobile number',
                                  prefixIcon: Icon(Icons.phone_outlined),
                                  counterText: '',
                                ),
                                validator: _validatePhone,
                              ),
                              _buildLabel('Create Password *'),
                              TextFormField(
                                controller: _passwordController,
                                obscureText: !_showPassword,
                                maxLength: 32,
                                decoration: InputDecoration(
                                  hintText: 'At least 8 characters',
                                  prefixIcon: const Icon(Icons.lock_outline),
                                  counterText: '',
                                  suffixIcon: IconButton(
                                    onPressed: () => setState(
                                      () => _showPassword = !_showPassword,
                                    ),
                                    icon: Icon(
                                      _showPassword
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                    ),
                                  ),
                                ),
                                validator: _validatePassword,
                              ),
                              const Text(
                                'Use uppercase, lowercase and a number.',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black54,
                                ),
                              ),
                              _buildLabel('Select Course *'),
                              DropdownButtonFormField<String>(
                                initialValue: _selectedCourse,
                                isExpanded: true,
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(Icons.school_outlined),
                                  hintText: 'Choose a course',
                                ),
                                items: _courses.map((course) {
                                  return DropdownMenuItem<String>(
                                    value: course,
                                    child: Text(course),
                                  );
                                }).toList(),
                                onChanged: (value) =>
                                    setState(() => _selectedCourse = value),
                                validator: (value) =>
                                    value == null || value.isEmpty
                                    ? 'Please select a course.'
                                    : null,
                              ),
                              _buildLabel('Gender *'),
                              RadioGroup<String>(
                                groupValue: _gender,
                                onChanged: (value) =>
                                    setState(() => _gender = value),
                                child: const Column(
                                  children: [
                                    RadioListTile<String>(
                                      value: 'Female',
                                      title: Text('Female'),
                                      contentPadding: EdgeInsets.zero,
                                    ),
                                    RadioListTile<String>(
                                      value: 'Male',
                                      title: Text('Male'),
                                      contentPadding: EdgeInsets.zero,
                                    ),
                                    RadioListTile<String>(
                                      value: 'Prefer not to say',
                                      title: Text('Prefer not to say'),
                                      contentPadding: EdgeInsets.zero,
                                    ),
                                  ],
                                ),
                              ),
                              if (_gender == null)
                                const Padding(
                                  padding: EdgeInsets.only(left: 12),
                                  child: Text(
                                    'Please select your gender.',
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              _buildLabel('Date of Birth *'),
                              InkWell(
                                onTap: _pickDate,
                                borderRadius: BorderRadius.circular(12),
                                child: InputDecorator(
                                  decoration: InputDecoration(
                                    prefixIcon: const Icon(
                                      Icons.calendar_month,
                                    ),
                                    errorText: _dateOfBirth == null
                                        ? 'Please select your date of birth.'
                                        : null,
                                  ),
                                  child: Text(
                                    _dateOfBirth == null
                                        ? 'Choose your date of birth'
                                        : _formatDate(_dateOfBirth!),
                                  ),
                                ),
                              ),
                              _buildLabel('Experience Level *'),
                              DropdownButtonFormField<String>(
                                initialValue: _experience,
                                isExpanded: true,
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(Icons.trending_up),
                                  hintText: 'Select your experience',
                                ),
                                items: const [
                                  DropdownMenuItem(
                                    value: 'Beginner',
                                    child: Text('Beginner'),
                                  ),
                                  DropdownMenuItem(
                                    value: 'Intermediate',
                                    child: Text('Intermediate'),
                                  ),
                                  DropdownMenuItem(
                                    value: 'Advanced',
                                    child: Text('Advanced'),
                                  ),
                                ],
                                onChanged: (value) =>
                                    setState(() => _experience = value),
                                validator: (value) => value == null
                                    ? 'Please select your experience level.'
                                    : null,
                              ),
                              const SizedBox(height: 12),
                              CheckboxListTile(
                                value: _acceptTerms,
                                contentPadding: EdgeInsets.zero,
                                controlAffinity:
                                    ListTileControlAffinity.leading,
                                title: const Text(
                                  'I accept the terms and conditions. *',
                                ),
                                subtitle: !_acceptTerms
                                    ? const Text(
                                        'Acceptance is required to register.',
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 12,
                                        ),
                                      )
                                    : null,
                                onChanged: (value) => setState(
                                  () => _acceptTerms = value ?? false,
                                ),
                              ),
                              const SizedBox(height: 24),
                              SizedBox(
                                width: double.infinity,
                                child: FilledButton.icon(
                                  onPressed: _isSubmitting ? null : _submitForm,
                                  icon: AnimatedSwitcher(
                                    duration: const Duration(milliseconds: 250),
                                    child: _isSubmitting
                                        ? const SizedBox(
                                            key: ValueKey('loading'),
                                            height: 18,
                                            width: 18,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 2,
                                              color: Colors.white,
                                            ),
                                          )
                                        : const Icon(
                                            Icons.app_registration,
                                            key: ValueKey('register'),
                                          ),
                                  ),
                                  label: AnimatedSwitcher(
                                    duration: const Duration(milliseconds: 250),
                                    child: Text(
                                      _isSubmitting
                                          ? 'Submitting...'
                                          : 'Submit Registration',
                                      key: ValueKey<bool>(_isSubmitting),
                                    ),
                                  ),
                                  style: FilledButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 16,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 12),
                              SizedBox(
                                width: double.infinity,
                                child: OutlinedButton.icon(
                                  onPressed: _isSubmitting ? null : _clearForm,
                                  icon: const Icon(Icons.refresh),
                                  label: const Text('Clear Form'),
                                ),
                              ),
                              const SizedBox(height: 12),
                              const Text(
                                '* Required fields. Correct any errors before submitting.',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
