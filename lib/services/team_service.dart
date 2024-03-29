import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:tracker/models/showTeamModel.dart';
import 'package:tracker/models/team_model.dart';
import 'package:tracker/models/user_model.dart';

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
    for (var i=0; i<body.length ;i++)//var t in jsonData
    {
      teams.add(TeamModel.fromJson(body[i]));

    }
 // print(teams[0].id);
    return teams;
}
//deletion*********************************
  static Future deleteTeam(int id) async{

    var url=ServerConfig.domainName+ServerConfig.deleteTeam+id.toString();
    var response=await http.delete(Uri.parse(url),headers: {
      'Authorization':'Bearer  ${GetStorage().read('token')}',
      'Accept':'application/json',
    });
    print(response.statusCode);
    var body=jsonDecode(response.body);
    print(body);
    return response.statusCode.toString();

  }

  ///myTeamMember
  static var sTm;
  static Future<ShowTeamModel> showTeamM() async{
    List<User> leader=[];
    List<User> tMembers=[];
    var url=ServerConfig.domainName+ServerConfig.myTeam;
    var response=await http.get(Uri.parse(url),headers: {
      'Authorization':'Bearer  ${GetStorage().read('token')}',
      'Accept':'application/json',
    });
    print(response.statusCode);
    var body=jsonDecode(response.body);
    //team=TeamModel.fromJson(body["the team"]);

        leader.add(User.fromJson(body["the leader of team"][0]) as User);
for(int i=0;i<body["my team"].length;i++)
      {
if(body["my team"][i]["img_profile"]!=null)
        tMembers.add(User.fromJson(body["my team"][i]) as User);
else
  tMembers.add(User(
    first_name: body["my team"][i]["first_name"] as String,
    last_name:body["my team"][i]["last_name"] as String,
      id:body["my team"][i]["id"] as int,

  ));

      }



    sTm=ShowTeamModel(teamLeader: leader,teamMembers: tMembers);
    print(body);
    ///print(sTm.teamMembers[4]);
    print('hi');
    return sTm;
  }
  ///myTeamLeader
  static var sTl;
  static Future<ShowTeamModel> showTeamL() async{
    List<User> tMembers=[];
    var url=ServerConfig.domainName+ServerConfig.myTeam;
    var response=await http.get(Uri.parse(url),headers: {
      'Authorization':'Bearer  ${GetStorage().read('token')}',
      'Accept':'application/json',
    });
    print(response.statusCode);
    var body=jsonDecode(response.body);
print(body["my team"].length);
    for(int i=0;i<body["my team"].length;i++)
      {

        tMembers.add(User.fromJson(body["my team"][i]) as User);

      }
    print(tMembers.length);
    sTl=ShowTeamModel(teamMembers: tMembers);
   print('hi');
    print(sTl.teamMembers);
    return sTl;
  }
  //show specific show team
  static var showTeamModel;
  static Future<ShowTeamModel> showTeam(int id) async{
    TeamModel team;
    List<User> leader;
    List<User> tMembers;
    var url=ServerConfig.domainName+ServerConfig.showAteam+id.toString();
    var response=await http.get(Uri.parse(url),headers: {
      'Authorization':'Bearer  ${GetStorage().read('token')}',
      'Accept':'application/json',
    });
    print(response.statusCode);
    var body=jsonDecode(response.body);
    team=TeamModel.fromJson(body["the team"]);
    leader=(body["leader"] as List).map((i) =>
        User.fromJson(i)).toList();
    tMembers=(body["members"] as List).map((i) =>
        User.fromJson(i)).toList();
    showTeamModel=ShowTeamModel(teamModel: team,teamLeader: leader,teamMembers: tMembers);
    print(body);
    return showTeamModel;
  }

  }











