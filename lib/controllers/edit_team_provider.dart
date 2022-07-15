import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:tracker/models/team_model.dart';
import 'package:tracker/services/team_service.dart';
class EditTeamProvider extends ChangeNotifier{
  TeamModel? modelTeam;
  TextEditingController teamName=TextEditingController();
  TextEditingController teamId=TextEditingController();
  Future onEditTeam()async{
    TeamModel teamModel =TeamModel(name: teamName.text,id: teamId.text );
    modelTeam= await TeamService.editTeam(teamModel);
  }

}
