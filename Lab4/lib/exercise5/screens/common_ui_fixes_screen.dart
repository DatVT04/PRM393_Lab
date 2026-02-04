import 'package:flutter/material.dart';
import '../widgets/expanded_fix.dart';
import '../widgets/overflow_fix.dart';
import '../widgets/set_state_fix.dart';
import '../widgets/context_fix.dart';

class CommonUIFixesScreen extends StatelessWidget {
  const CommonUIFixesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Exercise 5 - Common UI Fixes'),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          bottom: const TabBar(
            isScrollable: true,
            tabs: [
              Tab(text: "1. Expanded Fix"),
              Tab(text: "2. Overflow Fix"),
              Tab(text: "3. setState Fix"),
              Tab(text: "4. Context Fix"),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            ExpandedFix(),
            OverflowFix(),
            SetStateFix(),
            ContextFix(),
          ],
        ),
      ),
    );
  }
}