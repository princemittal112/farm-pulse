// widgets/charts/disease_distribution_chart.dart
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../models/outbreak.dart';
import '../../services/analytics_service.dart';

class DiseaseDistributionChart extends StatelessWidget {
  final List<Outbreak> outbreaks;

  const DiseaseDistributionChart({Key? key, required this.outbreaks}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final distribution = AnalyticsService.getDiseaseDistribution(outbreaks);
    
    return Card(
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Disease Distribution',
              style: Theme.of(context).textTheme.headline6,
            ),
            SizedBox(height: 16),
            Container(
              height: 200,
              child: PieChart(
                PieChartData(
                  sections: _buildSections(distribution),
                  centerSpaceRadius: 40,
                ),
              ),
            ),
            SizedBox(height: 16),
            _buildLegend(distribution),
          ],
        ),
      ),
    );
  }

  List<PieChartSectionData> _buildSections(Map<String, int> distribution) {
    final List<Color> colors = [
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.red,
      Colors.purple,
    ];

    int colorIndex = 0;
    return distribution.entries.map((entry) {
      final percentage = (entry.value / outbreaks.length) * 100;
      final section = PieChartSectionData(
        value: percentage,
        color: colors[colorIndex % colors.length],
        title: '${percentage.toStringAsFixed(1)}%',
        radius: 60,
        titleStyle: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      );
      colorIndex++;
      return section;
    }).toList();
  }

  Widget _buildLegend(Map<String, int> distribution) {
    final List<Color> colors = [
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.red,
      Colors.purple,
    ];

    int colorIndex = 0;
    return Wrap(
      spacing: 8,
      runSpacing: 4,
      children: distribution.entries.map((entry) {
        final widget = Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 12,
              height: 12,
              color: colors[colorIndex % colors.length],
            ),
            SizedBox(width: 4),
            Text(
              '${entry.key} (${entry.value})',
              style: TextStyle(fontSize: 12),
            ),
          ],
        );
        colorIndex++;
        return widget;
      }).toList(),
    );
  }
}