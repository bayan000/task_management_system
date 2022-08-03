import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:tracker/models/team_model.dart';
import 'package:tracker/services/team_service.dart';
class EditTeamProvider extends ChangeNotifier{
  TeamModel? modelTeam;
  var message;
  TextEditingController teamName=TextEditingController();
  var teamId;
  void setTeamId(var id ){
    teamId=id;
  }
  Future onEditTeam()async{
    TeamModel teamModel =TeamModel(name: teamName.text,id: teamId);
    modelTeam= await TeamService.editTeam(teamModel);
    message =await TeamService.emessage;
  }

}
