// widgets/charts/regional_comparison_chart.dart
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../models/farm.dart';
import '../../models/outbreak.dart';

class RegionalComparisonChart extends StatelessWidget {
  final List<Farm> farms;
  final List<Outbreak> outbreaks;

  const RegionalComparisonChart({
    Key? key,
    required this.farms,
    required this.outbreaks,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Simulate regional data (in a real app, this would come from API)
    final Map<String, double> regionalCompliance = {
      'North': 82.5,
      'South': 78.2,
      'East': 65.8,
      'West': 88.4,
    };

    final Map<String, int> regionalOutbreaks = {
      'North': 12,
      'South': 8,
      'East': 25,
      'West': 5,
    };

    return Card(
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Regional Comparison',
              style: Theme.of(context).textTheme.headline6,
            ),
            SizedBox(height: 16),
            Container(
              height: 200,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: 100,
                  barGroups: regionalCompliance.entries.map((entry) {
                    return BarChartGroupData(
                      x: regionalCompliance.keys.toList().indexOf(entry.key),
                      barRods: [
                        BarChartRodData(
                          toY: entry.value,
                          color: _getColorForValue(entry.value),
                          width: 16,
                        ),
                      ],
                    );
                  }).toList(),
                  titlesData: FlTitlesData(
                    show: true,
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          return Text(regionalCompliance.keys.toList()[value.toInt()]);
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          return Text('${value.toInt()}%');
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getColorForValue(double value) {
    if (value >= 80) return Colors.green;
    if (value >= 60) return Colors.orange;
    return Colors.red;
  }
}