import 'package:flutter/material.dart';

enum MovieGenre { action, comedy, drama }

class InputControlsScreen extends StatefulWidget {
  const InputControlsScreen({super.key});

  @override
  State<InputControlsScreen> createState() => _InputControlsScreenState();
}

class _InputControlsScreenState extends State<InputControlsScreen> {
  double _sliderValue = 50;
  bool _isSwitchActive = false;
  MovieGenre? _selectedGenre;
  DateTime? _selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      appBar: AppBar(
        title: const Text('Exercise 2 - Input Controls'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const Text('Rating (Slider)', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Slider(
            value: _sliderValue,
            min: 0,
            max: 100,
            divisions: 100,
            label: _sliderValue.round().toString(),
            onChanged: (double value) {
              setState(() { _sliderValue = value; });
            },
          ),
          Center(child: Text('Current value: ${_sliderValue.round()}')),
          const SizedBox(height: 24),

          const Text('Active (Switch)', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SwitchListTile(
            title: const Text('Is movie active?'),
            value: _isSwitchActive,
            onChanged: (bool value) {
              setState(() { _isSwitchActive = value; });
            },
          ),
          const SizedBox(height: 24),

          const Text('Genre (RadioListTile)', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          RadioListTile<MovieGenre>(
            title: const Text('Action'),
            value: MovieGenre.action,
            groupValue: _selectedGenre,
            onChanged: (MovieGenre? value) {
              setState(() { _selectedGenre = value; });
            },
          ),
          RadioListTile<MovieGenre>(
            title: const Text('Comedy'),
            value: MovieGenre.comedy,
            groupValue: _selectedGenre,
            onChanged: (MovieGenre? value) {
              setState(() { _selectedGenre = value; });
            },
          ),
          const SizedBox(height: 8),

          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text(
              'Selected genre: ${_selectedGenre?.name ?? 'None'}',
              style: const TextStyle(color: Colors.black54),
            ),
          ),
          const SizedBox(height: 24),

          ElevatedButton(
            onPressed: () => _selectDate(context),
            style: ElevatedButton.styleFrom(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              backgroundColor: Colors.grey.shade200,
              foregroundColor: Colors.indigo.shade300,
              minimumSize: const Size(double.infinity, 50),
            ),
            child: const Text('Open Date Picker'),
          ),
          const SizedBox(height: 12),

          if (_selectedDate != null)
            Center(
              child: Text(
                'Selected Date: ${_selectedDate!.toLocal()}'.split(' ')[0],
                style: const TextStyle(color: Colors.black54),
              ),
            ),
        ],
      ),
    );
  }
}