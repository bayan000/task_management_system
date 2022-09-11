
import 'dart:convert';
import 'dart:io';

import 'package:get_storage/get_storage.dart';

import '../config/server_config.dart';
import '../models/attachment_model.dart';
import 'package:http/http.dart' as http;
class AttachementService{



  static Future<List<AttachementModel>> AllAttachement()async {
    var response = await http.get(
        Uri.parse(ServerConfig.domainName + ServerConfig.showAllAttachement),

        headers: {
          HttpHeaders.authorizationHeader: 'Bearer ${GetStorage().read(
              'token')}',
          'Accept': 'application/json'
        }

    );
    Map<String, dynamic> json = jsonDecode(response.body);
    List<AttachementModel> list_attachement = [];
    print(response.statusCode);


    for (var att in json['my attachments']) {
      list_attachement.add(AttachementModel.fromJson(att));
    }

    return list_attachement;
  }



  static Future<AttachementModel> AddAttachement(AttachementModel attachementModel)async {
    AttachementModel att;

    var response = await http.post(
        Uri.parse(ServerConfig.domainName + ServerConfig.fAddAttachement+'${attachementModel.task_id}'+ServerConfig.sAddAttachement),
        body:{
          'title': attachementModel.title,
          'description':attachementModel.description

        },
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer ${GetStorage().read(
              'token')}',
          'Accept': 'application/json'
        }

    );
    Map<String, dynamic> json = jsonDecode(response.body);


    print(response.body);
    print(response.statusCode);
    att=AttachementModel(
        title: json['the info:']['title'],
        description: json['the info:']['description']

    );



    return att;
  }




}