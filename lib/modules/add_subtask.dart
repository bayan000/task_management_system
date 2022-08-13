
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:tracker/controllers/add_subtask_controller.dart';

import '../models/subtask_task_status_model.dart';
import '../shared/components.dart';
import '../shared/constants.dart';

class AddSubtask extends StatefulWidget {
  AddSubtask({Key? key, this.dateTime, this.value}) : super(key: key);
  final String? value ;
  @override
  State<AddSubtask> createState() => _AddSubtaskState();
  late DateTime? dateTime;
  late DateTime? dateTimee;
  String? time;
}

class _AddSubtaskState extends State<AddSubtask> {
  AddSubtaskProvider addSubtaskProvider =AddSubtaskProvider();

  String? st;
  String? value ;
  static var des;

  static var dato;
  static var datoo;
  static var tii;
  //static var taymo;
  static var selectedP;
  static var selectedS;
  static List<int> l=[];
  @override
  Widget build(BuildContext context) {
    DateTime _date;
    Size size =MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: appCo,
          shadowColor: appCo,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),

            onPressed: () {
              Navigator.pushReplacementNamed(
                  context, '/subtask');
            },
          ),
          title: Text('Add subtask',style: trackerStyle,),
        ),
        backgroundColor: appCo,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(

              padding: EdgeInsets.all(size.height*0.025),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:  [
                  SizedBox(height: size.height*0.049,),
                  Container(
                      height: size.height*0.25,
                      decoration:  BoxDecoration(
                        borderRadius: BorderRadius.only(topRight: Radius.circular(r),topLeft: Radius.circular(r),
                            bottomLeft:Radius.circular(r),bottomRight:Radius.circular(r) ),
                        image:const DecorationImage(image: AssetImage("assets/images/puzzle.jpg"),
                          fit: BoxFit.fill,),)),
                  SizedBox(height: size.height*0.05,),
                   Row(
                    children: [
                      ElevatedButton(
                          style:  ButtonStyle(backgroundColor: MaterialStateProperty.all(appFo),
                              shadowColor:MaterialStateProperty.all(pu) ,
                              elevation:MaterialStateProperty.all(10)),
                          child: Text('starts at',style: TextStyle(color: pu,
                              fontSize: size.width*0.04),),
                          onPressed: (){
                            showDatePicker(context: context,
                                initialDatePickerMode: DatePickerMode.day,
                                initialEntryMode: DatePickerEntryMode.calendarOnly,
                                initialDate: DateTime.now(),
                                firstDate:  DateTime.now(),
                                lastDate: DateTime(2050),
                                builder: (context,picker){
                                  return Theme(data:ThemeData.light().copyWith(
                                      colorScheme: ColorScheme.light(primary: pu
                                      )),
                                    child:picker!,);}).then((date){
                              if(date!=null)
                              {
                                widget.dateTime=date;
                                _date=date;


                              }
                            });
                          }),
                      SizedBox(width: size.width*0.08),
                   /*   Text(
                     '2022-09-10',style: TextStyle(color: appFo,fontSize: size.width*0.045),),*/

                    ],
                  ),

                  SizedBox(height:size.height*0.02),
                  Row(
                      children: [
                        ElevatedButton(
                            style:  ButtonStyle(backgroundColor: MaterialStateProperty.all(appFo),
                                shadowColor:MaterialStateProperty.all(pu) ,
                                elevation:MaterialStateProperty.all(10)),
                            child: Text('daed line',style: TextStyle(color: pu,fontSize: size.width*0.04),),
                            onPressed: (){
                              showTimePicker(context: context,
                                  initialEntryMode: TimePickerEntryMode.dial,
                                  initialTime:
                                  const TimeOfDay(hour: 12, minute: 0),
                                  builder: (context,picker){
                                    return Theme(data:ThemeData.light().copyWith(colorScheme: ColorScheme.light(primary: pu
                                    )),
                                      child:picker!,);}
                              ).then((date){
                                if(date!=null)
                                {
                                  print('h');
                                }
                              });}),
                        SizedBox(width: size.width*0.08),
                     /*   Text('2022-12-05',style: TextStyle(color: appFo,fontSize: size.width*0.045),),*/
                      ],
                    ),
                  SizedBox(height:size.height*0.02),
                  CustomField(allBorder: true, hintText: 'title', isPassword: false),
                  SizedBox(height:size.height*0.02),
                  CustomField(allBorder: true, hintText: 'priority', isPassword: false),
                  SizedBox(height:size.height*0.02),
                  CustomField(allBorder: true, hintText: 'status', isPassword: false),
                  Row(children:[
                    const Text(
                      'add ',
                      style: TextStyle(
                        fontSize: 16,
                        color:appFo ,
                      ),
                    ),
                    TextButton(onPressed: (){

                            Navigator.pushReplacementNamed(
                                context, '/myteam');

                          }, child: const Text(
                            'Members',
                            style:TextStyle(
                              fontSize: 20,
                              color:appFo,
                            ),
                          ),
                          )
                  ],
                  ),
                  SizedBox(height:size.height*0.02),
                  Row(
                    /*Navigator.pushReplacementNamed(
                                            context, '/meetings');*/
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                       ElevatedButton(
                              onPressed:() async{
                                  await addSubtaskProvider.onAddS();
                                  if (addSubtaskProvider.message=="200" || addSubtaskProvider.message=="201")
                                  {
                                    EasyLoading.showSuccess("subtask added successfully");
                                    Navigator.pushReplacementNamed(
                                        context, '/Task');
                                  }
                                  else
                                  {
                                    EasyLoading.showError('oops! error');

                                  }

                              }
                              ,child:  Text('add',style: TextStyle(color: appFo,fontSize: size.width*0.045)),
                              style: ButtonStyle(
                                //elevation: MaterialStateProperty.all(40),
                                shape: MaterialStateProperty.all(const CircleBorder()),
                                padding: MaterialStateProperty.all(const EdgeInsets.all(20)),
                                foregroundColor: MaterialStateProperty.all(appFo),
                                backgroundColor: MaterialStateProperty.all(pu), // <-- Button color
                                overlayColor: MaterialStateProperty.resolveWith<Color?>((states) {
                                  if (states.contains(MaterialState.pressed)) return pu; // <-- Splash color
                                }),
                              ),
                            )



                    ],
                  ),
                  //SizedBox(height:size.height*0.02),

                ],
              ),

            ),

          ),
        ));
  }
  DropdownMenuItem<String> buildMenuItem(String item) =>
      DropdownMenuItem(value:item,child: Text(item));
}

class CustomField extends StatefulWidget {
  final Color? colorField;
  final String hintText;
  final String? labelText;
  final  TextInputType? keyboard;
  final double? height;
  final  TextEditingController? controller;
  Widget? prefixIcon;
  final bool isPassword;
  final bool allBorder;
  final Color? hintColor;
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
    required this.hintText,
    required this.isPassword,
    this.controller,
    this.keyboard,
    this.colorField,
    this.prefixIcon



  });

  @override
  State<CustomField> createState() => _CustomFieldState();
}

class _CustomFieldState extends State<CustomField> {


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(

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

      child:   Center(
          child:

          Row(children: [
            Expanded(child:  TextFormField(
              readOnly:widget.iconWidget == null ? false:true,
              controller:widget.controller ,
              obscureText: widget.isPassword ? widget.unVisable : false,
              cursorColor: Colors.indigo,
              keyboardType: widget.keyboard ?? TextInputType.text,
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
}