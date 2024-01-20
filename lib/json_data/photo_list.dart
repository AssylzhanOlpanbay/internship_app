import 'dart:convert';

import 'package:http/http.dart' as http;

class PhotosList {
  List<Photo> photos;
  PhotosList({required this.photos});

  factory PhotosList.fromJson(List<dynamic> json) {
    // var postsJson = json['posts'] as List;

    List<Photo> photosList = json.map((i) => Photo.fromJson(i)).toList();

    return PhotosList(
      photos: photosList,
    );
  }
}

class Photo {
  final int albumId;
  final int id;
  final String title;
  final String url;
  final String thumbnailUrl;

  Photo(
      {required this.albumId,
      required this.id,
      required this.title,
      required this.url,
      required this.thumbnailUrl});

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
        albumId: json['albumId'] as int,
        id: json['id'] as int,
        title: json['title'] as String,
        url: json['url'] as String,
        thumbnailUrl: json['thumbnailUrl'] as String);
  }
}

Future<PhotosList> getPhotosList(int albumId) async {
  // const url = 'https://jsonplaceholder.typicode.com/comments';
  final response = await http.get(Uri.parse(
      'https://jsonplaceholder.typicode.com/photos?albumId=$albumId'));

  if (response.statusCode == 200) {
    return PhotosList.fromJson(json.decode(response.body));
  } else {
    throw Exception('Error: ${response.reasonPhrase}');
  }
}
