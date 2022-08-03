import 'package:flutter/material.dart';

import 'package:tracker/services/team_service.dart';
import 'package:provider/provider.dart';

import '../models/showTeamModel.dart';
class ShowTeamController extends ChangeNotifier{
  //****
  var teamModel;
  Future<ShowTeamModel> fetchTeam(var id) async{
    teamModel=await TeamService.showTeam(id);
   return await TeamService.showTeam(id);

  }

}