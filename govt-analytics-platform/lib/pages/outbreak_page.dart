// pages/outbreak_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/api_service.dart';
import '../services/auth_service.dart';
import '../services/notification_service.dart';
import '../models/outbreak.dart';
import '../widgets/maps/outbreak_map.dart';
import '../widgets/charts/outbreak_timeline_chart.dart';

class OutbreakPage extends StatefulWidget {
  @override
  _OutbreakPageState createState() => _OutbreakPageState();
}

class _OutbreakPageState extends State<OutbreakPage> {
  late Future<List<Outbreak>> _outbreaksFuture;
  late ApiService _apiService;
  String _filterStatus = 'all';

  @override
  void initState() {
    super.initState();
    final authService = Provider.of<AuthService>(context, listen: false);
    _apiService = ApiService(authService.token!);
    
    _outbreaksFuture = _apiService.getOutbreaks(days: 30);
  }

  void _refreshOutbreaks() {
    setState(() {
      _outbreaksFuture = _apiService.getOutbreaks(days: 30);
    });
  }

  void _sendAlert(Outbreak outbreak) {
    NotificationService.showNotification(
      title: 'Outbreak Alert: ${outbreak.diseaseType}',
      body: 'New outbreak reported in ${outbreak.district}. ${outbreak.affectedAnimals} animals affected.',
    );
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Alert sent to relevant authorities')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Outbreak Management'),
        actions: [
          DropdownButton<String>(
            value: _filterStatus,
            items: [
              DropdownMenuItem(value: 'all', child: Text('All Status')),
              DropdownMenuItem(value: 'suspected', child: Text('Suspected')),
              DropdownMenuItem(value: 'confirmed', child: Text('Confirmed')),
              DropdownMenuItem(value: 'contained', child: Text('Contained')),
            ],
            onChanged: (String? value) {
              setState(() {
                _filterStatus = value!;
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _refreshOutbreaks,
          ),
        ],
      ),
      body: FutureBuilder<List<Outbreak>>(
        future: _outbreaksFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final outbreaks = snapshot.data!.where((outbreak) {
              return _filterStatus == 'all' || outbreak.status == _filterStatus;
            }).toList();

            return SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Outbreak Map',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  SizedBox(height: 16),
                  Container(
                    height: 300,
                    child: OutbreakMap(outbreaks: outbreaks),
                  ),
                  SizedBox(height: 24),
                  Text(
                    'Outbreak Timeline',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  SizedBox(height: 16),
                  Container(
                    height: 200,
                    child: OutbreakTimelineChart(outbreaks: outbreaks),
                  ),
                  SizedBox(height: 24),
                  Text(
                    'Recent Outbreaks (${outbreaks.length})',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  SizedBox(height: 16),
                  _buildOutbreakList(outbreaks),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Report new outbreak
        },
        child: Icon(Icons.add_alert),
      ),
    );
  }

  Widget _buildOutbreakList(List<Outbreak> outbreaks) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: outbreaks.length,
      itemBuilder: (context, index) {
        final outbreak = outbreaks[index];
        return Card(
          margin: EdgeInsets.only(bottom: 8),
          child: ListTile(
            leading: Icon(
              Icons.warning,
              color: _getStatusColor(outbreak.status),
            ),
            title: Text(outbreak.diseaseType),
            subtitle: Text(
                '${outbreak.district} • ${outbreak.affectedAnimals} animals • ${_formatDate(outbreak.reportedDate)}'),
            trailing: IconButton(
              icon: Icon(Icons.notification_important),
              onPressed: () => _sendAlert(outbreak),
            ),
            onTap: () {
              // Show outbreak details
            },
          ),
        );
      },
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'suspected':
        return Colors.orange;
      case 'confirmed':
        return Colors.red;
      case 'contained':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}