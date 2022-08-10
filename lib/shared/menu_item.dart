
import 'package:flutter/material.dart';

class MenuItem {

  final String text;
  final IconData icon;

  const  MenuItem({required this.text,required this.icon});


}


class MenuItems{
  static const itemDelete= MenuItem (text: 'Delete', icon: Icons.delete);
  static const   itemEdit= MenuItem(text: 'Edit', icon: Icons.edit);
  static const  List<MenuItem> items=[itemDelete, itemEdit];

  //
  static const List<MenuItem> itemlist=[
    MenuItem (text: 'Delete', icon: Icons.delete),
    MenuItem(text: 'Edit', icon: Icons.edit)
    //

  ];

}
