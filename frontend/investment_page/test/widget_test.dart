// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:investment_page/main.dart';

void main() {
  testWidgets('Investment page smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const InvestmentApp());

    // Verify that the investment page loads correctly
    expect(find.text('Investments'), findsOneWidget);
    expect(find.text('Mutual Funds'), findsOneWidget);
    expect(find.text('Recommended Plans'), findsOneWidget);
    expect(find.text('Investment Calculator'), findsOneWidget);
  });

  testWidgets('Investment page categories test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const InvestmentApp());

    // Verify that all categories are present
    expect(find.text('Mutual Funds'), findsOneWidget);
    expect(find.text('Gold Savings'), findsOneWidget);
    expect(find.text('Fixed Deposits'), findsOneWidget);
    expect(find.text('SIPs'), findsOneWidget);
    expect(find.text('Bonds'), findsOneWidget);
    expect(find.text('Crypto'), findsOneWidget);
  });
}
