import 'package:flutter/material.dart';
import 'screens/welcome_page.dart';
import 'screens/home_page.dart';
import 'screens/investment_page.dart';
import 'screens/goal_planning_page.dart';
import 'screens/user_profile.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Finance App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Roboto',
      ),
      home: WelcomePage(),
      debugShowCheckedModeBanner: false,
      routes: {
        '/home': (context) => HomePage(),
        '/investment': (context) => InvestmentPage(),
        '/goals': (context) => GoalPlanningPage(),
        '/profile': (context) => UserProfilePage(),
      },
    );
  }
}