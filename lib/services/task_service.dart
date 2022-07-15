import 'dart:convert';

import 'package:http/http.dart' as http;
import 'dart:async';

import 'package:get_storage/get_storage.dart';
import 'package:tracker/config/server_config.dart';
import 'package:tracker/models/task_model.dart';

class  TaskService{


  //----------------------- add Task ----------------------------

  static Future addTask(TaskModel taskModel)async{

    var response=await http.post(
        Uri.parse(ServerConfig.domainName+ServerConfig.addTask),
        body:{

          'title':taskModel.title        ,
          'description':  taskModel.description     ,
          'start_date':taskModel.start_date     ,
          'end_date':  taskModel.end_date   ,
          'team_id':   taskModel.team_id   ,
          'status_id':   taskModel.status_id
        },
        headers: {
          'auth': 'Bearer  ${GetStorage().read('token')}',
          'Accept': 'application/json',
        }
    );

  }








}