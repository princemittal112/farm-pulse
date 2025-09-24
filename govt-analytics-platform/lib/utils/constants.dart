// utils/constants.dart
class AppConstants {
  // API Endpoints
  static const String apiBaseUrl = 'https://your-api-endpoint.com/api';
  static const String loginEndpoint = '$apiBaseUrl/auth/login';
  static const String farmsEndpoint = '$apiBaseUrl/farms';
  static const String outbreaksEndpoint = '$apiBaseUrl/outbreaks';
  static const String complianceEndpoint = '$apiBaseUrl/compliance';
  
  // App Constants
  static const String appName = 'Government Analytics Dashboard';
  static const String appVersion = '1.0.0';
  
  // Risk Levels
  static const String riskLow = 'low';
  static const String riskMedium = 'medium';
  static const String riskHigh = 'high';
  
  // Compliance Status
  static const String statusCompliant = 'compliant';
  static const String statusNonCompliant = 'non-compliant';
  static const String statusPending = 'pending';
  
  // Outbreak Status
  static const String outbreakSuspected = 'suspected';
  static const String outbreakConfirmed = 'confirmed';
  static const String outbreakContained = 'contained';
  
  // User Roles
  static const String roleAdmin = 'admin';
  static const String roleOfficer = 'officer';
  static const String roleInspector = 'inspector';
}

class AppColors {
  static const Color primary = Color(0xFF1976D2);
  static const Color secondary = Color(0xFF42A5F5);
  static const Color accent = Color(0xFFFF4081);
  
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFFC107);
  static const Color danger = Color(0xFFF44336);
  static const Color info = Color(0xFF2196F3);
  
  static const Color lowRisk = Color(0xFF4CAF50);
  static const Color mediumRisk = Color(0xFFFFC107);
  static const Color highRisk = Color(0xFFF44336);
}

class AppDimens {
  static const double paddingSmall = 8.0;
  static const double paddingMedium = 16.0;
  static const double paddingLarge = 24.0;
  
  static const double borderRadius = 8.0;
  static const double cardElevation = 2.0;
}