import 'package:flutter/material.dart';
import 'package:tracker/models/team_model.dart';
import 'package:tracker/services/team_service.dart';
import 'package:provider/provider.dart';
class TeamsController extends ChangeNotifier{
  //****
  String? message;
  List<TeamModel> teams=[];
  Future<List<TeamModel>> fetchTeams() async{
    teams=await TeamService.showTeams();
    return await TeamService.showTeams();
  }
  Future deletion(int id) async{
    message= await TeamService.deleteTeam(id);
    for (var t in teams) {
      if (t.id == id) {
        teams.remove(id);
        notifyListeners();
        break;
      }
    }
    return message;
  }
}