import 'package:get/get.dart';
import 'package:sapio_assignment/controllers/activity_log_controller.dart';
import 'package:sapio_assignment/controllers/audit_log_controller.dart';
import 'package:sapio_assignment/features/auth/auth_controller.dart';

import '../data/models/task_model.dart';
import '../data/services/hive_service.dart';

class TaskController extends GetxController {

  final selectedFilter = "All".obs;
  final selectedDate = Rxn<DateTime>();

  var tasks = <TaskModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadTasks();
  }

  List<TaskModel> get filteredTasks {
    try {
      final role = Get
          .find<AuthController>()
          .currentRole
          .value;
      final currentTeam = Get
          .find<AuthController>()
          .currentTeam
          .value;

      var result = tasks.toList();

      if (role == "Field Agent") {
        result = result.where((task) => task.team == currentTeam).toList();
      }

      if (role == "Team Lead") {
        result = result.where((task) => task.team == currentTeam).toList();
      }

      if (selectedFilter.value != "All") {
        result = result.where((t) => t.status == selectedFilter.value).toList();
      }

      final date = selectedDate.value;
      if (date != null) {
        result = result.where((t) =>
        t.dueDate.day == selectedDate.value!.day &&
            t.dueDate.month == selectedDate.value!.month &&
            t.dueDate.year == selectedDate.value!.year
        ).toList();
      }

      return result;
    } catch (e) {
      return tasks.toList();
    }
  }

  void addTask(TaskModel task) {
    tasks.add(task);

    Get.find<ActivityLogController>().addLog(
      "Task Created",
      "Task '${task.title}' assigned to ${task.assignedTo}",
    );

    Get.find<AuditLogController>().logAction(
      actorName: Get.find<AuthController>().currentUser.value,
      actorRole: Get.find<AuthController>().currentRole.value,
      action: "Task Created",
      target: "Task '${task.title}'",
      details: "Assigned to ${task.assignedTo} in ${task.team}",
    );

    HiveService.tasksBox.put(
      'tasks',
      tasks.map((task) => {
        'id': task.id,
        'title': task.title,
        'status': task.status,
        'assignedTo': task.assignedTo,
        'requiresVisit': task.requiresVisit,
        'description': task.description,
        'team': task.team,
        'dueDate': task.dueDate.toIso8601String(),
      }).toList(),
    );
  }

  List<TaskModel> get visibleTasks {

    final role = Get.find<AuthController>().currentRole.value;
    final currentTeam = Get.find<AuthController>().currentTeam.value;

    if(role == "Field Agent") {

      return tasks.where(
            (t) => t.team == currentTeam,
      ).toList();

    }

    if(role == "Team Lead") {

      return tasks.where(
            (t) => t.team == currentTeam,
      ).toList();

    }

    return tasks;
  }

  void updateTaskStatus(
      String taskId,
      String newStatus,
      ) {

    final index = tasks.indexWhere((t) => t.id == taskId);
    if (index == -1) return;
    final taskTitle = tasks[index].title;

    tasks[index] = TaskModel(
      id: tasks[index].id,
      title: tasks[index].title,
      status: newStatus,
      assignedTo: tasks[index].assignedTo,
      requiresVisit: tasks[index].requiresVisit,
      description: tasks[index].description,
      team: tasks[index].team,
      dueDate: tasks[index].dueDate,
    );

    Get.find<ActivityLogController>().addLog(
      "Task Updated",
      "Task '$taskTitle' moved to $newStatus",
    );

    Get.find<AuditLogController>().logAction(
      actorName: Get.find<AuthController>().currentUser.value,
      actorRole: Get.find<AuthController>().currentRole.value,
      action: "Status Changed",
      target: "Task '$taskTitle'",
      details: "Moved to $newStatus",
    );

    HiveService.tasksBox.put(
      'tasks',

      tasks.map((task) => {
          'id': task.id,
          'title': task.title,
          'status': task.status,
          'assignedTo': task.assignedTo,
          'requiresVisit': task.requiresVisit,
          'description': task.description,
          'team': task.team,
          'dueDate': task.dueDate.toIso8601String(),
      }).toList(),
    );
  }

  void loadTasks() {

    final savedTasks =
    HiveService.tasksBox.get('tasks');

    if (savedTasks != null) {

      tasks.value = List<TaskModel>.from(

        savedTasks.map((task) {

          return TaskModel(
            id: task['id'],
            title: task['title'],
            status: task['status'],
            assignedTo: task['assignedTo'],
            requiresVisit: task['requiresVisit'],
            description: task['description'],
            team: task['team'],
            dueDate: DateTime.parse(task['dueDate']),
          );
        }),
      );

    } else {

      loadDefaultTasks();
    }
  }

  void loadDefaultTasks() {

    tasks.value = [

      TaskModel(
        id: "1",
        title: "Verify Candidate Details",
        status: "Pending",
        assignedTo: "Rahul",
        requiresVisit: true,
        description: "Verify all candidate documents",
        team: "Field Team",
        dueDate: DateTime(2025, 6, 10),
      ),

      TaskModel(
        id: "2",
        title: "Generate Monthly Report",
        status: "Completed",
        assignedTo: "Priya",
        requiresVisit: false,
        description: "Generate report for May",
        team: "Team Lead",
        dueDate: DateTime(2025, 5, 30),
      ),

    ];
  }
}