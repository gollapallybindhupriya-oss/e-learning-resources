
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

  static const TextStyle heading = TextStyle(
    fontSize: 25,
    fontWeight: FontWeight.bold,
    color: Color(0xFF202A44),
  );

  static const TextStyle subtitle = TextStyle(
    fontSize: 15,
    color: Color(0xFF64748B),
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

// ================= APP =================

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
        ),
        scaffoldBackgroundColor: AppStyles.background,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppStyles.primary,
          foregroundColor: Colors.white,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppStyles.primary,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(
              horizontal: 22,
              vertical: 14,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
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
        '/form': (_) => const CourseFormScreen(),
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

            const SizedBox(height: 12),

            CustomActionButton(
              text: 'Register for a Course',
              icon: Icons.app_registration,
              onPressed: () {
                Navigator.pushNamed(context, '/form');
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
            const CounterWidget(),
          ],
        ),
      ),
    );
  }
}

// ================= HEADER =================

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
        Text(title, style: AppStyles.heading),
        if (subtitle != null) ...[
          const SizedBox(height: 5),
          Text(subtitle!, style: AppStyles.subtitle),
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
          onTap: () => Navigator.pushNamed(context, route),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Icon(icon, size: 40, color: AppStyles.primary),
                const SizedBox(height: 12),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(description, style: AppStyles.subtitle),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ================= CUSTOM BUTTON =================

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

// ================= PROVIDER PROGRESS =================

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
          style: AppStyles.heading,
        ),
      ),
    );
  }
}

// ================= RESOURCE TILE =================

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
        title: Text(title),
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
            Text('Button clicked: $count times'),
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

// ================= COURSE REGISTRATION FORM =================

class CourseFormScreen extends StatefulWidget {
  const CourseFormScreen({super.key});

  @override
  State<CourseFormScreen> createState() => _CourseFormScreenState();
}

class _CourseFormScreenState extends State<CourseFormScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();

  String? _selectedCourse;
  String? _gender;
  String _experience = 'Beginner';
  DateTime? _dateOfBirth;
  bool _acceptedTerms = false;
  bool _showPassword = false;

  final List<String> _courses = [
    'Flutter Development',
    'Dart Programming',
    'Web Development',
    'UI/UX Design',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();

    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime(now.year - 18, now.month, now.day),
      firstDate: DateTime(1950),
      lastDate: now,
    );

    if (picked != null) {
      setState(() {
        _dateOfBirth = picked;
      });
    }
  }

  void _submitForm() {
    if (!_formKey.currentState!.validate()) return;

    if (_gender == null || _selectedCourse == null ||
        _dateOfBirth == null || !_acceptedTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Please select gender, course, date of birth, and accept the terms.',
          ),
        ),
      );
      return;
    }

    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Registration Successful'),
        content: Text(
          'Thank you, ${_nameController.text.trim()}!\n'
          'Course: $_selectedCourse\n'
          'Experience: $_experience',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              Navigator.pop(context);
            },
            child: const Text('Done'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 600;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Course Registration'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(isMobile ? 16 : 32),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 650),
            child: Card(
              child: Padding(
                padding: EdgeInsets.all(isMobile ? 18 : 28),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SectionTitle(
                        title: 'Registration Form',
                        subtitle: 'Enter your details to enroll in a course',
                      ),
                      const SizedBox(height: 24),

                      TextFormField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                          labelText: 'Full Name',
                          prefixIcon: Icon(Icons.person),
                          hintText: 'Enter your full name',
                        ),
                        textCapitalization: TextCapitalization.words,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 16),

                      TextFormField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                          labelText: 'Email Address',
                          prefixIcon: Icon(Icons.email),
                          hintText: 'example@email.com',
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null ||
                              !RegExp(r'^[^@]+@[^@]+\.[^@]+$')
                                  .hasMatch(value.trim())) {
                            return 'Enter a valid email address';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 16),

                      TextFormField(
                        controller: _phoneController,
                        decoration: const InputDecoration(
                          labelText: 'Phone Number',
                          prefixIcon: Icon(Icons.phone),
                        ),
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value == null ||
                              !RegExp(r'^\d{10}$').hasMatch(value.trim())) {
                            return 'Enter a 10-digit phone number';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 16),

                      TextFormField(
                        controller: _passwordController,
                        obscureText: !_showPassword,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          prefixIcon: const Icon(Icons.lock),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _showPassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            onPressed: () {
                              setState(() {
                                _showPassword = !_showPassword;
                              });
                            },
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.length < 6) {
                            return 'Password must have at least 6 characters';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 16),

                      DropdownButtonFormField<String>(
                        value: _selectedCourse,
                        decoration: const InputDecoration(
                          labelText: 'Select Course',
                          prefixIcon: Icon(Icons.school),
                        ),
                        items: _courses.map((course) {
                          return DropdownMenuItem(
                            value: course,
                            child: Text(course),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedCourse = value;
                          });
                        },
                        validator: (value) =>
                            value == null ? 'Please select a course' : null,
                      ),

                      const SizedBox(height: 16),

                      const Text(
                        'Gender',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),

                      RadioGroup<String>(
                        groupValue: _gender,
                        onChanged: (value) {
                          setState(() {
                            _gender = value;
                          });
                        },
                        child: const Column(
                          children: [
                            RadioListTile<String>(
                              title: Text('Female'),
                              value: 'Female',
                            ),
                            RadioListTile<String>(
                              title: Text('Male'),
                              value: 'Male',
                            ),
                            RadioListTile<String>(
                              title: Text('Prefer not to say'),
                              value: 'Prefer not to say',
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 12),

                      OutlinedButton.icon(
                        onPressed: _pickDate,
                        icon: const Icon(Icons.calendar_month),
                        label: Text(
                          _dateOfBirth == null
                              ? 'Select Date of Birth'
                              : 'Date of Birth: '
                                  '${_dateOfBirth!.day}/'
                                  '${_dateOfBirth!.month}/'
                                  '${_dateOfBirth!.year}',
                        ),
                      ),

                      const SizedBox(height: 20),

                      DropdownButtonFormField<String>(
                        value: _experience,
                        decoration: const InputDecoration(
                          labelText: 'Experience Level',
                          prefixIcon: Icon(Icons.trending_up),
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
                        onChanged: (value) {
                          if (value != null) {
                            setState(() {
                              _experience = value;
                            });
                          }
                        },
                      ),

                      const SizedBox(height: 12),

                      CheckboxListTile(
                        contentPadding: EdgeInsets.zero,
                        value: _acceptedTerms,
                        controlAffinity: ListTileControlAffinity.leading,
                        title: const Text(
                          'I accept the terms and conditions',
                        ),
                        onChanged: (value) {
                          setState(() {
                            _acceptedTerms = value ?? false;
                          });
                        },
                      ),

                      const SizedBox(height: 20),

                      CustomActionButton(
                        text: 'Submit Registration',
                        icon: Icons.send,
                        onPressed: _submitForm,
                      ),

                      const SizedBox(height: 8),

                      TextButton(
                        onPressed: () {
                          _formKey.currentState?.reset();
                          _nameController.clear();
                          _emailController.clear();
                          _passwordController.clear();
                          _phoneController.clear();

                          setState(() {
                            _selectedCourse = null;
                            _gender = null;
                            _experience = 'Beginner';
                            _dateOfBirth = null;
                            _acceptedTerms = false;
                            _showPassword = false;
                          });
                        },
                        child: const Text('Clear Form'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
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

// ================= DETAIL SCREEN =================

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
              Text(title, style: AppStyles.heading),
              const SizedBox(height: 12),
              const Text(
                'Explore this learning resource.',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 15),
              Text(
                'Resources marked as learned: '
                '${learningState.completedResources}',
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
