import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:tracker/models/team_model.dart';

import '../config/server_config.dart';
import 'package:http/http.dart' as http;
class TeamService{
 static var message;
 static var emessage;
  //add team function *********************************
  static Future   addTeam(TeamModel teamModel) async {

    var url=ServerConfig.domainName+ServerConfig.addTeam;
    //used parse to generate URI obj out of my string url
    var response =await http.post(Uri.parse(url),body: {
      "name":teamModel.name
    },headers: {
      'Authorization':'Bearer  ${GetStorage().read('token')}',
      'Accept':'application/json',
    },);
    Map<String, dynamic> ateam = jsonDecode(response.body);
    print(response.statusCode);
    message=ateam['message'];
    return TeamModel.fromJson(ateam['tha department:']);
    }

//edit team function *********************************
  static Future   editTeam(TeamModel teamModel) async {

    var url=ServerConfig.domainName+ServerConfig.editTeam+teamModel.id.toString();
    var response =await http.post(Uri.parse(url),body: {
      "name":teamModel.name
    },headers: {
      'Authorization':'Bearer  ${GetStorage().read('token')}',
      'Accept':'application/json',
    },);
    Map<String, dynamic> eteam = jsonDecode(response.body);
    print(response.statusCode);
    emessage=eteam['message'];
    return TeamModel.fromJson(eteam['0']);
  }

//show teams function *********************************
  //static List<TeamModel> teams=[];
  static var message1;

static Future<List<TeamModel>> showTeams() async{
  List<TeamModel> teams=[];
    var url=ServerConfig.domainName+ServerConfig.showTeams;
    var response=await http.get(Uri.parse(url),headers: {
      'Authorization':'Bearer  ${GetStorage().read('token')}',
      'Accept':'application/json',
    });
  print(response.statusCode);
    var body=jsonDecode(response.body);
    print(body);
   // List<TeamModel>? teams=[];
    for (var i=0; i<body.length ;i++)//var t in jsonData
    {
      teams.add(TeamModel.fromJson(body[i]));
     // TeamModel team=TeamModel(name: t["name"],id: t["id"],created_at: t["created_at"],updated_at: t["updated_at"]);
     // teams.add(team);
    }

    return teams;
}
  }











