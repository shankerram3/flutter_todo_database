import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo/models/todo.dart';
import 'package:flutter_todo/services/todo_service.dart';

class TodosByCategory extends StatefulWidget {
final String? category;
TodosByCategory({this.category});
  @override
  State<TodosByCategory> createState() => _TodosByCategoryState();
}

class _TodosByCategoryState extends State<TodosByCategory> {
  List<Todo> _todoList = List.empty(growable: true);
  TodoService _todoService = TodoService();



  getTodosByCategories()async{
    
    var todos = await _todoService.readTodosByCategory(this.widget.category);
    todos.forEach((todo){
      setState((){
        var model = Todo();
        model.title = todo['title'];
        model.description = todo['description'];
        model.todoDate = todo['todoDate'];
        _todoList.add(model);
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todos by Category'),
      ),

    );
  }
}
