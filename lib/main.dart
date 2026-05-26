import 'package:flutter/material.dart';
import 'package:sapio_assignment/controllers/activity_log_controller.dart';
import 'package:sapio_assignment/controllers/audit_log_controller.dart';
import 'package:sapio_assignment/controllers/visit_controller.dart';
import 'package:sapio_assignment/features/auth/auth_controller.dart';
import 'package:sapio_assignment/controllers/task_controller.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sapio_assignment/features/splash/splash_screen.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  await Hive.openBox('tasksBox');
  await Hive.openBox('visits');
  await Hive.openBox('logs');

  await Hive.openBox('auditLogs');

  Get.put(AuthController());

  Get.put(ActivityLogController());
  Get.put(VisitController());
  Get.put(
    TaskController(),
    permanent: true,
  );
  Get.put(AuditLogController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Field Ops App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
    );
  }
}