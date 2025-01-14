import 'package:flutter/material.dart';
import 'package:modern_profile/screens/profile_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Modern Profile 2024',
      debugShowCheckedModeBanner: false,
      home: ProfileScreen(),
    );
  }
}
