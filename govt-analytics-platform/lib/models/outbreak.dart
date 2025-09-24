// models/outbreak.dart
class Outbreak {
  final String id;
  final String diseaseType;
  final double latitude;
  final double longitude;
  final DateTime reportedDate;
  final int affectedAnimals;
  final String status; // 'suspected', 'confirmed', 'contained'
  final String district;

  Outbreak({
    required this.id,
    required this.diseaseType,
    required this.latitude,
    required this.longitude,
    required this.reportedDate,
    required this.affectedAnimals,
    required this.status,
    required this.district,
  });

  factory Outbreak.fromJson(Map<String, dynamic> json) {
    return Outbreak(
      id: json['id'],
      diseaseType: json['diseaseType'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      reportedDate: DateTime.parse(json['reportedDate']),
      affectedAnimals: json['affectedAnimals'],
      status: json['status'],
      district: json['district'],
    );
  }
}