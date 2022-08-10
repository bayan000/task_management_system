import 'dart:collection';
//import 'dart:html';

import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:tracker/models/meetingModel.dart';
import 'package:tracker/services/meeting_service.dart';

import '../models/meetingStates.dart';
import '../models/user_model.dart';
import '../services/user_service.dart';
import '../shared/constants.dart';
class EditMeetingProvider extends ChangeNotifier{
  List<User> list_of_Users = [];
  MeetingModel? modelMeeting;
  var statesMap;
  var stateId;
  var stateeee;
  var message;
  String? dateOfMeetingg;
  TextEditingController dateOfMeeting=TextEditingController();
  //TextEditingController meetingTeam=TextEditingController();
  String? timeOfMeeting;
  var meetingStatus;
  List<User?> meetingWith=[];
  List<int> l=[];
  static List<String> st=[];
Map<String,String> map={};

  savingSelectedItems(HashSet<User> selectedItem){

  if(selectedItem.length!=0)
  {
    selectedItem.forEach((element) {l.add(element.id);});
    notifyListeners();
  }
  notifyListeners();
  }

  Future onEditMeeting(var id)async{

    MeetingModel meetingModel =MeetingModel(
        id: id,
        meeting_date: dateOfMeetingg ,
        start_at: timeOfMeeting ,
        meeting_status: stateeee.toString(),

       participant_list: l
      );
for(int i=0;i<l.length;i++)
  {
    map["participant_list[$i]"]=l.toString();
    //s["participant_list[$i]"]=meetingModel.participant_list![i].toString();
  }
      //print(meetingModel.participant_list?[0].toString);
      message =await   MeetingService.editMeeting(meetingModel);

  }

changeStatus(var value){
   stateeee=value;

   notifyListeners();
}
  changeDOM(var dodo)
  {
    dateOfMeetingg=dodo;
    notifyListeners();

  }
  printDOM()
  {
    return dateOfMeetingg;
  }
  changeTOM(var dodo)
  {
    timeOfMeeting=dodo;
    notifyListeners();

  }
  printTOM()
  {
    return timeOfMeeting;
  }
  Future<Map> fetchMeetingStates() async
  {
    await MeetingService.meetingStates();
    stateId=await MeetingService.idMap;
    statesMap=await MeetingService.map;
    st=await MeetingService.st;
    notifyListeners();
    return statesMap;

  }
Text datoO(Size size){
    if (dateOfMeetingg==null)
      {return Text('when is your meeting?',style: TextStyle(color: appFo,fontSize: size.width*0.045),);
      }
    else
      {return Text('$dateOfMeetingg',style: TextStyle(color: appFo,fontSize: size.width*0.045),);
}
}

  Future<List<User>> onClickShowAllUser() async {

    list_of_Users = await UserService.servAllUsaer();

    return list_of_Users;

  }
}