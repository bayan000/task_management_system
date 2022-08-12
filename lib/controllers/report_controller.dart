
import 'dart:convert';

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
    for(var r in json)
      models.add(ReoprtModel.fromJson(r));

    return models;
  }



}