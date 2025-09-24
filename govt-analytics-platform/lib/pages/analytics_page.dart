// pages/analytics_page.dart
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';
import '../services/api_service.dart';
import '../services/auth_service.dart';
import '../models/farm.dart';
import '../models/outbreak.dart';
import '../widgets/charts/disease_distribution_chart.dart';
import '../widgets/charts/compliance_trend_chart.dart';
import '../widgets/charts/regional_comparison_chart.dart';

class AnalyticsPage extends StatefulWidget {
  @override
  _AnalyticsPageState createState() => _AnalyticsPageState();
}

class _AnalyticsPageState extends State<AnalyticsPage> {
  late Future<List<Farm>> _farmsFuture;
  late Future<List<Outbreak>> _outbreaksFuture;
  late ApiService _apiService;
  String _selectedTimeframe = '30d';

  @override
  void initState() {
    super.initState();
    final authService = Provider.of<AuthService>(context, listen: false);
    _apiService = ApiService(authService.token!);
    
    _farmsFuture = _apiService.getFarms();
    _outbreaksFuture = _apiService.getOutbreaks(days: 30);
  }

  void _refreshData() {
    setState(() {
      int days;
      switch (_selectedTimeframe) {
        case '7d':
          days = 7;
          break;
        case '90d':
          days = 90;
          break;
        case '1y':
          days = 365;
          break;
        default:
          days = 30;
      }
      _outbreaksFuture = _apiService.getOutbreaks(days: days);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Analytics & Insights'),
        actions: [
          DropdownButton<String>(
            value: _selectedTimeframe,
            items: ['7d', '30d', '90d', '1y'].map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                _selectedTimeframe = newValue!;
                _refreshData();
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _refreshData,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Disease Analytics',
              style: Theme.of(context).textTheme.headline5,
            ),
            SizedBox(height: 16),
            FutureBuilder<List<Outbreak>>(
              future: _outbreaksFuture,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return DiseaseDistributionChart(outbreaks: snapshot.data!);
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                return Center(child: CircularProgressIndicator());
              },
            ),
            SizedBox(height: 24),
            Text(
              'Compliance Trends',
              style: Theme.of(context).textTheme.headline6,
            ),
            SizedBox(height: 16),
            FutureBuilder<List<Farm>>(
              future: _farmsFuture,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ComplianceTrendChart(farms: snapshot.data!);
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                return Center(child: CircularProgressIndicator());
              },
            ),
            SizedBox(height: 24),
            Text(
              'Regional Comparison',
              style: Theme.of(context).textTheme.headline6,
            ),
            SizedBox(height: 16),
            FutureBuilder(
              future: Future.wait([_farmsFuture, _outbreaksFuture]),
              builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                if (snapshot.hasData) {
                  return RegionalComparisonChart(
                    farms: snapshot.data![0],
                    outbreaks: snapshot.data![1],
                  );
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                return Center(child: CircularProgressIndicator());
              },
            ),
          ],
        ),
      ),
    );
  }
}