// lib/Exercise-2/Repositories/mock_posts_repository.dart

import '../model/post.dart';
import 'post_repository.dart';

class MockPostRepository extends PostRepository {
  @override
  Future<List<Post>> getPosts() {
    return Future.delayed(Duration(seconds: 5), () {
      return [
        Post(
          id: 1,
          title: 'Who is the best',
          description: 'teacher ronan',
        ),
        Post(
          id: 2,
          title: 'Flutter vs React Native',
          description: 'A comparison of two popular frameworks',
        ),
        Post(
          id: 3,
          title: 'Dart Language Features',
          description: 'Exploring the features of Dart',
        ),
        // Add more fake posts as needed
      ];
    });
  }
}
