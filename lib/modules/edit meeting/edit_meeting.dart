import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:tracker/controllers/edit_meeting_controller.dart';

import '../../shared/constants.dart';
import '../team/team.dart';



class EditMeeting extends StatefulWidget with ChangeNotifier {
  EditMeeting({Key? key, this.dateTime}) : super(key: key);
  late DateTime? dateTime;
  String? time;


  static const items=[
    'Upcoming','Finished','Delayed'
  ];

  @override
  State<EditMeeting> createState() => _EditMeetingState();
}

class _EditMeetingState extends State<EditMeeting> {
  String? value ;
  String? dato;
  String? taymo;
  EditMeetingProvider editMeetingProvider=EditMeetingProvider();
  @override
  Widget build(BuildContext context) {
    DateTime _date;
    Size size =MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appCo,
        shadowColor: appCo,
        elevation: 0,
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
                                    editMeetingProvider.dateOfMeetingg=_date.year.toString()+"-"+_date.month.toString()+"-"+_date.day.toString();
                                    print(editMeetingProvider.dateOfMeetingg);
                                    dato=_date.year.toString()+"-"+_date.month.toString()+"-"+_date.day.toString();
                                    emp.changeDOM(dato);

                                  }
                                });
                              }),
                          SizedBox(width: size.width*0.08),
                          // editMeetingProvider.datoO(size),

                          Text(emp.dateOfMeetingg==null? 'when is your meeting?':emp.printDOM(),style: TextStyle(color: appFo,fontSize: size.width*0.045),),

                        ],
                      );
                    },)

                  ,SizedBox(height:size.height*0.02),
                  Row(
                    children: [
                      Text('meeting status',style: TextStyle(color: appFo,fontSize: size.width*0.045),),
                      SizedBox(width:size.width*0.08),
                      DropdownButton<String>(
                        dropdownColor: pu,
                        style: TextStyle(color: appFo,fontSize: size.width*0.045),
/* widget.dateTime=date;
                            _date=date;
                            editMeetingProvider.dateOfMeetingg=_date.year.toString()+"-"+_date.month.toString()+"-"+_date.day.toString();
                            print(editMeetingProvider.dateOfMeetingg);*/
                      icon: Icon(Icons.arrow_drop_down,color: appFo,),
                          value: value,
                          items: EditMeeting.items.map(buildMenuItem).toList(),
                          onChanged: (value)=>
                        setState(() {
                          this.value=value;
                          if(value=="Upcoming")
                          {
                            editMeetingProvider.meetingStatus =1;
                        }
                          else if(value=="Finished")
                            editMeetingProvider.meetingStatus =2;
                          if(value=="Delayed")
                            editMeetingProvider.meetingStatus =3;
                        })
                        /*{
                          if(value=="Upcoming")
                            {
                              editMeetingProvider.meetingStatus =1,
                              this.value=value,

                            }
                         else if(value=="Finished")
                          editMeetingProvider.meetingStatus =2,
                          if(value=="Delayed")
                          editMeetingProvider.meetingStatus =3,
                          }*/),
                    ],
                  ),//emit meeting status
                  SizedBox(height:size.height*0.02),
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
                                    editMeetingProvider.timeOfMeeting= date.hour.toString()+":"+date.minute.toString();
                                  else{
                                    if(date.minute.toString().length==1 && date.hour.toString().length==1)
                                      editMeetingProvider.timeOfMeeting= "0"+date.hour.toString()+":"+"0"+date.minute.toString();
                                    if(date.hour.toString().length==1)
                                      editMeetingProvider.timeOfMeeting="0"+ date.hour.toString()+":"+date.minute.toString();
                                    if(date.minute.toString().length==1)
                                      editMeetingProvider.timeOfMeeting= date.hour.toString()+":"+"0"+date.minute.toString();
                                  }
                                  print(editMeetingProvider.timeOfMeeting);
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
                      TextButton(onPressed: (){Navigator.pushReplacementNamed(
                          context, '/team');
                      }, child: const Text(
                        'with ',
                        style:TextStyle(
                          fontSize: 20,
                          color:appFo,
                        ),
                      ),

                      ),
                    ],
                  ),//here we'll emit
                  SizedBox(height:size.height*0.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: () async{
                          EasyLoading.show(status: 'Loading....');
                          await editMeetingProvider.onEditMeeting();
                          if (editMeetingProvider.message=="200" || editMeetingProvider.message=="201")
                          {
                          EasyLoading.showSuccess("Meeting added successfully");
                          Navigator.pushReplacementNamed(
                          context, '/meetings');
                          }
                          else
                          {
                            EasyLoading.showError('oops! error'+editMeetingProvider.message);

                          }
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


