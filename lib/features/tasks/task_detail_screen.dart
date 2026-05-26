import 'package:flutter/material.dart';
import 'package:sapio_assignment/controllers/task_controller.dart';
import 'package:sapio_assignment/controllers/visit_controller.dart';
import 'package:sapio_assignment/data/models/task_model.dart';
import 'package:get/get.dart';
import 'package:sapio_assignment/data/models/visit_model.dart';
import 'package:sapio_assignment/features/auth/auth_controller.dart';
import 'package:sapio_assignment/features/visits/visit_update_screen.dart';

class TaskDetailScreen extends StatelessWidget{
  final TaskController controller = Get.find<TaskController>();
  final TaskModel task;

  TaskDetailScreen({super.key, required this.task});

  @override
  Widget build(BuildContext context){

    final role = Get.find<AuthController>().currentRole.value;
    final isReadOnly = role == "Auditor";


    return Scaffold(
      appBar: AppBar(
        title: const Text("Task Details"),
      ),
      body: Padding(
          padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              task.title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),
            
            Text(
              "Status: ${task.status}",
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 12),

            Text(
              "Assigned to: ${task.assignedTo}",
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 30),

            if(task.requiresVisit)
              SizedBox(
                width: double.infinity,

                child: ElevatedButton(
                  onPressed: () {
                    final visitController = Get.find<VisitController>();

                    final existingIndex = visitController.visits.indexWhere(
                          (v) => v.taskId == task.id,
                    );

                    if (existingIndex != -1) {
                      Get.to(() => VisitUpdateScreen(
                        visit: visitController.visits[existingIndex],
                      ));
                    } else {
                      final newVisit = VisitModel(
                        id: DateTime.now().millisecondsSinceEpoch.toString(),
                        taskId: task.id,
                        assignedTo: task.assignedTo,
                        team: task.team,
                        status: "Pending",
                        notes: "",
                        outcome: "Pending",
                        visitDate: task.dueDate,
                      );
                      visitController.addVisit(newVisit);
                      Get.to(() => VisitUpdateScreen(visit: newVisit));
                    }
                  },
                  child: const Text(
                    "Update Visit",
                  ),
              ),
            ),

            const SizedBox(height: 20),

            if(!isReadOnly)
              ElevatedButton(
                onPressed: () {
                  controller.updateTaskStatus(
                    task.id,
                    "In Progress",
                  );

                  Get.back();

                  Get.snackbar(
                    "Updated",
                    "Task moved to In Progress",
                    snackPosition: SnackPosition.BOTTOM,
                  );
                  },

                child: const Text(
                  "Start Task",
                ),
              ),

            const SizedBox(height: 12),

            if(!isReadOnly)
              ElevatedButton(
                onPressed: () {

                  controller.updateTaskStatus(
                    task.id,
                    "Completed",
                  );

                  Get.back();

                  Get.snackbar(
                    "Completed",
                    "Task completed successfully",
                    snackPosition: SnackPosition.BOTTOM,
                  );
                },

                child: const Text(
                  "Complete Task",
                ),
              ),

            Text("Description: ${task.description}"),
            const SizedBox(height: 12),
            Text("Team: ${task.team}"),
            const SizedBox(height: 12),
            Text("Due Date: ${task.dueDate.day}/${task.dueDate.month}/${task.dueDate.year}"),
          ],

        ),
      ),
    );
  }
}