import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:tracker/models/team_model.dart';
import 'package:tracker/services/team_service.dart';
class AddTeamProvider extends ChangeNotifier{
  TeamModel? modelTeam;
  TextEditingController teamName=TextEditingController();
  Future onAddTeam()async{
    TeamModel teamModel =TeamModel(name: teamName.text);
    modelTeam= await TeamService.addTeam(teamModel);
  }

}
