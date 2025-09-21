// main.dart
import 'package:flutter/material.dart';

void main() => runApp(const TaskApp());

class TaskApp extends StatelessWidget {
  const TaskApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Widget Fundamentals Demo',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black87,
          foregroundColor: Colors.white,
        ),
      ),
      home: const TaskListPage(),
    );
  }
}

class TaskListPage extends StatelessWidget {
  const TaskListPage({super.key});

  static final _demoTasks = [
    {
      'title': 'Write unit tests',
      'description': 'Cover TaskCard widget and interactive behavior.',
      'priority': 'High',
    },
    {
      'title': 'Refactor auth',
      'description': 'Move logic into a reusable AuthService and clean up UI.',
      'priority': 'Low',
    },
    {
      'title': 'Design review',
      'description': 'Prepare slides for Friday review with product.',
      'priority': 'High',
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tasks')),
      body: ListView.separated(
        padding: const EdgeInsets.all(12),
        itemCount: _demoTasks.length,
        separatorBuilder: (_, __) => const SizedBox(height: 8),
        itemBuilder: (context, i) {
          final t = _demoTasks[i];
          return TaskCard(
            title: t['title']!,
            description: t['description']!,
            priority: t['priority']!,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openAddModal(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _openAddModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Add Task', style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 12),
                const TextField(
                  decoration: InputDecoration(labelText: 'Title'),
                ),
                const SizedBox(height: 8),
                const TextField(
                  maxLines: 2,
                  decoration: InputDecoration(labelText: 'Description'),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Create (UI only)'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        );
      },
    );
  }
}

/// ---------------------------
/// Widget: TaskCard (Stateless)
/// ---------------------------
/// You can extract this to its own file: widgets/task_card.dart
class TaskCard extends StatelessWidget {
  final String title;
  final String description;
  final String priority;

  const TaskCard({
    super.key,
    required this.title,
    required this.description,
    required this.priority,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                      // Personalized IconLabel with due date
                      IconLabel(
                        icon: Icons.access_time,
                        label: 'Due Today',
                        color: Colors.blue.shade600,
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      IconLabel(
                        icon: Icons.person_outline,
                        label: 'John Doe',
                        color: Colors.black54,
                      ),
                      const SizedBox(width: 12),
                      IconLabel(
                        icon: Icons.task_alt,
                        label: '3/5 done',
                        color: Colors.blue.shade700,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            _PriorityBadge(priority: priority),
          ],
        ),
      ),
    );
  }
}

/// Small private sub-widget (extractable)
class _PriorityBadge extends StatelessWidget {
  final String priority;

  const _PriorityBadge({required this.priority});

  Color get _color => priority.toLowerCase() == 'high' 
      ? Colors.blue.shade800 
      : Colors.black54;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: _color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        priority,
        style: TextStyle(color: _color, fontWeight: FontWeight.w600),
      ),
    );
  }
}

/// ---------------------------
/// Personalized IconLabel widget with color support
/// ---------------------------
class IconLabel extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color? color;
  final double iconSize;
  final double spacing;

  const IconLabel({
    super.key,
    required this.icon,
    required this.label,
    this.color,
    this.iconSize = 18.0,
    this.spacing = 8.0,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveColor = color ?? Theme.of(context).colorScheme.onSurface;
    
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: iconSize,
          color: effectiveColor,
        ),
        SizedBox(width: spacing),
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: effectiveColor,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
