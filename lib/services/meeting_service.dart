import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:tracker/models/meetingModel.dart';
import 'package:tracker/models/meetingStates.dart';

import '../config/server_config.dart';
import 'package:http/http.dart' as http;
import '../models/user_model.dart';
class MeetingService{
  static var message;
  static var emessage;
  static List<String>? names;
 static int id=1;
  static var meeting_states;
  //add meeting function *********************************
   static MeetingModel? m;
   static Map<String,String> ss={};
   static Future   addMeeting(MeetingModel meetingModel) async {


    ss["meeting_date"]=meetingModel.meeting_date.toString() ;
    ss [ "start_at"]=meetingModel.start_at.toString() ;
    print('hi');
    print(ss["meeting_date"]);
    print(ss["start_at"]);
    if(meetingModel.participant_list?.length!=0)
    {
      for(int i=0;i<meetingModel.participant_list!.length;i++)
      {
        ss["participant_list[$i]"]=meetingModel.participant_list![i].toString();
      }
    }

    print(ss["participant_list[$id]"]);
    print(meetingModel.participant_list?.length.toString());
    var url=ServerConfig.domainName+ServerConfig.addMeeting;
    var response =await http.post(Uri.parse(url),
      body: ss,
      headers: {
        'Authorization':'Bearer  ${GetStorage().read('token')}',
        'Accept':'application/json',
      },);
    Map<String, dynamic> emeeting = jsonDecode(response.body);
    print(response.statusCode);
    print(emeeting['Updating successfully']);
    print(emeeting['with']);
    if(response.statusCode==422)
      print(emeeting['errors']);
    return response.statusCode.toString();
  }
//edit meeting function **********************************
  static MeetingModel? mm;
  static Map<String,String> s={};
  static Future   editMeeting(MeetingModel meetingModel) async {
    s["meeting_date"]=meetingModel.meeting_date.toString() ;
    s [ "start_at"]=meetingModel.start_at.toString() ;
    s[ "meeting_statuses_id"] =meetingModel.meeting_status.toString();
    if(meetingModel.participant_list?.length!=0)
      {
        for(int i=0;i<meetingModel.participant_list!.length;i++)
          {
            s["participant_list[$i]"]=meetingModel.participant_list![i].toString();
          }
      }
    print(meetingModel.participant_list?.length.toString());
    var url=ServerConfig.domainName+ServerConfig.editMeeting+meetingModel.id.toString();
    var response =await http.post(Uri.parse(url),
      body: s,
      headers: {
      'Authorization':'Bearer  ${GetStorage().read('token')}',
      'Accept':'application/json',
    },);
    Map<String, dynamic> emeeting = jsonDecode(response.body);
    print(response.statusCode);
    print(emeeting['Updating successfully']);
    print(emeeting['with']);
if(response.statusCode==500)
  print(emeeting['errors']);
    return response.statusCode.toString();
  }
  //get meeting states************************************
 static Map<dynamic,String> map={};
  static Map<String,int> idMap={};
  static List<String> st=[];
static Future<List<MeetingStates>> meetingStates() async{
  List<MeetingStates> states=[];
  var url=ServerConfig.domainName+ServerConfig.meetingStates;
  var response =await http.get(Uri.parse(url),headers: {
    'Authorization':'Bearer  ${GetStorage().read('token')}',
    'Accept':'application/json',
  },);
  List<dynamic> smeeting = jsonDecode(response.body);
  print(response.statusCode);
 // message=smeeting['message'];
  print(smeeting[0]["id"]);
  for (var i=0; i<smeeting.length ;i++)//var t in jsonData
      {
    states.add( MeetingStates.fromJson(smeeting[i]));
    map[states[i].id]=states[i].name!;
    idMap[states[i].name!]=states[i].id;
    if(!st.contains(states[i].name!))
    st.add(states[i].name!);
  }
  print(map[0]);

  return states;
}
//get meeting state****************************************
  static var stateNamee;
  static Future<String> meetingState(var id) async{
    var namee;
    var url=ServerConfig.domainName+ServerConfig.stateName+id.toString();
    var response =await http.get(Uri.parse(url),headers: {
      'Authorization':'Bearer  ${GetStorage().read('token')}',
      'Accept':'application/json',
    },);
    Map<String,dynamic> body= jsonDecode(response.body);
    print(response.statusCode);
    namee =MeetingStates.fromJson(body);
    print(namee.name);
    stateNamee=namee.name;
   // print(stateNamee);
    return namee.name;

  }
//get leaders meeetings************************************
  static Future<List<MeetingModel>> showLeMeetings() async{
    List<MeetingModel> meetings=[];
    User user;
    List<User> mMembers=[];
    MeetingModel meetingModel;
    var url=ServerConfig.domainName+ServerConfig.showMeetings;
    var response=await http.get(Uri.parse(url),headers: {
      'Authorization':'Bearer  ${GetStorage().read('token')}',
      'Accept':'application/json',
    });
    print(response.statusCode);
    var body=jsonDecode(response.body);
    // body[1][i]["meeting_date"]
    print(body[1][0]["meeting_date"]);

   // print(body[1][1]["meeting_date"]);//this one leads to nothing

    for (var i=1; i<body.length ;i++)
    {


      for (var j=0; j<body[i][0]["users"].length ;j++)
      {
      if(body[i][0]["users"][j]["leaders"].length !=0)
      {
        if(body[i][0]["users"][j]["leaders"][0]["img_profile"] !=null)
        {
          user=User(first_name: body[i][0]["users"][j]["first_name"] as String,
            last_name: body[i][0]["users"][j]["last_name"] as String,
            img_profile: body[i][0]["users"][j]["leaders"][0]["img_profile"] as String,
          );
          mMembers.add(user);
          print('hi');
        }
        //   if(body[1][i]["users"][j]["leaders"][0]["img_profile"] ==null)
       else if(body[i][0]["users"][j]["leaders"][0]["img_profile"]==null)
        {   print('hit');
          user=User(first_name: body[i][0]["users"][j]["first_name"] as String,
            last_name: body[i][0]["users"][j]["last_name"] as String,
          );
          mMembers.add(user);
        }
      }
      else if(body[i][0]["users"][j]["members"].length !=0)
      {
print('members');
        if(body[i][0]["users"][j]["members"][0]["img_profile"] !=null)
        {
          print('member');
          user=User(first_name: body[i][0]["users"][j]["first_name"] as String,
            last_name: body[i][0]["users"][j]["last_name"] as String,
            img_profile: body[i][0]["users"][j]["members"][0]["img_profile"] as String,
          );
          print(body[i][0]["users"][j]["first_name"] as String);
          print(body[i][0]["users"][j]["last_name"] as String);
          print(body[i][0]["users"][j]["members"][0]["img_profile"] as String);


          mMembers.add(user);
        }
        else if(body[i][0]["users"][j]["members"][0]["img_profile"] ==null)
        {
          print('membersss');
          user=User(first_name: body[i][0]["users"][j]["first_name"] as String,
            last_name: body[i][0]["users"][j]["last_name"] as String,
          );

          print('membersss');
          mMembers.add(user);
          print('membersss');
        }


      }


      }

      meetingModel=MeetingModel(

          meeting_date: body[i][0]["meeting_date"] as String,
          start_at:  body[i][0]["start_at"] as String,
          meeting_status: body[i][0]["meeting_statuses_id"],
          id:body[i][0]["id"],
          participants: mMembers
      );

      meetings.add(meetingModel);
      mMembers=[];
    }
    return meetings;
  }
//get meetings*********************************************
static Future<List<MeetingModel>> showMeetings() async{
  List<MeetingModel> meetings=[];
  User user;
  List<User> mMembers=[];
  MeetingModel meetingModel;
    var url=ServerConfig.domainName+ServerConfig.showMeetings;
    var response=await http.get(Uri.parse(url),headers: {
      'Authorization':'Bearer  ${GetStorage().read('token')}',
      'Accept':'application/json',
    });
  print(response.statusCode);
    var body=jsonDecode(response.body);
    print(body);

    for (var i=0; i<body.length ;i++)
    {


      for (var j=0; j<body[i]["users"].length ;j++)
        {
          if(body[i]["users"][j]["leaders"].length !=0)
          {
              if(body[i]["users"][j]["leaders"][0]["img_profile"] !=null)
                {
                  user=User(first_name: body[i]["users"][j]["first_name"] as String,
                    last_name: body[i]["users"][j]["last_name"] as String,
                    img_profile: body[i]["users"][j]["leaders"][0]["img_profile"] as String,
                  );
                  mMembers.add(user);
                }
              else if(body[i]["users"][j]["leaders"][0]["img_profile"] ==null)
           {
             user=User(first_name: body[i]["users"][j]["first_name"] as String,
               last_name: body[i]["users"][j]["last_name"] as String,
             );
             mMembers.add(user);
           }
          }
          else if(body[i]["users"][j]["members"].length !=0)
          {

            if(body[i]["users"][j]["members"][0]["img_profile"] !=null)
              {
                user=User(first_name: body[i]["users"][j]["first_name"] as String,
                  last_name: body[i]["users"][j]["last_name"] as String,
                  img_profile: body[i]["users"][j]["members"][0]["img_profile"] as String,
                );
                mMembers.add(user);
              }
            else if(body[i]["users"][j]["members"][0]["img_profile"] ==null)
              {
                user=User(first_name: body[i]["users"][j]["first_name"] as String,
                  last_name: body[i]["users"][j]["last_name"] as String,
                );
                mMembers.add(user);
              }


          }


        }

      meetingModel=MeetingModel(

        meeting_date: body[i]["meeting_date"] as String,
        start_at:  body[i]["start_at"] as String,
        meeting_status: body[i]["meeting_statuses_id"],
        id:body[i]["id"],
        participants: mMembers
      );

      meetings.add(meetingModel);
      mMembers=[];
    }
    return meetings;
}
//delete a meeting*****************************************
  static Future<MeetingModel> showMeeting(var id) async{
  User user;
  List<User> mMembers=[];
  MeetingModel meetingModel;
    var url=ServerConfig.domainName+ServerConfig.showMeeting+id.toString();
    var response=await http.get(Uri.parse(url),headers: {
      'Authorization':'Bearer  ${GetStorage().read('token')}',
      'Accept':'application/json',
    });
  print(response.statusCode);
    var body=jsonDecode(response.body);
    print(body);


      for (var j=0; j<body[0]["users"].length ;j++)
        {
          if(body[0]["users"][j]["leaders"].length !=0)
          {
              if(body[0]["users"][j]["leaders"][0]["img_profile"] !=null)
                {
                  user=User(first_name: body[0]["users"][j]["first_name"] as String,
                    last_name: body[0]["users"][j]["last_name"] as String,
                    img_profile: body[0]["users"][j]["leaders"][0]["img_profile"] as String,
                  );
                  mMembers.add(user);
                }
              else if(body[0]["users"][j]["leaders"][0]["img_profile"] ==null)
           {
             user=User(first_name: body[0]["users"][j]["first_name"] as String,
               last_name: body[0]["users"][j]["last_name"] as String,
             );
             mMembers.add(user);
           }
          }
          else if(body[0]["users"][j]["members"].length !=0)
          {

            if(body[0]["users"][j]["members"][0]["img_profile"] !=null)
              {
                user=User(first_name: body[0]["users"][j]["first_name"] as String,
                  last_name: body[0]["users"][j]["last_name"] as String,
                  img_profile: body[0]["users"][j]["members"][0]["img_profile"] as String,
                );
                mMembers.add(user);
              }
            else if(body[0]["users"][j]["members"][0]["img_profile"] ==null)
              {
                user=User(first_name: body[0]["users"][j]["first_name"] as String,
                  last_name: body[0]["users"][j]["last_name"] as String,
                );
                mMembers.add(user);
              }


          }


        }

      meetingModel=MeetingModel(

        meeting_date: body[0]["meeting_date"] as String,
        start_at:  body[0]["start_at"] as String,
        meeting_status: body[0]["meeting_statuses_id"],
        id:body[0]["id"],
        participants: mMembers
      );
print(meetingModel.meeting_date);
     return meetingModel;
}
// get a specific meeting**********************************
static Future deleteMeeting(int id) async{

    var url=ServerConfig.domainName+ServerConfig.deleteMeeting+id.toString();
    var response=await http.delete(Uri.parse(url),headers: {
      'Authorization':'Bearer  ${GetStorage().read('token')}',
      'Accept':'application/json',
    });
    print(response.statusCode);
    var body=jsonDecode(response.body);
    print(body);
    return response.statusCode.toString();
  }

  }
