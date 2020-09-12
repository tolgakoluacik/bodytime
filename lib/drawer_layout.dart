import 'package:bodytime/models/drawer_menu_item.dart';
import 'package:flutter/material.dart';

class DrawerLayout extends StatefulWidget {

  List<DrawerMenuItem> _menuItems;
  DrawerLayout(List<DrawerMenuItem> menuItems, {Key key, this.title}) : super(key: key) {

    this._menuItems = menuItems;
  }

  final String title;

  @override
  _DrawerLayoutState createState() => _DrawerLayoutState(_menuItems);
}

class _DrawerLayoutState extends State<DrawerLayout> {

  List<DrawerMenuItem> _menuItems = [];

  _DrawerLayoutState(List<DrawerMenuItem> menuItems) {
    this._menuItems = menuItems;
  }

  @override
  void initState() {
    super.initState();
  }

  Widget listItem(String text, IconData icon, Function onClick) {
    return FlatButton(
      onPressed: () {
        if (onClick != null) {
          onClick.call();
        }
        Navigator.pop(context);
      },
      child: Container(
        padding: EdgeInsets.only(top: 16, bottom: 16,),
        child: Row(
          children: <Widget>[
            Icon(
              icon,
              color: Colors.white,
              size: 26,
            ),
            Container(
                padding: EdgeInsets.only(left: 12),
                child: Text(
                  text,
                  style: TextStyle(color: Colors.white, fontSize: 17),
                ))
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 10,
      child: Container(
        color: Color(0XFF2C2C2C),
        child: ListView(
          padding: EdgeInsets.only(top: 50, ),
          children: _menuItems.map((e) => listItem(e.name, e.icon, e.onClick)).toList(),
        ),
      ),
    );
  }
}
