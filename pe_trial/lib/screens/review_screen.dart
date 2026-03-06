import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../providers/app_state.dart';

class ReviewScreen extends StatelessWidget {
  const ReviewScreen({super.key});

  String _formatMoney(double amount) {
    return '${amount.toStringAsFixed(0).replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (m) => '.')} VND';
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (context, state, _) {
        return Scaffold(
          backgroundColor: const Color(0xFF1A1A2E),
          appBar: AppBar(
            backgroundColor: const Color(0xFF16213E),
            title: const Text('Review & Confirm', style: TextStyle(color: Colors.white)),
            iconTheme: const IconThemeData(color: Colors.white),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _section(
                  'Personal Profile',
                  Icons.person,
                  [
                    _row('Name', state.fullName),
                    _row('Birth Date',
                        state.birthDate != null
                            ? DateFormat('dd/MM/yyyy').format(state.birthDate!)
                            : '-'),
                    _row('Age', '${state.age} years old'),
                    _row('Gender', state.gender),
                    _row('Weight', '${state.weight} kg'),
                    _row('Height', '${state.height} cm'),
                    _row('BMI',
                        '${state.bmi.toStringAsFixed(1)} (${state.bmiCategory})'),
                  ],
                  editRoute: '/profile',
                  context: context,
                ),
                const SizedBox(height: 16),
                _section(
                  'Selected Plan',
                  Icons.fitness_center,
                  [
                    _row('Plan', state.selectedPlan?.name ?? '-'),
                    _row('Price', _formatMoney(state.originalPrice)),
                  ],
                  editRoute: '/plan',
                  context: context,
                ),
                const SizedBox(height: 16),
                _section(
                  'Payment Info',
                  Icons.payment,
                  [
                    _row('Promo Code',
                        state.promoCode.isEmpty ? 'None' : state.promoCode),
                    if (state.discount > 0)
                      _row('Discount', '- ${_formatMoney(state.discount)}',
                          valueColor: Colors.green),
                    _row('Total', _formatMoney(state.finalPrice),
                        valueColor: const Color(0xFFE94560), bold: true),
                  ],
                  editRoute: '/payment',
                  context: context,
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: () =>
                        Navigator.pushReplacementNamed(context, '/dashboard'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFE94560),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text('Confirm & Register',
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
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

  Widget _section(
      String title,
      IconData icon,
      List<Widget> rows, {
        required String editRoute,
        required BuildContext context,
      }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.06),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.white12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(icon, color: const Color(0xFFE94560), size: 20),
                  const SizedBox(width: 8),
                  Text(title,
                      style: const TextStyle(
                          color: Color(0xFFE94560),
                          fontWeight: FontWeight.bold,
                          fontSize: 15)),
                ],
              ),
              TextButton.icon(
                onPressed: () {
                  // Pop all routes until the target route is on top
                  Navigator.popUntil(context,
                      ModalRoute.withName(editRoute));
                },
                icon: const Icon(Icons.edit, size: 14, color: Colors.white54),
                label: const Text('Edit',
                    style: TextStyle(color: Colors.white54, fontSize: 13)),
                style: TextButton.styleFrom(padding: EdgeInsets.zero),
              ),
            ],
          ),
          const Divider(color: Colors.white12),
          ...rows,
        ],
      ),
    );
  }

  Widget _row(String label, String value,
      {Color? valueColor, bool bold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.white54, fontSize: 14)),
          Text(value,
              style: TextStyle(
                  color: valueColor ?? Colors.white,
                  fontSize: 14,
                  fontWeight: bold ? FontWeight.bold : FontWeight.normal)),
        ],
      ),
    );
  }
}
