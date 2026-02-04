import 'package:flutter/material.dart';

class SetStateFix extends StatefulWidget {
  const SetStateFix({super.key});

  @override
  State<SetStateFix> createState() => _SetStateFixState();
}

class _SetStateFixState extends State<SetStateFix> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text(
            'You have pushed the button this many times:',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Text(
            '$_counter',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _incrementCounter,
            child: const Text('Increment (with setState)'),
          ),
        ],
      ),
    );
  }
}