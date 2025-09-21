import 'package:flutter/material.dart';
import 'icon_label.dart';

class TaskCard extends StatelessWidget {
  final String title;
  final String description;
  final String priority;
  final String? dueDate;
  final String? assignee;

  const TaskCard({
    super.key,
    required this.title,
    required this.description,
    required this.priority,
    this.dueDate,
    this.assignee,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(description),
            const SizedBox(height: 8),
            Row(
              children: [
                _PriorityBadge(priority: priority),
                const SizedBox(width: 12),
                IconLabel(
                  icon: Icons.person_outline,
                  label: assignee ?? 'Unassigned',
                  color: Colors.black54,
                ),
                const SizedBox(width: 12),
                IconLabel(
                  icon: Icons.access_time,
                  label: dueDate ?? 'No due date',
                  color: Colors.black54,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _PriorityBadge extends StatelessWidget {
  final String priority;

  const _PriorityBadge({required this.priority});

  @override
  Widget build(BuildContext context) {
    Color color;
    switch (priority.toLowerCase()) {
      case 'high':
        color = Colors.red;
        break;
      case 'medium':
        color = Colors.orange;
        break;
      case 'low':
        color = Colors.green;
        break;
      default:
        color = Colors.grey;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(priority, style: TextStyle(color: color, fontWeight: FontWeight.bold)),
    );
  }
}
