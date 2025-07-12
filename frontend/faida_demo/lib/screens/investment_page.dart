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
      'name': 'Bluechip Mutual Fund',
      'category': 'Mutual Funds',
      'rating': 4.5,
      'minInvestment': 5000,
      'expectedReturn': '12%',
      'risk': 'Medium',
      'time': '5Y',
    },
    {
      'name': 'Gold Savings Plan',
      'category': 'Gold Savings',
      'rating': 4.2,
      'minInvestment': 2000,
      'expectedReturn': '8%',
      'risk': 'Low',
      'time': '3Y',
    },
    {
      'name': 'Crypto Growth',
      'category': 'Crypto',
      'rating': 4.8,
      'minInvestment': 1000,
      'expectedReturn': '18%',
      'risk': 'High',
      'time': '1Y',
    },
    {
      'name': 'Government Bonds',
      'category': 'Bonds',
      'rating': 4.0,
      'minInvestment': 10000,
      'expectedReturn': '7%',
      'risk': 'Low',
      'time': '10Y+',
    },
    {
      'name': 'SIP Starter',
      'category': 'SIPs',
      'rating': 4.3,
      'minInvestment': 500,
      'expectedReturn': '10%',
      'risk': 'Medium',
      'time': '5Y',
    },
    {
      'name': 'FD Plus',
      'category': 'Fixed Deposits',
      'rating': 4.1,
      'minInvestment': 10000,
      'expectedReturn': '6.5%',
      'risk': 'Low',
      'time': '3Y',
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.account_balance_wallet,
                    color: const Color(0xFF1E3A8A),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    plan['name'],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              _buildRating(plan['rating']),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              _buildPlanDetail(
                Icons.monetization_on,
                'Min: ₹${plan['minInvestment']}',
              ),
              const SizedBox(width: 16),
              _buildPlanDetail(
                Icons.trending_up,
                'Return: ${plan['expectedReturn']}',
              ),
              const SizedBox(width: 16),
              _buildPlanDetail(Icons.shield, 'Risk: ${plan['risk']}'),
              const SizedBox(width: 16),
              _buildPlanDetail(Icons.access_time, plan['time']),
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