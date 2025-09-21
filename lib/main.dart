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
      'dueDate': 'Today',
      'assignee': 'Theo',
      'tags': ['Testing', 'Flutter'],
    },
    {
      'title': 'Refactor auth',
      'description': 'Move logic into a reusable AuthService and clean up UI.',
      'priority': 'Low',
      'dueDate': 'Next Week',
      'assignee': 'John',
      'tags': ['Backend', 'Security'],
    },
    {
      'title': 'Design review',
      'description': 'Prepare slides for Friday review with product.',
      'priority': 'High',
      'dueDate': 'Friday',
      'assignee': 'Dave',
      'tags': ['Design', 'Review'],
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
            title: t['title']! as String,
            description: t['description']! as String,
            priority: t['priority']! as String,
            dueDate: t['dueDate'] as String?,
            assignee: t['assignee'] as String?,
            tags: (t['tags'] as List<dynamic>?)?.cast<String>(),
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
    final titleController = TextEditingController(text: 'Weekly sync notes');
    final descController = TextEditingController(text: 'Discuss weekly updates');
    String selectedPriority = 'High';

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => StatefulBuilder(
        builder: (context, setState) {
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
                  TextField(
                    controller: titleController,
                    decoration: const InputDecoration(labelText: 'Title'),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: descController,
                    maxLines: 2,
                    decoration: const InputDecoration(labelText: 'Description'),
                  ),
                  const SizedBox(height: 8),
                  DropdownButton<String>(
                    value: selectedPriority,
                    isExpanded: true,
                    items: ['High', 'Medium', 'Low']
                        .map((p) => DropdownMenuItem(value: p, child: Text(p)))
                        .toList(),
                    onChanged: (v) {
                      if (v != null) setState(() => selectedPriority = v);
                    },
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue.shade700,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  '(UI-only) Task "${titleController.text}" created with priority $selectedPriority',
                                ),
                                duration: const Duration(seconds: 2),
                              ),
                            );
                          },
                          child: const Text('Create (UI-only)'),
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
      ),
    );
  }
}

/// ---------------------------
/// Widget: TaskCard (Stateless)
/// ---------------------------
class TaskCard extends StatelessWidget {
  final String title;
  final String description;
  final String priority;
  final String? dueDate;
  final String? assignee;
  final List<String>? tags;
  final bool isImportant;

  const TaskCard({
    super.key,
    required this.title,
    required this.description,
    required this.priority,
    this.dueDate,
    this.assignee,
    this.tags,
    this.isImportant = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top row: Priority badge and due date
            Row(
              children: [
                _PriorityBadge(priority: priority),
                const Spacer(),
                IconLabel(
                  icon: Icons.access_time,
                  label: dueDate ?? 'No due date',
                  color: priority.toLowerCase() == 'high'
                      ? Colors.blue.shade700
                      : Colors.black54,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
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
                  label: assignee ?? 'Unassigned',
                  color: priority.toLowerCase() == 'high'
                      ? Colors.blue.shade600
                      : Colors.black54,
                ),
                const SizedBox(width: 12),
                IconLabel(
                  icon: Icons.task_alt,
                  label: priority,
                  color: priority.toLowerCase() == 'high'
                      ? Colors.blue.shade800
                      : Colors.black54,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// ---------------------------
/// Small private sub-widget
/// ---------------------------
class _PriorityBadge extends StatelessWidget {
  final String priority;

  const _PriorityBadge({required this.priority});

  Color get _color =>
      priority.toLowerCase() == 'high' ? Colors.blue.shade800 : Colors.black54;

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
/// Simple personalized IconLabel widget
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
        Icon(icon, size: iconSize, color: effectiveColor),
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
