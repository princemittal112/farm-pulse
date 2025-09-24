// models/user.dart
class User {
  final String id;
  final String name;
  final String email;
  final String role; // 'admin', 'officer', 'inspector'
  final String district;
  final String state;
  final DateTime lastLogin;
  final bool isActive;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.district,
    required this.state,
    required this.lastLogin,
    required this.isActive,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      role: json['role'],
      district: json['district'],
      state: json['state'],
      lastLogin: DateTime.parse(json['lastLogin']),
      isActive: json['isActive'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'role': role,
      'district': district,
      'state': state,
      'lastLogin': lastLogin.toIso8601String(),
      'isActive': isActive,
    };
  }
}