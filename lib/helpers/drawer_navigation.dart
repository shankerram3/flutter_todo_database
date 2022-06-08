import 'package:flutter/material.dart';
import 'package:flutter_todo/screens/categories_screens.dart';
import 'package:flutter_todo/screens/home_screens.dart';
import 'package:flutter_todo/services/category_service.dart';

import '../screens/todos_by_category.dart';

class DrawerNavigation extends StatefulWidget {

  @override
  State<DrawerNavigation> createState() => _DrawerNavigationState();
}

class _DrawerNavigationState extends State<DrawerNavigation> {

  var _categoryList = List<Widget>.empty(growable:true);
  CategoryService _categoryService = CategoryService();
  initState(){
    super.initState();
    getAllCategories();
  }
  getAllCategories() async{
    var categories = await _categoryService.readCategories();

    categories.forEach((category){
      setState((){
        _categoryList.add(InkWell(
          onTap: ()=>Navigator.push(context, new MaterialPageRoute(builder: (context)=> new TodosByCategory())),
          child: ListTile(
            title: Text(category['name']),
          ),
        ));
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(backgroundImage: NetworkImage('https://www.rd.com/wp-content/uploads/2021/01/GettyImages-588935825.jpg'),),
              accountName: Text('Ram Sankar hk'),
              accountEmail: Text('shankerram3@gmail.com'),
              decoration: BoxDecoration(color: Colors.blue),
            ),
            ListTile(
              title:Text('Home'),
              leading:Icon(Icons.home),
              onTap:()=>Navigator.of(context).push(MaterialPageRoute(builder:(context)=>HomeScreen(),),),
            ),
            ListTile(
              title:Text('Categories'),
              leading:Icon(Icons.view_list),
              onTap:()=>Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CategoriesScreen(),),),
            ),
            Divider(),
            Column(
            children: _categoryList,
            ),


          ],
        ),
      ),
    );
  }
}
