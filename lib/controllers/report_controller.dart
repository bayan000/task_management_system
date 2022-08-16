
import 'dart:convert';
import 'dart:io';

import 'package:get_storage/get_storage.dart';

import '../config/server_config.dart';
import '../models/report_model.dart';

import 'package:http/http.dart' as http;
class ReportController{

  static Future<List<ReoprtModel>> reports()async{
    var response = await http.get(Uri.parse(ServerConfig.domainName + ServerConfig.showReports),
        headers: {
          'Authorization': 'Bearer ${GetStorage().read('token')}',
        }
    );
    print(response.body);
    List json = jsonDecode(response.body);
    List<ReoprtModel> models = [];
    ReoprtModel re;

    for(int i=0;i<json.length;i++)
      {
        re=ReoprtModel.fromJson(json[i]);
        await teamName(json[i]['the task'][0]['team_id'] as int);
        re.theTask[0].teamName=t;
        print( re.theTask[0].teamName);
        models.add(re);

      }
    return models;
  }
  static var t;
  static Future teamName(var i) async{
    var response = await http.get(
        Uri.parse(ServerConfig.domainName +ServerConfig.teamName+i.toString())
        ,
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer ${GetStorage().read(
              'token')}',
          'Accept': 'application/json'
        });
    List< dynamic> json = jsonDecode(response.body);
    if(json.isNotEmpty)
      t=json[0]['name'] as String;
    else
      t="";
  }


}