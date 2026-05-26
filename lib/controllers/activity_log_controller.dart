import 'package:get/get.dart';
import 'package:sapio_assignment/data/models/activity_log_model.dart';
import 'package:sapio_assignment/data/mock_data/dummy_activity_logs.dart';
import 'package:sapio_assignment/data/services/hive_service.dart';

class ActivityLogController extends GetxController {
  var logs = <ActivityLogModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadLogs();
  }

  void addLog(String title, String description) {
    final now = DateTime.now();
    final time = "${now.hour}:${now.minute.toString().padLeft(2, '0')} ${now.hour >= 12 ? 'PM' : 'AM'}";

    logs.insert(0, ActivityLogModel(
      title: title,
      description: description,
      time: time,
    ));

    saveLogs();
  }

  void saveLogs() {
    HiveService.logsBox.put(
      'logs',
      logs.map((log) => {
        'title': log.title,
        'description': log.description,
        'time': log.time,
      }).toList(),
    );
  }

  void loadLogs() {
    final savedLogs = HiveService.logsBox.get('logs');

    if (savedLogs != null) {
      logs.value = List<ActivityLogModel>.from(
        savedLogs.map((log) => ActivityLogModel(
          title: log['title'],
          description: log['description'],
          time: log['time'],
        )),
      );
    } else {
      logs.value = dummyLogs;
      saveLogs();
    }
  }
}