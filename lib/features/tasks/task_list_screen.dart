import 'package:flutter/material.dart';
import 'package:sapio_assignment/controllers/task_controller.dart';
import 'package:sapio_assignment/features/auth/auth_controller.dart';
import 'package:sapio_assignment/features/tasks/create_task_screen.dart';
import 'package:sapio_assignment/features/tasks/task_detail_screen.dart';
import 'package:get/get.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  final TaskController controller = Get.find<TaskController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tasks"),
      ),

      floatingActionButton: Builder(
          builder: (context) {
            final role = Get.find<AuthController>().currentRole.value;
            if(role != "Auditor" && role != "Field Agent") {
              return FloatingActionButton(
                  onPressed: () {
                    Get.to(() => const CreateTaskScreen());
                  },

                child: const Icon(Icons.add),
              );

            }

            return const SizedBox.shrink();
          }
      ),
      body: Column(
        children: [
          const SizedBox(height: 12),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                _filterButton("All"),
                const SizedBox(width: 8),
                _filterButton("Pending"),
                const SizedBox(width: 8),
                _filterButton("In Progress"),
                const SizedBox(width: 8),
                _filterButton("Completed"),
                const SizedBox(width: 8),

                Obx(() => ElevatedButton.icon(
                    icon: const Icon(Icons.calendar_today, size: 16),
                    label: Text(
                      controller.selectedDate.value == null
                          ? "Date"
                          : "${controller.selectedDate.value!.day}/${controller.selectedDate.value!.month}/${controller.selectedDate.value!.year}",
                    ),

                  style: ElevatedButton.styleFrom(
                    backgroundColor: controller.selectedDate.value != null
                        ? Colors.blue
                        : Colors.grey[300],
                  ),

                  onPressed: () async{
                      final picked = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2025),
                          lastDate: DateTime(2027)
                      );

                      if(picked != null) {
                        controller.selectedDate.value = picked;
                      }
                  },
                )
                ),

                const SizedBox(width: 8),

                Obx(() => controller.selectedDate.value != null

                    ? IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      controller.selectedDate.value = null;
                    },
                )
                    :const SizedBox.shrink(),

                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: Obx(() {
              if (controller.filteredTasks.isEmpty) {
                return const Center(child: Text("No tasks found"));
              }
              return ListView.builder(
                itemCount: controller.filteredTasks.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.all(12),
                    child: ListTile(
                      leading: const CircleAvatar(
                        child: Icon(Icons.task),
                      ),
                      title: Text(controller.filteredTasks[index].title),
                      subtitle: Text(controller.filteredTasks[index].status),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        Get.to(() =>
                            TaskDetailScreen(
                              task: controller.filteredTasks[index],
                            ));
                      },
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _filterButton(String label) {
    return Obx(() => ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: controller.selectedFilter.value == label
            ? Colors.blue
            : Colors.grey[300],
      ),
      onPressed: () {
        controller.selectedFilter.value = label;
      },
      child: Text(label),
    ));
  }
}