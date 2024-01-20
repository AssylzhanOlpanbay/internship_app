import 'dart:convert';

import 'package:http/http.dart' as http;

class AlbumsList {
  List<Album> albums;
  AlbumsList({required this.albums});

  factory AlbumsList.fromJson(List<dynamic> json) {
    // var postsJson = json['posts'] as List;

    List<Album> albumsList = json.map((i) => Album.fromJson(i)).toList();

    return AlbumsList(
      albums: albumsList,
    );
  }
}

class Album {
  final int id;
  final String title;

  Album({required this.id, required this.title});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      id: json['id'] as int,
      title: json['title'] as String,
    );
  }
}

Future<AlbumsList> getAlbumsList() async {
  const url = 'https://jsonplaceholder.typicode.com/albums';
  final response =
      await http.get(Uri.parse('https://jsonplaceholder.typicode.com/albums'));

  if (response.statusCode == 200) {
    return AlbumsList.fromJson(json.decode(response.body));
  } else {
    throw Exception('Error: ${response.reasonPhrase}');
  }
}
