import 'package:flutter/material.dart';
import 'package:mini_task_hub/themes/task_card_theme.dart';

class TaskCard extends StatelessWidget {
  final String title;
  final String label;
  final String? dueDate;
  final bool isCompleted;
  final int progress; // from 0 to 100

  const TaskCard({
    super.key,
    required this.title,
    required this.label,
    this.dueDate,
    required this.isCompleted,
    this.progress = 0,
  });

  @override
Widget build(BuildContext context) {
  final theme = Theme.of(context).extension<TaskCardTheme>()!;
  final bool completed = isCompleted;

  return Container(
    width: 175,
    margin: const EdgeInsets.only(right: 16),
    padding: const EdgeInsets.only(left: 16, right: 8, bottom: 8),
    decoration: BoxDecoration(
      color: completed ? Colors.grey.shade100 : theme.backgroundColor,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: completed ? Colors.black : theme.foregroundColor,
            fontSize: 18,
            height: 1.3,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          label,
          style: TextStyle(
            color: completed ? Colors.black87 : theme.labelColor,
            fontSize: 13,
          ),
        ),
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: const [
            CircleAvatar(radius: 18, backgroundImage: AssetImage("assets/images/avatars/avatar1.jpg")),
            CircleAvatar(radius: 18, backgroundImage: AssetImage("assets/images/avatars/avatar2.jpg")),
            CircleAvatar(radius: 18, backgroundImage: AssetImage("assets/images/avatars/avatar3.jpeg")),
          ],
        ),
        const SizedBox(height: 16),
        if (completed) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Completed',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: theme.completedTextColor,
                  fontSize: 14,
                ),
              ),
              Text(
                '100%',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: theme.completedTextColor,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ] else ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Due on : $dueDate',
                style: TextStyle(
                  color: theme.labelColor,
                  fontSize: 13,
                ),
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 32,
                    height: 32,
                    child: CircularProgressIndicator(
                      value: progress / 100,
                      strokeWidth: 4,
                      valueColor: AlwaysStoppedAnimation<Color>(theme.progressColor),
                      backgroundColor: Colors.white12,
                    ),
                  ),
                  Text(
                    '$progress%',
                    style: TextStyle(color: theme.foregroundColor, fontSize: 10),
                  ),
                ],
              )
            ],
          ),
        ],
      ],
    ),
  );
}

}
