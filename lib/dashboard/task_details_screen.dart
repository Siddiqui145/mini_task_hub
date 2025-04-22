import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';
import 'package:mini_task_hub/widgets/custom_messages.dart';

class TaskDetailScreen extends StatelessWidget {
  final String taskId;

  const TaskDetailScreen({super.key, required this.taskId});

  @override
  Widget build(BuildContext context) {

    Future<void> deleteTask() async {
      showDialog(context: context, builder: (context) {
      return AlertDialog(
        content: Text("Do you want to Delete this Task?",
        style: Theme.of(context).textTheme.bodyMedium,),
        actions: [
          TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text("No",style: Theme.of(context).textTheme.bodySmall!.copyWith(
            color: Colors.green
          ),)),

          TextButton(
          onPressed: () async {
            await FirebaseFirestore.instance.collection("tasks").doc(taskId).delete();

            if(!context.mounted) return;
                  Navigator.of(context).pop();
                  showSuccessMessage(context, "Task Deleted Successfully!");
          },
          child: Text("Yes",style: Theme.of(context).textTheme.bodySmall!.copyWith(
            color: Colors.red
          ),))
        ],
      );
    });
    }

    Future<void> updateStatus() async{
      FirebaseFirestore.instance.collection("tasks").doc(taskId).update({
        "completed": true
      });
      showSuccessMessage(context, "Task Completed Successfully!");
      Navigator.of(context).pop();
    }

    final taskRef = FirebaseFirestore.instance.collection('tasks').doc(taskId);
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Task Details'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: deleteTask,
          ),
          SizedBox(width: 16),
        ],
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: taskRef.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text("Error loading task", style: TextStyle(color: Colors.white)));
          }
          if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Center(child: CircularProgressIndicator());
          }

          final task = snapshot.data!.data() as Map<String, dynamic>;
          final title = task['title'] ?? '';
          final details = task['details'] ?? '';
          final dueDate = DateTime.tryParse(task['taskDateTime'] ?? '') ?? DateTime.now();
          final createdAt = DateTime.tryParse(task['createdAt'] ?? '') ?? DateTime.now();
          final formattedCreatedAt = DateFormat('d MMMM yyyy, h:mm a').format(createdAt);
          final isCompleted = task['completed'] ?? false;

          final progressValue = isCompleted ? 1.0 : 0.6;
          final progressText = isCompleted ? '100%' : '60%';


          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                Text(
                  title,
                  style: textTheme.titleLarge
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _InfoCard(
                      icon: Icons.calendar_month,
                      label: 'Due Date',
                      value: DateFormat('d MMMM').format(dueDate),
                    ),
                    _InfoCard(
                      icon: Icons.group,
                      label: 'Project Team',
                      avatars: const [
                        'assets/images/avatars/avatar1.jpg',
                        'assets/images/avatars/avatar2.jpg',
                        'assets/images/avatars/avatar3.jpeg',
                      ],
                    ).animate().fadeIn(delay: 200.ms),
                  ],
                ),
                const SizedBox(height: 24),
                Text(
                  'Project Details',
                  style: textTheme.titleMedium
                ),
                const SizedBox(height: 8),
                Text(
                  details,
                  style: textTheme.bodyMedium,
                ),
                const SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Project Progress',
                      style: textTheme.titleMedium
                    ),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          width: 50,
                          height: 50,
                          child: CircularProgressIndicator(
                            value: progressValue,
                            strokeWidth: 5,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.yellow.shade300),
                            backgroundColor: Colors.white12,
                          ),
                        ),
                        Text(
                          progressText,
                          style: textTheme.bodyMedium
                        ).animate().slideY(),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Text(
                  'Project Created At:',
                  style: textTheme.titleMedium
                ),
                SizedBox(height: 15,),
                Text(
                  formattedCreatedAt.toString(),
                  style: textTheme.bodyMedium
                ).animate().fadeIn().scale(),
                const SizedBox(height: 75),

                if(!isCompleted)
                SizedBox(
                  width: 75,
                  height: 50,
                  child: ElevatedButton.icon(
                    onPressed: updateStatus, 
                    icon: Icon(Icons.done),
                    label: Text('Mark as Completed?',style: textTheme.bodyMedium,),),
                )

              ],
            ),
          );
        },
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String? value;
  final List<String>? avatars;

  const _InfoCard({
    required this.icon,
    required this.label,
    this.value,
    this.avatars,
  });

  @override
  Widget build(BuildContext context) {
    final bool isAvatar = avatars != null;
    return Container(
      padding: const EdgeInsets.all(12),
      width: MediaQuery.of(context).size.width * 0.4,
      decoration: BoxDecoration(
        color: const Color(0xFF2A323E),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(icon, color: Colors.yellow.shade300, size: 28),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(color: Colors.white60, fontSize: 13),
          ),
          const SizedBox(height: 8),
          if (isAvatar)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: avatars!.map((path) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2),
                  child: CircleAvatar(
                    radius: 14,
                    backgroundImage: AssetImage(path),
                  ),
                );
              }).toList(),
            )
          else
            Text(
              value ?? '',
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
        ],
      ),
    );
  }
}
