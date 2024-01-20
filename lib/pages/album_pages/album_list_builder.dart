import 'package:flutter/material.dart';

import '../../json_data/album_list.dart';
import 'album_info_page.dart';

class AlbumListBuilderPage extends StatefulWidget {
  const AlbumListBuilderPage({Key? key}) : super(key: key);

  @override
  State<AlbumListBuilderPage> createState() => _AlbumListBuilderPage();
}

class _AlbumListBuilderPage extends State<AlbumListBuilderPage> {
  late Future<AlbumsList> albumsList;

  @override
  void initState() {
    super.initState();
    albumsList = getAlbumsList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        title: const Text('Albums'),
      ),
      body: FutureBuilder<AlbumsList>(
        future: albumsList,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data?.albums.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: Colors.yellow,
                    child: ListTile(
                      title: Text('${snapshot.data?.albums[index].title}'),
                      subtitle: Text(''),
                      isThreeLine: true,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                AlbumInfoPage(snapshot.data!.albums[index]),
                          ),
                        );
                      },
                    ),
                  );
                });
          } else if (snapshot.hasError) {
            return const Text('Error');
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
