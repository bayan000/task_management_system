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
  // map[id]=name
  static Map<dynamic,String> suStatu={};
  //map[name]=id
  static Map<String,int> idMap={};
  static List<String> st=[];
  static List<String> stt=[];





  static Future<List<StatusModel>> subSt() async{

    List<StatusModel> states=[];

    var response =await http.get(Uri.parse(ServerConfig.domainName+ServerConfig.showAllStatus),

      headers: {
        'Authorization':'Bearer  ${GetStorage().read('token')}',
        'Accept':'application/json',
      },
    );
    List<dynamic> s = jsonDecode(response.body);

    print(response.statusCode);

    print(s[0]["id"]);
    for (var i=0; i<s.length ;i++)//var t in jsonData
        {
      states.add( StatusModel.fromJson(s[i]));

      suStatu[states[i].id]=states[i].name!;

      print(' suStatu[states[0].id]  :');
      print( suStatu[states[0].id]);

      idMap[states[i].name!]=states[i].id;
      print('  idMap[states[i].name!] :');

      print( idMap[states[i].name!]);
      print('here');

      if(!states.contains(states[i].name) ){

        stt.add(states[i].name!);
      }




    }
    print(suStatu[1]);
    print(stt);
    print('well');
    print(st);
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

    print(response.statusCode);


    for(var us in json ){
      print(us);
      models.add(Task.fromJson(us));}

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


  static Future  servToDoTasks()async{

    var response = await http.get(Uri.parse(ServerConfig.domainName +'api/show/todo/tasks')
        ,
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer ${GetStorage().read(
              'token')}',
          'Accept': 'application/json'
        });


    Map<String,dynamic> json = jsonDecode(response.body);

    print(response.statusCode);

    List<Task> models = [];




    for(var ta in  json['to to tasks']){
      print(ta['id']);
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



  static Future  serTesty(int id)async{
    ModelSubTask  sub;
    List<ModelSubTask> list_subtaskT=[];
    Task taslModel;


    var response= await http.get(Uri.parse(ServerConfig.domainName+ServerConfig.showOneTask+'${id}'),
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer ${GetStorage().read(
              'token')}',
          'Accept': 'application/json'
        });

    var body=jsonDecode(response.body);
    print(response.statusCode);


    print(body['the info about task'][0]["subtasks"]);
    print(body['the info about task'][0]["subtasks"].length);

    for (var j=0; j<body['the info about task'][0]["subtasks"].length ;j++){

      sub=ModelSubTask(
          title:body['the info about task'][0]["subtasks"][j]['title'] as String,
          description:body['the info about task'][0]["subtasks"][j]['description'] as String ,
          start_at:body['the info about task'][0]["subtasks"][j]['start_at'] as String ,
          id:body['the info about task'][0]["subtasks"][j]['id'],
          end_at:body['the info about task'][0]["subtasks"][j]['end_at'] as String ,
          priority_id:body['the info about task'][0]["subtasks"][j]['priority_id'] ,
          status_id:body['the info about task'][0]["subtasks"][j]['status_id'] ,
          task_id:body['the info about task'][0]["subtasks"][j]['task_id']
      );
      list_subtaskT.add(sub);



    }



    taslModel=Task(
        title: body['the info about task'][0]['title'] as String ,
        description:body['the info about task'][0]['description'] as String ,
        end_date:body['the info about task'][0]['end_date'] as String,
        start_date:body['the info about task'][0]['start_date'] as String,
        status_id: body['the info about task'][0]['status_id']  ,
        id:body['the info about task'][0]['id'],
        subtasks:list_subtaskT


    );


    return taslModel;





  }



//***************************Leader*****************************
  //-------------------------Leader Show ALL Task ---------------------

  static Future lAllTasks()async{

    var response = await http.get(Uri.parse(ServerConfig.domainName + ServerConfig.showTasks)
        ,
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer ${GetStorage().read(
              'token')}',
          'Accept': 'application/json'
        });


    var json = jsonDecode(response.body);


    List< Task > models = [];

    print(response.statusCode);


    for(var us in json['my task'] ){

      models.add(Task.fromJson(us));}

    return models;




  }





  //-----------------TO DO TASK------------------

  static Future  lToDoTasks()async{

    var response = await http.get(Uri.parse(ServerConfig.domainName+'api/show/todo/tasks')
        ,
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer ${GetStorage().read(
              'token')}',
          'Accept': 'application/json'
        });


    Map<String,dynamic> json = jsonDecode(response.body);
    print('todo');
    print(response.statusCode);
    print(json);
    print('todo list');
    print(json["to do tasks"]);
    List<Task> models_todo = [];

    for(var ta in  json["to do tasks"]){
      print(ta['id']);
      models_todo.add(Task.fromJson(ta));}
    print(models_todo);
    if(models_todo != null) {
      return models_todo;
    }
    else{
      return [];
    }










  }

}
