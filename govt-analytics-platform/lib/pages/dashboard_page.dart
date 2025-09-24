// pages/dashboard_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import '../services/api_service.dart';
import '../services/auth_service.dart';
import '../models/farm.dart';
import '../models/outbreak.dart';
import '../widgets/dashboard/stats_grid.dart';
import '../widgets/dashboard/outbreak_chart.dart';
import '../widgets/dashboard/risk_distribution_chart.dart';
import '../widgets/maps/farm_map.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late Future<Map<String, dynamic>> _statsFuture;
  late Future<List<Farm>> _farmsFuture;
  late Future<List<Outbreak>> _outbreaksFuture;
  late ApiService _apiService;

  @override
  void initState() {
    super.initState();
    final authService = Provider.of<AuthService>(context, listen: false);
    _apiService = ApiService(authService.token!);
    
    _statsFuture = _apiService.getDashboardStats();
    _farmsFuture = _apiService.getFarms();
    _outbreaksFuture = _apiService.getOutbreaks(days: 30);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Government Analytics Dashboard'),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              // Navigate to notifications page
            },
          ),
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              Provider.of<AuthService>(context, listen: false).logout();
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Overview',
              style: Theme.of(context).textTheme.headline5,
            ),
            SizedBox(height: 16),
            FutureBuilder<Map<String, dynamic>>(
              future: _statsFuture,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return StatsGrid(stats: snapshot.data!);
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                return Center(child: CircularProgressIndicator());
              },
            ),
            SizedBox(height: 24),
            Text(
              'Farm Distribution Map',
              style: Theme.of(context).textTheme.headline6,
            ),
            SizedBox(height: 16),
            Container(
              height: 300,
              child: FutureBuilder<List<Farm>>(
                future: _farmsFuture,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return FarmMap(farms: snapshot.data!);
                  } else if (snapshot.hasError) {
                    return Text('Error loading map: ${snapshot.error}');
                  }
                  return Center(child: CircularProgressIndicator());
                },
              ),
            ),
            SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Outbreak Trends',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      SizedBox(height: 16),
                      Container(
                        height: 200,
                        child: FutureBuilder<List<Outbreak>>(
                          future: _outbreaksFuture,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return OutbreakChart(outbreaks: snapshot.data!);
                            } else if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            }
                            return Center(child: CircularProgressIndicator());
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Risk Distribution',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      SizedBox(height: 16),
                      Container(
                        height: 200,
                        child: FutureBuilder<List<Farm>>(
                          future: _farmsFuture,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return RiskDistributionChart(farms: snapshot.data!);
                            } else if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            }
                            return Center(child: CircularProgressIndicator());
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 24),
            // Additional dashboard components can be added here
          ],
        ),
      ),
    );
  }
}