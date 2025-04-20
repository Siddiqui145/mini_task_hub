import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mini_task_hub/dashboard/task_details_screen.dart';

class TaskTile extends StatelessWidget {
  final String taskId;
  final String title;
  final String description;

  const TaskTile({
    super.key,
    required this.taskId,
    required this.title,
    required this.description,
  });

  Future<double> _calculateProgress() async {
    final subtasksSnapshot = await FirebaseFirestore.instance
        .collection('tasks')
        .doc(taskId)
        .collection('subtasks')
        .get();
    final total = subtasksSnapshot.docs.length;
    if (total == 0) return 0.0;
    final completed = subtasksSnapshot.docs
        .where((doc) => doc['isCompleted'] == true)
        .length;
    return completed / total;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<double>(
      future: _calculateProgress(),
      builder: (context, snapshot) {
        final progress = snapshot.data ?? 0.0;
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ListTile(
            title: Text(title),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(description),
                const SizedBox(height: 8),
                LinearProgressIndicator(value: progress),
              ],
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => TaskDetailScreen(taskId: taskId),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
