class AiService {

  static String generateRecommendation(String notes) {
    final note = notes.toLowerCase();

    if (note.contains("delay")) {
      return "⚠️ High Priority Follow-up Required";
    } else if (note.contains("interested")) {
      return "📅 Schedule Follow-up Meeting";
    } else if (note.contains("rejected") || note.contains("not interested")) {
      return "❌ Mark Lead as Closed";
    } else if (note.contains("urgent") || note.contains("critical")) {
      return "🚨 Escalate to Regional Manager";
    } else if (note.contains("completed") || note.contains("done")) {
      return "✅ Task Successfully Completed";
    } else {
      return "📝 Visit Logged Successfully";
    }
  }

  static String generateSummary(String notes) {
    if (notes.isEmpty) return "";

    final wordCount = notes.split(" ").length;

    if (wordCount <= 5) {
      return "Brief visit note recorded.";
    } else if (wordCount <= 15) {
      return "Short visit completed with notes submitted.";
    } else {
      return "Detailed visit note recorded. Review recommended.";
    }
  }

  static String? generateWarningFlag(String notes, String status) {
    final note = notes.toLowerCase();

    if (status == "Delayed") {
      return "⚠️ Visit was delayed. Manager notified.";
    } else if (note.contains("problem") || note.contains("issue")) {
      return "⚠️ Potential issue detected in visit notes.";
    }

    return null;
  }
}