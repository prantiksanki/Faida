import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Goal Planner',
      theme: ThemeData(
        fontFamily: 'Poppins',
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color(0xFFF5F7FA),
      ),
      home: const GoalPlanningPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class GoalPlanningPage extends StatefulWidget {
  const GoalPlanningPage({super.key});

  @override
  State<GoalPlanningPage> createState() => _GoalPlanningPageState();
}

class _GoalPlanningPageState extends State<GoalPlanningPage> {
  final List<Goal> _goals = [
    Goal(
      title: "Buy a Car",
      targetAmount: 500000,
      deadline: DateTime.now().add(const Duration(days: 300)),
      createdAt: DateTime.now(),
      currentAmount: 227500,
      icon: Icons.directions_car,
    ),
    Goal(
      title: "Save for Wedding",
      targetAmount: 1000000,
      deadline: DateTime.now().add(const Duration(days: 450)),
      createdAt: DateTime.now(),
      currentAmount: 121000,
      icon: Icons.favorite,
    ),
  ];

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  DateTime? _selectedDate;

  void _addGoal() {
    if (_formKey.currentState!.validate() && _selectedDate != null) {
      setState(() {
        _goals.add(Goal(
          title: _titleController.text,
          targetAmount: double.parse(_amountController.text),
          deadline: _selectedDate!,
          createdAt: DateTime.now(),
          icon: Icons.flag, // <-- Add this line
        ));
        _titleController.clear();
        _amountController.clear();
        _selectedDate = null;
        Navigator.pop(context);
      });
    }
  }

  void _showAddGoalSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 25,
            right: 25,
            top: 25,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 5,
                  width: 60,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Create New Goal',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF2E3A59),
                  ),
                ),
                const SizedBox(height: 25),
                TextFormField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    labelText: 'Goal Name',
                    labelStyle: const TextStyle(color: Color(0xFF6A5ACD)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(color: Color(0xFFE0E6ED)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide:
                          const BorderSide(color: Color(0xFF6A5ACD), width: 2),
                    ),
                    prefixIcon: Container(
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: const Color(0xFF6A5ACD).withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.flag, color: Color(0xFF6A5ACD)),
                    ),
                  ),
                  validator: (value) =>
                      value!.isEmpty ? 'Enter goal name' : null,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Target Amount (₹)',
                    labelStyle: const TextStyle(color: Color(0xFF6A5ACD)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(color: Color(0xFFE0E6ED)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide:
                          const BorderSide(color: Color(0xFF6A5ACD), width: 2),
                    ),
                    prefixIcon: Container(
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: const Color(0xFF6A5ACD).withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.currency_rupee,
                          color: Color(0xFF6A5ACD)),
                    ),
                  ),
                  validator: (value) => value!.isEmpty ? 'Enter amount' : null,
                ),
                const SizedBox(height: 20),
                InkWell(
                  onTap: () async {
                    final date = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now().add(const Duration(days: 30)),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2030),
                    );
                    if (date != null) {
                      setState(() => _selectedDate = date);
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 18),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: const Color(0xFFE0E6ED)),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: const Color(0xFF6A5ACD).withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.calendar_today,
                              color: Color(0xFF6A5ACD), size: 20),
                        ),
                        const SizedBox(width: 15),
                        Text(
                          _selectedDate == null
                              ? 'Select Deadline'
                              : DateFormat('dd MMM yyyy')
                                  .format(_selectedDate!),
                          style: TextStyle(
                            color: _selectedDate == null
                                ? Colors.grey[500]
                                : Colors.black,
                          ),
                        ),
                        const Spacer(),
                        const Icon(Icons.arrow_drop_down, color: Colors.grey),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Container(
                  width: double.infinity,
                  height: 55,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF6A5ACD), Color(0xFF9370DB)],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF6A5ACD).withOpacity(0.3),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      )
                    ],
                  ),
                  child: ElevatedButton(
                    onPressed: _addGoal,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: const Text(
                      'CREATE GOAL',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 25),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 180,
            floating: true,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text('Goal Planner',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20)),
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFF6A5ACD), Color(0xFF9370DB)],
                  ),
                ),
              ),
            ),
            actions: [
              IconButton(
                icon: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.notifications, color: Colors.white),
                ),
                onPressed: () {},
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Your Financial Goals',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF2E3A59),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Track and manage your savings targets',
                    style: TextStyle(
                      color: Color(0xFF7E8CA0),
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ..._goals.map((goal) => GoalCard(goal: goal)).toList(),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddGoalSheet,
        backgroundColor: Colors.white,
        elevation: 8,
        child: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const LinearGradient(
              colors: [Color(0xFFFF7F50), Color(0xFFFFA07A)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFFF7F50).withOpacity(0.4),
                blurRadius: 10,
                offset: const Offset(0, 5),
              )
            ],
          ),
          child: const Icon(Icons.add, color: Colors.white),
        ),
      ),
    );
  }
}

class Goal {
  final String title;
  final double targetAmount;
  final DateTime deadline;
  final DateTime createdAt;
  double currentAmount;
  final IconData icon;

  Goal({
    required this.title,
    required this.targetAmount,
    required this.deadline,
    required this.createdAt,
    this.currentAmount = 0,
    this.icon = Icons.flag,
  });

  double get progress => currentAmount / targetAmount;
  String get progressPercent => '${(progress * 100).toStringAsFixed(1)}%';
}

class GoalCard extends StatelessWidget {
  final Goal goal;

  const GoalCard({super.key, required this.goal});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 15,
            offset: const Offset(0, 5),
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: const Color(0xFF6A5ACD).withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(goal.icon, color: const Color(0xFF6A5ACD)),
                    ),
                    const SizedBox(width: 15),
                    Text(
                      goal.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF2E3A59),
                      ),
                    ),
                  ],
                ),
                if (goal.progress >= 0.25)
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: const BoxDecoration(
                      color: Color(0xFF20B2AA),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.notifications_active,
                        color: Colors.white, size: 18),
                  )
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const Icon(Icons.currency_rupee,
                    size: 16, color: Color(0xFF7E8CA0)),
                Text(
                  '${NumberFormat('#,##0').format(goal.targetAmount)}',
                  style: const TextStyle(
                    color: Color(0xFF2E3A59),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                const Icon(Icons.calendar_today,
                    size: 16, color: Color(0xFF7E8CA0)),
                const SizedBox(width: 5),
                Text(
                  DateFormat('dd MMM yyyy').format(goal.deadline),
                  style: const TextStyle(
                    color: Color(0xFF2E3A59),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Stack(
              children: [
                Container(
                  height: 12,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                Container(
                  height: 12,
                  width:
                      MediaQuery.of(context).size.width * 0.7 * goal.progress,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF20B2AA), Color(0xFF40E0D0)],
                    ),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF20B2AA).withOpacity(0.3),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      )
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                  text: TextSpan(
                    text: '₹',
                    style: const TextStyle(
                      color: Color(0xFF7E8CA0),
                      fontSize: 13,
                    ),
                    children: [
                      TextSpan(
                        text:
                            '${NumberFormat('#,##0').format(goal.currentAmount)} saved',
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  goal.progressPercent,
                  style: const TextStyle(
                    color: Color(0xFF2E3A59),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'SUGGESTED INVESTMENTS:',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Color(0xFF7E8CA0),
                fontSize: 12,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 12),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildPlanChip(
                      'Axis Bluechip Fund', '+12.5%', Icons.show_chart),
                  _buildPlanChip('PPF Account', '+7.1%', Icons.account_balance),
                  _buildPlanChip('SBI Gold ETF', '+8.2%', Icons.money),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlanChip(String title, String returns, IconData icon) {
    final isPositive = returns.contains('+');
    return Container(
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFE8F4F8), Colors.white],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: const Color(0xFF20B2AA).withOpacity(0.2)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, 3),
          )
        ],
      ),
      child: Row(
        children: [
          Icon(icon, size: 18, color: const Color(0xFF20B2AA)),
          const SizedBox(width: 8),
          Text(
            title,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Color(0xFF2E3A59),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            returns,
            style: TextStyle(
              color: isPositive ? const Color(0xFF4CAF50) : Colors.red,
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}
