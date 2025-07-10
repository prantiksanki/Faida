import 'package:flutter/material.dart';
import 'investment_page.dart';

void main() {
  runApp(const InvestmentApp());
}

class InvestmentApp extends StatelessWidget {
  const InvestmentApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Investment Page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: const Color(0xFF1E3A8A),
        scaffoldBackgroundColor: Colors.grey[50],
      ),
      home: const InvestmentPage(),
    );
  }
}
