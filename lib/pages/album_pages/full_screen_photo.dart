import 'package:flutter/material.dart';
import 'package:internship_project/json_data/photo_list.dart';

class FullScreenPhoto extends StatelessWidget {
  final Photo photo;

  FullScreenPhoto({required this.photo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        title: Text('Full Screen Photo'),
      ),
      body: Center(
        child: Image.network(
          photo.url,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
