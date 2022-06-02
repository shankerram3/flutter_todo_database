import 'package:flutter/material.dart';
import 'package:flutter_todo/screens/categories_screens.dart';
import 'package:flutter_todo/screens/home_screens.dart';

class DrawerNavigation extends StatefulWidget {
  const DrawerNavigation({Key? key}) : super(key: key);

  @override
  State<DrawerNavigation> createState() => _DrawerNavigationState();
}

class _DrawerNavigationState extends State<DrawerNavigation> {
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
            )

          ],
        ),
      ),
    );
  }
}
