import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:tracker/models/meetingModel.dart';

import '../config/server_config.dart';
import 'package:http/http.dart' as http;
class MeetingService{
  static var message;
  static var emessage;
  static var partiNames = <dynamic, dynamic>{};
  static List<String>? names;
static int id=0;


  //add meeting function *********************************
  static Future   addMeeting(MeetingModel meetingModel) async {
    print('hey');
    var url=ServerConfig.domainName+ServerConfig.addMeeting;
    print('hey');
   // var map=Map()
    //var map = Map<dynamic, dynamic>{};
  //  print('hey');
   /* map["meeting_date"] =meetingModel.meeting_date;
    map["start_at"] =meetingModel.start_at ;
    map["meeting_statuses_id"] =meetingModel.meeting_statuses_id;
    map["participant_list"] =meetingModel.participant_list;*/
    //


    var response =await http.post(Uri.parse(url),body: {
      "meeting_date":meetingModel.meeting_date ,

      "start_at":meetingModel.start_at ,
      "meeting_statuses_id":meetingModel.meeting_statuses_id,

      "participant_list[$id]":"2"//meetingModel.participant_list
      /*
     // map
      "meeting_date":map["meeting_date"],
      "start_at":map["start_at"],
      "meeting_statuses_id":map["meeting_statuses_id"],
      "participant_list": map["participant_list"]*/
    },headers: {
      'Authorization':'Bearer  ${GetStorage().read('token')}',
      'Accept':'application/json',
    },);
    Map<String, dynamic> ameeting = jsonDecode(response.body);
    print(response.statusCode);
    message=ameeting['message'];
    print(message);
   //
   // partiNames[names]=ameeting['with']['first_name']+' '+ameeting['with']['last_name'];
   // print(partiNames[names]);
    return MeetingModel.fromJson(ameeting['0']);
  }

//edit meeting function *********************************
  /*static Future   editTeam(TeamModel teamModel) async {

    var url=ServerConfig.domainName+ServerConfig.editTeam+teamModel.id.toString();
    var response =await http.post(Uri.parse(url),body: {
      "name":teamModel.name
    },headers: {
      'Authorization':'Bearer  ${GetStorage().read('token')}',
      'Accept':'application/json',
    },);
    Map<String, dynamic> eteam = jsonDecode(response.body);
    print(response.statusCode);
    emessage=eteam['message'];
    return TeamModel.fromJson(eteam['0']);
  }
*/}