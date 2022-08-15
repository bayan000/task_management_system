import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tracker/modules/add_user.dart';

import '../controllers/task_controller.dart';
import '../shared/components.dart';

class AddTask extends StatefulWidget {

  //TaskController taskController=TaskController();




  List<int>teamIdList=[1,2,3,4];
  List<int> statusIdList=[1,2,3];



  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {


  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    var taskController=Provider.of<TaskController>(context);

    return Scaffold(
      backgroundColor: Colors.blue,
      body: SafeArea(
        child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    Icon(Icons.arrow_back,
                      color: Colors.white,size: 25,),

                    Text(
                      'AddTask',
                      style: TextStyle(color: Colors.white, fontSize: 27),
                    ),
                    SizedBox(

                    ),

                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30))),
                  child: Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                      child: SingleChildScrollView(
                        child: Column(children: [
                          SizedBox(
                            height: 10,
                          ),
                          //---------TitleTask-------------------------------------
                          InputField(widget: CustomField(

                            height: MediaQuery.of(context).size.height * 0.07,
                            allBorder:true,hintText:'Title',
                            hintColor: Colors.grey[700],
                            isPassword: false,
                            controller:taskController.titleController ,
                            colorField: Colors.grey[100],)


                              , title: 'Title'),


//------------------------------description-----------------------------
                          InputField(widget: CustomField(

                            height: MediaQuery.of(context).size.height * 0.07,
                            allBorder:true,hintText:'Descroption', isPassword: false,
                            controller:taskController.descriptionController,
                            hintColor: Colors.grey[700],
                            colorField: Colors.grey[100],)
                              , title: 'Description'),

//-------------------start_date------------------------
                          InputField(widget: CustomField(
                            iconWidget: IconButton(
                              icon:Icon(Icons.calendar_today_outlined,
                                color: Colors.blue,
                              ),
                              onPressed: (){

                                fetchDateFromUser(context,taskController,true);

                              },
                            ),
                            height: MediaQuery.of(context).size.height * 0.07,
                            allBorder:true,
                            hintText: DateFormat.yMd().format(taskController.selectedStartDate), isPassword: false,
                            hintColor: Colors.grey[700],
                            colorField: Colors.grey[100],)
                            , title:'Start_Date' ,

                          ),

//------------------------------endDate----------------------
                          InputField(widget: CustomField(
                            iconWidget: IconButton(
                                icon:Icon(Icons.calendar_today_outlined),
                                color: Colors.blue,
                                onPressed: () {

                                  fetchDateFromUser(context,taskController,false);

                                }
                            ),
                            height: MediaQuery.of(context).size.height * 0.07,
                            allBorder:true,
                            hintText: DateFormat.yMd().format(taskController.selectedEndDate),
                            isPassword: false,
                            hintColor: Colors.grey[700],
                            colorField: Colors.grey[100],)
                            , title:'End_Date' ,

                          ),

//------------------teamid-----------------------------

                          InputField(widget: CustomField(
                            iconWidget: DropdownButtonHideUnderline(
                              child:   DropdownButton(
                                icon:Icon(Icons.keyboard_arrow_down,color:Colors.grey[600],),
                                iconSize: 30,
                                elevation: 4,
                                items: widget.teamIdList.map(kbuildMenuItem).toList(),
                                underline: Container(height: 0,),
                                onChanged:(String ?value)=>

                                    setState(() {
                                      taskController.selectedIdTeam=int.parse(value!);
                                    }),
                                //style: ,


                              ),
                            ),
                            height: MediaQuery.of(context).size.height * 0.07,
                            allBorder:true,hintText:' selected_Id_Team', isPassword: false,

                            hintColor: Colors.grey[700],
                            colorField: Colors.grey[100],) , title: 'IdTeam'),
//------------------------------StatusID----------------------------------
                          InputField(widget: CustomField(
                            iconWidget:

                            DropdownButtonHideUnderline(
                              child:   DropdownButton(
                                icon:Icon(Icons.keyboard_arrow_down,color:Colors.grey[600],),
                                iconSize: 30,
                                elevation: 4,
                                items: widget.statusIdList.map(kbuildMenuItem).toList(),
                                onChanged:(String ?value)=>
                                    setState(() {
                                      taskController.selectedIdStatus=int.parse(value!);
                                    }),
                              ),
                            ),



                            height: MediaQuery.of(context).size.height * 0.07,
                            allBorder:true,hintText:' selected_Id_Status', isPassword: false,

                            hintColor: Colors.grey[700],

                            colorField: Colors.grey[100],) , title: 'Id_Status'),

                          SizedBox(height: 40,),
                          CustomButton(height: 50, width: 180, buttonName: 'Save ',buttonColor:Colors.blue,fontSize: 18, onTap: (){})

                        ]


                        ),
                      )
                  ),
                ),
              ),







            ]),

      ),
/*
      floatingActionButton: FloatingActionButton(backgroundColor:Colors.indigo,onPressed: () async {
        EasyLoading.show(status: 'loading...');
        await taskController.onClickAddTask();
        if(taskController.addedTask !=null){
          EasyLoading.showSuccess('new task is added');
          Navigator.of(context).pop();
        }
        else {
          EasyLoading.showError('can not add ');
        }
      },child: Icon(Icons.check_outlined),) ,
*/
    );
  }

  fetchDateFromUser(var context,TaskController taskContr,bool isStartDate)async{
    DateTime? pickerDate= await showDatePicker(
        context: context,initialDate:DateTime.now() ,firstDate:DateTime.now(),
        lastDate:DateTime(2126)

    );

    if(pickerDate !=null){
      if(isStartDate ==true) {
        setState(() {
          taskContr.selectedStartDate = pickerDate;
          print(taskContr.selectedStartDate);
        });
      }
      else if(isStartDate == false){
        setState(() {
          taskContr.selectedEndDate = pickerDate;
          print(taskContr.selectedEndDate);
        });


      }


    }



  }




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

DropdownMenuItem<String> kbuildMenuItem(var item) => DropdownMenuItem(
    value: item.toString(),
    child: Text(item.toString())
);