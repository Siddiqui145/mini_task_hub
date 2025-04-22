import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:mini_task_hub/dashboard/task_details_screen.dart';
import 'add_task_screen.dart';
import 'task_card.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      backgroundColor: const Color(0xFF212832),
      appBar: AppBar(
        backgroundColor: const Color(0xFF212832),
        elevation: 0,
        toolbarHeight: 90,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Welcome Back!",
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: Colors.yellow.shade300,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    user?.email ?? '',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                  ),
                ],
              ),
              const CircleAvatar(
                radius: 32,
                backgroundImage: AssetImage('assets/images/profile.jpeg'),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView(
          children: [
            const SizedBox(height: 50),
            _buildSectionHeader('Completed Tasks'),
            const SizedBox(height: 16),
            _buildTaskStream(
              context,
              isCompleted: true,
            ),
            const SizedBox(height: 32),
            _buildSectionHeader('Ongoing Projects'),
            const SizedBox(height: 16),
            _buildTaskStream(
              context,
              isCompleted: false,
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.yellow.shade300,
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const AddTaskScreen()),
          );
        },
        child: const Icon(Icons.add, color: Colors.black),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: const BottomAppBar(
        shape: CircularNotchedRectangle(),
        color: Color(0xFF2A323E),
        child: SizedBox(height: 60),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            )),
        const Text(
          'See all',
          style: TextStyle(
            fontSize: 14,
            color: Colors.white54,
          ),
        ),
      ],
    );
  }

  Widget _buildTaskStream(BuildContext context, {required bool isCompleted}) {
    final userId = FirebaseAuth.instance.currentUser!.uid;

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('tasks')
          .where('uid', isEqualTo: userId)
          .where('completed', isEqualTo: isCompleted)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
      }

      if (snapshot.hasError) {
  return const Center(child: Text("Something went wrong"));
}

      if (snapshot.hasData && snapshot.data!.docs.isEmpty) {
  return const Center(
    child: Text(
      "No Tasks Completed Yet!",
      style: TextStyle(color: Colors.white70),
    ),
  );
}


        final tasks = snapshot.data!.docs;

        return SizedBox(
          height: isCompleted ? 170 : 150,
          child: ListView.builder(
            scrollDirection: isCompleted ? Axis.horizontal : Axis.vertical,
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final task = tasks[index].data() as Map<String, dynamic>;
              final title = task['title'] ?? '';
              final dueDate = task['taskDateTime'] != null
                  ? DateFormat('d MMM').format(DateTime.parse(task['taskDateTime']))
                  : 'N/A';
              final progress = isCompleted ? 100 : 60; 
              final taskId = tasks[index].id;

              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => TaskDetailScreen(taskId: taskId),
                  ));
                },
                child: TaskCard(
                  title: title,
                  label: 'Team members',
                  dueDate: isCompleted ? null : dueDate,
                  isCompleted: isCompleted,
                  progress: progress,
                ),
              );
            },
          ),
        );
      },
    );
  }
}
