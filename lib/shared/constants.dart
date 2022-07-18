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
double r=30;//boreder radious
//Colors.blue.shade200,
const Color appCo=Colors.blue;
const MaterialColor appCol=Colors.blue;
 Color pu=Colors.purple;
const MaterialColor pur=Colors.purple;
//const MaterialColor pu=Colors.purple;
const FontWeight fw=FontWeight.bold;
const Color appFo=Colors.white;
//
const Color  kred=Color(0xff992149);
const Color korange=Color(0xfffa4c4c);
const Color kblack=Color(0xff211e1f);
const Color kwhite=Color(0xffffffff);
const Color kpurple=Color(0xff2b2024);
const Color kblue=Color(0xff0D47A1);

//
TextStyle trackerStyle= GoogleFonts.chewy(textStyle:const TextStyle(fontWeight: FontWeight.w100,color: appFo,fontSize: 27, letterSpacing: .5));
