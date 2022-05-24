import 'package:flutter/material.dart';

String appName ='tracker';
TextStyle style(isHeader)=>TextStyle(
    fontWeight:isHeader? FontWeight.bold:FontWeight.normal
);
AppBar trackerBar()=>AppBar(
  backgroundColor: appCo,
  shadowColor: appCo,
  elevation: 0,
);

const Color appCo=Colors.blue;
const MaterialColor appCol=Colors.blue;
const MaterialColor pu=Colors.purple;
const FontWeight fw=FontWeight.bold;
const Color appFo=Colors.white;

TextStyle trackerStyle=const TextStyle(fontSize: 25,color:pu,fontWeight: fw);