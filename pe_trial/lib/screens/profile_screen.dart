import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../providers/app_state.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _weightCtrl = TextEditingController();
  final _heightCtrl = TextEditingController();
  String _gender = 'Male';
  DateTime? _birthDate;

  @override
  void initState() {
    super.initState();
    final state = context.read<AppState>();
    _nameCtrl.text = state.fullName;
    _weightCtrl.text = state.weight > 0 ? state.weight.toString() : '';
    _heightCtrl.text = state.height > 0 ? state.height.toString() : '';
    _gender = state.gender;
    _birthDate = state.birthDate;
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _weightCtrl.dispose();
    _heightCtrl.dispose();
    super.dispose();
  }

  double get _bmi {
    final w = double.tryParse(_weightCtrl.text) ?? 0;
    final h = double.tryParse(_heightCtrl.text) ?? 0;
    if (w <= 0 || h <= 0) return 0;
    return w / ((h / 100) * (h / 100));
  }

  String get _bmiCategory {
    if (_bmi <= 0) return '';
    if (_bmi < 18.5) return 'Underweight';
    if (_bmi < 25) return 'Normal';
    if (_bmi < 30) return 'Overweight';
    return 'Obese';
  }

  Color get _bmiColor {
    if (_bmi <= 0) return Colors.grey;
    if (_bmi < 18.5) return Colors.blue;
    if (_bmi < 25) return Colors.green;
    if (_bmi < 30) return Colors.orange;
    return Colors.red;
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _birthDate ?? DateTime(2000),
      firstDate: DateTime(1940),
      lastDate: DateTime.now(),
    );
    if (picked != null) setState(() => _birthDate = picked);
  }

  void _continue() {
    if (_formKey.currentState!.validate() && _birthDate != null) {
      context.read<AppState>().updateProfile(
        name: _nameCtrl.text.trim(),
        birth: _birthDate,
        gen: _gender,
        w: double.parse(_weightCtrl.text),
        h: double.parse(_heightCtrl.text),
      );
      Navigator.pushNamed(context, '/plan');
    } else if (_birthDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select your birth date')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E),
      appBar: AppBar(
        backgroundColor: const Color(0xFF16213E),
        title: const Text('Profile Setup', style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _sectionTitle('Personal Information'),
              const SizedBox(height: 16),
              _buildField(
                controller: _nameCtrl,
                label: 'Full Name',
                icon: Icons.person,
                validator: (v) =>
                (v == null || v.trim().isEmpty) ? 'Please enter your name' : null,
              ),
              const SizedBox(height: 14),
              _buildDatePicker(),
              const SizedBox(height: 14),
              _buildGenderSelector(),
              const SizedBox(height: 24),
              _sectionTitle('Physical Information'),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _buildField(
                      controller: _weightCtrl,
                      label: 'Weight (kg)',
                      icon: Icons.monitor_weight,
                      keyboardType: TextInputType.number,
                      onChanged: (_) => setState(() {}),
                      validator: (v) {
                        final n = double.tryParse(v ?? '');
                        if (n == null || n <= 0) return 'Must be positive number';
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildField(
                      controller: _heightCtrl,
                      label: 'Height (cm)',
                      icon: Icons.height,
                      keyboardType: TextInputType.number,
                      onChanged: (_) => setState(() {}),
                      validator: (v) {
                        final n = double.tryParse(v ?? '');
                        if (n == null || n <= 0) return 'Must be positive number';
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              if (_bmi > 0) ...[
                const SizedBox(height: 20),
                _buildBMICard(),
              ],
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: _continue,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE94560),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Tiếp tục',
                    style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        color: Color(0xFFE94560),
        fontSize: 16,
        fontWeight: FontWeight.bold,
        letterSpacing: 1,
      ),
    );
  }

  Widget _buildField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
    void Function(String)? onChanged,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      onChanged: onChanged,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white54),
        prefixIcon: Icon(icon, color: const Color(0xFFE94560)),
        filled: true,
        fillColor: Colors.white.withOpacity(0.07),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xFFE94560)),
        ),
      ),
      validator: validator,
    );
  }

  Widget _buildDatePicker() {
    return GestureDetector(
      onTap: _pickDate,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.07),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            const Icon(Icons.cake, color: Color(0xFFE94560)),
            const SizedBox(width: 12),
            Text(
              _birthDate == null
                  ? 'Select Birth Date'
                  : DateFormat('dd/MM/yyyy').format(_birthDate!),
              style: TextStyle(
                color: _birthDate == null ? Colors.white54 : Colors.white,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGenderSelector() {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 8,
      runSpacing: 8,
      children: [
        const Icon(Icons.wc, color: Color(0xFFE94560)),
        const Text('Gender:', style: TextStyle(color: Colors.white54, fontSize: 16)),
        ...['Male', 'Female', 'Other'].map(
              (g) => ChoiceChip(
            label: Text(g),
            selected: _gender == g,
            selectedColor: const Color(0xFFE94560),
            backgroundColor: Colors.white12,
            labelStyle: TextStyle(
              color: _gender == g ? Colors.white : Colors.white70,
            ),
            onSelected: (_) => setState(() => _gender = g),
          ),
        ),
      ],
    );
  }

  Widget _buildBMICard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _bmiColor.withOpacity(0.15),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _bmiColor.withOpacity(0.5)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('Your BMI:', style: TextStyle(color: Colors.white, fontSize: 16)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                _bmi.toStringAsFixed(1),
                style: TextStyle(
                  color: _bmiColor,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                _bmiCategory,
                style: TextStyle(color: _bmiColor, fontSize: 14),
              ),
            ],
          ),
        ],
      ),
    );
  }
}