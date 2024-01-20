import 'package:flutter/material.dart';
import 'package:internship_project/json_data/comments_list.dart';
import 'package:internship_project/json_data/post_list.dart';

class PostInfoPage extends StatefulWidget {
  final Post post;

  PostInfoPage(this.post);

  @override
  State<PostInfoPage> createState() => _PostInfoPageState();
}

class _PostInfoPageState extends State<PostInfoPage> {
  late Future<CommentsList> commentsList;

  @override
  void initState() {
    super.initState();
    commentsList = getCommentsList(widget.post.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 0, top: 25),
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16.0, top: 70, right: 16),
                child: Text(
                  widget.post.title,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Divider(color: Colors.grey),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16),
                child: Text(
                  widget.post.body,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.normal,
                    color: Colors.grey,
                  ),
                ),
              ),
              SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.only(left: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Comments:",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: FutureBuilder<CommentsList>(
                  future: commentsList,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data!.comments.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(snapshot.data!.comments[index].name),
                            subtitle: Text(snapshot.data!.comments[index].body),
                            isThreeLine: true,
                          );
                        },
                      );
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }
                    return const Center(child: CircularProgressIndicator());
                  },
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
