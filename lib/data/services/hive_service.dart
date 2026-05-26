import 'package:hive_flutter/hive_flutter.dart';

class HiveService {
  static Box get tasksBox => Hive.box('tasksBox');
  static Box get visitsBox => Hive.box('visits');
  static Box get logsBox => Hive.box('logs');
}