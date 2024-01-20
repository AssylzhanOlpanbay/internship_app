import 'package:flutter/material.dart';
import 'package:internship_project/navigation/bottom_nav_bar.dart';
import 'package:internship_project/pages/album_pages/album_list_builder.dart';
import 'package:internship_project/pages/post_pages/post_list_builder.dart';
import 'package:internship_project/pages/todo_pages/to_do_list_builder.dart';
import 'package:internship_project/pages/user_pages/user_list_screen.dart';

import 'app_routes.dart';

class RouteGenerator {
  static Route<Object?>? generateRoute(RouteSettings settings) {
    final routeName = settings.name;

    switch (routeName) {
      case AppRoutes.home:
        return MaterialPageRoute(
          builder: (context) {
            return PostListBuilderPage();
            // return MainPage(userCredential: userCredential);
          },
        );

      case AppRoutes.albumsListPage:
        return MaterialPageRoute(
          builder: (context) {
            return AlbumListBuilderPage();
            // return MainPage(userCredential: userCredential);
          },
        );

      case AppRoutes.todoListPage:
        return MaterialPageRoute(
          builder: (context) {
            return ToDoListBuilder();
            // return MainPage(userCredential: userCredential);
          },
        );

      case AppRoutes.userPage:
        return MaterialPageRoute(
          builder: (context) {
            return UserPage();
            // return MainPage(userCredential: userCredential);
          },
        );

      case AppRoutes.navBar:
        return MaterialPageRoute(
          builder: (context) {
            return BottomNavBar();
            // return MainPage(userCredential: userCredential);
          },
        );

      default:
        return _errorRoute();
    }
  }

  static MaterialPageRoute buildRoute(Widget child,
      {required RouteSettings settings}) {
    return MaterialPageRoute(
        settings: settings, builder: (BuildContext context) => child);
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueAccent,
          title: const Text(
            'ERROR!!',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        body: const Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 450.0,
                  width: 450.0,
                  // child: Lottie.asset('assets/lottie/error.json'),
                ),
                Text(
                  'Seems the route you\'ve navigated to doesn\'t exist!!',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
