import 'package:flutter/material.dart';
import 'add_task.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:core';
import 'package:semifi_exam/custom_text.dart';

class Details extends StatefulWidget {
  final int id_value;

  const Details({super.key, required this.id_value});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  String baseURL = 'https://jsonplaceholder.typicode.com/todos';

  dynamic getResponse = {};

  getOneTodo(int id) async {
    var response = await http.get(Uri.parse('$baseURL/$id'));

    if (response.statusCode == 200) {
      print('Success!');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.blue[400],
        content: Text('Success!'),
        action: SnackBarAction(
            label: 'DISMISS',
            onPressed: () {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
            }),
      ));
      setState(() {
        getResponse = jsonDecode(response.body) as Map<String, dynamic>;
      });
    } else {
      return null;
    }
  }

  @override
  void initState() {
    getOneTodo(widget.id_value);
    print(getResponse);
    super.initState();
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
      body: ListView(
        children: [
          CustomText(
            title: 'User ID',
            content: getResponse['userId'].toString(),
          ),
          CustomText(
            title: 'ID',
            content: getResponse['id'].toString(),
          ),
          CustomText(
            title: 'title',
            content: getResponse['title'].toString(),
          ),
          CustomText(
            title: 'completed',
            content: getResponse['completed'].toString(),
          ),
        ],
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
