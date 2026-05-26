import 'package:get/get.dart';
import 'package:sapio_assignment/controllers/activity_log_controller.dart';
import 'package:sapio_assignment/controllers/audit_log_controller.dart';
import 'package:sapio_assignment/data/models/visit_model.dart';
import 'package:sapio_assignment/data/services/hive_service.dart';
import 'package:sapio_assignment/features/auth/auth_controller.dart';

class VisitController extends GetxController {

  var visits = <VisitModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadVisits();
  }


  List<VisitModel> get filteredVisits {
    try {
      final role = Get
          .find<AuthController>()
          .currentRole
          .value;
      final currentTeam = Get
          .find<AuthController>()
          .currentTeam
          .value;

      if (role == "Field Agent") {
        return visits.where((v) => v.team == currentTeam).toList();
      }

      if (role == "Team Lead") {
        return visits.where((v) => v.team == currentTeam).toList();
      }

      return visits.toList();
    } catch (e) {
      return visits.toList();
    }
  }

  void addVisit(VisitModel visit) {
    visits.add(visit);
    saveVisits();
  }

  void updateVisit(String id, String status, String notes, String aiRecommendation, String aiSummary, String aiWarning) {
    final index = visits.indexWhere((v) => v.id == id);
    if (index != -1) {
      visits[index] = VisitModel(
        id: visits[index].id,
        taskId: visits[index].taskId,
        assignedTo: visits[index].assignedTo,
        team: visits[index].team,
        status: status,
        notes: notes,
        outcome: status == "Completed" ? "Successful" : "Pending",
        visitDate: visits[index].visitDate,
        aiRecommendation: aiRecommendation,
        aiSummary: aiSummary,
        aiWarning: aiWarning,
      );

      visits.refresh();

      final updatedVisit = visits[index];

      Get.find<ActivityLogController>().addLog(
          "Visit $status",
          "Visit by ${updatedVisit.assignedTo} marked as $status",
      );

      Get.find<AuditLogController>().logAction(
        actorName: visits[index].assignedTo,
        actorRole: "Field Agent",
        action: "Visit $status",
        target: "Visit #${visits[index].id}",
        details: notes.isNotEmpty ? "Notes: ${notes.substring(0, notes.length.clamp(0, 30))}" : "No notes",
      );

      if(notes.isNotEmpty){
        Get.find<ActivityLogController>().addLog(
            "Notes Added",
            "Visit notes submitted: ${notes.length > 30 ? '${notes.substring(0,30)}...' : notes}",
        );
      }
      saveVisits();
    }
  }

  void saveVisits() {
    HiveService.visitsBox.put(
      'visits',
      visits.map((v) => {
        'id': v.id,
        'taskId': v.taskId,
        'assignedTo': v.assignedTo,
        'team': v.team,
        'status': v.status,
        'notes': v.notes,
        'outcome': v.outcome,
        'visitDate': v.visitDate.toIso8601String(),
        'aiRecommendation': v.aiRecommendation,
        'aiSummary': v.aiSummary,
        'aiWarning': v.aiWarning,
      }).toList(),
    );
  }

  void loadVisits() {
    final savedVisits = HiveService.visitsBox.get('visits');

    if (savedVisits != null) {
      visits.value = List<VisitModel>.from(
        savedVisits.map((v) => VisitModel(
          id: v['id'],
          taskId: v['taskId'],
          assignedTo: v['assignedTo'],
          team: v['team'] ?? "Field Team",
          status: v['status'],
          notes: v['notes'],
          outcome: v['outcome'],
          visitDate: DateTime.parse(v['visitDate']),
          aiRecommendation: v['aiRecommendation'] ?? "",
          aiSummary: v['aiSummary'],
          aiWarning: v['aiWarning'] ?? "",
        )),
      );
    } else {
      loadDefaultVisits();
    }
  }

  void loadDefaultVisits() {
    visits.value = [
      VisitModel(
        id: "1",
        taskId: "1",
        assignedTo: "Rahul",
        team: "Field Team",
        status: "Pending",
        notes: "",
        outcome: "Pending",
        visitDate: DateTime(2025, 6, 10),
        aiSummary: "",
        aiRecommendation: "",
        aiWarning: "",
      ),
      VisitModel(
        id: "2",
        taskId: "2",
        assignedTo: "Priya",
        team: "Team Lead",
        status: "Completed",
        notes: "Client was interested in the product",
        outcome: "Successful",
        visitDate: DateTime(2025, 5, 30),
        aiSummary: "Schedule Follow-up Request",
        aiRecommendation: "",
        aiWarning: "",
      ),
    ];
  }
}