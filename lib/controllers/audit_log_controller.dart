import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sapio_assignment/data/models/audit_log_model.dart';

class AuditLogController extends GetxController {
  final logs = <AuditLogModel>[].obs;
  final _box = Hive.box('auditLogs');

  @override
  void onInit() {
    super.onInit();
    _loadLogs();
  }

  void logAction({
    required String actorName,
    required String actorRole,
    required String action,
    required String target,
    required String details,
  }) {
    final now = DateTime.now();
    final newLog = AuditLogModel(
      actorName: actorName,
      actorRole: actorRole,
      action: action,
      target: target,
      details: details,
      timestamp: "${now.hour}:${now.minute.toString().padLeft(2, '0')}",
    );
    logs.insert(0, newLog);
    _saveLogs();
  }

  void _saveLogs() {
    _box.put('auditLogs', logs.map((log) => {
      'actorName': log.actorName,
      'actorRole': log.actorRole,
      'action': log.action,
      'target': log.target,
      'details': log.details,
      'timestamp': log.timestamp,
    }).toList());
  }

  void _loadLogs() {
    final saved = _box.get('auditLogs');
    if (saved != null) {
      logs.value = List<AuditLogModel>.from(
        saved.map((log) => AuditLogModel(
          actorName: log['actorName'],
          actorRole: log['actorRole'],
          action: log['action'],
          target: log['target'],
          details: log['details'],
          timestamp: log['timestamp'],
        )),
      );
    } else {
      _seedLogs();
      _saveLogs();
    }
  }

  void _seedLogs() {
    logs.addAll([
      AuditLogModel(
        actorName: "Alice (Admin)", actorRole: "Admin",
        action: "Task Assigned", target: "Task #1",
        details: "Assigned to Rahul",
        timestamp: "10:30 AM",
      ),
      AuditLogModel(
        actorName: "Rahul (Field Agent)", actorRole: "Field Agent",
        action: "Visit Completed", target: "Visit #1",
        details: "Notes submitted",
        timestamp: "12:05 PM",
      ),
    ]);
  }
}