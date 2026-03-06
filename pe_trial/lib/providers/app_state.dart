import 'package:flutter/material.dart';

class GymPlan {
  final String name;
  final int price;
  GymPlan({required this.name, required this.price});
}

final List<GymPlan> availablePlans = [
  GymPlan(name: 'Basic', price: 500000),
  GymPlan(name: 'Premium', price: 1000000),
  GymPlan(name: 'VIP', price: 2000000),
];

class AppState extends ChangeNotifier {
  // Screen 1 - Profile
  String fullName = '';
  DateTime? birthDate;
  String gender = 'Male';
  double weight = 0;
  double height = 0;

  // Screen 2 - Plan
  GymPlan? selectedPlan;

  // Screen 3 - Payment
  String promoCode = '';
  double discount = 0;
  String promoMessage = '';

  // Computed
  double get bmi {
    if (weight <= 0 || height <= 0) return 0;
    double h = height / 100;
    return weight / (h * h);
  }

  String get bmiCategory {
    if (bmi <= 0) return '';
    if (bmi < 18.5) return 'Underweight';
    if (bmi < 25) return 'Normal';
    if (bmi < 30) return 'Overweight';
    return 'Obese';
  }

  int get age {
    if (birthDate == null) return 0;
    final now = DateTime.now();
    int a = now.year - birthDate!.year;
    if (now.month < birthDate!.month ||
        (now.month == birthDate!.month && now.day < birthDate!.day)) {
      a--;
    }
    return a;
  }

  double get originalPrice => selectedPlan?.price.toDouble() ?? 0;

  double get finalPrice => originalPrice - discount;

  bool get isBasicDisabledByBMI =>
      bmi > 30 && selectedPlan?.name == 'Basic';

  bool get canContinueFromPlan {
    if (selectedPlan == null) return false;
    if (bmi > 30 && selectedPlan!.name == 'Basic') return false;
    return true;
  }

  void updateProfile({
    String? name,
    DateTime? birth,
    String? gen,
    double? w,
    double? h,
  }) {
    if (name != null) fullName = name;
    if (birth != null) birthDate = birth;
    if (gen != null) gender = gen;
    if (w != null) weight = w;
    if (h != null) height = h;
    // Reset promo if BMI changes
    promoCode = '';
    discount = 0;
    promoMessage = '';
    notifyListeners();
  }

  void selectPlan(GymPlan plan) {
    selectedPlan = plan;
    // Reset promo when plan changes
    promoCode = '';
    discount = 0;
    promoMessage = '';
    notifyListeners();
  }

  void applyPromo(String code) {
    promoCode = code.trim().toUpperCase();
    discount = 0;
    promoMessage = '';

    if (promoCode == 'GIAM50') {
      if (originalPrice > 1500000) {
        discount = originalPrice * 0.5;
        promoMessage = 'Applied GIAM50: 50% off!';
      } else {
        promoMessage = 'GIAM50 only applies for orders over 1,500,000 VND.';
      }
    } else if (promoCode == 'TANTHU') {
      if (age < 22) {
        discount = originalPrice * 0.2;
        promoMessage = 'Applied TANTHU: 20% off for users under 22!';
      } else {
        promoMessage = 'TANTHU only applies for users under 22 years old.';
      }
    } else if (promoCode.isNotEmpty) {
      promoMessage = 'Invalid promo code.';
    }
    notifyListeners();
  }

  void reset() {
    fullName = '';
    birthDate = null;
    gender = 'Male';
    weight = 0;
    height = 0;
    selectedPlan = null;
    promoCode = '';
    discount = 0;
    promoMessage = '';
    notifyListeners();
  }
}
