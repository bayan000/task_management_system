import 'dart:convert';

import 'package:get_storage/get_storage.dart';

import '../config/server_config.dart';
import '../models/subtask_model.dart';
import '../models/subtask_task_status_model.dart';
import '../models/user_model.dart';

import 'package:http/http.dart' as http;
class  SubTaskService {
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
  static Future<List<StatusModel>> subPr() async{
    List<StatusModel> states=[];
    var url=ServerConfig.domainName+'api/show3';
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

}