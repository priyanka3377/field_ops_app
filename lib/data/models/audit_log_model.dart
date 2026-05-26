class AuditLogModel {
  final String actorName;
  final String actorRole;
  final String action;
  final String target;
  final String details;
  final String timestamp;

  AuditLogModel({
    required this.actorName,
    required this.actorRole,
    required this.action,
    required this.target,
    required this.details,
    required this.timestamp
});
}