import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:tracker/controllers/add_meeting_controller.dart';
import 'package:tracker/modules/users.dart';

import '../../shared/constants.dart';
import '../team/team.dart';
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;


class AddMeeting extends StatefulWidget {
   AddMeeting({Key? key, this.dateTime, this.value}) : super(key: key);
   late final DateTime? dateTime;
  final String? value ;


 /* static const items=[
    'OnGoing','Done','Cancelled'
  ];
  static const teams=[
    'team1','team2','team3'
  ];*/

  @override
  State<AddMeeting> createState() => _AddMeetingState();
}

class _AddMeetingState extends State<AddMeeting> {
AddMeetingProvider addMeetingProvider=AddMeetingProvider();
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
                context, '/meetings');
          },
        ),
        title: Text('Add meeting',style: trackerStyle,),
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
                             child: Text('Date of meeting',style: TextStyle(color: pu,fontSize: size.width*0.04),),
                             onPressed: (){
                                     showDatePicker(context: context,
                                                    initialDate: DateTime.now(),
                                                   firstDate: DateTime(2020),
                                                   // ignore: avoid_print
                                                   lastDate: DateTime(2050),
    builder: (context,picker){
    return Theme(data:ThemeData.light().copyWith(colorScheme: ColorScheme.light(primary: pu
    )),
    child:picker!,);}).then((date){
      if(date!=null)
      {
        widget.dateTime=date;
        _date=date;
        addMeetingProvider.dateOfMeetingg=_date.year.toString()+"-"+_date.month.toString()+"-"+_date.day.toString();
        print(addMeetingProvider.dateOfMeetingg);
      }
    });
                              }
                             ),
                                  SizedBox(width: size.width*0.08),

                                  // editMeetingProvider.datoO(size),

                                  Text( 'when is your meeting?',style: TextStyle(color: appFo,fontSize: size.width*0.045),),

                                /*  Text(widget.dateTime==null? 'when is your meeting?':widget.dateTime.toString(),
                                    style: TextStyle(color: appFo,fontSize: size.width*0.045),),*/
                                ],
                              ),
                              SizedBox(height:size.height*0.02),

                              Row(
                                children: [
                                  ElevatedButton(
                                      style:  ButtonStyle(backgroundColor: MaterialStateProperty.all(appFo),
                                          shadowColor:MaterialStateProperty.all(pu) ,
                                          elevation:MaterialStateProperty.all(10)),
                                      child: Text('time of meeting',style: TextStyle(color: pu,fontSize: size.width*0.04),),
                                      onPressed: (){
                                        // ignore: avoid_print
                                        showTimePicker(context: context,
                                            initialTime:
                                            const TimeOfDay(hour: 12, minute: 0),
                                            builder: (context,picker){
                                              return Theme(data:ThemeData.light().copyWith(colorScheme: ColorScheme.light(primary: pu
                                              )),
                                                child:picker!,);}

                                        ).then((date){
                                          if(date!=null)
                                          {
                                            if(date.minute.toString().length==2 && date.hour.toString().length==2)
                                            addMeetingProvider.timeOfMeeting= date.hour.toString()+":"+date.minute.toString();
                                            else{
                                              if(date.minute.toString().length==1 && date.hour.toString().length==1)
                                                addMeetingProvider.timeOfMeeting= "0"+date.hour.toString()+":"+"0"+date.minute.toString();
                                              if(date.hour.toString().length==1)
                                                addMeetingProvider.timeOfMeeting="0"+ date.hour.toString()+":"+date.minute.toString();
                                              if(date.minute.toString().length==1)
                                                addMeetingProvider.timeOfMeeting= date.hour.toString()+":"+"0"+date.minute.toString();
                                            }
                                            print(addMeetingProvider.timeOfMeeting);
                                          }
                                        });


                                      }),
                                  SizedBox(width: size.width*0.08),
                                  Text(widget.dateTime==null? 'which hour is it?':widget.dateTime.toString(),
                                    style: TextStyle(color: appFo,fontSize: size.width*0.045),),
                                ],
                              ),
                              SizedBox(height:size.height*0.02),
                           //
                              Row(


                                children:[
                                  const Text(
                                    'Make meeting',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color:appFo ,
                                    ),
                                  ),
                                  TextButton(onPressed: (){Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => Users()),
                                  );
                                  }, child: const Text(
                                    'with ',
                                    style:TextStyle(
                                      fontSize: 20,
                                      color:appFo ,
                                    ),
                                  ),

                                  ),
                                ],
                              ),
                              //
                           /*   Row(
                                children: [
                                  Text('Meeting with',style: TextStyle(color: Colors.black45,fontSize: size.width*0.045),),
                                  SizedBox(width:size.width*0.08),
                                  DropdownButton<String>(
                                      value: value,
                                      items: names.map(buildMenuItem).toList(),
                                      onChanged: (value)=>print('have chosen')),
                                ],
                              ),//here we'll emit
*/                              SizedBox(height:size.height*0.02),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  ElevatedButton(
                                    onPressed: ()async{
                                      EasyLoading.show(status: 'Loading....');

                                      await addMeetingProvider.onAddMeeting();
                                      if (addMeetingProvider.modelMeeting != null)
                                      {
                                        EasyLoading.showSuccess(addMeetingProvider.message);
                                        Navigator.pushReplacementNamed(
                                            context, '/meetings');
                                      }
                                      else if (addMeetingProvider.modelMeeting == null)
                                      {
                                        EasyLoading.showError('oops!'+addMeetingProvider.message);

                                      }
                                    },
                                    child:  Text('add',style: TextStyle(color: appFo,fontSize: size.width*0.045)),
                                    style: ButtonStyle(
                                      //elevation: MaterialStateProperty.all(40),
                                      shape: MaterialStateProperty.all(const CircleBorder()),
                                      padding: MaterialStateProperty.all(const EdgeInsets.all(20)),
                                      foregroundColor: MaterialStateProperty.all(appFo),
                                      backgroundColor: MaterialStateProperty.all(pu), // <-- Button color
                                      overlayColor: MaterialStateProperty.resolveWith<Color?>((states) {
                                        if (states.contains(MaterialState.pressed)) return appFo; // <-- Splash color
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
/*
  DropdownMenuItem<String> buildMenuItem(String item) =>
      DropdownMenuItem(value:item,child: Text(item));*/
}

