import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sapio_assignment/controllers/activity_log_controller.dart';

class ActivityLogScreen extends StatelessWidget {
  const ActivityLogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ActivityLogController controller = Get.find<ActivityLogController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Activity Logs"),
      ),
      body: Obx(() {
        if (controller.logs.isEmpty) {
          return const Center(child: Text("No activity yet"));
        }
        return ListView.builder(
          itemCount: controller.logs.length,
          itemBuilder: (context, index) {
            final log = controller.logs[index];
            return Card(
              margin: const EdgeInsets.all(12),
              child: ListTile(
                leading: const CircleAvatar(
                  child: Icon(Icons.history),
                ),
                title: Text(log.title),
                subtitle: Text(log.description),
                trailing: Text(log.time),
              ),
            );
          },
        );
      }),
    );
  }
}