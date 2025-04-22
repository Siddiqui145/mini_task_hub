import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mini_task_hub/auth/login_screen.dart';
import 'package:mini_task_hub/dashboard/task_details_screen.dart';
import 'package:mini_task_hub/providers/cubit_theme.dart';
import 'package:mini_task_hub/widgets/custom_messages.dart';
import 'add_task_screen.dart';
import 'task_card.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  Future<void> signout() async {
    showDialog(context: context, builder: (context) {
      return AlertDialog(
        content: Text("Do you really want to Logout?",
        style: Theme.of(context).textTheme.bodyMedium,),
        actions: [
          TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text("No",style: Theme.of(context).textTheme.bodySmall!.copyWith(
            color: Colors.green
          ),)),

          TextButton(
          onPressed: () async {
            await FirebaseAuth.instance.signOut();
            if(!context.mounted) return;
            showSuccessMessage(context, "Logged out successfully!");
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginScreen()));
          },
          child: Text("Yes",style: Theme.of(context).textTheme.bodySmall!.copyWith(
            color: Colors.red
          ),))
        ],
      );
    });
    }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final themeMode = context.watch<CubitTheme>().state;
    final isDark = themeMode == ThemeMode.dark;

    return Scaffold(
      appBar: AppBar(
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
                  style: Theme.of(context).textTheme.titleSmall,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
            const CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage('assets/images/profile.jpeg'),
            ),
          ],
        ),
        actions: [
          IconButton(onPressed: signout, icon: Icon(Icons.logout)),
          Switch(value: isDark, onChanged: (value) {
            context.read<CubitTheme>().toggleTheme(value);
          } )
        ],
      ),
      body: Padding(
  padding: const EdgeInsets.symmetric(horizontal: 16),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const SizedBox(height: 50),
      _buildSectionHeader('Completed Tasks').animate().fade(duration: 300.ms).slideX(begin: -0.1),
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
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const AddTaskScreen()),
          );
        },
        child: const Icon(Icons.add
        )
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Widget _buildSectionHeader(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            style: Theme.of(context).textTheme.titleSmall
            ),
         Text(
          'See all',
          style: Theme.of(context).textTheme.bodySmall
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
  return Center(
    child: Text(
      "No Tasks Completed Yet!",
      style: Theme.of(context).textTheme.bodyMedium
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
                ).animate()
                .fade(duration: 400.ms)
                .slideY(begin: 0.2)
                .then(delay: 100.ms),
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
                  ).animate()
                .fade(duration: 400.ms)
                .slideY(begin: 0.2)
                .then(delay: 100.ms),
                ),
              );
            },
          );
      },
    );
  }
}
