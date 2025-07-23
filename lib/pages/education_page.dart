import 'package:flutter/material.dart';

class EducationPage extends StatelessWidget {
  const EducationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1B2A), // dark navy blue
      appBar: AppBar(
        backgroundColor: const Color(0xFF1B263B), // slightly lighter dark blue
        title: const Text('Financial Education'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Smart Money Tips 💡",
              style: TextStyle(
                fontSize: 22,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),

            // FAQs as Expansion Tiles
            _buildQuestion(
              "What's SIP?",
              "SIP (Systematic Investment Plan) lets you invest small fixed amounts regularly in mutual funds. It’s stress-free and builds wealth slowly over time.",
            ),
            _buildQuestion(
              "Is Gold a smart option?",
              "Yes, especially in India! Digital gold and gold funds are safer ways to invest without holding physical gold.",
            ),
            _buildQuestion(
              "What is a Fixed Deposit (FD)?",
              "You give money to the bank for a fixed time and get guaranteed returns. It’s safe, but returns are lower compared to mutual funds.",
            ),
            _buildQuestion(
              "How much should I save monthly?",
              "Start with 20% of your income if possible. Even ₹500/month builds habit and momentum.",
            ),
            _buildQuestion(
              "Mutual funds risky hai?",
              "They go up and down with the market, but SIPs help reduce risk over time. Choose good funds, stay invested.",
            ),
            _buildQuestion(
              "I earn in cash daily. What can I do?",
              "Use micro-saving apps, local chit funds, or bank saving schemes. Start with ₹10/day – it adds up.",
            ),

            const SizedBox(height: 30),

            const Text(
              "Ask Your Doubt",
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),

            TextField(
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Type your question here...',
                hintStyle: const TextStyle(color: Colors.white70),
                filled: true,
                fillColor: const Color(0xFF1B263B),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
              maxLines: 2,
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Your doubt has been submitted!'),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF415A77),
              ),
              child: const Text("Submit"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuestion(String question, String answer) {
    return Theme(
      data: ThemeData.dark().copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        collapsedIconColor: Colors.lightBlue[200],
        iconColor: Colors.lightBlue[200],
        title: Text(
          question,
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              answer,
              style: const TextStyle(color: Colors.white70),
            ),
          )
        ],
      ),
    );
  }
}

