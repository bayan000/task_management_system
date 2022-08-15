
import 'dart:convert';
import 'dart:io';

import 'package:get_storage/get_storage.dart';

import '../config/server_config.dart';
import '../models/calenadar_model.dart';
import 'package:http/http.dart' as http;
class CalendarService{


  static  Future  AddEvent(ModelCalendar modelCalendar)async {
    var response = await http.post(
        Uri.parse(ServerConfig.domainName + ServerConfig.addEvent),
        body: {
          'event_name': modelCalendar.event_name
        },
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer ${GetStorage().read(
              'token')}',
          'Accept': 'application/json'
        }
    );
    Map<String, dynamic> json = jsonDecode(response.body);
    print(response.statusCode);
    print(response.body);

    if (json['added done'] == null)
      return null;
    return ModelCalendar.fromJson(json['added done']);
  }
//---------------------EditEvent-------------------------

  static Future EditEvent(ModelCalendar modelCalendar,int id_event)async{


    var response=await http.put(
        Uri.parse(ServerConfig.domainName+ServerConfig.editEvent+'${id_event}'),
        body:{
          'event_name':modelCalendar.event_name
        },
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer ${GetStorage().read('token')}',
          'Accept': 'application/json'
        }
    );
    Map<String,dynamic> json=jsonDecode(response.body);
    print(response.statusCode);
    print(response.body);

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
    List<String> json = jsonDecode(response.body);
    print(response.statusCode);
    print(json[0]);
    if (response.statusCode == 200) {
      return json[0];
    }
    else {
      return 'Failed to delete user.';
    }
  }




  //-------------------------------ShowAllEvents-------------------

  static Future ShowMyEvents()async {
    var response = await http.get(
        Uri.parse(ServerConfig.domainName + ServerConfig.showMyEvents)
        ,
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer ${GetStorage().read(
              'token')}',
          'Accept': 'application/json'
        });


    Map<String, dynamic> json = jsonDecode(response.body);
    List events = json['all events'];

    List<ModelCalendar> models = [];
    print(response.statusCode);


    for (var ca in events) {
      models.add(ModelCalendar.fromJson(ca));
    }
    print(models);
    if (models != null) {
      return models;
    }
    else {
      return [];
    }
  }
//-----------------------------------ShowOneEvent-------------------

  static Future ShowOneEvent(int id_event)async {

    var response = await http.get(  Uri.parse(ServerConfig.domainName+ServerConfig.showOneEvent+'${id_event}')
        ,
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer ${GetStorage().read(
              'token')}',
          'Accept': 'application/json'
        });



    Map<String,dynamic> json= jsonDecode(response.body);

    print(response.statusCode);

    print(json['the event']);

    if(json['the event'] == null)
      return null;
    return ModelCalendar.fromJson(json['the event']);
  }














}