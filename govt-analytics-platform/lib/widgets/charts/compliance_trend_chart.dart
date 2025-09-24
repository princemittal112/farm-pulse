// widgets/charts/compliance_trend_chart.dart
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../models/farm.dart';

class ComplianceTrendChart extends StatelessWidget {
  final List<Farm> farms;

  const ComplianceTrendChart({Key? key, required this.farms}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Simulate compliance trend data (in a real app, this would come from historical data)
    final List<FlSpot> trendData = [
      FlSpot(0, 65),
      FlSpot(1, 68),
      FlSpot(2, 72),
      FlSpot(3, 75),
      FlSpot(4, 78),
      FlSpot(5, 82),
      FlSpot(6, 85),
    ];

    return Card(
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Compliance Trend (Last 7 Days)',
              style: Theme.of(context).textTheme.headline6,
            ),
            SizedBox(height: 16),
            Container(
              height: 200,
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(show: true),
                  titlesData: FlTitlesData(show: true),
                  borderData: FlBorderData(show: true),
                  minX: 0,
                  maxX: 6,
                  minY: 0,
                  maxY: 100,
                  lineBarsData: [
                    LineChartBarData(
                      spots: trendData,
                      isCurved: true,
                      colors: [Colors.green],
                      barWidth: 4,
                      belowBarData: BarAreaData(show: true, colors: [Colors.green.withOpacity(0.3)]),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}