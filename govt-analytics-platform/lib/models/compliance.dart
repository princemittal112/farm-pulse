// models/compliance.dart
class ComplianceRecord {
  final String id;
  final String farmId;
  final DateTime inspectionDate;
  final String inspectorId;
  final Map<String, bool> checklist;
  final double score;
  final String status; // 'compliant', 'non-compliant', 'pending'
  final String? notes;

  ComplianceRecord({
    required this.id,
    required this.farmId,
    required this.inspectionDate,
    required this.inspectorId,
    required this.checklist,
    required this.score,
    required this.status,
    this.notes,
  });

  factory ComplianceRecord.fromJson(Map<String, dynamic> json) {
    return ComplianceRecord(
      id: json['id'],
      farmId: json['farmId'],
      inspectionDate: DateTime.parse(json['inspectionDate']),
      inspectorId: json['inspectorId'],
      checklist: Map<String, bool>.from(json['checklist']),
      score: json['score'].toDouble(),
      status: json['status'],
      notes: json['notes'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'farmId': farmId,
      'inspectionDate': inspectionDate.toIso8601String(),
      'inspectorId': inspectorId,
      'checklist': checklist,
      'score': score,
      'status': status,
      'notes': notes,
    };
  }
}

class ComplianceChecklist {
  final String id;
  final String category;
  final String question;
  final String description;
  final int weight;

  ComplianceChecklist({
    required this.id,
    required this.category,
    required this.question,
    required this.description,
    required this.weight,
  });

  factory ComplianceChecklist.fromJson(Map<String, dynamic> json) {
    return ComplianceChecklist(
      id: json['id'],
      category: json['category'],
      question: json['question'],
      description: json['description'],
      weight: json['weight'],
    );
  }
}