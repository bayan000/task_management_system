import 'package:tracker/models/team_model.dart';
import 'package:tracker/services/team_service.dart';
class TeamsController {
  Future<List<TeamModel>> fetchTeams() async{
    return TeamService.showTeams();
  }
}