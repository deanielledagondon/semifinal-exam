import 'package:flutter/material.dart';
import 'add_task.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:core';
import 'details_task.dart';

class HomePage extends StatefulWidget {


  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}



class _HomePageState extends State<HomePage> {

  String baseURL = 'https://jsonplaceholder.typicode.com/todos';

  List getResponse = <dynamic>[];

  getTodo() async {
    var url = Uri.parse(baseURL);
    var response = await http.get(url);

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.blueAccent,
          content: Text(
              'Success!'),
      action: SnackBarAction(
          label: 'DISMISS',
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          })));
      setState(() {
        getResponse = jsonDecode(response.body) as List <dynamic>;
      });
    } else {
      return null;
    }
  }

  displayEditedTask(var object) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.deepPurple,
        content: Text(
            'Successfully edited task: ${object["title"]} ID: ${object["id"]}')));
  }

  displayCreatedTask(var object) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.deepPurple,
        content: Text(
            'Successfully created task: ${object["title"]} ID: ${object["id"]}')));
  }

  @override
  void initState() {
    super.initState();
    getTodo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('To Do App'),
        centerTitle: true,
        titleTextStyle: const TextStyle(
          color: Color.fromRGBO(255, 255, 255, 10),
          fontSize: 20,
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: getResponse.length,
        itemBuilder: (context, index) {
          return CheckboxListTile(
            title: Text('${getResponse[index]['title']}'),
            controlAffinity: ListTileControlAffinity.leading,
            activeColor: Colors.deepPurple,
            secondary: IconButton(
              onPressed: () async {
                await Navigator.push(context, MaterialPageRoute(
                    builder: (context) => Details(id_value: getResponse[index]['id'])));
              },
              icon: const Icon(Icons.notification_important),
              color: Colors.deepPurple,
            ),

            value: getResponse[index]['completed'],
            onChanged: (bool? value) {
              setState(() {
                getResponse[index]['completed'] = value!;
              });
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (_) => const AddTask(),
          );
        },

        tooltip: 'Add a new item!',
        child: const Icon(Icons.bookmark_add_outlined),
      ),
    );
  }
}
