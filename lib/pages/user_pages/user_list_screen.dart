// import 'package:flutter/material.dart';
// import 'package:internship_project/user_details_screen.dart';
// import 'package:internship_project/user_model.dart';
//
// class UserListBuilderPage extends StatefulWidget {
//   const UserListBuilderPage({Key? key}) : super(key: key);
//
//   @override
//   State<UserListBuilderPage> createState() => _UserListBuilderPage();
// }
//
// class _UserListBuilderPage extends State<UserListBuilderPage> {
//   late Future<UsersList> usersList;
//
//   @override
//   void initState() {
//     super.initState();
//     usersList = getUsersList();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Users'),
//         centerTitle: true,
//       ),
//       body: FutureBuilder<UsersList>(
//         future: usersList,
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             return ListView.builder(
//                 itemCount: snapshot.data?.users.length,
//                 itemBuilder: (context, index) {
//                   return Card(
//                     child: ListTile(
//                       title: Text('${snapshot.data?.users[index].username}'),
//                       subtitle: Text('${snapshot.data?.users[index].phone}'),
//                       isThreeLine: true,
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) =>
//                                 UserProfilePage(snapshot.data!.users[index]),
//                           ),
//                         );
//                       },
//                     ),
//                   );
//                 });
//           } else if (snapshot.hasError) {
//             return const Text('Error');
//           }
//           return const Center(child: CircularProgressIndicator());
//         },
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:internship_project/json_data/user_model.dart';
import 'package:internship_project/pages/user_pages/user_details_screen.dart';
import 'package:provider/provider.dart';

class UserPage extends StatelessWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        FutureProvider<List<User>>(
          create: (_) => getUsersList(),
          initialData: [],
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.yellow,
          title: const Text('User Module'),
        ),
        body: Consumer<List<User>>(
          builder: (context, userList, child) {
            if (userList.isEmpty) {
              return Center(child: CircularProgressIndicator());
            } else {
              return ListView.builder(
                itemCount: userList.length,
                itemBuilder: (context, index) {
                  return buildUserCard(context, userList[index]);
                },
              );
            }
          },
        ),
      ),
    );
  }

  Widget buildUserCard(BuildContext context, User user) {
    return Card(
      color: Colors.yellow,
      child: ListTile(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => UserProfilePage(user),
            ),
          );
        },
        leading: CircleAvatar(
          radius: 25,
          backgroundColor: Colors.black,
          child: Text(
            user.name![0].toUpperCase(),
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        title: Text(
          user.name!,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Email: ${user.email}",
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
