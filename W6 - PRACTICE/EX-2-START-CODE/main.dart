import 'package:flutter/material.dart';
import 'repository/http_post_repository.dart'; // Import the HTTP repository
import 'repository/post_repository.dart'; // Keep this if you need the interface
import 'package:provider/provider.dart';

import 'ui/providers/post_provider.dart';
import 'ui/screens/post_screen.dart';

void main() {
  // 1- Create the repository
  PostRepository postRepo = HttpPostsRepository(); // Use the HTTP repository

  // 2 - Run the UI
  runApp(
    ChangeNotifierProvider(
      create: (context) => PostProvider(repository: postRepo),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: PostScreen(),
      ),
    ),
  );
}
