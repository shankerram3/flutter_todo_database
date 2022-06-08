import 'package:flutter/material.dart';
import 'package:flutter_todo/helpers/drawer_navigation.dart';
import 'package:flutter_todo/screens/ToDo_screen.dart';
import 'package:flutter_todo/services/todo_service.dart';

import '../models/todo.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TodoService? _todoService;
  List<Todo> _todoList = List.empty(growable: true);
  @override
  initState(){
    super.initState();
      getAllTodos();

  }
  getAllTodos()async{
    _todoService = TodoService();
    var todos = await _todoService?.readTodo();
    todos.forEach((todo){
        setState((){
          var model = Todo();
          model.id=todo['id'];
          model.title = todo['title'];
          model.description =todo['description'];
          model.isFinished = todo['isFinished'];
          _todoList.add(model);
        });
        });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('todolist '),
      ),
      body:ListView.builder(itemCount:_todoList.length ,itemBuilder: (context,index){
        return Padding(
          padding: EdgeInsets.only(top: 5.0,left:5.0,right:5.0,bottom: 0.0),
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0)
            ),
            child: ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(_todoList[index].title?? 'No Title')
                ],
              ),
              subtitle: Text(_todoList[index].category?? 'No category'),
              trailing: Text(_todoList[index].todoDate?? ' No category'),
            ),
          ),
        );
      }),
      drawer: DrawerNavigation(),
      floatingActionButton: FloatingActionButton(
        onPressed: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context)=>TodoScreen())).then((_) => getAllTodos()),
        child: Icon(Icons.add),
      ),
    );
  }
}
