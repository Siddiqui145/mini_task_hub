import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:mini_task_hub/auth/login_screen.dart';
import 'package:mini_task_hub/dashboard/task_details_screen.dart';
import 'package:mini_task_hub/widgets/custom_messages.dart';
import 'add_task_screen.dart';
import 'task_card.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {

    Future<void> signout() async {
      await FirebaseAuth.instance.signOut();
      showSuccessMessage(context, "Logged out successfully!");
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginScreen()));
    }
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      backgroundColor: const Color(0xFF212832),
      appBar: AppBar(
        backgroundColor: const Color(0xFF212832),
        elevation: 0,
        toolbarHeight: 90,
        title: Row(
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
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: Colors.white,
                      ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
            const CircleAvatar(
              radius: 32,
              backgroundImage: AssetImage('assets/images/profile.jpeg'),
            ),
          ],
        ),
        actions: [
          IconButton(onPressed: signout, icon: Icon(Icons.logout))
        ],
      ),
      body: Padding(
  padding: const EdgeInsets.symmetric(horizontal: 16),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const SizedBox(height: 50),
      _buildSectionHeader('Completed Tasks'),
      const SizedBox(height: 16),
      _buildTaskStream(context, isCompleted: true),
      const SizedBox(height: 32),
      _buildSectionHeader('Ongoing Projects'),
      const SizedBox(height: 16),
      Expanded(child: _buildTaskStream(context, isCompleted: false)),
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
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
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

        return isCompleted ? SizedBox(
          height: 160,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final task = tasks[index].data() as Map<String, dynamic>;
              final title = task['title'] ?? '';
              final progress = 100; 
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
                  dueDate:  null,
                  isCompleted: isCompleted,
                  progress: progress,
                ),
              );
            },
          ),
        )
        : ListView.builder(
          itemCount: tasks.length,
            itemBuilder: (context, index) {
              final task = tasks[index].data() as Map<String, dynamic>;
              final title = task['title'] ?? '';
              final dueDate = task['taskDateTime'] != null
                  ? DateFormat('d MMM').format(DateTime.parse(task['taskDateTime']))
                  : 'N/A';
              final progress = 60; 
              final taskId = tasks[index].id;

              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => TaskDetailScreen(taskId: taskId),
                  ));
                },
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TaskCard(
                    title: title,
                    label: 'Team members',
                    dueDate: isCompleted ? null : dueDate,
                    isCompleted: isCompleted,
                    progress: progress,
                  ),
                ),
              );
            },
          );
      },
    );
  }
}
