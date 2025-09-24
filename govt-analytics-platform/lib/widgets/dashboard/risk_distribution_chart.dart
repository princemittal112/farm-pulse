// widgets/dashboard/risk_distribution_chart.dart
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../models/farm.dart';
import '../../services/analytics_service.dart';

class RiskDistributionChart extends StatelessWidget {
  final List<Farm> farms;

  const RiskDistributionChart({Key? key, required this.farms}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final distribution = AnalyticsService.getRiskLevelDistribution(farms);
    
    return PieChart(
      PieChartData(
        sections: [
          PieChartSectionData(
            value: distribution['low']?.toDouble() ?? 0,
            color: Colors.green,
            title: '${distribution['low']}',
            radius: 60,
          ),
          PieChartSectionData(
            value: distribution['medium']?.toDouble() ?? 0,
            color: Colors.orange,
            title: '${distribution['medium']}',
            radius: 60,
          ),
          PieChartSectionData(
            value: distribution['high']?.toDouble() ?? 0,
            color: Colors.red,
            title: '${distribution['high']}',
            radius: 60,
          ),
        ],
      ),
    );
  }
}