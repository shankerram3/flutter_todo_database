import 'package:flutter_todo/models/todo.dart';
import 'package:flutter_todo/repositories/repositories.dart';

class TodoService{
  Repository? _repository;
  TodoService(){
    _repository = Repository();

  }

  saveTodo(Todo todo)async{
    return await _repository?.insertData('todos', todo.todoMap());
  }
  readTodo()async{
    return await _repository?.readData('todos');
  }

  //read todos by category
readTodosByCategory(category)async{
    return await _repository?.readDataByCategory('todos', 'category', category);
}
}