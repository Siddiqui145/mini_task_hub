import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mini_task_hub/dashboard/add_task_screen.dart';
import 'package:mini_task_hub/dashboard/task_tile.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(33, 40, 50, 1),
      appBar: AppBar(
        title: Text('Tasks',style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.white),),
        actions: [
          IconButton(onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddTaskScreen())),
           icon: Icon(Icons.add, color: Colors.white,))
        ],
        backgroundColor: Color.fromRGBO(33, 40, 50, 1),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('tasks').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Error loading tasks'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData){
            return const Center(child: Text("No Tasks Yet!"));
          }
          final tasks = snapshot.data!.docs;
          return ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final taskData = tasks[index].data() as Map<String, dynamic>;
              final taskId = tasks[index].id;
              return TaskTile(
                taskId: taskId,
                title: taskData['title'] ?? '',
                description: taskData['description'] ?? '',
              );
            },
          );
        },
      ),
    );
  }
}
