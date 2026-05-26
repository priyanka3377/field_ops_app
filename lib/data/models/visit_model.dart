class VisitModel {
  final String id;
  final String taskId;
  final String assignedTo;
  final String team;
  String status;
  final String notes;
  final String outcome;
  final DateTime visitDate;
  final String aiRecommendation;
  final String aiSummary;
  final String aiWarning;

  VisitModel({
    required this.id,
    required this.taskId,
    required this.assignedTo,
    required this.team,
    required this.status,
    required this.notes,
    required this.outcome,
    required this.visitDate,
    this.aiRecommendation = "",
    this.aiSummary = "",
    this.aiWarning = "",
});
}