import 'dart:convert';

import 'package:http/http.dart' as http;

class PostsList {
  List<Post> posts;
  PostsList({required this.posts});

  factory PostsList.fromJson(List<dynamic> json) {
    // var postsJson = json['posts'] as List;

    List<Post> postsList = json.map((i) => Post.fromJson(i)).toList();

    return PostsList(
      posts: postsList,
    );
  }
}

class Post {
  final int id;
  final String title;
  final String body;

  Post({required this.id, required this.title, required this.body});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
        id: json['id'] as int,
        title: json['title'] as String,
        body: json['body'] as String);
  }
}

Future<PostsList> getPostsList() async {
  const url = 'https://jsonplaceholder.typicode.com/posts';
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    return PostsList.fromJson(json.decode(response.body));
  } else {
    throw Exception('Error: ${response.reasonPhrase}');
  }
}
