// widgets/dashboard/outbreak_chart.dart
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../models/outbreak.dart';
import '../../services/analytics_service.dart';

class OutbreakChart extends StatelessWidget {
  final List<Outbreak> outbreaks;

  const OutbreakChart({Key? key, required this.outbreaks}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final trendData = AnalyticsService.prepareOutbreakTrendData(outbreaks);

    return LineChart(
      LineChartData(
        gridData: FlGridData(show: false),
        titlesData: FlTitlesData(show: false),
        borderData: FlBorderData(show: false),
        minX: 0,
        maxX: trendData.length > 0 ? trendData.last.x : 10,
        minY: 0,
        maxY: trendData.length > 0 
            ? trendData.map((point) => point.y).reduce((a, b) => a > b ? a : b) + 2 
            : 10,
        lineBarsData: [
          LineChartBarData(
            spots: trendData,
            isCurved: true,
            colors: [Colors.red],
            barWidth: 4,
            isStrokeCapRound: true,
            belowBarData: BarAreaData(show: false),
          ),
        ],
      ),
    );
  }
}