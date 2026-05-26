import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sapio_assignment/controllers/visit_controller.dart';
import 'package:sapio_assignment/features/visits/visit_update_screen.dart';

class VisitListScreen extends StatelessWidget {
  const VisitListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final VisitController controller = Get.find<VisitController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Visits"),
      ),
      body: Obx(() {
        if (controller.filteredVisits.isEmpty) {
          return const Center(child: Text("No visits found"));
        }

        return ListView.builder(
          itemCount: controller.filteredVisits.length,
          itemBuilder: (context, index) {
            final visit = controller.filteredVisits[index];

            return Card(
              margin: const EdgeInsets.all(12),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: _getStatusColor(visit.status),
                  child: const Icon(Icons.place, color: Colors.white),
                ),
                title: Text("Visit #${index + 1}"),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Assigned to: ${visit.assignedTo}"),
                    Text("Status: ${visit.status}"),
                    Text(
                      "Date: ${visit.visitDate.day}/${visit.visitDate.month}/${visit.visitDate.year}",
                    ),
                  ],
                ),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Get.to(() => VisitUpdateScreen(visit: visit));
                },
              ),
            );
          },
        );
      }),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Completed":
        return Colors.green;
      case "Started":
        return Colors.blue;
      case "Delayed":
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}