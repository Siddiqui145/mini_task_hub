import 'package:flutter/material.dart';

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
    return Container(
      width: 175,
      margin: const EdgeInsets.only(right: 16),
      padding: const EdgeInsets.only(left: 16, right: 8, bottom: 8),
      decoration: BoxDecoration(
        color: isCompleted ? Colors.grey.shade100 : const Color(0xFF2A323E),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isCompleted ? Colors.black : Colors.white,
              fontSize: 18,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            label,
            style: TextStyle(
              color: isCompleted ? Colors.black87 : Colors.white70,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CircleAvatar(
                radius: 18,
                backgroundImage: AssetImage("assets/images/avatars/avatar1.jpg"),
              ),
              CircleAvatar(
                radius: 18,
                backgroundImage: AssetImage("assets/images/avatars/avatar2.jpg"),
              ),
              CircleAvatar(
                radius: 18,
                backgroundImage: AssetImage("assets/images/avatars/avatar3.jpeg"),
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (isCompleted) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Completed',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                    fontSize: 14,
                  ),
                ),
                const Text(
                  '100%',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
              ],
            ),
          ] else ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Due on : $dueDate',
                  style: const TextStyle(color: Colors.white70, fontSize: 13),
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
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.yellow.shade300),
                        backgroundColor: Colors.white12,
                      ),
                    ),
                    Text(
                      '$progress%',
                      style: const TextStyle(color: Colors.white, fontSize: 10),
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
