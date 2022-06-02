import 'package:flutter/material.dart';
import 'package:flutter_todo/screens/home_screens.dart';
import 'package:flutter_todo/services/category_service.dart';
import 'package:sqflite/sqflite.dart';

import '../models/category.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  var _categoryNameController = TextEditingController();
  var _categoryDescriptionController = TextEditingController();
  var _editCategoryNameController = TextEditingController();
  var _editCategoryDescriptionController= TextEditingController();
  var _category = Category();
  var _categoryService = CategoryService();

  List<Category> _categoryList = List.empty();
  @override
  void initState() {
    super.initState();
    getAllCategories();
  }

  getAllCategories() async {
    _categoryList = <Category>[];
    var categories = await _categoryService.readCategories();
    categories.forEach((_category) {
      setState(() {
        var categoryModel = Category();
        categoryModel.name = _category['name'];
        categoryModel.description = _category['description'];
        categoryModel.id = _category['id'];
        _categoryList.add(categoryModel);
      });
    });
  }

  _editCategory(BuildContext context,categoryId)async{
    _category = await _categoryService.readDataById(categoryId);
    setState(() {
      _editCategoryNameController.text = _category[0]['name'] ?? 'No name';
      _editCategoryDescriptionController.text =
          _category[0]['description'] ?? 'No description';
    });
  }
  _showFormDialog(BuildContext context ) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (param) {
          return AlertDialog(
            actions: [
              FlatButton(
                color: Colors.red,
                onPressed: () => Navigator.pop(context),
                child: Text('Cancel'),
              ),
              FlatButton(
                color: Colors.blue,
                onPressed: () async {
                  _category.name = _categoryNameController.text;
                  _category.description = _categoryDescriptionController.text;
                  _categoryService.saveCategory(_category);
                  getAllCategories();
                  Navigator.pop(context);
                },
                child: Text('Save'),
              ),
            ],
            title: Text('Categories form'),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  TextField(
                    controller: _categoryNameController,
                    decoration: InputDecoration(
                        hintText: 'Write a category', labelText: 'category'),
                  ),
                  TextField(
                    controller: _categoryDescriptionController,
                    decoration: InputDecoration(
                        hintText: 'Write a description',
                        labelText: 'Description'),
                  ),
                ],
              ),
            ),
          );
        });
  }
  _editFormDialog(BuildContext context ) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (param) {
          return AlertDialog(
            actions: [
              FlatButton(
                color: Colors.red,
                onPressed: () => Navigator.pop(context),
                child: Text('Cancel'),
              ),
              FlatButton(
                color: Colors.blue,
                onPressed: () async {
                  _category.name = _categoryNameController.text;
                  _category.description = _categoryDescriptionController.text;
                  _categoryService.saveCategory(_category);
                  getAllCategories();
                  Navigator.pop(context);
                },
                child: Text('Update '),
              ),
            ],
            title: Text('Edit Categories form'),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  TextField(
                    controller: _editCategoryNameController,
                    decoration: InputDecoration(
                        hintText: 'Write a category', labelText: 'category'),
                  ),
                  TextField(
                    controller: _editCategoryDescriptionController,
                    decoration: InputDecoration(
                        hintText: 'Write a description',
                        labelText: 'Description'),
                  ),
                ],
              ),
            ),
          );
        });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: ElevatedButton(
          style: ElevatedButton.styleFrom(primary: Colors.blue, elevation: 0.0),
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => HomeScreen(),
            ),
          ),
          child: Icon(Icons.arrow_back),
        ),
        title: Text('Categories'),
      ),
      body: ListView.builder(
        itemCount: _categoryList.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 5.0,
            child: ListTile(
              leading: IconButton(icon: Icon(Icons.edit), onPressed: ()async {
                _editCategory(context, _categoryList[index].id);


              }),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(_categoryList[index].name ?? ""),
                  IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                    onPressed: () async {
                       await _categoryService.deleteData(_categoryList[index].id??0);
                          getAllCategories();
                    },
                  )
                ],
              ),
              subtitle: Text(_categoryList[index].description ?? ""),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showFormDialog(context)
        ,
        child: Icon(Icons.add),
      ),
    );
  }
}
