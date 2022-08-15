import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:get_storage/get_storage.dart';

import '../config/server_config.dart';
import '../models/task_model.dart';

class SearchService{



  static  Future fetchTask(Task task)async{

    var response= await http.post(Uri.parse(ServerConfig.domainName+ServerConfig.SearchOfTask),
        body: {
          'title': task.title

        },



        headers: {
          HttpHeaders.authorizationHeader: 'Bearer ${GetStorage().read(
              'token')}',
          'Accept': 'application/json'
        }


    );

    var json = jsonDecode(response.body);
    print(response.statusCode);
    print(response.body);

    List<Task> model=[];
    if(response.statusCode ==200 || response.statusCode ==201){
      model=json.map((e) => Task.fromJson(e)).toList();

      if(task.title != null){
        model=model.where((element) => element.title!.toLowerCase().contains(task.title!.toLowerCase())).toList();
      }
    }
    else{
      print('there are error ');
    }

    return model;

  }









}