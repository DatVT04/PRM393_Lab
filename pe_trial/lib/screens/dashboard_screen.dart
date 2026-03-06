import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../providers/app_state.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  String _formatMoney(double amount) {
    return '${amount.toStringAsFixed(0).replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (m) => '.')} VND';
  }

  Color _planColor(String? name) {
    switch (name) {
      case 'Premium':
        return Colors.amber;
      case 'VIP':
        return Colors.purpleAccent;
      default:
        return const Color(0xFFE94560);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (context, state, _) {
        final planColor = _planColor(state.selectedPlan?.name);

        return Scaffold(
          backgroundColor: const Color(0xFF1A1A2E),
          appBar: AppBar(
            backgroundColor: const Color(0xFF16213E),
            title: const Text('Member Dashboard', style: TextStyle(color: Colors.white)),
            automaticallyImplyLeading: false,
            iconTheme: const IconThemeData(color: Colors.white),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                // Virtual Member Card
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        planColor.withOpacity(0.8),
                        planColor.withOpacity(0.3),
                        const Color(0xFF1A1A2E),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: planColor.withOpacity(0.5)),
                    boxShadow: [
                      BoxShadow(
                        color: planColor.withOpacity(0.3),
                        blurRadius: 20,
                        spreadRadius: 2,
                      )
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
                              const Icon(Icons.fitness_center,
                                  color: Colors.white, size: 28),
                              const SizedBox(width: 8),
                              const Text('ZenFit',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 2)),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 6),
                            decoration: BoxDecoration(
                              color: planColor,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              state.selectedPlan?.name.toUpperCase() ?? 'BASIC',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Text(
                        state.fullName,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        '${state.gender}  •  Age ${state.age}',
                        style: const TextStyle(
                            color: Colors.white70, fontSize: 14),
                      ),
                      const SizedBox(height: 16),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          _statChip('BMI', state.bmi.toStringAsFixed(1)),
                          _statChip('Weight', '${state.weight}kg'),
                          _statChip('Height', '${state.height}cm'),
                        ],
                      ),
                      const SizedBox(height: 16),
                      const Divider(color: Colors.white24),
                      const SizedBox(height: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Total Paid: ${_formatMoney(state.finalPrice)}',
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Joined: ${DateFormat('dd/MM/yyyy').format(DateTime.now())}',
                            style: const TextStyle(
                                color: Colors.white70, fontSize: 13),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                // Stats
                Row(
                  children: [
                    Expanded(
                        child: _statCard(
                            'BMI Status', state.bmiCategory, Icons.monitor_heart)),
                    const SizedBox(width: 12),
                    Expanded(
                        child: _statCard('Plan',
                            state.selectedPlan?.name ?? '-', Icons.card_membership)),
                  ],
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: () =>
                        Navigator.pushNamed(context, '/ai_history'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF16213E),
                      side: const BorderSide(color: Color(0xFFE94560)),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text('Hết bài làm',
                        style: TextStyle(
                            fontSize: 18,
                            color: Color(0xFFE94560),
                            fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _statChip(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.black26,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text('$label: $value',
          style: const TextStyle(color: Colors.white, fontSize: 12)),
    );
  }

  Widget _statCard(String title, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.06),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(icon, color: const Color(0xFFE94560), size: 30),
          const SizedBox(height: 8),
          Text(title,
              style: const TextStyle(color: Colors.white54, fontSize: 12)),
          const SizedBox(height: 4),
          Text(value,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}