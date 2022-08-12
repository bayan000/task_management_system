import 'package:flutter/material.dart';
import 'package:tracker/models/meetingStates.dart';

import 'package:tracker/services/meeting_service.dart';
import 'package:provider/provider.dart';

import '../models/meetingModel.dart';
class MeetingsController extends ChangeNotifier{

  String? message;

  var meetingState;
var statesMap;
var meeting;
  List<MeetingModel> meet=[];
  Future<List<MeetingModel>> fetchMeetings() async
  {
    await fetchMeetingStates();
    meet=await MeetingService.showMeetings();
    return await MeetingService.showMeetings();

  }
  //**
  Future<List<MeetingModel>> fetchLeMeetings() async
  {
    await fetchMeetingStates();
    meet=await MeetingService.showLeMeetings();
    return await MeetingService.showLeMeetings();

  }
  Future<List<MeetingStates>> fetchMeetingStates() async
  {
    await MeetingService.meetingStates();
    statesMap=await MeetingService.map;
    return await MeetingService.meetingStates();
  }
  //**
  Future<MeetingModel> fetchMeeting(var id) async
  {
    await fetchMeetingStates();
    statesMap=await MeetingService.map;
    meeting=await MeetingService.showMeeting(id);
    return meeting;

  }

 Future getStateById(var id) async{
    await MeetingService.meetingState(id);
    meetingState=await MeetingService.stateNamee;
  }



 Future deletion(int id) async{
    message= await MeetingService.deleteMeeting(id);
    for (var m in meet) {
      if (m.id == id) {
        meet.remove(id);
        notifyListeners();
        break;
      }
    }
    return message;
  }
}