import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:tracker/models/meetingModel.dart';
import 'package:tracker/services/meeting_service.dart';

import '../models/user_model.dart';
import '../shared/constants.dart';
class EditMeetingProvider extends ChangeNotifier{
  MeetingModel? modelMeeting;
  var message;
  String? dateOfMeetingg;
  TextEditingController dateOfMeeting=TextEditingController();
  //TextEditingController meetingTeam=TextEditingController();
  String? timeOfMeeting;
  var meetingStatus;
 // TextEditingController timeOfMeeting=TextEditingController();
  //List<TextEditingController>? meetingWith;
  List<User>? meetingWith;
  Future onEditMeeting()async{

    var m=meetingWith;
    if(m==null){

      MeetingModel meetingModel =MeetingModel(meeting_date: dateOfMeetingg ,
        start_at: timeOfMeeting ,
        meeting_status: meetingStatus,

      );
      //modelMeeting= await MeetingService.editMeeting(meetingModel);
      //message =await MeetingService.message;
      message =await   MeetingService.editMeeting(meetingModel);
    }

   else if(m!=null){
      MeetingModel meetingModel =MeetingModel(meeting_date: dateOfMeetingg ,
        start_at: timeOfMeeting ,

        participants: (meetingWith as List<User>).toList(),
      );
    //  modelMeeting= await MeetingService.editMeeting(meetingModel);
     // message =await MeetingService.message;
      message =await   MeetingService.editMeeting(meetingModel);
    }
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
/*
 if(dateOfMeetingg==null)
d='when is your meeting?'
else
d=dateOfMeetingg

return d;

 */
Text datoO(Size size){
    if (dateOfMeetingg==null)
      {return Text('when is your meeting?',style: TextStyle(color: appFo,fontSize: size.width*0.045),);
      }
    else
      {return Text('$dateOfMeetingg',style: TextStyle(color: appFo,fontSize: size.width*0.045),);
}
}

}