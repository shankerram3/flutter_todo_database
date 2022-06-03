import 'package:flutter/material.dart';

class TodoScreen extends StatefulWidget {
  TodoScreen({Key? key}) : super(key: key);

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  var todoTitleController = TextEditingController();
  var todoDescriptionController = TextEditingController();
  var todoDateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Todo'),
      ),
      body: Column(
        children: <Widget>[
          TextField(
            controller: todoTitleController,
            decoration: InputDecoration(
              labelText: 'Title',
              hintText: 'Write Todo title',
            ),
          ),
          TextField(
            controller: todoDescriptionController,
            decoration: InputDecoration(
              labelText: 'description',
              hintText: 'Write Todo Description',
            ),
          ),
          TextField(
            controller: todoTitleController,
            decoration: InputDecoration(
              labelText: 'Title',
              hintText: 'Write Todo Description',
              prefix
            ),
          ),
        ],
      ),
    );
  }
}
