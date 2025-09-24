// widgets/compliance/compliance_history.dart
import 'package:flutter/material.dart';
import '../../models/compliance.dart';
import '../../utils/helpers.dart';

class ComplianceHistory extends StatelessWidget {
  final String farmId;

  const ComplianceHistory({Key? key, required this.farmId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Simulate compliance history data
    final List<ComplianceRecord> history = [
      ComplianceRecord(
        id: 'comp_001',
        farmId: farmId,
        inspectionDate: DateTime.now().subtract(Duration(days: 30)),
        inspectorId: 'inspector_001',
        checklist: {'fencing': true, 'logs': true, 'disinfection': false},
        score: 66.7,
        status: 'compliant',
        notes: 'Good progress, but disinfection needs improvement',
      ),
      ComplianceRecord(
        id: 'comp_002',
        farmId: farmId,
        inspectionDate: DateTime.now().subtract(Duration(days: 60)),
        inspectorId: 'inspector_001',
        checklist: {'fencing': false, 'logs': true, 'disinfection': false},
        score: 33.3,
        status: 'non-compliant',
        notes: 'Major compliance issues found',
      ),
    ];

    return Column(
      children: history.map((record) => _buildHistoryItem(record)).toList(),
    );
  }

  Widget _buildHistoryItem(ComplianceRecord record) {
    return Card(
      margin: EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  Helpers.formatDate(record.inspectionDate),
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Chip(
                  label: Text(
                    '${record.score}%',
                    style: TextStyle(color: Colors.white),
                  ),
                  backgroundColor: record.score >= 70
                      ? Colors.green
                      : record.score >= 50
                          ? Colors.orange
                          : Colors.red,
                ),
              ],
            ),
            SizedBox(height: 8),
            if (record.notes != null)
              Text(
                record.notes!,
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
          ],
        ),
      ),
    );
  }
}