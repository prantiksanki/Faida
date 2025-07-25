import 'package:flutter/material.dart';

class TransactionsPage extends StatelessWidget {
  const TransactionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final completedTransactions = [
      {"title": "SIP", "amount": "₹1,500", "date": "10 July 2025"},
      {"title": "Mutual Fund", "amount": "₹5,000", "date": "08 July 2025"},
      {"title": "Fixed Deposit", "amount": "₹10,000", "date": "01 July 2025"},
    ];

    final pendingTransactions = [
      {"title": "Gold", "amount": "₹3,000", "date": "15 July 2025"},
      {"title": "SIP", "amount": "₹1,500", "date": "20 July 2025"},
    ];

    return Scaffold(
      backgroundColor: const Color(0xFF0D1B2A), // dark blue
      appBar: AppBar(
        backgroundColor: const Color(0xFF1B263B), // slightly lighter dark blue
        title: const Text(
          'Your Transactions',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, '/education');
            },
            child: const Text(
              'Education',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: ListView(
          children: [
            const Text(
              "Completed",
              style: TextStyle(fontSize: 18, color: Colors.white70),
            ),
            const SizedBox(height: 10),
            ...completedTransactions.map((tx) => TransactionCard(
                  title: tx["title"]!,
                  amount: tx["amount"]!,
                  date: tx["date"]!,
                  statusColor: Colors.green,
                  icon: Icons.check_circle,
                )),
            const SizedBox(height: 25),
            const Text(
              "Pending",
              style: TextStyle(fontSize: 18, color: Colors.white70),
            ),
            const SizedBox(height: 10),
            ...pendingTransactions.map((tx) => TransactionCard(
                  title: tx["title"]!,
                  amount: tx["amount"]!,
                  date: tx["date"]!,
                  statusColor: Colors.orange,
                  icon: Icons.hourglass_bottom,
                )),
          ],
        ),
      ),
    );
  }
}

class TransactionCard extends StatelessWidget {
  final String title;
  final String amount;
  final String date;
  final Color statusColor;
  final IconData icon;

  const TransactionCard({
    super.key,
    required this.title,
    required this.amount,
    required this.date,
    required this.statusColor,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF1B263B),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Icon(icon, color: statusColor, size: 28),
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          date,
          style: const TextStyle(color: Colors.white70),
        ),
        trailing: Text(
          amount,
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }
}