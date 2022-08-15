import 'dart:collection';

import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:tracker/models/subtask_model.dart';
import 'package:tracker/services/meeting_service.dart';

import '../models/subtask_task_status_model.dart';
import '../models/user_model.dart';
import '../services/subtask_service.dart';
import '../services/user_service.dart';
class AddSubtaskProvider extends ChangeNotifier{
  List<User> list_of_Users = [];
  ModelSubTask? modelSubTask;
  var priorities;
  var substates;
  var statesMap;
  var stateId;
  var stateeee;
  var state;
  var priority;
  var proiorityMap;
  var proiorityId;
  var proiorityyyy;
  var message;
  String? tit;
  String? des;
  TextEditingController title=TextEditingController();
  TextEditingController description=TextEditingController();
  String? start;
  String? end;
  List<int> l=[];
  static List<String> st=[];

  static List<String> stt=[];
  changeDOM(var dodo)
  {
    start=dodo.toString();
    notifyListeners();

  }
  changeS(var value){
    stateeee=value;

    notifyListeners();
  }
  changepro(var value){
    proiorityyyy=value;

    notifyListeners();
  }
  printDOM()
  {
    return start.toString();
  }
  changeEO(var dodo)
  {
    end=dodo;
    notifyListeners();

  }
  printEO()
  {
    return end;
  }
Future delete()async{
    await SubTaskService.deleteSubt();
}
  Future onEditS()async{
    // ModelSubTask modelSubTas=[] as ModelSubTask;
    await SubTaskService.editSub();
/*
    MeetingModel meetingModel =MeetingModel(
        meeting_date: dateOfMeetingg ,
        start_at: timeOfMeeting ,

        participant_list: l
    );
    for(int i=0;i<l.length;i++)
    {
      map["participant_list[$i]"]=l.toString();
    }
    message =await   MeetingService.addMeeting(meetingModel);*/

  }
Future<String> memEdS()async{
  return  await SubTaskService.memberEditSubtask();
}
  Future onAddS()async{
   // ModelSubTask modelSubTas=[] as ModelSubTask;
    await SubTaskService.addSub();
/*
    MeetingModel meetingModel =MeetingModel(
        meeting_date: dateOfMeetingg ,
        start_at: timeOfMeeting ,

        participant_list: l
    );
    for(int i=0;i<l.length;i++)
    {
      map["participant_list[$i]"]=l.toString();
    }
    message =await   MeetingService.addMeeting(meetingModel);*/

  }
  Future<List<StatusModel>> fetchPriorites() async
  {
    await SubTaskService.subPr();
    proiorityId=await SubTaskService.idMap;
    priorities=await SubTaskService.priority;
    st=await MeetingService.st;
    return await SubTaskService.subPr();
  }
  Future<List<StatusModel>> fetchStates() async
  {
    await SubTaskService.subSt();
    stateId=await SubTaskService.idMapp;
    substates=await SubTaskService.suStatu;
    stt=await SubTaskService.stt;
    print(substates);
    print('kkk');
    return await SubTaskService.subSt();
  }
}