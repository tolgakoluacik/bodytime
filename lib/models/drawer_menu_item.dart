import 'package:flutter/cupertino.dart';

class DrawerMenuItem {

  String name;
  IconData icon;
  Function onClick;

  DrawerMenuItem(String name, IconData iconData, Function onClick) {
    this.name = name;
    this.icon = iconData;
    this.onClick = onClick;
  }
}