// lib/ui/providers/post_provider.dart

import 'package:flutter/material.dart';
import '../../model/post.dart';
import '../../repository/post_repository.dart'; // Import the PostRepository interface
import 'async_value.dart';

class PostProvider extends ChangeNotifier {
  final PostRepository _repository; // Use the PostRepository type

  AsyncValue<List<Post>>? postValue;

  PostProvider({required PostRepository repository}) : _repository = repository;

  void fetchPosts() async {
    postValue = AsyncValue.loading();
    notifyListeners();

    try {
      List<Post> posts = await _repository.getPosts(); // Use the repository to fetch posts
      postValue = AsyncValue.success(posts);
    } catch (error) {
      postValue = AsyncValue.error(error);
    }

    notifyListeners();
  }
}
