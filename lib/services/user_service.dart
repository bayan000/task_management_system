import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tracker/models/task_model.dart';
import 'package:tracker/models/user_model.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:tracker/config/server_config.dart';

import '../models/all_u_models.dart';
class UserService {


//---------------------------AddUser--------------------------------

  static Future addUser(User user) async {
    var response = await http.post(
        Uri.parse(ServerConfig.domainName + ServerConfig.addUser),
        body: {
          'first_name': user.first_name,
          'last_name': user.last_name,
          'email': user.email,
          'employee_identical': user.employee_identical,
          'password': user.password,
          'role_id': user.role_id,
          'team_id': user.team_id
        },
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer ${GetStorage().read(
              'token')}',
          'Accept': 'application/json'
        }


    );

    Map<String, dynamic> json = jsonDecode(response.body);
    print(response.statusCode);
    if (json['the user is:'] == null)
      return null;
    return User.fromJson(json['the user is:']);
  }
//-------------------------ShowUser and save his phone+image---------------------------

  static var img;
  static var phn;
  static Future<dynamic> showUser(var id) async {

    var url=ServerConfig.domainName+'api/admin/user/show/user/'+id.toString();
    var response=await http.get(Uri.parse(url),
      headers: {
      'Authorization':'Bearer  ${GetStorage().read('token')}',
      'Accept':'application/json',
      },
    );
    var body=jsonDecode(response.body);
    if(body['the user'].isEmpty)
      {
        img=null;
        phn=null;
      }

    else{
      if(body['the user'][0]['img_profile']!=null)
      img=body['the user'][0]['img_profile'] as String;
      else if(body['the user'][0]['img_profile']==null)
        img=null;
      if(body['the user'][0]['phone']!=null)
        phn=body['the user'][0]['phone'] as String;
      else if(body['the user'][0]['phone']==null)
        phn=null;
    }
    return img;
  }
//-------------------------EditUser---------------------------
  static Future editUser(User user, int id_user) async {
    var response = await http.put(
        Uri.parse(
            ServerConfig.domainName + ServerConfig.editUser + '${id_user}'),

        body: {
          'first_name': user.first_name,
          'last_name': user.last_name,
          'email': user.email,
          'employee_identical': user.employee_identical,
          'password': user.password,
          'role_id': user.role_id,
          'team_id': user.team_id
        },
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer ${GetStorage().read(
              'token')}',
          'Accept': 'application/json'
        }


    );

    Map<String, dynamic> json = jsonDecode(response.body);
    print(response.statusCode);
    if (json['the user is:'] == null)
      return null;

    return User.fromJson(json['the user is:']);
  }

//----------------------DeleteUser-------------------------------

  static Future deleteUser(int id_user) async {
    var response = await http.delete(
      Uri.parse(
          ServerConfig.domainName + ServerConfig.deleteUser + '${id_user}'),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer ${GetStorage().read('token')}',
        'Accept': 'application/json'
      },
    );
    Map<String, dynamic> json = jsonDecode(response.body);
    print(response.statusCode);
    print(json['message']);
    if (response.statusCode == 200) {
      return json['message'];
    }
    else {
      return 'Failed to delete user.';
    }
  }

//-----------------------showAllUsers-------------------------
static var idi;
  static Future<List<User>> servAllUsaer() async {
    var response = await http.get(
        Uri.parse(ServerConfig.domainName + ServerConfig.showUsers)
        ,
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer ${GetStorage().read(
              'token')}',
          'Accept': 'application/json'
        });


    Map<String, dynamic> json = jsonDecode(response.body);
    print(response.statusCode);
    List users = json['the users'] ;

print(users);
    List<User> models = [];
    print(response.statusCode);

for(int i=0 ;i<json['the users'].length;i++)
  {
    idi=json['the users'][i]['id'];
    await showUser(idi);
    models.add(User(
      id: idi,
      img_profile: img,
      first_name: json['the users'][i]['first_name'] as String,
      last_name: json['the users'][i]['last_name'] as String,
      email: json['the users'][i]['email'] as String,
      role_id: json['the users'][i]['role_id'] as int,
    ));

  }

    print(models);
    if (models != null) {
      return models;
    }
    else {
      return [];
    }
  }
  //------------------------get the name of the user's team
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
  //------------------------
  static Future<User> servAUser(var idd) async {
    var response = await http.get(
        Uri.parse(ServerConfig.domainName + ServerConfig.showUsers)
        ,
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer ${GetStorage().read(
              'token')}',
          'Accept': 'application/json'
        });


    Map<String, dynamic> json = jsonDecode(response.body);
    print(response.statusCode);
    List users = json['the users'] ;

    print(users);
    User model =User() ;
    print(response.statusCode);

    for(int i=0 ;i<json['the users'].length;i++)
    {
      idi=json['the users'][i]['id'];
      if(idi==idd)
      {
        await showUser(idi);
        await teamName(json['the users'][i]['team_id'] as int);
        model=User(
        id: idi,
        img_profile: img,
        phone: phn,
        first_name: json['the users'][i]['first_name'] as String,
        last_name: json['the users'][i]['last_name'] as String,
        email: json['the users'][i]['email'] as String,
        role_id: json['the users'][i]['role_id'] as int,
        team_id:   json['the users'][i]['team_id'] as int,
          teamName: t
      );
      }


    }


      return model;

  }


}
