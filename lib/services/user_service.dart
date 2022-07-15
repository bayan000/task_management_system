import 'package:get_storage/get_storage.dart';
import 'package:tracker/models/task_model.dart';
import 'package:tracker/models/user_model.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:tracker/config/server_config.dart';

class UserService{


  static Future addUser(User user)async{

    var response=await http.post(
        Uri.parse(ServerConfig.domainName+ServerConfig.addUser),
        body:{
          'first_name':user.first_name,
          'last_name':user.last_name,
          'email':user.email,
          'employee_identical':user.employee_identical,
          'password':user.password,
          'role_id':user.role_id,
          'team_id':user.team_id,
        },
        headers: {
          'auth': 'Bearer  ${GetStorage().read('token')}',
          'Accept': 'application/json',
        }


    );

    Map<String,dynamic> json=jsonDecode(response.body);
//----check here ----------
    print(json['message:']);
    return User.fromJson(json['the user:']['user']);
  }





}