import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  Map<String, dynamic>? studentInfo;
  late AnimationController _animController;
  late Animation<double> _fadeAnim;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fadeAnim = CurvedAnimation(parent: _animController, curve: Curves.easeIn);
    _loadStudentInfo();
  }

  Future<void> _loadStudentInfo() async {
    final String jsonStr =
    await rootBundle.loadString('assets/student_info.json');
    final data = jsonDecode(jsonStr);
    setState(() => studentInfo = data);
    _animController.forward();

    await Future.delayed(const Duration(seconds: 5));
    if (mounted) {
      Navigator.pushReplacementNamed(context, '/profile');
    }
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF1A1A2E), Color(0xFF16213E), Color(0xFF0F3460)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: FadeTransition(
          opacity: _fadeAnim,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE94560),
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFE94560).withOpacity(0.5),
                        blurRadius: 30,
                        spreadRadius: 5,
                      )
                    ],
                  ),
                  child: const Icon(
                    Icons.fitness_center,
                    size: 70,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'ZenFit',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 4,
                  ),
                ),
                const Text(
                  'Smart Gym Management',
                  style: TextStyle(
                    color: Color(0xFFE94560),
                    fontSize: 16,
                    letterSpacing: 2,
                  ),
                ),
                const SizedBox(height: 60),
                if (studentInfo != null) ...[
                  Container(
                    padding: const EdgeInsets.all(20),
                    margin: const EdgeInsets.symmetric(horizontal: 40),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.15),
                      ),
                    ),
                    child: Column(
                      children: [
                        _infoRow(Icons.person, studentInfo!['name']),
                        const SizedBox(height: 8),
                        _infoRow(Icons.badge, studentInfo!['student_id']),
                        const SizedBox(height: 8),
                        _infoRow(Icons.email, studentInfo!['email']),
                      ],
                    ),
                  ),
                ] else
                  const CircularProgressIndicator(color: Color(0xFFE94560)),
                const SizedBox(height: 40),
                const SizedBox(
                  width: 200,
                  child: LinearProgressIndicator(
                    color: Color(0xFFE94560),
                    backgroundColor: Colors.white24,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Loading...',
                  style: TextStyle(color: Colors.white54),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _infoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: const Color(0xFFE94560), size: 18),
        const SizedBox(width: 10),
        Flexible(
          child: Text(
            text,
            style: const TextStyle(color: Colors.white, fontSize: 14),
          ),
        ),
      ],
    );
  }
}
