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
  static Map<String,int> idMapp={};
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
      idMapp[states[i].name!]=states[i].id;
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
  static Future deleteSubt() async{

    var url=ServerConfig.domainName+'api/leader/task/9/subtask/delete/16'+"6";
    var response=await http.delete(Uri.parse(url),headers: {
      'Authorization':'Bearer  ${GetStorage().read('token')}',
      'Accept':'application/json',
    });
    print(response.statusCode);
    var body=jsonDecode(response.body);
    print(body);
    return response.statusCode.toString();

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


  static ModelSubTask? s;
  static Map<String,dynamic> ss={};
  static Future   addSub() async {
var id =0;

    ss["title"]='task 29' ;
    ss ["description"]='testing for task29' ;
    ss ["end_at"]='2022-12-05';
    ss [ "start_at"]='2022-09-10';
    //ss [ "description"]=modelSubTask.
    print('hi');
    ss["priority_id"]='1';
    ss["status_id"]='1';
    ss["user_list[$id]"]="4";
    /*if(meetingModel.participant_list?.length!=0)
    {
      for(int i=0;i<meetingModel.participant_list!.length;i++)
      {
        ss["participant_list[$i]"]=meetingModel.participant_list![i].toString();
      }
    }*/

   // print(ss["participant_list[$id]"]);
   // print(meetingModel.participant_list?.length.toString());
    var url=ServerConfig.domainName+'api/leader/task/1/subtask/create';
    var response =await http.post(Uri.parse(url),
      body: ss,
      headers: {
        'Authorization':'Bearer  ${GetStorage().read('token')}',
        'Accept':'application/json',
      },);
    Map<String, dynamic> a = jsonDecode(response.body);
    print(response.statusCode);
    print(a['message']);
   // print(emeeting['with']);
    if(response.statusCode==422)
      print(a['errors']);
    return response.statusCode.toString();
  }
  static var v;
  static Future<String> memberEditSubtask()async{
    var url=ServerConfig.domainName+'api/member/task/1/subtask/update/37';
    var response =await http.post(Uri.parse(url),
      body: {
        "status_id":"2"
      },
      headers: {
        'Authorization':'Bearer  ${GetStorage().read('token')}',
        'Accept':'application/json',
      },);
    v=response.statusCode.toString();
    return v;
  }
  static Future   editSub() async {
    var id =0;

    ss["title"]='testing testing 9' ;
    ss ["description"]='marketing test 9' ;
    ss ["end_at"]='2022-12-05';
    ss [ "start_at"]='2022-09-10';
    //ss [ "description"]=modelSubTask.
    print('hi');
    ss["priority_id"]='1';
    ss["status_id"]='1';
    ss["user_list[$id]"]="4";
    /*if(meetingModel.participant_list?.length!=0)
    {
      for(int i=0;i<meetingModel.participant_list!.length;i++)
      {
        ss["participant_list[$i]"]=meetingModel.participant_list![i].toString();
      }
    }*/

    // print(ss["participant_list[$id]"]);
    // print(meetingModel.participant_list?.length.toString());
    var url=ServerConfig.domainName+'api/leader/task/1/subtask/create';
    var response =await http.post(Uri.parse(url),
      body: ss,
      headers: {
        'Authorization':'Bearer  ${GetStorage().read('token')}',
        'Accept':'application/json',
      },);
    Map<String, dynamic> a = jsonDecode(response.body);
    print(response.statusCode);
    print(a['message']);
    // print(emeeting['with']);
    if(response.statusCode==422)
      print(a['errors']);
    return response.statusCode.toString();
  }


}