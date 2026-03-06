import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/app_state.dart';
import 'screens/splash_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/plan_screen.dart';
import 'screens/payment_screen.dart';
import 'screens/review_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/ai_history_screen.dart';
import 'screens/ai_detail_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => AppState(),
      child: const ZenFitApp(),
    ),
  );
}

class ZenFitApp extends StatelessWidget {
  const ZenFitApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ZenFit',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFE94560),
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/plan': (context) => const PlanScreen(),
        '/payment': (context) => const PaymentScreen(),
        '/review': (context) => const ReviewScreen(),
        '/dashboard': (context) => const DashboardScreen(),
        '/ai_history': (context) => const AIHistoryScreen(),
        '/ai_detail': (context) => const AIDetailScreen(),
      },
    );
  }
}
