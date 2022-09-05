
import 'dart:convert';
import 'dart:io';

import 'package:get_storage/get_storage.dart';

import '../config/server_config.dart';
import '../models/calenadar_model.dart';
import 'package:http/http.dart' as http;

class MyCalendarService{


  static Future allEvents()async{

    var response = await http.get(  Uri.parse(ServerConfig.domainName +'api/show/events')
        ,
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer ${GetStorage().read(
              'token')}',
          'Accept': 'application/json'
        });


    Map<String,dynamic> json = jsonDecode(response.body);
    print(response.statusCode);
    List<ModelCalendar> list_allEvents=[];

    for(var event in json['all events']){
      list_allEvents.add(ModelCalendar.fromJson(event));


    }
    return list_allEvents;

  }



  static  Future  AddEvent(ModelCalendar modelCalendar)async {
    var response = await http.post(
        Uri.parse(ServerConfig.domainName + ServerConfig.addEvent),
        body: {
          'event_name': modelCalendar.event_name,
          'date_of_event':modelCalendar.date_of_event
        },
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer ${GetStorage().read(
              'token')}',
          'Accept': 'application/json'
        }
    );
    Map<String, dynamic> json = jsonDecode(response.body);
    print(response.statusCode);


    if (json['added done'] == null)
      return null;
    return ModelCalendar.fromJson(json['added done']);
  }

//---------------------EditEvent-------------------------

  static Future EditEvent(ModelCalendar modelCalendar,int id_event)async{


    var response=await http.put(
        Uri.parse(ServerConfig.domainName+ServerConfig.editEvent+'${id_event}'),
        body:{
          'event_name': modelCalendar.event_name,
          'date_of_event':modelCalendar.date_of_event

        },
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer ${GetStorage().read('token')}',
          'Accept': 'application/json'
        }
    );
    Map<String,dynamic> json=jsonDecode(response.body);
    print(response.statusCode);


    if(json['after update'] == null)
      return null;
    return ModelCalendar.fromJson(json['after update']);




  }


//------------------DeleteEvent----------------------
  static Future DeleteEvent(int id_event)async {
    var response = await http.delete(
      Uri.parse(
          ServerConfig.domainName + ServerConfig.deleteEvent + '${id_event}'),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer ${GetStorage().read('token')}',
        'Accept': 'application/json'
      },
    );
    var json = jsonDecode(response.body);
    print(response.statusCode);
    print(json[0]);

  }
//------------------OneEvent-------------

  static Future OneEvent(int id_event)async{
    ModelCalendar event;

    var response = await http.get(
      Uri.parse(
          ServerConfig.domainName +'api/show/event/'+'${id_event}'),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer ${GetStorage().read('token')}',
        'Accept': 'application/json'
      },
    );
    Map<String,dynamic> json=jsonDecode(response.body);
    print(response.statusCode);
    print(response.body);


    event=ModelCalendar(
        event_name: json['the event']['event_name'],
        id:json['the event']['id'],
        date_of_event: json['the event']['date_of_event'],
        user_id: json['the event']['user_id']

    );
    print(event.event_name);
    return event;


  }


}