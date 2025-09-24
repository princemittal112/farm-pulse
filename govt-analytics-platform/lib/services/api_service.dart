// services/api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/farm.dart';
import '../models/outbreak.dart';
import '../models/compliance.dart';

class ApiService {
  static const String baseUrl = 'https://your-api-endpoint.com/api';
  final String authToken;

  ApiService(this.authToken);

  Future<List<Farm>> getFarms({String? district, String? riskLevel}) async {
    final response = await http.get(
      Uri.parse('$baseUrl/farms?district=$district&riskLevel=$riskLevel'),
      headers: {'Authorization': 'Bearer $authToken'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Farm.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load farms');
    }
  }

  Future<List<Outbreak>> getOutbreaks({int? days}) async {
    final response = await http.get(
      Uri.parse('$baseUrl/outbreaks?days=$days'),
      headers: {'Authorization': 'Bearer $authToken'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Outbreak.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load outbreaks');
    }
  }

  Future<Map<String, dynamic>> getDashboardStats() async {
    final response = await http.get(
      Uri.parse('$baseUrl/dashboard/stats'),
      headers: {'Authorization': 'Bearer $authToken'},
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load dashboard statistics');
    }
  }
}