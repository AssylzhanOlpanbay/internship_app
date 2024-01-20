import 'dart:convert';

import 'package:http/http.dart' as http;

class CommentsList {
  List<Comment> comments;
  CommentsList({required this.comments});

  factory CommentsList.fromJson(List<dynamic> json) {
    // var postsJson = json['posts'] as List;

    List<Comment> commentsList = json.map((i) => Comment.fromJson(i)).toList();

    return CommentsList(
      comments: commentsList,
    );
  }
}

class Comment {
  final int postId;
  final int id;
  final String name;
  final String email;
  final String body;

  Comment(
      {required this.postId,
      required this.id,
      required this.name,
      required this.email,
      required this.body});

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
        postId: json['postId'] as int,
        id: json['id'] as int,
        name: json['name'] as String,
        email: json['email'] as String,
        body: json['body'] as String);
  }
}

Future<CommentsList> getCommentsList(int postId) async {
  // const url = 'https://jsonplaceholder.typicode.com/comments';
  final response = await http.get(Uri.parse(
      'https://jsonplaceholder.typicode.com/comments?postId=$postId'));

  if (response.statusCode == 200) {
    return CommentsList.fromJson(json.decode(response.body));
  } else {
    throw Exception('Error: ${response.reasonPhrase}');
  }
}
