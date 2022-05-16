import 'package:flutter/material.dart';

Widget defaultBottun({double width=double.infinity,
  Color c=const Color.fromARGB(255, 121, 120, 117),
  bool isUpperCase=true,
  double radius=5,
  required void Function() function,
  required String text
}) =>
    Container(width: width,
      height:40,
//color: c,
      child: MaterialButton(onPressed:function,
        child:  Text(text,style:const TextStyle(color: Colors.white,fontSize: 17)),
      ),
      decoration: BoxDecoration(color:c,borderRadius: BorderRadius.circular(radius)),
    );

/// *****************************************************************************/

Widget defaultTextFormField({
  bool ispass=false,
  required TextEditingController controller,
  required TextInputType type,
  void Function(String)? onSubmit,
//required Function() onChanged,
  required String? Function(String?)? validate,
//required Function validate,
  required String label,
  required IconData prefix,
  IconData? suffix,
  // ignore: non_constant_identifier_names
  void suffixfunc,
})=>TextFormField(
  controller: controller,
  keyboardType: type,
  obscureText: ispass,
  onFieldSubmitted: onSubmit,
  // onChanged: onChanged,
  validator: validate,
  decoration: InputDecoration(
    labelText: label ,
    prefixIcon: Icon(prefix),
    suffixIcon: suffix != null ? IconButton(onPressed: (){},//suffixfunc,
      icon: Icon(suffix),) : null,
    border:const OutlineInputBorder(),
  ),
);


