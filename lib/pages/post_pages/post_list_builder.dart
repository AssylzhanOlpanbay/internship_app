import 'package:flutter/material.dart';
import 'package:internship_project/pages/post_pages/post_info_page.dart';

import '../../json_data/post_list.dart';

class PostListBuilderPage extends StatefulWidget {
  const PostListBuilderPage({Key? key}) : super(key: key);

  @override
  State<PostListBuilderPage> createState() => _PostListBuilderPage();
}

class _PostListBuilderPage extends State<PostListBuilderPage> {
  late Future<PostsList> postsList;

  @override
  void initState() {
    super.initState();
    postsList = getPostsList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        title: const Text('Posts'),
      ),
      body: FutureBuilder<PostsList>(
        future: postsList,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data?.posts.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: Colors.yellow,
                    child: ListTile(
                      title: Text('${snapshot.data?.posts[index].title}'),
                      subtitle: Text(
                        '${snapshot.data?.posts[index].body}',
                        style: TextStyle(color: Colors.white),
                      ),
                      isThreeLine: true,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                PostInfoPage(snapshot.data!.posts[index]),
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
