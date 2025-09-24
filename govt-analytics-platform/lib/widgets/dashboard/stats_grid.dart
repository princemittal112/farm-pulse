// widgets/dashboard/stats_grid.dart
import 'package:flutter/material.dart';

class StatsGrid extends StatelessWidget {
  final Map<String, dynamic> stats;

  const StatsGrid({Key? key, required this.stats}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: [
        _buildStatCard(
          'Total Farms',
          stats['totalFarms'].toString(),
          Colors.blue,
          Icons.agriculture,
        ),
        _buildStatCard(
          'Outbreaks (30d)',
          stats['recentOutbreaks'].toString(),
          Colors.red,
          Icons.warning,
        ),
        _buildStatCard(
          'High Risk Farms',
          stats['highRiskFarms'].toString(),
          Colors.orange,
          Icons.error,
        ),
        _buildStatCard(
          'Avg. Compliance',
          '${stats['avgCompliance']}%',
          Colors.green,
          Icons.assignment_turned_in,
        ),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, Color color, IconData icon) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color, size: 24),
            SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            ),
            SizedBox(height: 4),
            Text(
              value,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}