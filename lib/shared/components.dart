import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tracker/shared/constants.dart';
TextEditingController searchController=TextEditingController();
/// *****************************************************************************/
/*Widget defaultBottun({double width=double.infinity,
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
*/
/// *****************************************************************************/

Widget defaultTextFormField({
  bool ispass=false,
  required TextEditingController controller,
  required TextInputType type,
  void Function(String)? onSubmit,
//required Function() onChanged,
  String? Function(String?)? validate,
//required Function validate,
  required String hint,
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
    hintText:hint,
    labelText: label ,
    prefixIcon: Icon(prefix),
    suffixIcon: suffix != null ? IconButton(onPressed: (){},//suffixfunc,
      icon: Icon(suffix),) : null,
    border:const OutlineInputBorder(),
  ),
);

/// *****************************************************************************/
String formatTimeOfDay(TimeOfDay tod) {
  final now = new DateTime. now();
  final dt =DateTime(now. year, now. month, now. day, tod. hour, tod. minute);
  final format = DateFormat("hh:mm");
  return format. format(dt);
}
/// *****************************************************************************/

String getTheRightTime(String l) {
 if(l.contains("AM"))
  l= l.replaceAll("AM", "");
 if(l.contains("PM"))
   l= l.replaceAll("PM", "");
 return l;
}
/// *****************************************************************************/
String getTheHour(String l) {
  var pos = l.lastIndexOf(':');
  var x;
  String result = (pos != -1)? l.substring(0, pos): l;
  x=l.substring(0, l.indexOf(':'));
  x = int. parse(x);
  if(x>=12)
  result+=" pm";
  else if(x<12)
    result+=" am";
  return result;

}/*
TableRow buildRow(final List<String> cells,{bool isHeader=false}) => TableRow(
    children:[
      //...
      //If you want to use the .map function inside ListView children,
      // you should convert map result - iterable - to list and use the spread operator to spread this list inside children
      ...cells.map((cell){
        return Padding(padding: const EdgeInsets.all(12),
          child: Center(child: Text(cell,style:style(isHeader),overflow: TextOverflow.ellipsis,),),
        );
      })]
);*/
/// *****************************************************************************/
class CustomButton extends StatelessWidget {
  // اذا كان فاينل ما بصير هيئ الو قيمة هون
  final double height,width;
  final double? fontSize;
  final String buttonName;
  final Color? buttonColor,fontColor;
  final  Function()  onTap;

  CustomButton({
    required this.height,
    required this.width,
    required this.buttonName,
    required this.onTap,
    this.buttonColor,
    this.fontSize,
    this.fontColor
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: onTap,
      child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            //اذا اجا لون حطو والا تركو ازرق
              color: buttonColor ?? appCo,
              borderRadius: BorderRadius.circular(12)) ,

          child: Center(
            child: Text(
              buttonName,
              style: TextStyle(
                  color: fontColor ??Colors.white,
                  fontSize:fontSize ?? 20,
                  fontWeight: FontWeight.w500),

            ),
          )

      ),
    );




  }
}
/// *****************************************************************************/

class CustomField extends StatefulWidget {
  final Color? colorField;
  final String? hintText;
  final String? labelText;
  final  TextInputType? keyboard;
  final double? height;
  final  TextEditingController? controller;
  Widget? prefixIcon;
  final bool isPassword;
  final bool allBorder;
  final Color? hintColor;
  var validator;
  final double? borderRadius;
  final Widget? iconWidget;

  bool unVisable = true;

  CustomField({

    this.iconWidget,
    this.borderRadius,
    this.height,
    this.hintColor,
    this.labelText,
    required this.allBorder,
    this.hintText,
    required this.isPassword,
    this.controller,
    this.keyboard,
    this.colorField,
    this.prefixIcon,
    this.validator


  });

  @override
  State<CustomField> createState() => _CustomFieldState();
}

class _CustomFieldState extends State<CustomField> {


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.only(right: 10),
      height: widget.height,
      decoration: BoxDecoration(
        color:widget.colorField ?? Colors.grey[200],
        borderRadius: BorderRadius.circular(widget.borderRadius??8),
        border:widget.allBorder ? Border.all(color: Colors.black12, width: 1.5)
            :
        Border(
          top:BorderSide(color:Colors.white.withAlpha(30),width: 2),
          right:BorderSide(color:Colors.white.withAlpha(30),width: 2),
          left:BorderSide(color:Colors.white.withAlpha(30),width: 2),
          bottom:BorderSide(color:Colors.white.withAlpha(30),width: 2),

        ),

      ),

      child:
      Center(
          child:

          Row(children: [
            Expanded(child:  TextFormField(
              readOnly:widget.iconWidget == null ? false:true,
              controller:widget.controller ,
              obscureText: widget.isPassword ? widget.unVisable : false,
              cursorColor: Colors.indigo,
              keyboardType: widget.keyboard ?? TextInputType.text,
              validator: widget.validator,
              style: TextStyle(
                color:Colors.grey[800],
                fontSize: 18,


              ),
              decoration: InputDecoration(
                border: InputBorder.none,

                hintText:widget.hintText,
                labelText:widget.labelText,
                labelStyle:TextStyle(
                  fontSize: 18,

                ),
                hintStyle: TextStyle(
                  fontSize: 16,
                  color: widget.hintColor ?? Colors.grey[500],
                  //fontFamily: 'Acaslon Reqular',

                ),
                //المسافة بين النص وحواف الفيلد
                contentPadding: EdgeInsets.fromLTRB(13, 8, 8,8),
                prefixIcon: widget.prefixIcon,
                suffixIcon: widget.isPassword
                    ? IconButton(
                    onPressed: () {
                      setState(() {
                        widget.unVisable = !widget.unVisable;
                      });
                    },
                    icon: Icon(widget.unVisable
                        ? Icons.visibility
                        : Icons.visibility_off, color: Colors.grey[600],size:size.width*0.050,))
                    : null,


              ),




            ),),
            widget.iconWidget == null ? Container() : Container(child:widget.iconWidget)

          ],)
      ),
    );




  }
}/// *****************************************************************************/
