import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sapio_assignment/controllers/task_controller.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TaskController taskController = Get.find<TaskController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Reports"),
      ),
      body: Obx(() {
        final total = taskController.tasks.length;
        final completed = taskController.tasks.where((t) => t.status == "Completed").length;
        final inProgress = taskController.tasks.where((t) => t.status == "In Progress").length;
        final pending = taskController.tasks.where((t) => t.status == "Pending").length;

        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              _reportCard("Total Tasks", total.toString(), Colors.blue),
              const SizedBox(height: 12),
              _reportCard("Completed", completed.toString(), Colors.green),
              const SizedBox(height: 12),
              _reportCard("In Progress", inProgress.toString(), Colors.orange),
              const SizedBox(height: 12),
              _reportCard("Pending", pending.toString(), Colors.red),
            ],
          ),
        );
      }),
    );
  }

  Widget _reportCard(String title, String count, Color color) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Text(
            count,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: color),
          ),
        ],
      ),
    );
  }
}