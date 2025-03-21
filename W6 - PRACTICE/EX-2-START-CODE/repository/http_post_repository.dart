// lib/repository/http_posts_repository.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/post.dart';
import '../dto/post_dto.dart';
import 'post_repository.dart'; // Import the PostRepository interface

class HttpPostsRepository implements PostRepository { // Implement the interface
  final String apiUrl = 'https://jsonplaceholder.typicode.com/posts';

  @override
  Future<List<Post>> getPosts() async { // Override the method
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((post) => _fromJson(post)).toList();
    } else {
      throw Exception('Failed to load posts');
    }
  }

  Post _fromJson(Map<String, dynamic> json) {
    try {
      PostDTO postDTO = PostDTO.fromJson(json);
      return Post(
        id: postDTO.id,
        title: postDTO.title,
        description: postDTO.body, // Map body to description
      );
    } catch (e) {
      throw Exception('Error parsing post: $e');
    }
  }
}
