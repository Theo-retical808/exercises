import 'package:flutter/material.dart';
import 'widgets/task_card.dart';
import 'widgets/expandable_task_card.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Manager',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.grey[100],
      ),
      home: const TaskListPage(),
    );
  }
}

class Task {
  final String title;
  final String description;
  final String priority;
  final String? dueDate;
  final String? assignee;

  Task({
    required this.title,
    required this.description,
    required this.priority,
    this.dueDate,
    this.assignee,
  });
}

// Custom demo tasks
final List<Task> _demoTasks = [
  Task(
    title: 'Finish Flutter App Activity',
    description: 'Complete the personalized widgets and expandable task card activity for Flutter class.',
    priority: 'High',
    dueDate: 'Today 11:59 PM',
    assignee: 'Theo',
  ),
  Task(
    title: 'Attend CS Lecture',
    description: 'Join the online lecture for Data Structures class and take notes.',
    priority: 'Medium',
    dueDate: 'Today 2:00 PM',
    assignee: 'Self',
  ),
  Task(
    title: 'Work on Freelance Web Project',
    description: 'Implement the new feature requested by the client for the website dashboard.',
    priority: 'Medium',
    dueDate: 'Tomorrow 6:00 PM',
    assignee: 'Self',
  ),
  Task(
    title: 'University Organization Meeting',
    description: 'Participate in student council planning meeting for upcoming university events.',
    priority: 'Low',
    dueDate: 'Today 5:00 PM',
    assignee: 'Student Council',
  ),
  Task(
    title: 'Evening Workout',
    description: 'Follow the calisthenics routine in Thenix app for daily strength training.',
    priority: 'Low',
    dueDate: 'Today 8:00 PM',
    assignee: 'Self',
  ),
];

class TaskListPage extends StatelessWidget {
  const TaskListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Tasks'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: _demoTasks.length,
        itemBuilder: (context, index) {
          final task = _demoTasks[index];

          // Using ExpandableTaskCard for demo
          return ExpandableTaskCard(
            title: task.title,
            description: task.description,
            priority: task.priority,
            dueDate: task.dueDate,
            assignee: task.assignee,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showCreateTaskModal(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showCreateTaskModal(BuildContext context) {
    String selectedPriority = 'Medium';
    final titleController = TextEditingController(text: 'Weekly sync notes');
    final descriptionController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 16,
            right: 16,
            top: 16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Create Task',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
              ),
              const SizedBox(height: 12),
              DropdownButton<String>(
                value: selectedPriority,
                items: ['High', 'Medium', 'Low']
                    .map((p) => DropdownMenuItem(
                          value: p,
                          child: Text(p),
                        ))
                    .toList(),
                onChanged: (v) => setState(() => selectedPriority = v!),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('(UI-only) Task created')),
                    );
                  },
                  child: const Text('Create'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
