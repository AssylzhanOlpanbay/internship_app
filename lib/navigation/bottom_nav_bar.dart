import 'package:flutter/material.dart';
import 'package:internship_project/pages/album_pages/album_list_builder.dart';
import 'package:internship_project/pages/post_pages/post_list_builder.dart';
import 'package:internship_project/pages/todo_pages/to_do_list_builder.dart';
import 'package:internship_project/pages/user_pages/user_list_screen.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int index = 0;

  final scrrens = [
    PostListBuilderPage(),
    ToDoListBuilder(),
    AlbumListBuilderPage(),
    UserPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: scrrens[index],
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          backgroundColor: Colors.yellow,
          indicatorColor: Colors.yellow,
          labelTextStyle: MaterialStateProperty.all(TextStyle(
              fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black)),
        ),
        child: NavigationBar(
          height: 60,
          selectedIndex: index,
          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
          animationDuration: Duration(seconds: 1),
          onDestinationSelected: (index) => setState(() => this.index = index),
          destinations: [
            NavigationDestination(
              icon: Icon(
                Icons.post_add,
                color: Colors.black,
              ),
              label: "Post",
            ),
            NavigationDestination(
              icon: Icon(
                Icons.cases_rounded,
                color: Colors.black,
              ),
              label: "Cases",
            ),
            NavigationDestination(
              icon: Icon(
                Icons.photo_album_outlined,
                color: Colors.black,
              ),
              label: "Album",
            ),
            NavigationDestination(
              icon: Icon(
                Icons.supervised_user_circle_outlined,
                color: Colors.black,
              ),
              label: "User",
            ),
          ],
        ),
      ),
    );
  }
}
