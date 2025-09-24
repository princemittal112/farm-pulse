// main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'pages/login_page.dart';
import 'services/auth_service.dart';
import 'services/notification_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
        Provider(create: (_) => NotificationService()),
      ],
      child: MaterialApp(
        title: 'Government Analytics Dashboard',
        theme: AppThemes.lightTheme,
        darkTheme: AppThemes.darkTheme,
        home: LoginPage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}