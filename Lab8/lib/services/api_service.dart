// lib/services/api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/post_model.dart';

class ApiService {
  // Định nghĩa URL API mẫu
  static const String url = "https://jsonplaceholder.typicode.com/posts";

  Future<List<Post>> fetchPosts() async {
    try {
      final response = await http
          .get(
        Uri.parse(url),
        headers: {
          "Accept": "application/json",
          "User-Agent": "PostmanRuntime/7.28.4",
        },
      )
          .timeout(const Duration(seconds: 10));

      // Kiểm tra mã trạng thái phản hồi
      if (response.statusCode == 200) {
        // Giải mã JSON từ thân phản hồi
        final List<dynamic> jsonData = json.decode(response.body);
        // Chuyển đổi danh sách JSON thành danh sách các đối tượng Model
        return jsonData.map((item) => Post.fromJson(item)).toList();
      } else if (response.statusCode == 403) {
        throw Exception("Lỗi 403: Server từ chối truy cập.");
      } else {
        throw Exception("Server trả về lỗi: ${response.statusCode}");
      }
    } catch (e) {
      // Xử lý các lỗi kết nối hoặc ngoại lệ khác
      throw Exception("Lỗi kết nối: $e");
    }
  }

  // Phương thức gửi yêu cầu POST để tạo bài viết mới
  Future<Post> createPost(String title, String body) async {
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json; charset=UTF-8",
        },
        body: jsonEncode({
          "title": title,
          "body": body,
          "userId": 1, // API giả định userId
        }),
      );

      if (response.statusCode == 201) {
        return Post.fromJson(json.decode(response.body));
      } else {
        throw Exception("Không thể tạo bài viết: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Lỗi khi tạo bài viết: $e");
    }
  }
}
