import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_todo/models/todo.dart';
import 'package:flutter_todo/services/category_service.dart';
import 'package:flutter_todo/services/todo_service.dart';
import '../models/category.dart';
import 'package:intl/intl.dart';

class TodoScreen extends StatefulWidget {
  TodoScreen({Key? key}) : super(key: key);

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  var todoTitleController = TextEditingController();
  var todoDescriptionController = TextEditingController();
  var todoDateController = TextEditingController();
  var _selectedValue;

  // List<String>? _categories = null;
  List<String> _categories = [];

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  _loadCategories() async {
    var _categoryService = CategoryService();
    var readData = await _categoryService.readCategories();
    setState(() {
      readData.map((data) => _categories.add(data['name'])).toList();
    });
  }

  DateTime _dateTime = DateTime.now();
  _selectedTodoDate(BuildContext context) async {
    var _pickedDate = await showDatePicker(
        context: context,
        initialDate: _dateTime,
        firstDate: DateTime(1960),
        lastDate: DateTime(2060));
    if(_pickedDate!=null){
      setState((){
        _dateTime = _pickedDate;
        todoDateController.text = DateFormat('yyyy-MM-dd').format(_pickedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Todo'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(18.0),
          child: Column(
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
                controller: todoDateController,
                decoration: InputDecoration(
                  labelText: 'Date',
                  hintText: 'Pick a date',
                  prefixIcon: InkWell(
                    onTap: () {
                      _selectedTodoDate(context);
                    },
                    child: (Icon(Icons.calendar_today)),
                  ),
                ),
              ),
              DropdownButtonFormField<String>(
                value: _selectedValue,
                items: _categories
                    .map((String value) => DropdownMenuItem(
                          child: Text(value),
                          value: value,
                        ))
                    .toList(),
                hint: Text('category'),
                onChanged: (value) {
                  setState(() => _selectedValue = value);
                },
              ),
              SizedBox(
                height: 20,
              ),
              RaisedButton(
                onPressed: ()async {
                  var todoObject=Todo();
                  todoObject.title = todoTitleController.text;
                  todoObject.description = todoDescriptionController.text;
                  todoObject.isFinished = 0;
                  todoObject.category = _selectedValue;
                  todoObject.todoDate = await todoDateController.text;

                  var _todoService = TodoService();
                  var result = await _todoService.saveTodo(todoObject);
                  Navigator.pop(context);
                  },
                color: Colors.blue,
                child: Text('Save', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
