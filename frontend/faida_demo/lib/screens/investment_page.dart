import 'package:flutter/material.dart';

class InvestmentPage extends StatefulWidget {
  const InvestmentPage({Key? key}) : super(key: key);

  @override
  State<InvestmentPage> createState() => _InvestmentPageState();
}

class _InvestmentPageState extends State<InvestmentPage> {
  // Categories
  final List<String> _categories = [
    'Mutual Funds',
    'Gold Savings',
    'Fixed Deposits',
    'SIPs',
    'Bonds',
    'Crypto',
  ];
  String _selectedCategory = 'Mutual Funds';

  // Filters
  String _selectedRisk = 'All';
  String _selectedReturn = 'All';
  String _selectedTime = 'All';
  final List<String> _riskLevels = ['All', 'Low', 'Medium', 'High'];
  final List<String> _returnLevels = ['All', 'Below 8%', '8-12%', 'Above 12%'];
  final List<String> _timePeriods = ['All', '1Y', '3Y', '5Y', '10Y+'];

  // Recommended plans (mock data)
  final List<Map<String, dynamic>> _plans = [
    {
      "mfName": "Axis Bluechip Fund",
      "mfCode": "AXISBCF001",
      "amcName": "Axis Mutual Fund",
      "category": "Mutual Funds",
      "subcategory": "Large Cap",
      "riskLevel": "Moderate",
      "currentNAV": 48.25,
      "navDate": "2025-07-13",
      "expenseRatio": 1.52,
      "aum": 13500.25,
      "launchDate": "2010-05-01",
      "minInvestment": 500,
      "growthType": "Growth",
      "isOpenEnded": true,
      "rating": 4.3,
      "description": "A large-cap equity fund focusing on stable long-term returns.",
      "imageUrl": "https://www.chieflearningofficer.com/wp-content/uploads/2022/06/axis-bank-logo-1.jpg",
      "status": "Active",
    },
    {
      "mfName": "SBI Gold Fund",
      "mfCode": "SBIGF002",
      "amcName": "SBI Mutual Fund",
      "category": "Gold Savings",
      "subcategory": "Gold",
      "riskLevel": "Low",
      "currentNAV": 15.75,
      "navDate": "2025-07-13",
      "expenseRatio": 1.10,
      "aum": 2500.00,
      "launchDate": "2012-03-15",
      "minInvestment": 1000,
      "growthType": "Growth",
      "isOpenEnded": true,
      "rating": 4.1,
      "description": "Invests in gold for stable returns and wealth protection.",
      "imageUrl": "https://i.pinimg.com/originals/2a/2c/1d/2a2c1d90075390b22e7e6060254dab0d.jpg",
      "status": "Active",
    },
    {
      "mfName": "HDFC Short Term Debt Fund",
      "mfCode": "HDFCDT003",
      "amcName": "HDFC Mutual Fund",
      "category": "Bonds",
      "subcategory": "Debt",
      "riskLevel": "Low",
      "currentNAV": 22.10,
      "navDate": "2025-07-13",
      "expenseRatio": 0.85,
      "aum": 8000.00,
      "launchDate": "2015-08-10",
      "minInvestment": 5000,
      "growthType": "Growth",
      "isOpenEnded": true,
      "rating": 4.0,
      "description": "Short term debt fund for low risk and steady returns.",
      "imageUrl": "https://static.vecteezy.com/system/resources/previews/020/336/703/original/hdfc-logo-hdfc-icon-free-free-vector.jpg",
      "status": "Active",
    },
    {
      "mfName": "ICICI Prudential Technology Fund",
      "mfCode": "ICICITF004",
      "amcName": "ICICI Prudential",
      "category": "Mutual Funds",
      "subcategory": "Sectoral",
      "riskLevel": "High",
      "currentNAV": 210.50,
      "navDate": "2025-07-13",
      "expenseRatio": 2.05,
      "aum": 9500.00,
      "launchDate": "2018-01-20",
      "minInvestment": 1000,
      "growthType": "Growth",
      "isOpenEnded": true,
      "rating": 4.6,
      "description": "Invests in technology sector for high growth potential.",
      "imageUrl": "https://i.pinimg.com/originals/05/77/0b/05770b37ae535a178b27ab0c666f8f88.jpg",
      "status": "Active",
    },
    {
      "mfName": "Kotak Savings Plan",
      "mfCode": "KOTAKSP005",
      "amcName": "Kotak Mutual Fund",
      "category": "SIPs",
      "subcategory": "Savings",
      "riskLevel": "Medium",
      "currentNAV": 35.80,
      "navDate": "2025-07-13",
      "expenseRatio": 1.25,
      "aum": 4000.00,
      "launchDate": "2016-06-05",
      "minInvestment": 500,
      "growthType": "Growth",
      "isOpenEnded": true,
      "rating": 4.2,
      "description": "Systematic investment plan for disciplined savings.",
      "imageUrl": "https://wpassets.adda247.com/wp-content/uploads/multisite/sites/5/2022/08/16090243/titled-design.jpg",
      "status": "Active",
    },
  ];

  // Investment Calculator
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _yearsController = TextEditingController();
  double? _calculatedReturn;

  @override
  void dispose() {
    _amountController.dispose();
    _yearsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'Investments',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: const Color(0xFF1E3A8A),
        elevation: 0,
        iconTheme: const IconThemeData(color: Color.fromARGB(255, 13, 13, 13)),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCategorySelector(),
            const SizedBox(height: 16),
            _buildFilters(),
            const SizedBox(height: 16),
            _buildSection(
              title: 'Recommended Plans',
              icon: Icons.recommend,
              children: _buildPlanCards(),
            ),
            const SizedBox(height: 24),
            _buildSection(
              title: 'Investment Calculator',
              icon: Icons.calculate,
              children: [_buildCalculator()],
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildCategorySelector() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF1E3A8A), Color(0xFF3B82F6)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          children: _categories.map((cat) {
            final bool selected = _selectedCategory == cat;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedCategory = cat;
                  });
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: selected ? const Color(0xFF1E3A8A) : Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: selected
                          ? const Color(0xFF1E3A8A)
                          : Colors.grey[300]!,
                      width: selected ? 2 : 1,
                    ),
                    boxShadow: selected
                        ? [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.08),
                              blurRadius: 6,
                              offset: const Offset(0, 2),
                            ),
                          ]
                        : [],
                  ),
                  child: Text(
                    cat,
                    style: TextStyle(
                      color: selected ? Colors.white : const Color(0xFF1E3A8A),
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildFilters() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildDropdown('Risk', _riskLevels, _selectedRisk, (val) {
            setState(() => _selectedRisk = val!);
          }),
          _buildDropdown('Return', _returnLevels, _selectedReturn, (val) {
            setState(() => _selectedReturn = val!);
          }),
          _buildDropdown('Time', _timePeriods, _selectedTime, (val) {
            setState(() => _selectedTime = val!);
          }),
        ],
      ),
    );
  }

  Widget _buildDropdown(
    String label,
    List<String> items,
    String value,
    ValueChanged<String?> onChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Color(0xFF1E3A8A),
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey[200]!),
          ),
          child: DropdownButton<String>(
            value: value,
            underline: const SizedBox(),
            isDense: true,
            items: items
                .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                .toList(),
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }

  List<Widget> _buildPlanCards() {
    final filtered = _plans.where((plan) {
      if (_selectedCategory != plan['category']) return false;
      if (_selectedRisk != 'All' && plan['risk'] != _selectedRisk) return false;
      if (_selectedReturn != 'All') {
        final ret =
            double.tryParse(plan['expectedReturn'].replaceAll('%', '')) ?? 0;
        if (_selectedReturn == 'Below 8%' && ret >= 8) return false;
        if (_selectedReturn == '8-12%' && (ret < 8 || ret > 12)) return false;
        if (_selectedReturn == 'Above 12%' && ret <= 12) return false;
      }
      if (_selectedTime != 'All' && plan['time'] != _selectedTime) return false;
      return true;
    }).toList();
    if (filtered.isEmpty) {
      return [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'No plans found for selected filters.',
            style: TextStyle(color: Colors.grey[600]),
          ),
        ),
      ];
    }
    return filtered.map((plan) => _buildPlanCard(plan)).toList();
  }

  Widget _buildPlanCard(Map<String, dynamic> plan) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              plan['imageUrl'] != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        plan['imageUrl'],
                        width: 40,
                        height: 40,
                        fit: BoxFit.cover,
                      ),
                    )
                  : Icon(Icons.account_balance_wallet, color: Color(0xFF1E3A8A), size: 40),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      plan['mfName'] ?? plan['name'] ?? '',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      plan['amcName'] ?? '',
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
              _buildRating(plan['rating']?.toDouble() ?? 0),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            plan['description'] ?? '',
            style: TextStyle(color: Colors.grey[600]),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 16,
            runSpacing: 8,
            children: [
              _buildPlanDetail(Icons.category, plan['category'] ?? ''),
              _buildPlanDetail(Icons.shield, 'Risk: ${plan['riskLevel'] ?? plan['risk'] ?? ''}'),
              _buildPlanDetail(Icons.trending_up, 'NAV: ₹${plan['currentNAV'] ?? ''}'),
              _buildPlanDetail(Icons.percent, 'Expense: ${plan['expenseRatio'] ?? ''}%'),
              _buildPlanDetail(Icons.account_balance, 'AUM: ₹${plan['aum'] ?? ''} Cr'),
              _buildPlanDetail(Icons.calendar_today, 'Launch: ${plan['launchDate'] != null ? plan['launchDate'].toString().substring(0,10) : ''}'),
              _buildPlanDetail(Icons.monetization_on, 'Min: ₹${plan['minInvestment'] ?? ''}'),
              _buildPlanDetail(Icons.trending_up, 'Growth: ${plan['growthType'] ?? ''}'),
              _buildPlanDetail(Icons.star, 'Rating: ${plan['rating'] ?? ''}'),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                _showInvestDialog(plan);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1E3A8A),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Start Investing'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRating(double rating) {
    return Row(
      children: [
        Icon(Icons.star, color: Colors.amber[700], size: 18),
        const SizedBox(width: 2),
        Text(
          rating.toString(),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildPlanDetail(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: Colors.grey[600], size: 16),
        const SizedBox(width: 4),
        Text(text, style: const TextStyle(fontSize: 13)),
      ],
    );
  }

  Widget _buildCalculator() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Amount (₹)',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: TextField(
                controller: _yearsController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Years',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _calculateInvestment,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF3B82F6),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text('Calculate'),
          ),
        ),
        if (_calculatedReturn != null) ...[
          const SizedBox(height: 12),
          Text(
            'Estimated Return: ₹${_calculatedReturn!.toStringAsFixed(2)}',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Color(0xFF1E3A8A),
            ),
          ),
        ],
      ],
    );
  }

  void _calculateInvestment() {
    final amount = double.tryParse(_amountController.text) ?? 0;
    final years = double.tryParse(_yearsController.text) ?? 0;
    // Assume a fixed 10% return for demo
    final rate = 0.10;
    final result = amount * (1 + rate * years);
    setState(() {
      _calculatedReturn = result;
    });
  }

  void _showInvestDialog(Map<String, dynamic> plan) {
    final TextEditingController amountController = TextEditingController();
    final TextEditingController tenureController = TextEditingController();
    final _formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Invest in ${plan['name']}'),
        content: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.9,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Minimum investment: ₹${plan['minInvestment']}\nExpected Return: ${plan['expectedReturn']}',
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: amountController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Amount (₹)',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      final min = plan['minInvestment'] as int;
                      final entered = int.tryParse(value ?? '') ?? 0;
                      if (entered < min) {
                        return 'Minimum is ₹$min';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: tenureController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Time Tenure (years)',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if ((int.tryParse(value ?? '') ?? 0) <= 0) {
                        return 'Enter valid years';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Investment of ₹${amountController.text} for ${tenureController.text} years started in ${plan['name']}!',
                    ),
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1E3A8A),
              foregroundColor: Colors.white,
            ),
            child: const Text('Start Investing'),
          ),
        ],
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: const Color(0xFF1E3A8A)),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E3A8A),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...children,
        ],
      ),
    );
  }
}