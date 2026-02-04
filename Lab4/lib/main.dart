import 'package:flutter/material.dart';
import 'exercise1/core_widgets_screen.dart';
import 'exercise2/input_controls_screen.dart';
import 'exercise3/screens/layout_demo_screen.dart';
import 'exercise4/app_structure_screen.dart';
import 'exercise5/screens/common_ui_fixes_screen.dart';

void main() {
  runApp(const Lab4App());
}

class Lab4App extends StatelessWidget {
  const Lab4App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lab 4 - Flutter UI Fundamentals',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const ExerciseMenu(),
      debugShowCheckedModeBanner: false,
    );
  }
}


class ExerciseMenu extends StatelessWidget {
  const ExerciseMenu({super.key});

  Widget _buildMenuButton(BuildContext context, String title, Widget screen) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey.shade700,
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          color: Colors.grey.shade600,
          size: 20,
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => screen),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Lab 4 - Flutter UI Fundamentals',
          style: TextStyle(
            color: Colors.grey.shade800,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 16),
        children: [
          _buildMenuButton(
            context,
            'Exercise 1 - Core Widgets Demo',
            const CoreWidgetsScreen(),
          ),
          _buildMenuButton(
            context,
            'Exercise 2 - Input Controls Demo',
            const InputControlsScreen(),
          ),
          _buildMenuButton(
            context,
            'Exercise 3 - Layout Demo',
            const LayoutDemoScreen(),
          ),
          _buildMenuButton(
            context,
            'Exercise 4 - App Structure & Theme',
            const AppStructureScreen(),
          ),
          _buildMenuButton(
            context,
            'Exercise 5 - Common UI Fixes',
            const CommonUIFixesScreen(),
          ),
        ],
      ),
    );
  }
}