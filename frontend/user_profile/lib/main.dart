import 'package:flutter/material.dart';
import 'user_profile.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Faida',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const UserProfilePage(),
    );
  }
}
