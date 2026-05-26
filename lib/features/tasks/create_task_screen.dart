import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sapio_assignment/controllers/task_controller.dart';
import 'package:sapio_assignment/data/models/task_model.dart';

class CreateTaskScreen extends StatefulWidget {
  const CreateTaskScreen({super.key});

  @override
  State<CreateTaskScreen> createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {
  final TaskController controller = Get.find<TaskController>();

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  String selectedAssignee = "Rahul";
  String selectedTeam = "Field Team";
  DateTime? selectedDueDate;
  bool requiresVisit = false;

  final List<String> assignees = ["Rahul", "Priya", "Amit", "Sara"];
  final List<String> teams = ["Team Lead", "Field Team"];

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2027),
    );
    if (picked != null && mounted) {
      setState(() => selectedDueDate = picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Task"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: "Title",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 16),

            TextField(
              controller: descriptionController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: "Description",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 16),

            DropdownButtonFormField<String>(
              initialValue: selectedAssignee,
              items: assignees.map((a) => DropdownMenuItem(
                value: a,
                child: Text(a),
              )).toList(),
              onChanged: (val) => setState(() => selectedAssignee = val!),
              decoration: const InputDecoration(
                labelText: "Assign To",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 16),

            DropdownButtonFormField<String>(
              initialValue: selectedTeam,
              items: teams.map((t) => DropdownMenuItem(
                value: t,
                child: Text(t),
              )).toList(),
              onChanged: (val) => setState(() => selectedTeam = val!),
              decoration: const InputDecoration(
                labelText: "Team",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 16),

            // DATE PICKER BUTTON
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                icon: const Icon(Icons.calendar_today),
                label: Text(
                  selectedDueDate == null
                      ? "Select Due Date"
                      : "Due: ${selectedDueDate!.day}/${selectedDueDate!.month}/${selectedDueDate!.year}",
                ),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.all(16),
                  side: const BorderSide(color: Colors.grey),
                  alignment: Alignment.centerLeft,
                ),
                onPressed: _pickDate,
              ),
            ),

            const SizedBox(height: 16),

            // REQUIRES VISIT TOGGLE
            SwitchListTile(
              title: const Text("Requires Visit"),
              value: requiresVisit,
              onChanged: (val) => setState(() => requiresVisit = val),
            ),

            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (titleController.text.isEmpty) {
                    Get.snackbar("Error", "Title is required");
                    return;
                  }
                  if (selectedDueDate == null) {
                    Get.snackbar("Error", "Please select a due date");
                    return;
                  }

                  controller.addTask(TaskModel(
                    id: DateTime.now().toString(),
                    title: titleController.text.trim(),
                    status: "Pending",
                    assignedTo: selectedAssignee,
                    requiresVisit: requiresVisit,
                    description: descriptionController.text.trim(),
                    team: selectedTeam,
                    dueDate: selectedDueDate!,
                  ));

                  Get.back();
                  Get.snackbar("Success", "Task created successfully");
                },
                child: const Text("Create Task"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}