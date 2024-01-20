import 'package:flutter/material.dart';
import 'package:internship_project/json_data/photo_list.dart';

import '../../json_data/album_list.dart';
import 'full_screen_photo.dart';

class AlbumInfoPage extends StatefulWidget {
  final Album album;

  AlbumInfoPage(this.album);

  @override
  State<AlbumInfoPage> createState() => _AlbumInfoPageState();
}

class _AlbumInfoPageState extends State<AlbumInfoPage> {
  late Future<PhotosList> photosList;

  @override
  void initState() {
    super.initState();
    photosList = getPhotosList(widget.album.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        title: Text(widget.album.title),
      ),
      body: FutureBuilder<PhotosList>(
        future: photosList,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemCount: snapshot.data!.photos.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FullScreenPhoto(
                            photo: snapshot.data!.photos[index]),
                      ),
                    );
                  },
                  child: Card(
                    child: Image.network(
                      snapshot.data!.photos[index].thumbnailUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
