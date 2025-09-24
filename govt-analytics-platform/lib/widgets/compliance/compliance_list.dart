// widgets/compliance/compliance_list.dart
import 'package:flutter/material.dart';
import '../../models/compliance.dart';
import '../../utils/helpers.dart';

class ComplianceList extends StatelessWidget {
  final List<ComplianceRecord> records;

  const ComplianceList({Key? key, required this.records}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: records.length,
      itemBuilder: (context, index) {
        final record = records[index];
        return _buildComplianceCard(record, context);
      },
    );
  }

  Widget _buildComplianceCard(ComplianceRecord record, BuildContext context) {
    Color statusColor;
    switch (record.status) {
      case 'compliant':
        statusColor = Colors.green;
        break;
      case 'non-compliant':
        statusColor = Colors.red;
        break;
      case 'pending':
      default:
        statusColor = Colors.orange;
    }

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Farm ID: ${record.farmId}',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Chip(
                  label: Text(
                    Helpers.getStatusText(record.status),
                    style: TextStyle(color: Colors.white),
                  ),
                  backgroundColor: statusColor,
                ),
              ],
            ),
            SizedBox(height: 8),
            Text('Score: ${record.score}%'),
            Text('Date: ${Helpers.formatDate(record.inspectionDate)}'),
            SizedBox(height: 8),
            if (record.notes != null)
              Text(
                'Notes: ${record.notes}',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            SizedBox(height: 8),
            _buildChecklistSummary(record.checklist),
          ],
        ),
      ),
    );
  }

  Widget _buildChecklistSummary(Map<String, bool> checklist) {
    final completed = checklist.values.where((value) => value).length;
    final total = checklist.length;

    return LinearProgressIndicator(
      value: completed / total,
      backgroundColor: Colors.grey[300],
      valueColor: AlwaysStoppedAnimation<Color>(
        (completed / total) >= 0.7 ? Colors.green : Colors.orange,
      ),
    );
  }
}