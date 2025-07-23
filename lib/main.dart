import 'package:flutter/material.dart';
import 'pages/transactions_page.dart';
import 'pages/education_page.dart';

void main() {
  runApp(const FaidaApp());
}

class FaidaApp extends StatelessWidget {
  const FaidaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Faida App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF0D47A1), // Dark blue
          secondary: Color(0xFF1976D2), // Light blue
        ),
        scaffoldBackgroundColor: const Color(0xFF0A0E21),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF0D47A1),
          foregroundColor: Colors.white,
        ),
        listTileTheme: const ListTileThemeData(
          iconColor: Colors.white,
          textColor: Colors.white,
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const TransactionsPage(),
        '/education': (context) => const EducationPage(),
      },
    );
  }
}
