import 'package:flutter/material.dart';
import 'package:sapio_assignment/controllers/activity_log_controller.dart';
import 'package:sapio_assignment/controllers/audit_log_controller.dart';
import 'package:sapio_assignment/controllers/task_controller.dart';
import 'package:sapio_assignment/controllers/visit_controller.dart';
import 'package:sapio_assignment/features/activity/activity_log_screen.dart';
import 'package:sapio_assignment/features/audits/audit_log_screen.dart';
import 'package:sapio_assignment/features/reports/reports_screen.dart';
import 'package:sapio_assignment/features/tasks/task_list_screen.dart';
import 'package:sapio_assignment/features/visits/visit_list_screen.dart';
import 'package:sapio_assignment/widgets/dashboard_card.dart';
import 'package:get/get.dart';

class DashboardScreen extends StatelessWidget {
  final String role;
  const DashboardScreen({super.key, required this.role});

  @override
  Widget build(BuildContext context) {
    final taskController = Get.find<TaskController>();
    final visitController = Get.find<VisitController>();
    final activityLogController = Get.find<ActivityLogController>();
    final auditLogController = Get.find<AuditLogController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Container(
                height: 120,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: Text(
                    "Welcome $role",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              if (role == "Admin" || role == "Regional Manager")
                Row(
                  children: [
                    Expanded(
                      child: Obx(() => DashboardCard(
                        title: "All Tasks",
                        count: taskController.tasks.length.toString(),
                        onTap: () => Get.to(() => TaskListScreen()),
                      )),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Obx(() => DashboardCard(
                        title: "Reports",
                        count: taskController.tasks
                            .where((t) => t.status == "Completed")
                            .length
                            .toString(),
                        onTap: () => Get.to(() => const ReportsScreen()),
                      )),
                    ),
                  ],
                ),

              if (role == "Team Lead")
                Row(
                  children: [
                    Expanded(
                      child: Obx(() => DashboardCard(
                        title: "Team Tasks",
                        count: taskController.visibleTasks.length.toString(),
                        onTap: () => Get.to(() => TaskListScreen()),
                      )),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Obx(() => DashboardCard(
                        title: "Pending Reviews",
                        count: taskController.filteredTasks
                            .where((t) => t.status == "In Progress")
                            .length
                            .toString(),
                        onTap: () {
                          taskController.selectedFilter.value = "In Progress";
                          Get.to(() => TaskListScreen());
                        },
                      )),
                    ),
                  ],
                ),

              if (role == "Field Agent")
                Row(
                  children: [
                    Expanded(
                      child: Obx(() => DashboardCard(
                        title: "My Tasks",
                        count: taskController.visibleTasks.length.toString(),
                        onTap: () => Get.to(() => TaskListScreen()),
                      )),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Obx(() => DashboardCard(
                        title: "Visits",
                        count: visitController.filteredVisits.length.toString(),
                        onTap: () => Get.to(() => VisitListScreen()),
                      )),
                    ),
                  ],
                ),

              if (role == "Auditor")
                Row(
                  children: [
                    Expanded(
                      child: Obx(() => DashboardCard(
                        title: "Audit Logs",
                        count: auditLogController.logs.length.toString(),
                        onTap: () => Get.to(() => const AuditLogScreen()),
                      )),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Obx(() => DashboardCard(
                        title: "Reports",
                        count: taskController.tasks
                            .where((t) => t.status == "Completed")
                            .length
                            .toString(),
                        onTap: () => Get.to(() => const ReportsScreen()),
                      )),
                    ),
                  ],
                ),

              const SizedBox(height: 20),

              Obx(() => DashboardCard(
                title: "Activity Logs",
                count: activityLogController.logs.length.toString(),
                onTap: () => Get.to(() => ActivityLogScreen()),
              )),
            ],
          ),
        ),
      ),
    );
  }
}