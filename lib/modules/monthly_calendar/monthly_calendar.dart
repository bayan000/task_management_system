import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../shared/constants.dart';

class CalendarMonthly extends StatelessWidget {
  const CalendarMonthly({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appCo,
        shadowColor: appCo,
        elevation: 0,
        title: Text('My calendar',style: trackerStyle),),
        body:SfCalendar(
          view: CalendarView.month,
          initialSelectedDate: DateTime.now(),
          cellBorderColor: Colors.transparent,
          todayHighlightColor:pu,


        )

    ); /*;*/
  }
}
