import 'dart:convert';

import 'package:http/http.dart' as http;

class ToDo {
  final String userId;
  final String id;
  final String title;
  final bool completed;

  ToDo({
    required this.userId,
    required this.id,
    required this.title,
    required this.completed,
  });
  factory ToDo.fromJson(Map<String, dynamic> json) {
    return ToDo(
      userId: json['userId'].toString(),
      id: json['id'].toString(),
      title: json['title'] as String,
      completed: json['completed'] as bool,
    );
  }
}

Future<List<ToDo>> getCasesList() async {
  final url = 'https://jsonplaceholder.typicode.com/todos';
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    Iterable jsonResponse = json.decode(response.body);
    List<ToDo> tasks = jsonResponse.map((e) => ToDo.fromJson(e)).toList();
    return tasks;
  } else {
    throw Exception("Error on loading");
  }
}
