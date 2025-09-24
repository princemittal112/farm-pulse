// pages/farm_detail_page.dart
import 'package:flutter/material.dart';
import '../models/farm.dart';
import '../models/compliance.dart';
import '../widgets/compliance/compliance_history.dart';

class FarmDetailPage extends StatelessWidget {
  final Farm farm;

  const FarmDetailPage({Key? key, required this.farm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(farm.name),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildFarmInfoCard(),
            SizedBox(height: 16),
            _buildRiskIndicator(),
            SizedBox(height: 24),
            Text(
              'Compliance History',
              style: Theme.of(context).textTheme.headline6,
            ),
            SizedBox(height: 16),
            ComplianceHistory(farmId: farm.id),
            SizedBox(height: 24),
            _buildActionButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildFarmInfoCard() {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Farm Details',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            _buildDetailRow('Owner', farm.owner),
            _buildDetailRow('Species', farm.species),
            _buildDetailRow('Capacity', '${farm.capacity} animals'),
            _buildDetailRow('Last Inspection', 
                '${farm.lastInspection.day}/${farm.lastInspection.month}/${farm.lastInspection.year}'),
            _buildDetailRow('Compliance Score', '${farm.complianceScore}%'),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text(
            '$label: ',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(value),
        ],
      ),
    );
  }

  Widget _buildRiskIndicator() {
    Color riskColor;
    String riskText;
    
    switch (farm.riskLevel) {
      case 'high':
        riskColor = Colors.red;
        riskText = 'High Risk';
        break;
      case 'medium':
        riskColor = Colors.orange;
        riskText = 'Medium Risk';
        break;
      case 'low':
      default:
        riskColor = Colors.green;
        riskText = 'Low Risk';
    }

    return Card(
      color: riskColor.withOpacity(0.1),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(Icons.warning, color: riskColor),
            SizedBox(width: 12),
            Text(
              riskText,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: riskColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () {
              // Schedule inspection
            },
            icon: Icon(Icons.calendar_today),
            label: Text('Schedule Inspection'),
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () {
              // View on map
            },
            icon: Icon(Icons.map),
            label: Text('View on Map'),
          ),
        ),
      ],
    );
  }
}