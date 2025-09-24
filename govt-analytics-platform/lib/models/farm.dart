// models/farm.dart
class Farm {
  final String id;
  final String name;
  final String owner;
  final String species;
  final int capacity;
  final double latitude;
  final double longitude;
  final String riskLevel; // 'low', 'medium', 'high'
  final DateTime lastInspection;
  final double complianceScore;

  Farm({
    required this.id,
    required this.name,
    required this.owner,
    required this.species,
    required this.capacity,
    required this.latitude,
    required this.longitude,
    required this.riskLevel,
    required this.lastInspection,
    required this.complianceScore,
  });

  factory Farm.fromJson(Map<String, dynamic> json) {
    return Farm(
      id: json['id'],
      name: json['name'],
      owner: json['owner'],
      species: json['species'],
      capacity: json['capacity'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      riskLevel: json['riskLevel'],
      lastInspection: DateTime.parse(json['lastInspection']),
      complianceScore: json['complianceScore'].toDouble(),
    );
  }
}