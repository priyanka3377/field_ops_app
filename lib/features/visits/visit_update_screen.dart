import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sapio_assignment/controllers/visit_controller.dart';
import 'package:sapio_assignment/data/models/visit_model.dart';
import 'package:sapio_assignment/data/services/ai_service.dart';

class VisitUpdateScreen extends StatefulWidget{

  final VisitModel visit;
  const VisitUpdateScreen({super.key, required this.visit});

  @override
  State<VisitUpdateScreen> createState() => _VisitUpdateScreenState();
}

class _VisitUpdateScreenState extends State<VisitUpdateScreen>{
  final VisitController controller = Get.find<VisitController>();
  TextEditingController notesController = TextEditingController();
  String selectedStatus = "Started";
  String aiRecommendation = "";
  String aiSummary = "";
  String aiWarning = "";
  final List<String> visitStatus = [
    "Started",
    "Completed",
    "Delayed",
  ];


  @override
  void initState() {
    super.initState();

    notesController =
        TextEditingController(text: widget.visit.notes);

    selectedStatus = widget.visit.status == "Pending"
        ? "Started"
        : widget.visit.status;

    aiSummary = widget.visit.aiSummary;
    aiRecommendation = widget.visit.aiRecommendation;
    aiWarning = widget.visit.aiWarning;
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Visit"),
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),

        child: Column(
          children: [
            DropdownButtonFormField<String>(
                initialValue: selectedStatus,
                items: visitStatus.map((status) {
                  return DropdownMenuItem(
                      value: status,
                      child: Text(status),
                  );
                }
                ).toList(),

              onChanged: (value) {
                  setState(() {
                    selectedStatus = value!;
                  });
              },

              decoration: const InputDecoration(
                labelText: "Visit Status",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),


            TextField(
              controller: notesController,
              maxLines: 5,
              decoration: const InputDecoration(
                labelText: "Visit Notes",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              
              child: ElevatedButton(
                  onPressed: () {
                    if(notesController.text.isEmpty) {
                      Get.snackbar("Error", "Please enter visit notes");
                      return;
                    }

                    final recommendation = AiService.generateRecommendation(notesController.text);
                    final summary = AiService.generateSummary(notesController.text);
                    final warning = AiService.generateWarningFlag(notesController.text, selectedStatus);
                    controller.updateVisit(
                        widget.visit.id,
                        selectedStatus,
                        notesController.text.trim(),
                        recommendation,
                        summary,
                        warning ?? "",
                    );

                    setState(() {
                      aiRecommendation = recommendation;
                      aiSummary = summary;
                      aiWarning = warning ?? "";
                    });
                    
                    Get.snackbar("Success", "Visit updated successfully");
                  },
                  child: const Text(
                    "Submit Visit",
                  ),
              ),
            ),

            const SizedBox(height: 24),

            if(aiRecommendation.isNotEmpty)

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.only(bottom: 12),

                decoration: BoxDecoration(
                  color: Colors.green.shade100,
                  borderRadius: BorderRadius.circular(16),
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    const Text(
                      "AI Recommendation",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),
                    Text(aiRecommendation),
                  ],
                ),
              ),

            if(aiSummary.isNotEmpty)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.only(bottom: 12),

                decoration: BoxDecoration(
                  color: Colors.blue.shade100,
                  borderRadius: BorderRadius.circular(16),
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "AI Summary",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(aiSummary),
                  ],
                ),
              ),

            if(aiWarning.isNotEmpty)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.only(bottom: 12),

                decoration: BoxDecoration(
                  color: Colors.orange.shade100,
                  borderRadius: BorderRadius.circular(16),
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "AI Warning",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(aiWarning),
                  ],
                ),
              )
          ],
        ),
      ),
    );
  }
}