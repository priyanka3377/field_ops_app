# Field Ops App

A **Field Force Management System** built with Flutter, designed to manage tasks, visits, and team activity across multiple roles.

---

## Features

- **Role-based access control** — Admin, Regional Manager, Team Lead, Field Agent, and Auditor roles, each with different permissions and views
- **Task management** — Create, assign, filter, and update tasks with due date filtering
- **Visit tracking** — Log and update field visits linked to tasks
- **AI-powered visit insights** — Auto-generated recommendations, summaries, and warning flags based on visit notes
- **Activity logs** — Real-time log of all actions taken in the app
- **Audit logs** — Detailed audit trail with actor, role, action, and timestamp
- **Offline persistence** — All data stored locally using Hive

---

## Tech Stack

| Layer | Technology |
|---|---|
| Framework | Flutter |
| State Management | GetX |
| Local Storage | Hive |
| Navigation | GetX Navigation |

---

## Project Structure

```
lib/
├── controllers/
│   ├── activity_log_controller.dart
│   ├── audit_log_controller.dart
│   ├── task_controller.dart
│   └── visit_controller.dart
├── data/
│   ├── mock_data/
│   │   └── dummy_activity_logs.dart
│   ├── models/
│   │   ├── activity_log_model.dart
│   │   ├── audit_log_model.dart
│   │   ├── task_model.dart
│   │   └── visit_model.dart
│   └── services/
│       ├── ai_service.dart
│       └── hive_service.dart
├── features/
│   ├── activity/
│   │   └── activity_log_screen.dart
│   ├── audits/
│   │   └── audit_log_screen.dart
│   ├── auth/
│   │   ├── auth_controller.dart
│   │   └── login_screen.dart
│   ├── dashboard/
│   │   └── dashboard_screen.dart
│   ├── reports/
│   │   └── reports_screen.dart
│   ├── splash/
│   │   └── splash_screen.dart
│   ├── tasks/
│   │   ├── create_task_screen.dart
│   │   ├── task_detail_screen.dart
│   │   └── task_list_screen.dart
│   └── visits/
│       ├── visit_list_screen.dart
│       └── visit_update_screen.dart
└── widgets/
    └── dashboard_card.dart
main.dart
```

---

## Demo Accounts

| Email | Password | Role |
|---|---|---|
| admin@sapio.com | password123 | Admin |
| manager@sapio.com | password123 | Regional Manager |
| lead@sapio.com | password123 | Team Lead |
| agent@sapio.com | password123 | Field Agent |
| auditor@sapio.com | password123 | Auditor |

---

## Role Permissions

| Feature | Admin | Regional Manager | Team Lead | Field Agent | Auditor |
|---|:---:|:---:|:---:|:---:|:---:|
| Create tasks | ✅ | ✅ | ✅ | ❌ | ❌ |
| View all tasks | ✅ | ✅ | ❌ | ❌ | ❌ |
| View team tasks | ❌ | ❌ | ✅ | ✅ | ❌ |
| Update task status | ✅ | ✅ | ✅ | ✅ | ❌ |
| Update visits | ✅ | ✅ | ✅ | ✅ | ❌ |
| View audit logs | ❌ | ❌ | ❌ | ❌ | ✅ |
| View reports | ✅ | ✅ | ❌ | ❌ | ✅ |

---

## Local Setup Instructions

### Prerequisites

Make sure the following are installed on your machine:

- [Flutter SDK](https://docs.flutter.dev/get-started/install) 3.0 or above
- Dart SDK (bundled with Flutter)
- Android Studio or VS Code with the Flutter extension
- Android Emulator or a physical Android device with USB debugging enabled

Verify your Flutter installation:
```bash
flutter doctor
```
All checkmarks should be green before proceeding.

---

## App Run Steps

1. Clone the repository:
   ```bash
   git clone https://github.com/priyanka3377/field_ops_app.git
   cd field_ops_app
   ```

2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Connect a device or start an emulator, then verify it's detected:
   ```bash
   flutter devices
   ```

4. Run the app in debug mode:
   ```bash
   flutter run
   ```

   To run in release mode (better performance):
   ```bash
   flutter run --release
   ```

5. To build an APK for installation:
   ```bash
   flutter build apk --release
   ```
   The output APK will be at `build/app/outputs/flutter-apk/app-release.apk`.

---

## Installing on a Phone

1. Download the APK file shared with you.

2. Open the APK file from your file manager and tap **Install**.

3. If prompted with "Install blocked" or "Unknown sources", tap **Settings** and enable **Install from unknown sources**, then go back and tap **Install** again.

4. Once installed, open **Field Ops App** from your home screen and log in using one of the demo accounts below.

---

## Using the App

### Login

1. Open the app and enter your email and password from the demo accounts.
2. Tap **Login** — you will be taken to your dashboard based on your role.

---

### Admin / Regional Manager

After login you will see:

- **All Tasks** — tap to view every task in the system. Use the filter buttons (Pending, In Progress, Completed) or the date picker to filter tasks.
- **Reports** — tap to see a summary of total, completed, in progress, and pending tasks.
- **Activity Logs** — tap to see a real-time log of all actions taken in the app.

**Creating a task:**
1. On the Tasks screen, tap the **+** button at the bottom right.
2. Fill in the title, description, assignee, team, and due date.
3. Toggle **Requires Visit** if the task needs a field visit.
4. Tap **Create Task**.

**Updating a task:**
1. Tap any task from the list to open its details.
2. Tap **Start Task** to move it to In Progress, or **Complete Task** to mark it as done.

---

### Team Lead

After login you will see:

- **Team Tasks** — tasks belonging to your team only.
- **Pending Reviews** — tasks currently In Progress within your team.
- **Activity Logs** — log of all actions taken in the app.

**Creating a task:**
1. On the Tasks screen, tap the **+** button at the bottom right.
2. Fill in the details and tap **Create Task**.

**Updating a task:**
1. Tap any task to open its details.
2. Tap **Start Task** or **Complete Task** to update the status.

---

### Field Agent

After login you will see:

- **My Tasks** — tasks assigned to your team.
- **Visits** — field visits linked to your tasks.
- **Activity Logs** — log of all actions taken in the app.

**Updating a visit:**
1. Tap any task and then tap **Update Visit**, or go to the Visits screen and tap a visit.
2. Select the visit status (Started, Completed, Delayed).
3. Enter your visit notes and tap **Submit Visit**.
4. AI-generated recommendation, summary, and warning (if any) will appear below.

---

### Auditor

After login you will see:

- **Audit Logs** — a detailed trail of every action taken in the app, including who did it, their role, and when.
- **Reports** — summary of task statuses across the system.
- **Activity Logs** — general activity log of the app.

Auditors are in **read-only** mode — no tasks or visits can be created or modified.

---

## Backend Run Steps

This app has **no backend**. There is no server, REST API, or database to set up or run. All data is stored locally on the device using Hive (a lightweight local NoSQL database). The app is fully self-contained and works offline.

---

Architecture
State Management — GetX
GetX was chosen for state management due to its simplicity and minimal boilerplate. All controllers extend GetxController and are registered globally in main.dart via Get.put(). Observable variables (.obs) are used for reactive UI updates, and Obx() widgets rebuild automatically when the observed values change. AuthController is intentionally initialized first so that role and team values are available to TaskController and VisitController when they load their data.

Data Layer — Hive
Hive is used as the local storage solution. It was chosen over SQLite for its speed, simplicity, and no need for a schema or ORM. A single HiveService class exposes the open boxes as static getters, keeping storage access clean and centralized. All models are serialized to plain maps before saving and deserialized back on load. Seed data is written to Hive on first launch so the app never opens to an empty state.

---

## Assumptions

- **Authentication is simulated** — there is no real auth system. Login is validated against a hardcoded map of demo users in `AuthController`. Passwords are stored in plain text in the source code for demo purposes only.

- **AI features are rule-based** — the `AiService` is not connected to any external AI or ML model. Recommendations, summaries, and warning flags are generated using simple keyword matching on visit notes.

- **No real-time sync** — there is no backend or cloud sync. Data exists only on the device it was entered on and is lost if the app is uninstalled.

- **Teams are fixed** — team assignments are hardcoded. Field Agents belong to "Field Team" and Team Leads belong to "Team Lead" team. There is no UI to create or manage teams.

- **Seed data is loaded on first launch** — if no data exists in Hive on first run, default tasks, visits, and activity logs are loaded automatically.

- **Role of Auditor is read-only** — Auditors can view audit logs and reports but cannot create or modify any tasks or visits.

- **Single device usage assumed** — the app is designed for a single user per device. Multi-user or multi-device scenarios are not supported.

---

## AI Service

The app includes a local `AiService` that generates insights from visit notes without any external API calls:

- **Recommendation** — suggests follow-up actions based on keywords in notes
- **Summary** — generates a brief summary based on note length
- **Warning flag** — flags delayed visits or notes containing problem keywords

---

## Data Persistence

All data is stored locally using Hive boxes:

| Box | Contents |
|---|---|
| `tasksBox` | All tasks |
| `visits` | All visits |
| `logs` | Activity logs |

Data persists across app restarts. Default seed data is loaded on first launch.
