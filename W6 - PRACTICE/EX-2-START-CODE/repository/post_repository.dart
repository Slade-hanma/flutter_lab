// lib/Exercise-2/Repositories/post_repository.dart

import '../model/post.dart';

abstract class PostRepository {
  Future<List<Post>> getPosts(); // Updated to return a list of posts
}
