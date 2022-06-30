import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

String appName ='tracker';
TextStyle style(isHeader)=>TextStyle(
    fontWeight:isHeader? FontWeight.bold:FontWeight.normal,
        color:isHeader?  pu:Colors.black87
);
AppBar trackerBar()=>AppBar(
  backgroundColor: appCo,
  shadowColor: appCo,
  elevation: 0,
);
double r=30;
const Color appCo=Colors.blue;
const MaterialColor appCol=Colors.blue;
 Color pu=Colors.purple;
const MaterialColor pur=Colors.purple;
//const MaterialColor pu=Colors.purple;
const FontWeight fw=FontWeight.bold;
const Color appFo=Colors.white;
//
TextStyle trackerStyle= GoogleFonts.chewy(textStyle:const TextStyle(fontWeight: FontWeight.w100,color: appFo,fontSize: 27, letterSpacing: .5));
