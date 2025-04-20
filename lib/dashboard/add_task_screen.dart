import 'package:flutter/material.dart';
import 'package:mini_task_hub/widgets/custom_button.dart';
import 'package:mini_task_hub/widgets/custom_text_filed.dart';
import 'package:mini_task_hub/widgets/time_date_picker.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {

  final taskTitleController = TextEditingController();
  final taskDetailsController = TextEditingController();

  void addTaskToDb() {}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(33, 40, 50, 1),
      appBar: AppBar(
        title: Text('Create New Task',style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.white),),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(33, 40, 50, 1),
        foregroundColor: Colors.white,
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
            style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.white),),
            const SizedBox(
              height: 25,
            ),
            CustomTextFiled(controller: taskTitleController),
            const SizedBox(
              height: 25,
            ),

            Text('Task Details',
            style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.white),),
            const SizedBox(
              height: 25,
            ),
            CustomTextFiled(controller: taskDetailsController, height: 150,),
            const SizedBox(
              height: 25,
            ),

            Text('Time & Date',
            style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.white),),
            const SizedBox(
              height: 25,
            ),
            TimeDatePickerRow(onTimeSelected: (time) {
              print("Selected time: $time");
            }, onDateSelected: (date) {
              print("Selected date: $date");
            }),

            const SizedBox(
              height: 65,
            ),
            CustomButton(
            label: 'Create', onPressed: addTaskToDb,
            backgroundColor: Colors.yellow.shade300,
            )
          ],
        ),),
      ),
    );
  }
}