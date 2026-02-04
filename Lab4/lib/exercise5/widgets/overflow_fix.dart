import 'package:flutter/material.dart';

class OverflowFix extends StatelessWidget {
  const OverflowFix({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Fix overflow in small screens using SingleChildScrollView',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 20),
            ...List.generate(
              15,
                  (index) => Container(
                color: Colors.blue[(index % 9 + 1) * 100],
                height: 50,
                margin: const EdgeInsets.only(bottom: 10),
                alignment: Alignment.center,
                child: Text('Container ${index + 1}'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}