import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:tracker/models/meetingModel.dart';

import '../config/server_config.dart';
import 'package:http/http.dart' as http;

import '../models/user_model.dart';
class MeetingService{
  static var message;
  static var emessage;
  //****************
 // static var partiNames = <dynamic, dynamic>{};
  static List<String>? names;
  static int id=0;
  static var meeting_states;

  //add meeting function *********************************
  static Future   addMeeting(MeetingModel meetingModel) async {
    var url=ServerConfig.domainName+ServerConfig.addMeeting;
    var response =await http.post(Uri.parse(url),body: {
      "meeting_date":meetingModel.meeting_date ,
      "start_at":meetingModel.start_at ,
      "participant_list[$id]":"2"
    },headers: {
      'Authorization':'Bearer  ${GetStorage().read('token')}',
      'Accept':'application/json',
    },);
    Map<String, dynamic> ameeting = jsonDecode(response.body);
    print(response.statusCode);
    message=ameeting['message'];
    print(message);
    return MeetingModel.fromJson(ameeting['0']);
  }

//edit meeting function *********************************
static MeetingModel? mm;
//  static Meeting? mee;
  static Future   editMeeting(MeetingModel meetingModel) async {
//meetingModel.participants?[0]=User(id:1);
    meetingModel.id=8;
    var url=ServerConfig.domainName+ServerConfig.editMeeting+meetingModel.id.toString();
    var response =await http.post(Uri.parse(url),body: {
      "meeting_date":meetingModel.meeting_date ,
      "start_at":meetingModel.start_at ,
      "meeting_statuses_id":meetingModel.meeting_status.toString(),
      "participant_list[$id]":"2"
    },headers: {
      'Authorization':'Bearer  ${GetStorage().read('token')}',
      'Accept':'application/json',
    },);
    Map<String, dynamic> emeeting = jsonDecode(response.body);
    print(response.statusCode);

   // message=emeeting['message'];
    //print(message);

    print(emeeting['Updating successfully']);
    print(emeeting['with']);
   // mee=Meeting.fromJson(emeeting['Updating successfully']);

    return response.statusCode.toString();
  }

  //get meeeing states*********
static Future meetingStates() async{
  var url=ServerConfig.domainName+ServerConfig.meetingStates;
  var response =await http.post(Uri.parse(url),headers: {
    'Authorization':'Bearer  ${GetStorage().read('token')}',
    'Accept':'application/json',
  },);
  Map<String, dynamic> smeeting = jsonDecode(response.body);
  print(response.statusCode);
  message=smeeting['message'];
  print(message);
  return MeetingModel.fromJson(smeeting['0']);
}
  }
