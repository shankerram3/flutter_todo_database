

import 'package:flutter_todo/repositories/database_connection.dart';
import 'package:sqflite/sqflite.dart';

class Repository{
  late DatabaseConnection _databaseConnection;

  Repository(){
//initialise database connection
    _databaseConnection = DatabaseConnection();
  }

  static Database? _database;

Future<Database?>get database async{
  if(_database!=null)return _database;
  _database = await _databaseConnection.setDatabase();
  return _database;
}
insertData(table,data)async{
  var connection =await database;
  return await connection?.insert(table, data);
}

readData(table)async{
  var connection = await database;
  return await connection?.query(table);

}
deleteData(table,dataId)async{
  var connection = await database;
  return await connection?.delete(table, where: 'id = ?', whereArgs: [dataId]);
  // return await database.delete(tableName, where: '$columnId = ?', whereArgs: [id])
}
readDataById(table,dataId)async{
  var connection = await database;
  return await connection?.query(table,where :'id =?',whereArgs:[dataId]);
}

  updateData(table, data)async {
  var connection = await database;
  return await connection?.update(table , data,where:'id =?',whereArgs:[data['id']]);
  }
  readDataByCategory(table,columnName,columnValue)async{
  var connection =await database;
  return await connection?.query(table,where:'$columnName',whereArgs: [columnValue]);
  }
}