// lib/Exercise-2/UI/Screens/post_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/post.dart';
import '../providers/async_value.dart';
import '../providers/post_provider.dart';

class PostScreen extends StatelessWidget {
  const PostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 1 - Get the post provider
    final PostProvider postProvider = Provider.of<PostProvider>(context);

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            // 2- Fetch the posts
            onPressed: () => postProvider.fetchPosts(),
            icon: const Icon(Icons.update),
          ),
        ],
      ),

      // 3 - Display the posts
      body: Center(child: _buildBody(postProvider)),
    );
  }

  Widget _buildBody(PostProvider postProvider) {
    final postValue = postProvider.postValue;

    if (postValue == null) {
      return Text('Tap refresh to display posts'); // Display an empty state
    }

    switch (postValue.state) {
      case AsyncValueState.loading:
        return CircularProgressIndicator(); // Display a progress indicator

      case AsyncValueState.error:
        return Text('Error: ${postValue.error}'); // Display an error message

      case AsyncValueState.success:
        final posts = postValue.data!;
        if (posts.isEmpty) {
          return Text('No posts for now'); // Handle empty list case
        }
        return ListView.builder(
          itemCount: posts.length,
          itemBuilder: (context, index) {
            return PostCard(post: posts[index]); // Display each post
          },
        );
    }
  }
}

class PostCard extends StatelessWidget {
  const PostCard({super.key, required this.post});

  final Post post;

  @override
  Widget build(BuildContext context) {
    return ListTile(title: Text(post.title), subtitle: Text(post.description));
  }
}
