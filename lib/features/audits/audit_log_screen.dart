import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sapio_assignment/controllers/audit_log_controller.dart';

class AuditLogScreen extends StatelessWidget {
  const AuditLogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AuditLogController>();

    return Scaffold(
      appBar: AppBar(title: const Text("Audit Logs")),
      body: Obx(() => ListView.builder(
        itemCount: controller.logs.length,
        itemBuilder: (context, index) {
          final log = controller.logs[index];
          return Card(
            margin: const EdgeInsets.all(12),
            child: ListTile(
              leading: const CircleAvatar(child: Icon(Icons.security)),
              title: Text("${log.action} — ${log.target}"),
              subtitle: Text("${log.actorName}\n${log.details}"),
              trailing: Text(log.timestamp, style: const TextStyle(fontSize: 11)),
              isThreeLine: true,
            ),
          );
        },
      )),
    );
  }
}