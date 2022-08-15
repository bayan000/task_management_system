import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:async';

import 'package:get_storage/get_storage.dart';
import 'package:tracker/config/server_config.dart';
import 'package:tracker/models/task_model.dart';

import '../models/subtask_model.dart';
import '../models/subtask_task_status_model.dart';
import '../models/user_model.dart';

class  TaskService{


  static Map<dynamic,String> priority={};
  static Map<dynamic,String> suStatu={};
  static Map<String,int> idMap={};
  static List<String> st=[];
  static List<String> stt=[];
  static Future<List<StatusModel>> subSt() async{
    List<StatusModel> states=[];
    var url=ServerConfig.domainName+'api/show2';
    var response =await http.get(Uri.parse(url),headers: {
      'Authorization':'Bearer  ${GetStorage().read('token')}',
      'Accept':'application/json',
    },);
    List<dynamic> s = jsonDecode(response.body);
    print(response.statusCode);
    print(s[0]["id"]);
    for (var i=0; i<s.length ;i++)//var t in jsonData
        {
      states.add( StatusModel.fromJson(s[i]));
      suStatu[states[i].id]=states[i].name!;
      idMap[states[i].name!]=states[i].id;
      if(!stt.contains(states[i].name!))
        stt.add(states[i].name!);
    }
    print(suStatu[1]);

    print('well');
    return states;
  }






  //----------------------- add Task ----------------------------

  static Future addTask(Task taskModel)async{

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
          HttpHeaders.authorizationHeader: 'Bearer ${GetStorage().read('token')}',
          'Accept': 'application/json'
        }
    );
    Map<String,dynamic> json=jsonDecode(response.body);
    print(response.statusCode);
    print(response.body);
    if(json['tha task is:'] == null)
      return null;
    return Task.fromJson(json['tha task is:']);
  }
//----------------------EditTask---------------------

  static Future editTask(Task taskModel,int id_task)async{
    print(id_task);
    var response = await http.put(
        Uri.parse(ServerConfig.domainName+ServerConfig.editTask+'${id_task}'),

        body: {
          'title':taskModel.title        ,
          'description':  taskModel.description     ,
          'start_date':taskModel.start_date     ,
          'end_date':  taskModel.end_date   ,
          'team_id':   taskModel.team_id   ,
          'status_id':   taskModel.status_id
        },
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer ${GetStorage().read('token')}',
          'Accept': 'application/json'
        }


    );

    Map<String,dynamic> json=jsonDecode(response.body);

    print(response.statusCode);
    if(json['tha task after updated is:'] == null)
      return null;
    return Task.fromJson(json['tha task after updated is:']);

  }
  //-----------------DeleteTask-----------------------

  static Future deleteTask(int id_task)async{


    var response=await http.delete(
      Uri.parse(ServerConfig.domainName+ServerConfig.deleteTask+'${id_task}'),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer ${GetStorage().read('token')}',
        'Accept': 'application/json'
      },
    );
    Map<String,dynamic> json=jsonDecode(response.body);
    print(response.statusCode);
    print(json['message']);
    if(response.statusCode ==  201 || response.statusCode ==  200){
      return json['message'];
    }
    else
    {
      return 'Failed to delete user.';
    }
  }
  //--------------------showAllTask---------------



  static Future<List<Task>>  servAllTasks()async{

    var response = await http.get(  Uri.parse(ServerConfig.domainName + ServerConfig.showTasks)
        ,
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer ${GetStorage().read(
              'token')}',
          'Accept': 'application/json'
        });


    var json = jsonDecode(response.body);


    List< Task > models = [];
    print(response.body);
    print(response.statusCode);
    print(json);

    for(var us in json ){
      print(us);
      models.add(Task.fromJson(us));}
    print(models);
    return models;

  }



  //-------------------CompletedTask-------
  static Future<List<Task>>  servCompletedTasks()async{

    var response = await http.get(  Uri.parse(ServerConfig.domainName + ServerConfig.showCompletedTasks)
        ,
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer ${GetStorage().read(
              'token')}',
          'Accept': 'application/json'
        });


    Map<String,dynamic> json = jsonDecode(response.body);

    var compTask = json['the completed tasks'];

    List <Task> models=[];
    print(response.statusCode);
    for(var ta in  compTask){

      models.add(Task.fromJson(ta));
    }

    if(models != null) {
      return models;
    }
    else{
      return [];
    }






  }

//-------------------Missed Task---------------------

  static Future<List<Task>>  servMissedTasks()async{

    var response = await http.get(  Uri.parse(ServerConfig.domainName + ServerConfig.showMissedTasks)
        ,
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer ${GetStorage().read(
              'token')}',
          'Accept': 'application/json'
        });


    Map<String,dynamic> json = jsonDecode(response.body);

    List missedTask = json['the missed tasks'];

    List< Task > models = [];
    print(response.statusCode);


    for(var ta in missedTask){
      models.add(Task.fromJson(ta));}
    print(models);
    if(models != null) {
      return models;
    }
    else{
      return [];
    }






  }

//---------------------Onprogress----------------

  static Future<List<Task>>  servOnprogressTasks()async{

    var response = await http.get(  Uri.parse(ServerConfig.domainName + ServerConfig.showOnProgressTasks)
        ,
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer ${GetStorage().read(
              'token')}',
          'Accept': 'application/json'
        });


    Map<String,dynamic> json = jsonDecode(response.body);

    List inProgressTasks = json['in progress tasks'];

    List< Task > models = [];
    print(response.statusCode);


    for(var ta in inProgressTasks){
      models.add(Task.fromJson(ta));}
    print(models);
    if(models != null) {
      return models;
    }
    else{
      return [];
    }






  }


  //------------------------------ToDoTasks------------------


  static Future<List<Task>>  servToDoTasks()async{

    var response = await http.get(  Uri.parse(ServerConfig.domainName + ServerConfig.showToDoTasks)
        ,
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer ${GetStorage().read(
              'token')}',
          'Accept': 'application/json'
        });


    Map<String,dynamic> json = jsonDecode(response.body);

    List inProgressTasks = json['to to tasks'];

    List< Task > models = [];
    print(response.statusCode);


    for(var ta in inProgressTasks){
      models.add(Task.fromJson(ta));}
    print(models);
    if(models != null) {
      return models;
    }
    else{
      return [];
    }






  }



//---------------------showOneTask----------------------

  static  Future<Task>    servOneTask(int id_task)async {
    var response = await http.get(  Uri.parse(ServerConfig.domainName+ServerConfig.showOneTask+'${id_task}')
        ,
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer ${GetStorage().read(
              'token')}',
          'Accept': 'application/json'
        });

    var json = jsonDecode(response.body);
    print(response.statusCode);
    List<ModelSubTask?>? subTaskss=[];
    var usersSub=[];

    print('json');
    print(json);

    Task taskmodel=Task();
    for (var ta in json['the info about task']) {

      print('enter in task');
      for (int i = 0; i < ta['subtasks'].length; i++){

        print('enter in subtask');
        subTaskss.add(ModelSubTask.fromJson(ta['subtasks'][i]) as ModelSubTask);
        for(int j=0;j< ta['subtasks'][j]['members'].length;j++){
          print('enter mem');
          usersSub.add(User.fromJson(ta['subtasks'][j]['members'][j]) as User);
          print('user1....');

        }
        print('subtask1....');

        print(subTaskss[0]!.title as String);
        print(ta['title']);

        taskmodel=Task(
            title:ta['title'] as String ,
            description: ta['description'] as String,
            start_date: ta['start_date'] as String,
            end_date: ta['end_date']  as String ,
            status_id: ta['status_id'] ,
            subtasks: subTaskss


        );

      }

      print('main task');

      print('yask mmmm');
      print(taskmodel);
    }
    return taskmodel;




  }

}
