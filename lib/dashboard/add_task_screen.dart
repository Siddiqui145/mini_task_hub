import 'package:flutter/material.dart';
import 'package:mini_task_hub/dashboard/dashboard_screen.dart';
import 'package:mini_task_hub/widgets/custom_button.dart';
import 'package:mini_task_hub/widgets/custom_messages.dart';
import 'package:mini_task_hub/widgets/custom_text_filed.dart';
import 'package:mini_task_hub/widgets/time_date_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  TimeOfDay? selectedTime;
  DateTime? selectedDate;

  final taskTitleController = TextEditingController();
  final taskDetailsController = TextEditingController();


  Future<void> uploadUserTask() async{
    final userId = FirebaseAuth.instance.currentUser?.uid;
    final title = taskTitleController.text.trim();
    final details = taskDetailsController.text.trim();

    if (selectedDate == null || selectedTime == null) {
     showErrorMessage(context, "Select Time& Date");
      return;
    }

    if (title.isEmpty || details.isEmpty) {
    showErrorMessage(context, "Title & Details can't be empty!"); 
      return;
    }

    final DateTime taskDateTime = DateTime(
      selectedDate!.year,
      selectedDate!.month,
      selectedDate!.day,
      selectedTime!.hour,
      selectedTime!.minute,
    );

    await FirebaseFirestore.instance.collection("tasks").add({
      "uid": userId,
      "title": title,
      "details": details,
      "taskDateTime": taskDateTime.toIso8601String(),
      "createdAt": DateTime.now().toIso8601String(),
      "completed": false,
    });

    if(!mounted) return;
    showSuccessMessage(context, "Task Saved Successfully!");
    Navigator.of(context).pop();
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => DashboardScreen()));
  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Create New Task',style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w500)),
        ),
      
        body: SingleChildScrollView(
          child: Padding(padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 25,
              ),
              Text('Task Title',
              style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(
                height: 25,
              ),
              CustomTextField(controller: taskTitleController, hintText: "Title",),
              const SizedBox(
                height: 25,
              ),
      
              Text('Task Details',
              style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(
                height: 25,
              ),
              CustomTextField(controller: taskDetailsController, height: 150, hintText: "Details", maxLines: 5,),
              const SizedBox(
                height: 25,
              ),
      
              Text('Task to be Completed by',
              style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(
                height: 25,
              ),
              TimeDatePickerRow(onTimeSelected: (time) {
                FocusScope.of(context).unfocus;
                setState(() {
                  selectedTime = time;
                });
              }, onDateSelected: (date) {
                FocusScope.of(context).unfocus;
                setState(() {
                  selectedDate = date;
                });
              }),
      
              const SizedBox(
                height: 65,
              ),
              CustomButton(
              label: 'Create', 
              onPressed: uploadUserTask,
              )
            ],
          ),),
        ),
      ),
    );
  }
}