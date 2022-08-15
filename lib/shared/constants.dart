import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
AppBar buildAppBar({IconData? prefixIcon,var onPressedPre,var onPressedSuf,required double fontsize ,required String text,required IconData suffixIcon}) {
  return AppBar(
    elevation: 0,
    centerTitle: true,
    backgroundColor: Colors.transparent,
    leading: prefixIcon == null ?Container():GestureDetector(child: Icon(prefixIcon),
      onTap: onPressedPre ,

    ),
    title: Text(
      text,
      style: TextStyle(
          color: Colors.white, fontSize: fontsize, fontWeight: FontWeight.bold),
    ),
    actions: [
      IconButton(
        icon:
        Icon(suffixIcon, size: 28, color: Colors.white),
        onPressed: onPressedSuf,
      ),
    ],
  );
}
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
const Color myGray=Colors.blueGrey;

//
const Color  kred=Color(0xffde8fa9);
const Color korange=Color(0xfffa4c4c);
const Color kblack=Color(0xff211e1f);
const Color kwhite=Color(0xffffffff);
const Color kpurple=Color(0xff2b2024);
const Color kblue=Color(0xff0D47A1);

const Color kBackgroundColor=Color(0xFFF1EEF1);
const Color kcolorApp=Colors.indigo;
const double kDefaultPadding=20.0;
const kDefaultShadow=BoxShadow(
    offset: Offset(0,15),
    blurRadius: 27,
    color:Colors.black12

);

//
TextStyle trackerStyle= GoogleFonts.chewy(textStyle:const TextStyle(fontWeight: FontWeight.w100,color: appFo,fontSize: 27, letterSpacing: .5));
