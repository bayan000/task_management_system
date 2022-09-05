
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/calenadar_model.dart';
import '../services/calendar_service.dart';

class MyCalendarCont with ChangeNotifier{
  DateTime selectedStartDate=DateTime.now();
  final TextEditingController titleCotroller=TextEditingController();
  int id_event=0;
  List<ModelCalendar>  l_AllEvents=[];
  Future<List<ModelCalendar>>  fetchAllEvent()async{
    l_AllEvents= await MyCalendarService.allEvents();
    return l_AllEvents;




  }

  var addedEvent;
  Future fetchAdedEvent()async{

    ModelCalendar modelCalendar=ModelCalendar(
        event_name: titleCotroller.text,
        date_of_event:selectedStartDate.toString()

    );

    addedEvent= await MyCalendarService.AddEvent(modelCalendar);

    l_AllEvents.add(addedEvent);
    notifyListeners();




  }


  var editedEvent;
  Future fetchEditedEvent()async{
    ModelCalendar modelCalendar=ModelCalendar(
        event_name:titleCotroller.text,
        date_of_event:selectedStartDate.toString()
    );
    editedEvent=await MyCalendarService.EditEvent(modelCalendar,id_event);

    for(var ev in l_AllEvents){
      if(ev.id == id_event){
        ev=editedEvent;
        notifyListeners();
        break;
      }
    }


  }

//---------------------Delete Event-------------------------

  Future showDeleteEvent()async {
    print(id_event);

    await MyCalendarService.DeleteEvent(id_event);

    for (var event in l_AllEvents) {
      if (event.id == id_event) {
        l_AllEvents.remove(event);


        notifyListeners();
        break;
      }
    }
  }
  // --------------------طبعا  هون ما استخدمت منن شي ____________
  toChangeData(ModelCalendar oneEvent ){
    print(oneEvent.event_name);
    print(oneEvent.date_of_event);
    titleCotroller.text=oneEvent.event_name;
    selectedStartDate=DateTime.parse(oneEvent.date_of_event);

  }


  var oneEvent;
  Future<ModelCalendar> fetchOneEvent()async{
    print('kl');
    oneEvent= await MyCalendarService.OneEvent(id_event);
    await toChangeData(oneEvent);
    return oneEvent;

  }

}