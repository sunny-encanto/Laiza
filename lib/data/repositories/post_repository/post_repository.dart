import 'package:dio/dio.dart';

import '../../models/post_model/post_model.dart';
import '../../services/apiClient/dio_client.dart';

class PostRepository {
  final ApiClient _apiClient = ApiClient();

  Future<List<Post>> fetchPosts() async {
    Response response = await _apiClient.get('/posts');
    try {
      if (response.statusCode == 200) {
        List<dynamic> body = response.data;
        List<Post> posts = [];
        // body.map((dynamic item) => Post.fromJson(item)).toList();
        return posts;
      } else {
        throw Exception('Failed to load posts');
      }
    } catch (e) {
      throw Exception('Failed to load posts');
    }
  }

  Future<void> createPost(Map<String, dynamic> postData) async {
    try {
      Response response = await _apiClient.post('/posts', data: postData);
      // return Post.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to create post: $e');
    }
  }
}
