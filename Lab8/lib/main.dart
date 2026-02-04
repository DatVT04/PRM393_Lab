import 'package:flutter/material.dart';
import 'screens/post_list_screen.dart'; // Import đúng đường dẫn vào thư mục screens

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const PostListScreen(),
    );
  }
}
