
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:tracker/controllers/calendar_controller.dart';

import '../../models/calenadar_model.dart';
import '../../shared/constants.dart';
import '../../shared/constants.dart';

class PageCalendar extends StatefulWidget {
  const PageCalendar({Key? key}) : super(key: key);

  @override
  _PageCalendarState createState() => _PageCalendarState();
}

class _PageCalendarState extends State<PageCalendar> {

  final CalendarController _calendarController=CalendarController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:buildAppBar( text:'Calendar',color: appCo,
          prefixIcon: Icons.arrow_back,onPressedPre: (){
            Navigator.pushNamed(context,'/DashboardTeamLeader');
          }
      ),
      body:


      Consumer<MyCalendarCont>(builder:(context,pro,_)=>FutureBuilder< List<ModelCalendar> >(
        future: pro.fetchAllEvent(),
        builder: (context,snapShot){
          //AsyncSnapShot
          if(snapShot.hasData)
            return

              SfCalendar(
                view: CalendarView.month,
                controller: _calendarController,
                dataSource: _getDataSource(snapShot.data!),
                onViewChanged: calendarViewChanged,
                //  monthViewSettings: MonthViewSettings(showAgenda: true),
                monthViewSettings: MonthViewSettings(
                    dayFormat: 'EEE',
                    // numberOfWeeksInView: 4,
                    //  appointmentDisplayCount: 2,
                    //appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
                    showAgenda: true,
                    agendaViewHeight: 400,
                    monthCellStyle
                        : MonthCellStyle(textStyle: TextStyle(fontStyle: FontStyle.
                    normal, fontSize: 15, color: Colors.black),
                      trailingDatesTextStyle: TextStyle(
                          fontStyle: FontStyle.normal,
                          fontSize: 15,
                          color: Colors.black),

                      leadingDatesTextStyle: TextStyle(
                          fontStyle: FontStyle.normal,
                          fontSize: 15,
                          color: Colors.black),

                      todayBackgroundColor:  Color(0xffe3f2fd),
                      leadingDatesBackgroundColor: Colors.grey[300],
                      trailingDatesBackgroundColor: Colors.grey[200],


                    )

                  //    navigationDirection: MonthNavigationDirection.horizontal
                ),

                //*
                viewHeaderStyle: ViewHeaderStyle(
                  backgroundColor: Colors.blue,

                  dayTextStyle:TextStyle
                    (color:Colors.white,fontWeight: FontWeight.bold) , ),

                headerStyle:CalendarHeaderStyle(
                  // textAlign: TextAlign.center,
                    backgroundColor: Colors.transparent,
                    textStyle: TextStyle(fontWeight: FontWeight.w500,fontSize: 18,color: Colors.blue,)) ,
                todayTextStyle: TextStyle(color:Colors.purple,fontSize: 16,fontWeight: FontWeight.w700),
                todayHighlightColor: Colors.purple.withOpacity(0.1),
                //showCurrentTimeIndicator: true,
                selectionDecoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(color: Colors.purple, width: 2),
                  borderRadius: const BorderRadius.all(Radius.circular(4)),
                  shape: BoxShape.rectangle,
                ),
                showNavigationArrow: true,

                allowAppointmentResize: true,
                backgroundColor: Colors.transparent,

                //*






              );



          if(snapShot.hasError)
            return Center(
              child: Text(snapShot.error.toString()),
            );

          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ))


      , floatingActionButton: FloatingActionButton(backgroundColor:Colors.purple,
        onPressed: ()async{

          Navigator.pushNamed(context, '/AllEvents');



        },child: Text('all')) ,





    );
  }
  void calendarViewChanged(ViewChangedDetails viewChangedDetails) {
    SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {
      _calendarController.selectedDate=null;
    });
  }
}

_DataSource _getDataSource(List<ModelCalendar> bEvents) {


  final List<Appointment> appointments = <Appointment>[];

  for(int i=0;i<bEvents.length;i++){



    DateTime s=DateTime.parse(bEvents[i].date_of_event);
    appointments.add(Appointment(
      startTime:DateTime(s.year,s.month,s.day,DateTime.now().hour,DateTime.now().minute,DateTime.now().second)
      ,
      endTime:DateTime(s.year,s.month,s.day,0,0,0),
      subject: bEvents[i].event_name,
      color: Colors.purple,) );

//print(bEvents[i].event_name);

    print(bEvents[i].date_of_event);

  }





  return _DataSource(appointments);
}

class _DataSource extends CalendarDataSource {
  _DataSource(List<Appointment> source) {
    appointments = source;
  }
}