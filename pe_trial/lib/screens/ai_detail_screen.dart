import 'package:flutter/material.dart';

class AIDetailScreen extends StatelessWidget {
  const AIDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final item =
    ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E),
      appBar: AppBar(
        backgroundColor: const Color(0xFF16213E),
        title: const Text('AI Response Detail',
            style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Metadata
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.06),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  _metaRow(Icons.access_time, 'Date & Time',
                      '${item['date']} ${item['time']}'),
                  const Divider(color: Colors.white12, height: 16),
                  _metaRow(Icons.person, 'From', item['sender'] ?? ''),
                  const Divider(color: Colors.white12, height: 16),
                  _metaRow(Icons.smart_toy, 'To', item['receiver'] ?? ''),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Prompt
            _block('Question (Prompt)', item['prompt'] ?? '',
                const Color(0xFF0F3460), const Color(0xFFE94560)),
            const SizedBox(height: 16),
            // Response
            _block('AI Response', item['response'] ?? '',
                Colors.teal.withOpacity(0.15), Colors.tealAccent),
          ],
        ),
      ),
    );
  }

  Widget _metaRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, color: const Color(0xFFE94560), size: 16),
        const SizedBox(width: 8),
        Text('$label: ', style: const TextStyle(color: Colors.white54, fontSize: 13)),
        Expanded(
          child: Text(value,
              style: const TextStyle(color: Colors.white, fontSize: 13)),
        ),
      ],
    );
  }

  Widget _block(String title, String content, Color bgColor, Color borderColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: TextStyle(
                color: borderColor,
                fontSize: 14,
                fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: borderColor.withOpacity(0.4)),
          ),
          child: Text(
            content,
            style: const TextStyle(color: Colors.white, fontSize: 14, height: 1.6),
          ),
        ),
      ],
    );
  }
}
