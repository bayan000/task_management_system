import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:get_storage/get_storage.dart';

import '../config/server_config.dart';
import '../models/task_model.dart';
class SearchService {

//*********************************8
  static Future<List<Task>> fetchMyTasks(Task modelTask ) async {
    var response = await http.post(
        Uri.parse(ServerConfig.domainName + ServerConfig.SearchOfTask),
        body: {
          'title': modelTask .title
        },
        headers: {
          HttpHeaders.authorizationHeader:
          'Bearer ${GetStorage().read('token')}',
          'Accept': 'application/json'
        });

    print('the name is ');
    print( modelTask .title);
    var json = jsonDecode(response.body);
    print(response.statusCode);
    print(response.body);

    List< Task > models = [];
    print('model');
    if (response.statusCode == 200 || response.statusCode == 201) {
      print('loop ');


      for(var t in json){
        models.add(Task.fromJson(t));

      }




      print('loop after');
      print(models);
      if ( modelTask .title != null) {
        print(' in loop');
        models=models.where((element) =>element.title!.toLowerCase().contains(element.title!.toLowerCase())).
        toList();
      }
    } else {
      print('the model is null ');
    }
    print('tttttttt yeeeeeees');

    if(models != null) {
      return models;
    }
    else{
      return [];
    }


  }


}