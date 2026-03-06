import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AIHistoryScreen extends StatefulWidget {
  const AIHistoryScreen({super.key});

  @override
  State<AIHistoryScreen> createState() => _AIHistoryScreenState();
}

class _AIHistoryScreenState extends State<AIHistoryScreen> {
  List<Map<String, dynamic>> _history = [];

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  Future<void> _loadHistory() async {
    final str = await rootBundle.loadString('assets/ai_prompt_history.json');
    final List<dynamic> data = jsonDecode(str);
    setState(() {
      _history = data.cast<Map<String, dynamic>>();
    });
  }

  String _shortTitle(String prompt) {
    return prompt.length > 60 ? '${prompt.substring(0, 60)}...' : prompt;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E),
      appBar: AppBar(
        backgroundColor: const Color(0xFF16213E),
        title: const Text('AI Prompt History', style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: _history.isEmpty
          ? const Center(
          child: CircularProgressIndicator(color: Color(0xFFE94560)))
          : ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: _history.length,
        separatorBuilder: (_, __) => const SizedBox(height: 10),
        itemBuilder: (context, i) {
          final item = _history[i];
          return GestureDetector(
            onTap: () => Navigator.pushNamed(
              context,
              '/ai_detail',
              arguments: item,
            ),
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.06),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white12),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE94560).withOpacity(0.15),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.smart_toy,
                        color: Color(0xFFE94560), size: 22),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _shortTitle(item['prompt'] ?? ''),
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            const Icon(Icons.access_time,
                                color: Colors.white38, size: 12),
                            const SizedBox(width: 4),
                            Text(
                              '${item['date']} ${item['time']}',
                              style: const TextStyle(
                                  color: Colors.white38, fontSize: 11),
                            ),
                            const SizedBox(width: 12),
                            const Icon(Icons.person_outline,
                                color: Colors.white38, size: 12),
                            const SizedBox(width: 4),
                            Text(
                              item['sender'] ?? '',
                              style: const TextStyle(
                                  color: Colors.white38, fontSize: 11),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.chevron_right,
                      color: Colors.white38),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
