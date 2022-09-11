import 'dart:convert';
import 'dart:io';

import 'package:get_storage/get_storage.dart';

import '../config/server_config.dart';
import '../models/data_model.dart';
import '../models/notification_model.dart';
import 'package:http/http.dart' as http;
class NotificationService{

  static List<LDataModel> n_title=[];
//static List<LDataModel>  nr_title=[];

//-------------------LEADER--&& MEMMBER---------------------------


//is true
  static Future<List<NotificationModel>>  ll()async {
    var response = await http.get(
        Uri.parse(ServerConfig.domainName + 'api/show/notification')
        ,
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer ${GetStorage().read(
              'token')}',
          'Accept': 'application/json'
        });


    Map<String, dynamic> json = jsonDecode(response.body);


    print(response.statusCode);

    List<LDataModel> list_data_notification=[];
    NotificationModel notificationModel;
    List<NotificationModel> list_notification=[];
    for (int i = 0; i < json['my notification'].length; i++) {

      list_data_notification.add(LDataModel.fromJson(json['my notification'][i]['data']));


      notificationModel=NotificationModel(
          id: json['my notification'][i]['id'],
          data: list_data_notification[i]
      );
      list_notification.add(notificationModel);


      //print(list_notification[0].data!.title);
//print(list_notification[0].id);

      json['my notification'][i]['data'].forEach((k, v) {
        if(k != 'note'){
          n_title.add(LDataModel(k,v));
        }
      });


    }
    // print(list_data_notification[0].title);
    // print(n_title[0].note); //title
    // print(n_title[0].title);// the value of title

    return list_notification;
  }
//

  static Future   LResdedNotifications()async {
    var response = await http.get(
        Uri.parse(ServerConfig.domainName+'api/show/ReadNotification')
        ,
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer ${GetStorage().read(
              'token')}',
          'Accept': 'application/json'
        });


    Map<String, dynamic> json = jsonDecode(response.body);


    print(response.statusCode);

    List<LDataModel> list_data_notification=[];
    NotificationModel notificationModel;
    List<NotificationModel> list_notification=[];




    for (int i = 0; i < json['the notification that you read'].length; i++) {

      list_data_notification.add(LDataModel.fromJson(json['the notification that you read'][i]['data']));


      notificationModel=NotificationModel(
          id: json['the notification that you read'][i]['id'],
          data: list_data_notification[i]
      );
      list_notification.add(notificationModel);

      // print(list_notification[0].data!.note);


      json['the notification that you read'][i]['data'].forEach((k, v) {
        if(k != 'note'){
          n_title.add(LDataModel(k,v));
        }
      });


    }

    //  print(list_data_notification[0].title);

    // print(n_title[0].note); //title




    // the value of title

    return list_notification;



  }



  static Future<String> makeNotificationsRed(String id)async{

    var response = await http.get(  Uri.parse(ServerConfig.domainName+'api/read/notification/'+'${id}')
        ,
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer ${GetStorage().read(
              'token')}',
          'Accept': 'application/json'
        });


    Map<String,dynamic> json = jsonDecode(response.body);

    print(json['message']);

    return json['message'];

  }

//--------------------------------------------------------------------------










}