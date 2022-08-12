import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:tracker/controllers/add_meeting_controller.dart';
import 'package:tracker/modules/users.dart';

import '../../shared/components.dart';
import '../../shared/constants.dart';
import '../selectUsers.dart';
import '../team/team.dart';
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;


class AddMeeting extends StatefulWidget {
   AddMeeting({Key? key, this.dateTime, this.value}) : super(key: key);
  final String? value ;
 @override
  State<AddMeeting> createState() => _AddMeetingState();
   late DateTime? dateTime;
   String? time;
}

class _AddMeetingState extends State<AddMeeting> {
AddMeetingProvider addMeetingProvider=AddMeetingProvider();
String? sta;
String? value ;
static var dato;
static var taymo;
static var selected;
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
                              Consumer<AddMeetingProvider>(builder: (context,amp,child)
                              {return Row(
                                  children: [
                                    ElevatedButton(
                                        style:  ButtonStyle(backgroundColor: MaterialStateProperty.all(appFo),
                                            shadowColor:MaterialStateProperty.all(pu) ,
                                            elevation:MaterialStateProperty.all(10)),
                                        child: Text('Date of meeting',style: TextStyle(color: pu,
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
                                              addMeetingProvider.dateOfMeetingg=_date.year.toString()+"-"+_date.month.toString()+"-"+_date.day.toString();
                                              print(addMeetingProvider.dateOfMeetingg);
                                              dato=_date.year.toString()+"-"+_date.month.toString()+"-"+_date.day.toString();
                                              amp.changeDOM(dato);

                                            }
                                          });
                                        }),
                                    SizedBox(width: size.width*0.08),
                                    Text(amp.dateOfMeetingg==null? 'when is your meeting?':
                                    amp.printDOM(),style: TextStyle(color: appFo,fontSize: size.width*0.045),),

                                  ],
                                );
                              },),
                              SizedBox(height:size.height*0.02),
                              Consumer<AddMeetingProvider>(builder: (context,amp,child){
                                return Row(
                                  children: [
                                    ElevatedButton(
                                        style:  ButtonStyle(backgroundColor: MaterialStateProperty.all(appFo),
                                            shadowColor:MaterialStateProperty.all(pu) ,
                                            elevation:MaterialStateProperty.all(10)),
                                        child: Text('time of meeting',style: TextStyle(color: pu,fontSize: size.width*0.04),),
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
                                              addMeetingProvider.timeOfMeeting=formatTimeOfDay(date);
                                              addMeetingProvider.timeOfMeeting=getTheRightTime(addMeetingProvider.timeOfMeeting.toString());
                                              taymo=addMeetingProvider.timeOfMeeting;
                                              amp.changeTOM(taymo);
                                            }
                                          });}),
                                    SizedBox(width: size.width*0.08),
                                    Text(amp.timeOfMeeting==null? 'which hour is it?':amp.printTOM(),style: TextStyle(color: appFo,fontSize: size.width*0.045),),
                                  ],
                                );
                              },),
                              SizedBox(height:size.height*0.02),
                              Row(children:[
                                  const Text(
                                    'Make meeting',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color:appFo ,
                                    ),
                                  ),
                                  Consumer<AddMeetingProvider>(
                                      builder: (context,amp,child) {
                                        return TextButton(onPressed: (){
                                          if(amp.l.length!=0)
                                            amp.l.length=0;
                                            Navigator.pushReplacementNamed(
    context, '/select_to_add_users');

                                        }, child: const Text(
                                          'with ',
                                          style:TextStyle(
                                            fontSize: 20,
                                            color:appFo,
                                          ),
                                        ),
                                        );
                                      }
                                  ),
                                ],
                              ),
                              SizedBox(height:size.height*0.02),
                              Row(
                                /*Navigator.pushReplacementNamed(
                                            context, '/meetings');*/
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Consumer<AddMeetingProvider>(
                                      builder: (context,emp,child) {
                                        return ElevatedButton(
                                          onPressed:() async{
                                            print(emp.l.length);
                                            print('iwillwin');
                                            EasyLoading.show(status: 'Loading....');
                                            addMeetingProvider.dateOfMeetingg=dato.toString();
                                            addMeetingProvider.timeOfMeeting=taymo.toString();
                                            addMeetingProvider.l=emp.l;
                                            if(addMeetingProvider.dateOfMeeting==null||
                                             addMeetingProvider.timeOfMeeting==null||
                                            addMeetingProvider.l.isEmpty){
                                              EasyLoading.showError('All fields are required ');
                                            }
                                            else{
                                              await addMeetingProvider.onAddMeeting();
                                              if (addMeetingProvider.message=="200" || addMeetingProvider.message=="201")
                                              {
                                                EasyLoading.showSuccess("Meeting added successfully");
                                                Navigator.pushReplacementNamed(
                                                    context, '/meetings');
                                              }
                                              else
                                              {
                                                EasyLoading.showError('oops! error');

                                              }
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
                                        );
                                      }
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

}

