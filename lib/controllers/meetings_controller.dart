import 'package:flutter/material.dart';
import 'package:tracker/models/meetingStates.dart';

import 'package:tracker/services/meeting_service.dart';
import 'package:provider/provider.dart';

import '../models/meetingModel.dart';
class MeetingsController extends ChangeNotifier{

  String? message;

  var meetingState;
var statesMap;
  Future<List<MeetingModel>> fetchMeetings() async
  {
    await fetchMeetingStates();
    statesMap=await MeetingService.map;
    return await MeetingService.showMeetings();

  }

 Future getStateById(var id) async{
    await MeetingService.meetingState(id);
    meetingState=await MeetingService.stateNamee;
  }

  Future<List<MeetingStates>> fetchMeetingStates() async
  {
    return await MeetingService.meetingStates();
  }

 Future deletion(int id) async{
    message= await MeetingService.deleteMeeting(id);
    return message;
  }
}