class TaskModel {
  final String id;
  final String title;
  String status;
  final String assignedTo;
  final bool requiresVisit;
  final String description;
  final String team;
  final DateTime dueDate;

  TaskModel({
    required this.id,
    required this.title,
    required this.status,
    required this.assignedTo,
    required this.requiresVisit,
    required this.description,
    required this.team,
    required this.dueDate
});
}