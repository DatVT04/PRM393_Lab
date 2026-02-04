import 'package:flutter/material.dart';

import '../services/api_service.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _bodyController = TextEditingController();
  final ApiService _apiService = ApiService();
  bool _isLoading = false;

  Future<void> _submitData() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final newPost = await _apiService.createPost(
        _titleController.text,
        _bodyController.text,
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Tạo bài viết thành công! ID: ${newPost.id}')),
      );
      Navigator.pop(context, newPost); // Trả về đối tượng Post vừa tạo
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Lỗi: $e')));
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Thêm bài viết mới")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Tiêu đề'),
                validator: (value) => value == null || value.isEmpty
                    ? 'Vui lòng nhập tiêu đề'
                    : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _bodyController,
                decoration: const InputDecoration(labelText: 'Nội dung'),
                maxLines: 3,
                validator: (value) => value == null || value.isEmpty
                    ? 'Vui lòng nhập nội dung'
                    : null,
              ),
              const SizedBox(height: 20),
              _isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                onPressed: _submitData,
                child: const Text("Đăng bài"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
