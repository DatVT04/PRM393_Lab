import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_state.dart';

class PlanScreen extends StatelessWidget {
  const PlanScreen({super.key});

  String _formatPrice(int price) {
    if (price >= 1000000) return '${(price / 1000000).toStringAsFixed(0)}tr VND';
    return '${(price / 1000).toStringAsFixed(0)}k VND';
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (context, state, _) {
        final isObese = state.bmi > 30;

        return Scaffold(
          backgroundColor: const Color(0xFF1A1A2E),
          appBar: AppBar(
            backgroundColor: const Color(0xFF16213E),
            title: const Text('Plan Selection', style: TextStyle(color: Colors.white)),
            iconTheme: const IconThemeData(color: Colors.white),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (isObese)
                  Container(
                    padding: const EdgeInsets.all(14),
                    margin: const EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.red.withOpacity(0.5)),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.warning_amber, color: Colors.red),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            'Your BMI indicates Obesity (>30). We strongly recommend Premium or VIP plan for better health support.',
                            style: TextStyle(color: Colors.red, fontSize: 13),
                          ),
                        ),
                      ],
                    ),
                  ),
                const Text(
                  'Choose Your Plan',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'BMI: ${state.bmi.toStringAsFixed(1)} - ${state.bmiCategory}',
                  style: const TextStyle(color: Colors.white54),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: ListView.separated(
                    itemCount: availablePlans.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 16),
                    itemBuilder: (context, i) {
                      final plan = availablePlans[i];
                      final isSelected = state.selectedPlan?.name == plan.name;
                      final isBasicDisabled = isObese && plan.name == 'Basic';

                      return GestureDetector(
                        onTap: isBasicDisabled
                            ? null
                            : () => state.selectPlan(plan),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? const Color(0xFFE94560).withOpacity(0.2)
                                : Colors.white.withOpacity(0.06),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: isSelected
                                  ? const Color(0xFFE94560)
                                  : isBasicDisabled
                                  ? Colors.red.withOpacity(0.3)
                                  : Colors.white12,
                              width: isSelected ? 2 : 1,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        _planIcon(plan.name),
                                        color: isBasicDisabled
                                            ? Colors.grey
                                            : _planColor(plan.name),
                                        size: 28,
                                      ),
                                      const SizedBox(width: 10),
                                      Text(
                                        plan.name,
                                        style: TextStyle(
                                          color: isBasicDisabled
                                              ? Colors.grey
                                              : Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    _formatPrice(plan.price),
                                    style: TextStyle(
                                      color: isBasicDisabled
                                          ? Colors.grey
                                          : _planColor(plan.name),
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              if (isBasicDisabled) ...[
                                const SizedBox(height: 8),
                                const Text(
                                  'Not available: BMI > 30 requires Premium or VIP for health safety.',
                                  style:
                                  TextStyle(color: Colors.red, fontSize: 12),
                                ),
                              ],
                              if (isSelected)
                                const Padding(
                                  padding: EdgeInsets.only(top: 8),
                                  child: Row(
                                    children: [
                                      Icon(Icons.check_circle,
                                          color: Color(0xFFE94560), size: 16),
                                      SizedBox(width: 4),
                                      Text('Selected',
                                          style: TextStyle(
                                              color: Color(0xFFE94560),
                                              fontSize: 13)),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 16),
                if (isObese && state.selectedPlan?.name == 'Basic')
                  Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      color: Colors.orange.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      'Cannot continue with Basic plan due to health concerns. Please select Premium or VIP.',
                      style: TextStyle(color: Colors.orange, fontSize: 13),
                    ),
                  ),
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: state.canContinueFromPlan
                        ? () => Navigator.pushNamed(context, '/payment')
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFE94560),
                      disabledBackgroundColor: Colors.grey.withOpacity(0.3),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Tiếp tục',
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  IconData _planIcon(String name) {
    switch (name) {
      case 'Premium':
        return Icons.star;
      case 'VIP':
        return Icons.diamond;
      default:
        return Icons.fitness_center;
    }
  }

  Color _planColor(String name) {
    switch (name) {
      case 'Premium':
        return Colors.amber;
      case 'VIP':
        return Colors.purpleAccent;
      default:
        return const Color(0xFFE94560);
    }
  }
}
