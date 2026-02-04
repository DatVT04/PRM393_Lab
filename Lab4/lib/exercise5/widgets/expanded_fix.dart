import 'package:flutter/material.dart';

class ExpandedFix extends StatelessWidget {
  const ExpandedFix({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'Correct ListView inside Column using Expanded',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: 4,
            itemBuilder: (context, index) {
              return ListTile(
                leading: const Icon(Icons.movie),
                title: Text('Movie ${String.fromCharCode(65 + index)}'),
              );
            },
          ),
        ),
      ],
    );
  }
}