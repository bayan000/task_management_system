
import 'package:flutter/material.dart';

import '../models/calenadar_model.dart';
import '../services/calendar_service.dart';

class CalendarContro  extends  ChangeNotifier{

  List<ModelCalendar> _events=[];

  List<ModelCalendar> get events =>_events;
  DateTime _selectedDate=DateTime.now();
  DateTime get selectedDate => _selectedDate;
  DateTime setDate(DateTime date) => _selectedDate=date;

  List<ModelCalendar> get eventsOfSelectedDate =>_events;


  var addedEvent;
  Future onClickAddEventt(ModelCalendar event)async{
    ModelCalendar modelCalendar=ModelCalendar(
        event_name: event.event_name
    );
    addedEvent= await CalendarService.AddEvent(modelCalendar);

    _events.add(addedEvent);
    notifyListeners();

  }
  var editedEvent;
  int event_id=0;
//---------------------Edit Event----------------------
  Future onClickEditEvent(ModelCalendar eventt,ModelCalendar oldevent)async{
    ModelCalendar modelCalendar=ModelCalendar(
        event_name: eventt.event_name
    );
    editedEvent=await CalendarService.EditEvent(modelCalendar,eventt.id);

    if(editedEvent != oldevent){
      final index=_events.indexOf(oldevent);
      _events[index]=editedEvent;
      notifyListeners();
    }
    /*
    for(var ev in _events){
      if(ev.id == event_id){
        ev=editedEvent;
        notifyListeners();
        break;
      }
  }
     */
  }

//---------------------Delete Event-------------------------

  Future onClickDeleteEvent(ModelCalendar event)async{

    await CalendarService.DeleteEvent(event.id);

    for (var ev in _events) {
      if (ev.id == event.id) {
        _events.remove(ev);
        notifyListeners();
        break;
      }
    }




  }

//---------------------ShowAllevents----------------------

  Future onClickShowEvents()async{

    await CalendarService.ShowMyEvents();


  }


//--------------------ShowOneEvent------------

  Future onClickShowOneEvent()async{

    await CalendarService.ShowOneEvent(11);


  }





}