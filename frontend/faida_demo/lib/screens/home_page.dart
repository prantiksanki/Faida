import 'package:flutter/material.dart';
import 'dart:math' as math;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  final PageController _newsController = PageController();
  // ignore: unused_field
  int _currentNewsIndex = 0;

  final List<Map<String, dynamic>> _portfolioData = [
    {'name': 'Gold', 'value': 35, 'color': Color(0xFFFFD700), 'amount': 125000},
    {'name': 'Savings', 'value': 25, 'color': Color(0xFF2DD4BF), 'amount': 89000},
    {'name': 'Mutual Funds', 'value': 30, 'color': Color(0xFF4C63D2), 'amount': 107000},
    {'name': 'Stocks', 'value': 10, 'color': Color(0xFFFF6B35), 'amount': 36000},
  ];

  final List<Map<String, dynamic>> _recentTransactions = [
    {'title': 'Gold Investment', 'amount': '+₹15,000', 'date': 'Today', 'isPositive': true},
    {'title': 'Mutual Fund SIP', 'amount': '-₹5,000', 'date': 'Yesterday', 'isPositive': false},
    {'title': 'Savings Deposit', 'amount': '+₹25,000', 'date': '2 days ago', 'isPositive': true},
    {'title': 'Stock Purchase', 'amount': '-₹12,000', 'date': '3 days ago', 'isPositive': false},
  ];

  final List<String> _financialTips = [
    "💡 Diversify your portfolio across different asset classes to minimize risk.",
    "📈 Start investing early to benefit from compound interest over time.",
    "🏆 Set clear financial goals and track your progress regularly.",
    "💰 Emergency fund should cover 6-12 months of expenses.",
  ];

  final List<Map<String, String>> _investorSuggestions = [
    {
      'name': 'Rakesh Jhunjhunwala',
      'tip': 'Invest in companies with strong fundamentals and hold for long term.',
      'avatar': 'RJ'
    },
    {
      'name': 'Warren Buffett',
      'tip': 'Be fearful when others are greedy and greedy when others are fearful.',
      'avatar': 'WB'
    },
    {
      'name': 'Radhika Gupta',
      'tip': 'SIP in mutual funds is the best way to build wealth systematically.',
      'avatar': 'RG'
    },
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 1500),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _newsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF4C63D2),
              Color(0xFF5B72E8),
            ],
          ),
        ),
        child: SafeArea(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: SingleChildScrollView(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(),
                  SizedBox(height: 30),
                  _buildBalanceCards(),
                  SizedBox(height: 30),
                  _buildPortfolioChart(),
                  SizedBox(height: 30),
                  _buildQuickActions(),
                  SizedBox(height: 30),
                  _buildRecentTransactions(),
                  SizedBox(height: 30),
                  _buildFinancialTips(),
                  SizedBox(height: 30),
                  _buildInvestorSuggestions(),
                  SizedBox(height: 30),
                  _buildChatButton(),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'FAIDA',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Color(0xFFFF6B35),
                letterSpacing: 2,
              ),
            ),
            SizedBox(height: 4),
            Text(
              'Welcome back!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(50),
          ),
          child: Icon(
            Icons.notifications_outlined,
            color: Colors.white,
            size: 24,
          ),
        ),
      ],
    );
  }

  Widget _buildBalanceCards() {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(25),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.15),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withOpacity(0.2)),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildBalanceItem('Total Invested', '₹3,57,000', Icons.trending_up),
                  Container(width: 1, height: 40, color: Colors.white.withOpacity(0.3)),
                  _buildBalanceItem('Total Balance', '₹4,12,850', Icons.account_balance_wallet),
                ],
              ),
              SizedBox(height: 15),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                decoration: BoxDecoration(
                  color: Color(0xFF2DD4BF).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.trending_up, color: Color(0xFF2DD4BF), size: 16),
                    SizedBox(width: 5),
                    Text(
                      '+15.6% overall return',
                      style: TextStyle(
                        color: Color(0xFF2DD4BF),
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBalanceItem(String title, String amount, IconData icon) {
    return Expanded(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: Colors.white.withOpacity(0.8), size: 16),
              SizedBox(width: 5),
              Text(
                title,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.8),
                  fontSize: 12,
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            amount,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPortfolioChart() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Portfolio Distribution',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF4C63D2),
            ),
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: SizedBox(
                  height: 150,
                  child: CustomPaint(
                    painter: PieChartPainter(_portfolioData),
                    child: Container(),
                  ),
                ),
              ),
              SizedBox(width: 20),
              Expanded(
                flex: 3,
                child: Column(
                  children: _portfolioData.map((data) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        children: [
                          Container(
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                              color: data['color'],
                              shape: BoxShape.circle,
                            ),
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              data['name'],
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                          Text(
                            '₹${(data['amount'] / 1000).toStringAsFixed(0)}K',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    return Row(
      children: [
        Expanded(
          child: _buildQuickActionButton(
            'Invest Now',
            Icons.add_circle_outline,
            Color(0xFF2DD4BF),
            () => _showSnackBar('Invest Now clicked'),
          ),
        ),
        SizedBox(width: 15),
        Expanded(
          child: _buildQuickActionButton(
            'Withdraw',
            Icons.remove_circle_outline,
            Color(0xFFFF6B35),
            () => _showSnackBar('Withdraw clicked'),
          ),
        ),
      ],
    );
  }

  Widget _buildQuickActionButton(String title, IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.3),
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, color: Colors.white, size: 28),
            SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentTransactions() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Recent Transactions',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4C63D2),
                ),
              ),
              TextButton(
                onPressed: () => _showSnackBar('View All clicked'),
                child: Text('View All'),
              ),
            ],
          ),
          SizedBox(height: 15),
          ..._recentTransactions.take(3).map((transaction) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: transaction['isPositive'] 
                          ? Color(0xFF2DD4BF).withOpacity(0.1)
                          : Color(0xFFFF6B35).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      transaction['isPositive'] 
                          ? Icons.arrow_upward 
                          : Icons.arrow_downward,
                      color: transaction['isPositive'] 
                          ? Color(0xFF2DD4BF) 
                          : Color(0xFFFF6B35),
                      size: 16,
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          transaction['title'],
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          transaction['date'],
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    transaction['amount'],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: transaction['isPositive'] 
                          ? Color(0xFF2DD4BF) 
                          : Color(0xFFFF6B35),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildFinancialTips() {
    return SizedBox(
      height: 120,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: Text(
              'Financial Tips',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(height: 15),
          Expanded(
            child: PageView.builder(
              controller: _newsController,
              onPageChanged: (index) {
                setState(() {
                  _currentNewsIndex = index;
                });
              },
              itemCount: _financialTips.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.white.withOpacity(0.2)),
                  ),
                  child: Center(
                    child: Text(
                      _financialTips[index],
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        height: 1.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInvestorSuggestions() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Expert Suggestions',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF4C63D2),
            ),
          ),
          SizedBox(height: 15),
          ..._investorSuggestions.map((suggestion) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: Color(0xFF4C63D2),
                    child: Text(
                      suggestion['avatar']!,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          suggestion['name']!,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          suggestion['tip']!,
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 12,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildChatButton() {
    return GestureDetector(
      onTap: () => _showSnackBar('Chat with AI clicked'),
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF2DD4BF), Color(0xFF14B8A6)],
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Color(0xFF2DD4BF).withOpacity(0.3),
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.chat_bubble_outline, color: Colors.white, size: 24),
            SizedBox(width: 12),
            Text(
              'Chat with AI Assistant',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Color(0xFF2DD4BF),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}

class PieChartPainter extends CustomPainter {
  final List<Map<String, dynamic>> data;

  PieChartPainter(this.data);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width / 2, size.height / 2) - 10;

    double startAngle = -math.pi / 2;
    final total = data.fold(0.0, (sum, item) => sum + item['value']);

    for (var item in data) {
      final sweepAngle = (item['value'] / total) * 2 * math.pi;
      final paint = Paint()
        ..color = item['color']
        ..style = PaintingStyle.fill;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        true,
        paint,
      );

      startAngle += sweepAngle;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}