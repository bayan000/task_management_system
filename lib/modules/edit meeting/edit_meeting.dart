import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:tracker/controllers/edit_meeting_controller.dart';
import 'package:tracker/modules/selectUsers.dart';
import 'package:tracker/shared/components.dart';

import '../../shared/constants.dart';
import '../meeting/meeting.dart';
import '../team/team.dart';



class EditMeeting extends StatefulWidget  {
  var id;
  EditMeeting({ this.id}) ;
  @override
  State<EditMeeting> createState() => _EditMeetingState(id);
  late DateTime? dateTime;
  late String? stat;
  String? time;
}

class _EditMeetingState extends State<EditMeeting> {
  int id;
  _EditMeetingState(this.id);

  EditMeetingProvider editMeetingProvider=EditMeetingProvider();
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
            this.id=id;
            Navigator.of(context).pushReplacement(                                                         //new
                new MaterialPageRoute(                                                                       //new
                    settings: const RouteSettings(name: '/meeting'),                                              //new
                    builder: (context) =>  Meeting(id:id,) //new
                )                                                                                            //new
            );
          },
        ),
        title: Text('Edit meeting',style: trackerStyle,),
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
                  Consumer<EditMeetingProvider>(builder: (context,emp,child)
                    {
                      return Row(
                        children: [
                          ElevatedButton(
                              style:  ButtonStyle(backgroundColor: MaterialStateProperty.all(appFo),
                                  shadowColor:MaterialStateProperty.all(pu) ,
                                  elevation:MaterialStateProperty.all(10)),
                              child: Text('Date of meeting',style: TextStyle(color: pu,fontSize: size.width*0.04),),
                              onPressed: (){
                                showDatePicker(context: context,
                                    initialDatePickerMode: DatePickerMode.day,
                                    initialEntryMode: DatePickerEntryMode.calendarOnly,
                                    initialDate: DateTime.now(),
                                    firstDate:  DateTime.now(),
                                    // ignore: avoid_print
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
                                    editMeetingProvider.dateOfMeetingg=_date.year.toString()+"-"+_date.month.toString()+"-"+_date.day.toString();
                                    print(editMeetingProvider.dateOfMeetingg);
                                    dato=_date.year.toString()+"-"+_date.month.toString()+"-"+_date.day.toString();
                                    emp.changeDOM(dato);
                                  }
                                });
                              }),
                          SizedBox(width: size.width*0.08),Text(emp.dateOfMeetingg==null? 'when is your meeting?':emp.printDOM(),style: TextStyle(color: appFo,fontSize: size.width*0.045),),
                        ],
                      );
                    },)
                  ,SizedBox(height:size.height*0.02),
                  Consumer<EditMeetingProvider>(
                     builder: (context,emp,child) {
                      //  emp.fetchMeetingStates();
                       return FutureBuilder<Map>(
                         future:emp.fetchMeetingStates(),
                           builder: (context,snapshot){return Row(
                              children: [
                                Text('meeting status',style: TextStyle(color: appFo,fontSize: size.width*0.045),),
                                SizedBox(width:size.width*0.08),
                                DropdownButton<String>(
                                  dropdownColor: pu,
                                  style: TextStyle(color: appFo,fontSize: size.width*0.045),
                                icon: Icon(Icons.arrow_drop_down,color: appFo,),
                                    value: emp.meetingStatus,
                                    items: EditMeetingProvider.st.map(buildMenuItem).toList(),
                                    onChanged: (String? value)=>setState(() {
                                      this.value=value;

                                      editMeetingProvider.stateeee=emp.stateId[this.value];
                                      emp.meetingStatus=this.value;
                                      emp.stateeee= emp.stateId[this.value];
                                      emp.changeStatus(emp.stateId[this.value]);
                                      selected=emp.stateeee;
                                      editMeetingProvider.stateeee=emp.stateeee;
                                      print(emp.stateeee.toString());
                                      print(editMeetingProvider.stateeee);

                                      print(emp.meetingStatus);
                                       print(emp.stateId[this.value].toString()//editMeetingProvider.stateeee
                                       );
                                      print('here i am');
                                    })

                                 )

                              ],
                            );}
                       );
                     }
                   )//emit meeting status
                  ,SizedBox(height:size.height*0.02),
                  Consumer<EditMeetingProvider>(builder: (context,emp,child){
                    return Row(
                      children: [
                        ElevatedButton(
                            style:  ButtonStyle(backgroundColor: MaterialStateProperty.all(appFo),
                                shadowColor:MaterialStateProperty.all(pu) ,
                                elevation:MaterialStateProperty.all(10)),
                            child: Text('time of meeting',style: TextStyle(color: pu,fontSize: size.width*0.04),),
                            onPressed: (){
                              // ignore: avoid_print
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
                                  editMeetingProvider.timeOfMeeting=formatTimeOfDay(date);
editMeetingProvider.timeOfMeeting=getTheRightTime(editMeetingProvider.timeOfMeeting.toString());
taymo=editMeetingProvider.timeOfMeeting;
emp.changeTOM(taymo);

                                }
                              });


                            }),
                        SizedBox(width: size.width*0.08),
                        Text(emp.timeOfMeeting==null? 'which hour is it?':emp.printTOM(),style: TextStyle(color: appFo,fontSize: size.width*0.045),),
                        //editMeetingProvider.timeOfMeeting==null?
                      ],
                    );
                  },),
                  SizedBox(height:size.height*0.02),
                  Row(


                    children:[
                      const Text(
                        'Make meeting',
                        style: TextStyle(
                          fontSize: 16,
                          color:appFo ,
                        ),
                      ),
                      Consumer<EditMeetingProvider>(
                        builder: (context,emp,child) {
                          return TextButton(onPressed: (){
                            if(emp.l.length!=0)
                              emp.l.length=0;
                            Navigator.of(context).pushReplacement(                                                         //new
                                new MaterialPageRoute(                                                                       //new
                                    settings: const RouteSettings(name: '/select_users'),                                              //new
                                    builder: (context) => new SelectUsers(id: this.id ,) //new
                                )                                                                                            //new
                            );
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
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Consumer<EditMeetingProvider>(
                        builder: (context,emp,child) {
                          return ElevatedButton(
                            onPressed:() async{
                              print(emp.l.length);
                              print('iwillwin');
                              EasyLoading.show(status: 'Loading....');
                              editMeetingProvider.stateeee=selected.toString();
                              editMeetingProvider.dateOfMeetingg=dato.toString();
                              editMeetingProvider.timeOfMeeting=taymo.toString();
                              editMeetingProvider.l=emp.l;
                              if(
                              editMeetingProvider.stateeee==null||
                                  editMeetingProvider.dateOfMeeting==null||
                                  editMeetingProvider.timeOfMeeting==null||
                                  editMeetingProvider.l.isEmpty){
                                              EasyLoading.showError('All fields are required ');
                                            }
                                            else{await editMeetingProvider.onEditMeeting(this.id);
                              if (editMeetingProvider.message=="200" || editMeetingProvider.message=="201")
                              {
                                print(editMeetingProvider.l.length);
                                print('hi');
                              EasyLoading.showSuccess("Meeting edited successfully");
                              Navigator.pushReplacementNamed(
                              context, '/meetings');
                              }
                              else
                              {
                                EasyLoading.showError('oops! error');

                              }}

                              }
                            ,child:  Text('edit',style: TextStyle(color: appFo,fontSize: size.width*0.045)),
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

  DropdownMenuItem<String> buildMenuItem(String item) =>
      DropdownMenuItem(value:item,child: Text(item));
}


