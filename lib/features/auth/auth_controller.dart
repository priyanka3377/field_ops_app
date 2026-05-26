import 'package:get/get.dart';
import 'package:sapio_assignment/features/dashboard/dashboard_screen.dart';

class AuthController extends GetxController{
  final Map<String, Map<String, String>> demoUsers = {
    "admin@sapio.com" : {"password": "password123", "role": "Admin", "team": ""},
    "manager@sapio.com" : {"password": "password123", "role": "Regional Manager", "team": ""},
    "lead@sapio.com" : {"password": "password123", "role": "Team Lead", "team": "Team Lead"},
    "agent@sapio.com" : {"password": "password123", "role": "Field Agent", "team": "Field Team"},
    "auditor@sapio.com" : {"password": "password123", "role": "Auditor", "team": "Audit Team"}
  };

  RxBool isLoading = false.obs;
  RxString currentRole = "".obs;
  RxString currentUser = "".obs;
  RxString currentTeam = "".obs;

  void login(String email, String password) {
    if(email.isEmpty || password.isEmpty) {
      Get.snackbar("Error", "Please fill all fields");
      return;
    }

    final user = demoUsers[email];

    if(user == null || user["password"] != password) {
      Get.snackbar("Error", "Invalid credentials");
      return;
    }

    isLoading.value = true;

    Future.delayed(const Duration(seconds: 1), () {
      isLoading.value = false;
      currentRole.value = user["role"]!;
      currentUser.value = email;
      currentTeam.value = user["team"]!;
      Get.off(() => DashboardScreen(role: user["role"]!));
    });
  }

}