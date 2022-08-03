import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:tracker/models/meetingModel.dart';
import 'package:tracker/services/meeting_service.dart';

import '../models/user_model.dart';
class AddMeetingProvider extends ChangeNotifier{
  MeetingModel? modelMeeting;
  var message;
  String? dateOfMeetingg;
  TextEditingController dateOfMeeting=TextEditingController();
  //TextEditingController meetingTeam=TextEditingController();
  String? timeOfMeeting;
 // TextEditingController timeOfMeeting=TextEditingController();
 // List<TextEditingController>? meetingWith;
  List<User?>? meetingWith;
  Future onAddMeeting()async{

    var m=meetingWith;
    if(m==null){

      MeetingModel meetingModel =MeetingModel(meeting_date: dateOfMeetingg ,
        start_at: timeOfMeeting ,

      );
      modelMeeting= await MeetingService.addMeeting(meetingModel);
      message =await MeetingService.message;
    }

   else if(m!=null){
      MeetingModel meetingModel =MeetingModel(meeting_date: dateOfMeetingg ,
        start_at: timeOfMeeting ,

        participants: (meetingWith as List<User>).toList(),
      );
      modelMeeting= await MeetingService.addMeeting(meetingModel);
      message =await MeetingService.message;
    }
  }

}
