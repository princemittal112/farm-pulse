// services/analytics_service.dart
import 'package:fl_chart/fl_chart.dart';
import '../models/farm.dart';
import '../models/outbreak.dart';

class AnalyticsService {
  static List<FlSpot> prepareOutbreakTrendData(List<Outbreak> outbreaks) {
    // Group outbreaks by date and count occurrences
    final Map<String, int> dailyCounts = {};
    
    for (var outbreak in outbreaks) {
      final dateKey = "${outbreak.reportedDate.year}-${outbreak.reportedDate.month}-${outbreak.reportedDate.day}";
      dailyCounts[dateKey] = (dailyCounts[dateKey] ?? 0) + 1;
    }
    
    // Convert to FlSpot format for the chart
    final List<FlSpot> spots = [];
    int index = 0;
    
    final sortedDates = dailyCounts.keys.toList()..sort();
    for (var date in sortedDates) {
      spots.add(FlSpot(index.toDouble(), dailyCounts[date]!.toDouble()));
      index++;
    }
    
    return spots;
  }

  static Map<String, int> getDiseaseDistribution(List<Outbreak> outbreaks) {
    final Map<String, int> distribution = {};
    
    for (var outbreak in outbreaks) {
      distribution[outbreak.diseaseType] = 
          (distribution[outbreak.diseaseType] ?? 0) + 1;
    }
    
    return distribution;
  }

  static Map<String, int> getRiskLevelDistribution(List<Farm> farms) {
    final Map<String, int> distribution = {
      'low': 0,
      'medium': 0,
      'high': 0,
    };
    
    for (var farm in farms) {
      distribution[farm.riskLevel] = (distribution[farm.riskLevel] ?? 0) + 1;
    }
    
    return distribution;
  }
}