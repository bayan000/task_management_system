import 'package:flutter/material.dart';
import 'package:tracker/models/team_model.dart';
import 'package:tracker/services/team_service.dart';
import 'package:provider/provider.dart';
class TeamsController extends ChangeNotifier{
  //****
  String? message;
  Future<List<TeamModel>> fetchTeams() async{
    return await TeamService.showTeams();
  }
  Future deletion(int id) async{
    message= await TeamService.deleteTeam(id);
    return message;
  }
}