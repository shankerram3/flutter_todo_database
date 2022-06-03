

import 'package:flutter_todo/models/category.dart';
import 'package:flutter_todo/repositories/repositories.dart';

class CategoryService {
  Repository? _repository;

  CategoryService() {
    _repository = Repository();
  }


  saveCategory(Category category) async {
    return await _repository?.insertData(tableName, category.categoryMap());
  }

  readCategories() async {
    return await _repository?.readData(tableName);
  }
  deleteData(int dataId)async{
    return await _repository?.deleteData(tableName, dataId);
  }
  readDataById(int dataId)async{
    return await _repository?.readDataById(tableName, dataId);
  }

  void updateCategory(Category category) async {

    return await _repository?.updateData(tableName,category.categoryMap());
  }





/*updateDataById(int dataId)async{
    return await _repository?.updateDataById(tableName, dataId);
  }*/
}

  const String tableName = 'categories';
