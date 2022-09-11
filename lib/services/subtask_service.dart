import 'dart:convert';

import 'package:get_storage/get_storage.dart';

import '../config/server_config.dart';
import '../models/subtask_model.dart';
import '../models/subtask_task_status_model.dart';
import '../models/user_model.dart';

import 'package:http/http.dart' as http;
class  SubTaskService {
  //priority id to name
  static Map<dynamic,String> priority={};
  //status id to name
  static Map<dynamic,String> suStatu={};
  //priority name to id
  static Map<String,int> idMap={};
  //status name to id
  static Map<String,int> idMapp={};
  //list of priority names
  static List<String> st=[];
  //list of status names
  static List<String> stt=[];
  //the function to fill the whole subtask status thing*********************************************
  static Future<List<StatusModel>> subSt() async{
    List<StatusModel> states=[];
    var url=ServerConfig.domainName+ServerConfig.showSubStatuses;
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
      idMapp[states[i].name!]=states[i].id;
      if(!stt.contains(states[i].name!))
        stt.add(states[i].name!);
    }
    print(suStatu[1]);

print('well');
    return states;
  }
  //the function to fill the whole subtask priority thing*******************************************
  static Future<List<StatusModel>> subPr() async{
    List<StatusModel> states=[];
    var url=ServerConfig.domainName+ServerConfig.showSubPriorites;
    var response =await http.get(Uri.parse(url),headers: {
      'Authorization':'Bearer  ${GetStorage().read('token')}',
      'Accept':'application/json',
    },);
    List<dynamic> s = jsonDecode(response.body);
    print(response.statusCode);
    // message=smeeting['message'];
    print(s[0]["id"]);
    for (var i=0; i<s.length ;i++)//var t in jsonData
        {
      states.add( StatusModel.fromJson(s[i]));
      priority[states[i].id]=states[i].name!;
      idMap[states[i].name!]=states[i].id;
      if(!st.contains(states[i].name!))
        st.add(states[i].name!);
    }
    print(priority[0]);

    return states;
  }
  //to delete subtask******************************************************************************
 static Future deleteSubtask(int id) async{

    var url=ServerConfig.domainName+'api/leader/task/1/subtask/delete/$id';
    var response=await http.delete(Uri.parse(url),headers: {
      'Authorization':'Bearer  ${GetStorage().read('token')}',
      'Accept':'application/json',
    });
    print(response.statusCode);
    var body=jsonDecode(response.body);
    print(body);
    return response.statusCode.toString();
  }
  //to showSubtask**********************************************************************************
  static Future<ModelSubTask> showSubtask(var sId) async{
  User user;
  List<User> sMembers=[];
  ModelSubTask modelSubTask;
    var url=ServerConfig.domainName+ServerConfig.showSubtask+sId.toString();
    var response=await http.get(Uri.parse(url),headers: {
      'Authorization':'Bearer  ${GetStorage().read('token')}',
      'Accept':'application/json',
    });
  print(response.statusCode);
    var body=jsonDecode(response.body);
    print(body);
  print(body["the info about subtask"][0]["members"]);

        if(body["the info about subtask"][0]["members"].length!=0)
          {

            for(int i=0;i<body["the info about subtask"][0]["members"].length;i++)
              {
                if(body["the info about subtask"][0]["members"][i]["img_profile"]==null)
                  {
                    user=User(
                      id: body["the info about subtask"][0]["members"][i]["id"]
                    );
                    sMembers.add(user);
                  }
                else if(body["the info about subtask"][0]["members"][i]["img_profile"]!=null)
                  {print('0');
                    user=User(
                        id: body["the info about subtask"][0]["members"][i]["id"],
                        img_profile:body["the info about subtask"][0]["members"][i]["img_profile"] as String );
                    sMembers.add(user);
                    print('e');
                  }
              }

        }

      modelSubTask=ModelSubTask(id: body["the info about subtask"][0]["id"],
      title:body["the info about subtask"][0]["title"] as String,
      description:  body["the info about subtask"][0]["description"] as String,
        priority_id: body["the info about subtask"][0]["priority_id"] ,
        status_id:body["the info about subtask"][0]["status_id"],
        users: sMembers,
        start_at: body["the info about subtask"][0]["start_at"]as String,
        end_at: body["the info about subtask"][0]["end_at"] as String,

      );

      return modelSubTask;

}
  //to addSubtask***********************************************************************************
  static Map<String,dynamic> requestBody={};
  static Future addSub(ModelSubTask modelSubTask) async {
    requestBody["title"]=modelSubTask.title ;
    requestBody["description"]=modelSubTask.description ;
    requestBody["end_at"]=modelSubTask.end_at;
    requestBody["start_at"]=modelSubTask.start_at;
    requestBody["priority_id"]=modelSubTask.priority_id.toString();
    requestBody["status_id"]=modelSubTask.status_id.toString();
    for(int i=0;i<modelSubTask.participants!.length;i++)
    {
    requestBody["user_list[$i]"]=modelSubTask.participants![i].toString();
    }
    var url=ServerConfig.domainName+'api/leader/task/${modelSubTask.task_id.toString()}/subtask/create';
    var response =await http.post(Uri.parse(url),
      body: requestBody,
      headers: {
        'Authorization':'Bearer  ${GetStorage().read('token')}',
        'Accept':'application/json',
      },);
    Map<String, dynamic> a = jsonDecode(response.body);
    print(response.statusCode);
    print(a['message']);
    if(response.statusCode==422)
      print(a['errors']);
    return response.statusCode.toString();
  }
  static var v;
  //member edition thing
  static Future<String> memberEditSubtask(var id)async{
    var url=ServerConfig.domainName+'api/member/task/4/subtask/update/50';
    var response =await http.post(Uri.parse(url),
      body: {
        "status_id":id.toString()
      },
      headers: {
        'Authorization':'Bearer  ${GetStorage().read('token')}',
        'Accept':'application/json',
      },);
    v=response.statusCode.toString();
    return v;
  }
  //leader edition thing
  static Map<String,dynamic> requestbody={};
  static Future   editSub(ModelSubTask modelSubTask) async {
    requestbody["title"]=modelSubTask.title ;
    requestbody["description"]=modelSubTask.description ;
    requestbody["end_at"]=modelSubTask.end_at;
    requestbody["start_at"]=modelSubTask.start_at;
    requestbody["priority_id"]=modelSubTask.priority_id.toString();
    requestbody["status_id"]=modelSubTask.status_id.toString();
    for(int i=0;i<modelSubTask.participants!.length;i++)
    {
      requestbody["user_list[$i]"]=modelSubTask.participants![i].toString();
    }
    var url=ServerConfig.domainName+'api/leader/task/${modelSubTask.task_id.toString()}/subtask/update/${modelSubTask.id.toString()}';
    var response =await http.post(Uri.parse(url),
      body: requestbody,
      headers: {
        'Authorization':'Bearer  ${GetStorage().read('token')}',
        'Accept':'application/json',
      },);
    Map<String, dynamic> a = jsonDecode(response.body);
    print(response.statusCode);
    print(a['message']);
    if(response.statusCode==404)
      print(a['errors']);
    return response.statusCode.toString();
  }


}