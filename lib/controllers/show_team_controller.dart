import 'package:flutter/material.dart';

import 'package:tracker/services/team_service.dart';
import 'package:provider/provider.dart';

import '../models/showTeamModel.dart';
class ShowTeamController extends ChangeNotifier{
  //****
  var teamModel;
  var tm;
  var t;
  Future<ShowTeamModel> fetchTeam(var id) async{
    teamModel=await TeamService.showTeam(id);
   return await TeamService.showTeam(id);

  }

  Future<ShowTeamModel> fetchMyTeam() async{
    tm=await TeamService.showTeamM();
    return await TeamService.showTeamM();

  }

  Future<ShowTeamModel> fetchLyTeam() async{
    t=await TeamService.showTeamL();
    return await TeamService.showTeamL();
  }
}