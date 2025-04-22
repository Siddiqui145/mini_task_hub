import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimeDatePickerRow extends StatefulWidget {
  final TimeOfDay? initialTime;
  final DateTime? initialDate;
  final Function(TimeOfDay) onTimeSelected;
  final Function(DateTime) onDateSelected;

  const TimeDatePickerRow({
    super.key,
    this.initialTime,
    this.initialDate,
    required this.onTimeSelected,
    required this.onDateSelected,
  });

  @override
  State<TimeDatePickerRow> createState() => _TimeDatePickerRowState();
}

class _TimeDatePickerRowState extends State<TimeDatePickerRow> {
  late TimeOfDay selectedTime;
  late DateTime selectedDate;

  @override
  void initState() {
    super.initState();
    selectedTime = widget.initialTime ?? TimeOfDay.now();
    selectedDate = widget.initialDate ?? DateTime.now();
  }

  Future<void> _pickTime() async {
    FocusScope.of(context).unfocus();
    await Future.delayed(Duration(milliseconds: 50));
  FocusManager.instance.primaryFocus?.unfocus(); 
    final picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null) {
      setState(() => selectedTime = picked);
      widget.onTimeSelected(picked);
    }
  }

  Future<void> _pickDate() async {
    await Future.delayed(Duration(milliseconds: 50));
  FocusManager.instance.primaryFocus?.unfocus(); 
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() => selectedDate = picked);
      widget.onDateSelected(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildBox(
          icon: Icons.access_time,
          text: selectedTime.format(context),
          onTap: _pickTime,
        ),
        const SizedBox(width: 12),
        _buildBox(
          icon: Icons.calendar_today,
          text: DateFormat('dd/MM/yyyy').format(selectedDate),
          onTap: _pickDate,
        ),
      ],
    );
  }

  Widget _buildBox({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 48,
          decoration: BoxDecoration(
            color: const Color(0xFF455A64),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Row(
            children: [
              Container(
                width: 40,
                height: double.infinity,
                decoration: const BoxDecoration(
                  color: Color(0xFFFFD54F),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(6),
                    bottomLeft: Radius.circular(6),
                  ),
                ),
                child: Icon(icon, color: Colors.black, size: 22),
              ),
              const SizedBox(width: 12),
              Text(
                text,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Colors.white,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
