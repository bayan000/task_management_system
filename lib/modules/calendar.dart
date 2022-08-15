
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../controllers/calendar controller.dart';
import '../models/calenadar_model.dart';

class PageThree extends StatelessWidget {
  TextEditingController controller=TextEditingController();
  String name_event='';
  final _formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Calendar '), centerTitle: true,),
        body: CalendarWidget(),
        floatingActionButton: FloatingActionButton(backgroundColor:Colors.blue,
          onPressed:




              ()async{

            showDialog(context: context,builder:(context) => AlertDialog(

              title: Text('Creat Event'),
              content: Form(
                key:_formKey,
                child:
                TextFormField(

                  autofocus: true,
                  decoration: InputDecoration(hintText:'Enter The title of Event',),

                  controller:controller ,
                  validator: (title) =>
                  title !=null && title.isEmpty ? 'Title cannot be empty':null,
                  onFieldSubmitted: (_) => ()async{
                    final isValid=_formKey.currentState!.validate();

                    if(isValid){

                      final event=ModelCalendar(event_name: controller.text);
                      final provider=Provider.of<CalendarContro>(context,listen:false);
                      //////////////////////


                      await  provider.onClickAddEventt(event);
                      Navigator.of(context).pop();


                      /////////////

                    }

                  },
                ),
              ),
              actions: [
                TextButton(onPressed:()async{

                  final isValid=_formKey.currentState!.validate();

                  if(isValid){

                    final event=ModelCalendar(event_name: controller.text);
                    final provider=Provider.of<CalendarContro>(context,listen:false);
                    await  provider.onClickAddEventt(event);
                    Navigator.of(context).pop();
                  }



                }, child:Text('Save') )

              ],
            ) );


          }



          ,child: Icon(Icons.check_outlined),
        )



    );


  }

}


class CalendarWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final  events=Provider.of<CalendarContro>(context).events;


    return SfCalendar(

      view:CalendarView.month,
      dataSource: EventDataSource(events),
      initialSelectedDate: DateTime.now(),
      cellBorderColor: Colors.transparent,
      onLongPress: (details){

        final provider=Provider.of<CalendarContro>(context,listen: false);

        provider.setDate(details.date!);
        showModalBottomSheet(

          context:context,
          builder:(context) => MyEvents(),

        );

      },

    );
  }
}

class MyEvents extends StatefulWidget {
  const MyEvents({Key? key}) : super(key: key);

  @override
  _MyEventsState createState() => _MyEventsState();
}

class _MyEventsState extends State<MyEvents> {
  @override
  Widget build(BuildContext context) {
    final provider=Provider.of<CalendarContro>(context);
    final selectedEvents=provider.eventsOfSelectedDate;
    if(selectedEvents.isEmpty){
      return Center(child:Text('No Events found!',style: TextStyle(color:Colors.white,fontSize: 20),)
      );
    }
    return
      SfCalendar(

        view: CalendarView.timelineDay,
        dataSource: EventDataSource(provider.events),
        initialDisplayDate: provider.selectedDate,
        appointmentBuilder:(BuildContext context,CalendarAppointmentDetails details){

          final event =details.appointments.first;
          return Container(

              width: details.bounds.width,
              height: details.bounds.height,

              decoration: BoxDecoration(color:event.backgroundColor.withOpacity(0.5),

                  borderRadius: BorderRadius.circular(12)
              ),

              child:Center(
                child: Text(
                  event.event_name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color:Colors.black,fontSize: 16,fontWeight: FontWeight.bold),



                ),
              )

          );


        },
        onTap: (details){

          if(details.appointments == null) return;
          final event=details.appointments!.first;
          provider.event_id=event.id;
          //////////////////////////////////////////////////////////
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) =>EventViewingPage(event:event) ));

        },
      )


    ;








  }

  Widget appointementBuilder(
      BuildContext context,CalendarAppointmentDetails details){
    final event =details.appointments.first;
    return Container(

        width: details.bounds.width,
        height: details.bounds.height,

        decoration: BoxDecoration(color:event.backgroundColor.withOpacity(0.5),

            borderRadius: BorderRadius.circular(12)
        ),

        child:Center(
          child: Text(
            event.event_name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color:Colors.black,fontSize: 16,fontWeight: FontWeight.bold),



          ),
        )

    );

  }




}


class EventViewingPage extends StatelessWidget {

  final ModelCalendar event;

  EventViewingPage({required this.event});


  @override
  Widget build(BuildContext context) {
    return

      Scaffold(


          appBar: AppBar(
            leading:CloseButton(),
            actions:buildViewActions(context,event),
          ),

          body: Row(children: [
            Text('Event Name :',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
            SizedBox(width: 7,),
            Text('${event.event_name}',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),

          ],)



      );



  }
  List<Widget> buildViewActions(BuildContext context,ModelCalendar event){
    return
      [
        IconButton(

          icon:Icon(Icons.edit),
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => EvenEditingPage(event:event)),
          ),

        ),
        IconButton(

            icon:Icon(Icons.delete),
            onPressed: () {
              final provider=Provider.of<CalendarContro>(context,listen:false);
              provider.onClickDeleteEvent(event);

            }

        )
      ];


  }

}

class EvenEditingPage extends StatefulWidget {


  final ModelCalendar? event;

  EvenEditingPage({ this.event});
  @override
  _EvenEditingPageState createState() => _EvenEditingPageState();

}

class _EvenEditingPageState extends State<EvenEditingPage> {
  final _formKey=GlobalKey<FormState>();
  final titleController=TextEditingController();


  @override
  void initState(){
    super.initState();


    if(widget.event != null){
      final event=widget.event!;
      titleController.text=event.event_name;

    }

  }

  @override
  void dispose(){
    titleController.dispose();


  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(

        leading: CloseButton(),
        actions:[  ElevatedButton.icon(

            style:ElevatedButton.styleFrom(
                primary: Colors.transparent,
                shadowColor: Colors.transparent
            ),
            onPressed:(){


            },  icon:Icon(Icons.done),
            label:Text('SAVE')

        )
        ],


      ),



    ) ;}





}
class EventDataSource extends CalendarDataSource{

  EventDataSource(List<ModelCalendar> appointments){

    this.appointments=appointments;

  }

  ModelCalendar getEvent(int index)=> appointments![index] as ModelCalendar;

  @override
  String getSubject(int index)=> getEvent(index).event_name;






}