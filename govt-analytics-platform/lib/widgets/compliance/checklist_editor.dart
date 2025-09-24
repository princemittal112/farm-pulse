// widgets/compliance/checklist_editor.dart
import 'package:flutter/material.dart';
import '../../models/compliance.dart';

class ChecklistEditor extends StatefulWidget {
  @override
  _ChecklistEditorState createState() => _ChecklistEditorState();
}

class _ChecklistEditorState extends State<ChecklistEditor> {
  final List<ComplianceChecklist> _checklistItems = [
    ComplianceChecklist(
      id: '1',
      category: 'Biosecurity',
      question: 'Perimeter fencing',
      description: 'Adequate fencing around the farm perimeter',
      weight: 10,
    ),
    ComplianceChecklist(
      id: '2',
      category: 'Biosecurity',
      question: 'Visitor logs maintained',
      description: 'Proper records of all farm visitors',
      weight: 8,
    ),
    ComplianceChecklist(
      id: '3',
      category: 'Hygiene',
      question: 'Disinfection protocols',
      description: 'Proper disinfection procedures in place',
      weight: 12,
    ),
  ];

  final Map<String, bool> _checklistValues = {};

  @override
  void initState() {
    super.initState();
    // Initialize all checklist values to false
    for (var item in _checklistItems) {
      _checklistValues[item.id] = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Compliance Checklist',
            style: Theme.of(context).textTheme.headline6,
          ),
          SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: _checklistItems.length,
              itemBuilder: (context, index) {
                final item = _checklistItems[index];
                return _buildChecklistItem(item);
              },
            ),
          ),
          SizedBox(height: 16),
          _buildSummaryCard(),
        ],
      ),
    );
  }

  Widget _buildChecklistItem(ComplianceChecklist item) {
    return Card(
      margin: EdgeInsets.only(bottom: 8),
      child: CheckboxListTile(
        title: Text(item.question),
        subtitle: Text(item.description),
        secondary: Chip(
          label: Text('${item.weight} pts'),
          backgroundColor: Theme.of(context).primaryColor,
          labelStyle: TextStyle(color: Colors.white),
        ),
        value: _checklistValues[item.id] ?? false,
        onChanged: (bool? value) {
          setState(() {
            _checklistValues[item.id] = value ?? false;
          });
        },
      ),
    );
  }

  Widget _buildSummaryCard() {
    final totalScore = _calculateTotalScore();
    final maxScore = _calculateMaxScore();
    final percentage = maxScore > 0 ? (totalScore / maxScore) * 100 : 0;

    return Card(
      color: Theme.of(context).primaryColor.withOpacity(0.1),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Compliance Summary',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('Score: $totalScore/$maxScore (${percentage.toStringAsFixed(1)}%)'),
            SizedBox(height: 8),
            LinearProgressIndicator(
              value: percentage / 100,
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(
                percentage >= 70 ? Colors.green : Colors.orange,
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _submitCompliance,
              child: Text('Submit Compliance Report'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
              ),
            ),
          ],
        ),
      ),
    );
  }

  int _calculateTotalScore() {
    int total = 0;
    for (var item in _checklistItems) {
      if (_checklistValues[item.id] == true) {
        total += item.weight;
      }
    }
    return total;
  }

  int _calculateMaxScore() {
    return _checklistItems.fold(0, (sum, item) => sum + item.weight);
  }

  void _submitCompliance() {
    final score = _calculateTotalScore();
    final maxScore = _calculateMaxScore();
    final percentage = (score / maxScore) * 100;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Submit Compliance Report'),
        content: Text('Compliance score: ${percentage.toStringAsFixed(1)}%'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              // Save compliance report
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Compliance report submitted successfully')),
              );
            },
            child: Text('Submit'),
          ),
        ],
      ),
    );
  }
}