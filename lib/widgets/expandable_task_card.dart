import 'package:flutter/material.dart';
import 'icon_label.dart';

class ExpandableTaskCard extends StatefulWidget {
  final String title;
  final String description;
  final String priority;
  final String? dueDate;
  final String? assignee;

  const ExpandableTaskCard({
    super.key,
    required this.title,
    required this.description,
    required this.priority,
    this.dueDate,
    this.assignee,
  });

  @override
  State<ExpandableTaskCard> createState() => _ExpandableTaskCardState();
}

class _ExpandableTaskCardState extends State<ExpandableTaskCard> {
  bool _expanded = false;
  bool _done = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () => setState(() => _expanded = !_expanded),
              child: Row(
                children: [
                  _PriorityBadge(priority: widget.priority),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      widget.title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                  Checkbox(
                    value: _done,
                    onChanged: (v) => setState(() => _done = v ?? false),
                  ),
                  Icon(_expanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down),
                ],
              ),
            ),
            AnimatedCrossFade(
              firstChild: const SizedBox.shrink(),
              secondChild: Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.description),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        IconLabel(
                          icon: Icons.person_outline,
                          label: widget.assignee ?? 'Unassigned',
                          color: Colors.black54,
                        ),
                        const SizedBox(width: 12),
                        IconLabel(
                          icon: Icons.access_time,
                          label: widget.dueDate ?? 'No due date',
                          color: Colors.black54,
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {},
                          child: const Text('Action 1'),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: () {},
                          child: const Text('Action 2'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              crossFadeState:
                  _expanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
              duration: const Duration(milliseconds: 200),
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
