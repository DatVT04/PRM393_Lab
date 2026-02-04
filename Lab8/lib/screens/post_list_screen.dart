import 'package:flutter/material.dart';
import '../models/post_model.dart';
import '../services/api_service.dart';
import 'add_post_screen.dart';

class PostListScreen extends StatefulWidget {
  const PostListScreen({super.key});
  @override
  State<PostListScreen> createState() => _PostListScreenState();
}

class _PostListScreenState extends State<PostListScreen> {
  final ApiService _apiService = ApiService();
  late Future<List<Post>> _futurePosts;

  @override
  void initState() {
    super.initState();
    _futurePosts = _apiService.fetchPosts();
  }

  Future<void> _refreshPosts() async {
    setState(() {
      _futurePosts = _apiService.fetchPosts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Lab 8 - API List")),
      body: RefreshIndicator(
        onRefresh: _refreshPosts,
        child: FutureBuilder<List<Post>>(
          future: _futurePosts,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Có lỗi xảy ra: ${snapshot.error}",
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: _refreshPosts,
                      child: const Text("Thử lại"),
                    ),
                  ],
                ),
              );
            } else if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final post = snapshot.data![index];
                  return Card(
                    // UI enhancement: Use Card
                    margin: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Text(post.id.toString()),
                      ), // UI enhancement
                      title: Text(
                        post.title,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        post.body,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  );
                },
              );
            }
            return const Center(child: Text("Không có dữ liệu"));
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddPostScreen()),
          );

          if (result is Post) {
            // Cập nhật danh sách local vì API giả không lưu dữ liệu
            setState(() {
              _futurePosts = _futurePosts.then((currentList) {
                final newList = List<Post>.from(currentList);
                newList.insert(0, result);
                return newList;
              });
            });
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
