import 'package:flutter/material.dart';
import 'package:internship_project/json_data/to_do_list.dart';

class ToDoListBuilder extends StatefulWidget {
  const ToDoListBuilder({Key? key});

  @override
  State<ToDoListBuilder> createState() => _ToDoListBuilder();
}

class _ToDoListBuilder extends State<ToDoListBuilder> {
  late Future<List<ToDo>> caseList;
  String filterValue = "all";

  @override
  void initState() {
    super.initState();
    caseList = getCasesList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        title: const Text('Cases Module'),
        actions: [
          PopupMenuButton(
            icon: const Icon(Icons.filter_list_outlined),
            itemBuilder: (context) => [
              const PopupMenuItem(
                child: Text("True"),
                value: "true",
              ),
              const PopupMenuItem(
                child: Text("False"),
                value: "false",
              ),
              const PopupMenuItem(
                child: Text("All"),
                value: "all",
              ),
            ],
            onSelected: (value) {
              setState(() {
                filterValue = value.toString();
              });
            },
          ),
        ],
      ),
      body: FutureBuilder<List<ToDo>>(
        future: getCasesList(), // Use the function directly here
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No cases available.'));
          } else {
            List<ToDo> filteredList = snapshot.data!
                .where((caseItem) =>
                    filterValue == "all" ||
                    caseItem.completed == (filterValue == "true"))
                .toList();

            return ListView.builder(
              itemCount: filteredList.length,
              itemBuilder: (context, index) {
                return Card(
                  color: Colors.yellow,
                  child: ListTile(
                    title: Text(
                      filteredList[index].title,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Completed: ${filteredList[index].completed}",
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: filteredList[index].completed
                                ? Colors.green
                                : Colors.red,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Id: ${filteredList[index].id}",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
