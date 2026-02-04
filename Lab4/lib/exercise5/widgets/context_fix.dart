import 'package:flutter/material.dart';

class ContextFix extends StatelessWidget {
  const ContextFix({super.key});

  void _showPicker(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Fix DatePicker build context errors by calling from a valid widget tree',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              _showPicker(context);
            },
            child: const Text('Show Date Picker (Correct Context)'),
          ),
        ],
      ),
    );
  }
}