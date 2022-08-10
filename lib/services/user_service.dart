import 'dart:io';

import 'package:get_storage/get_storage.dart';
import 'package:tracker/models/task_model.dart';
import 'package:tracker/models/user_model.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:tracker/config/server_config.dart';

import '../models/all_users_model.dart';

class UserService{
  static Future getAllUsers() async{


    var url = ServerConfig.domainName + ServerConfig.showUsers;
    try {
      var response = await http.get(Uri.parse(url), headers: {

        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiYjEzODk3M2I0M2YxMWQ4ZmZlNWZlZmYxMDRhYzc2OWY0NDQzYmNhYzQ0NTc0MzA5ODE4MjU3M2VmYWJjZWYyYzUzZWQwMjBmOWNlYWIzZWIiLCJpYXQiOjE2NTgwNTEyMzQuNTQ5MjEyLCJuYmYiOjE2NTgwNTEyMzQuNTQ5MjE4LCJleHAiOjE2ODk1ODcyMzQuNTIwMjE4LCJzdWIiOiIxIiwic2NvcGVzIjpbXX0.jFSqv7rg-KrvUnMTAFy0YXM0aokw5H1bST-epu0MuCMxq1t7BV_Q_1mprLUFnG5fF3PN1DvOftOA46AGgW7oPf2dEmGTFZaKkXBffRDWucole3Hu_5wWo147ZnUIhCC-a2TMkBlaSpZyZQARmzM52BwTj270CUt-l0-4hIov9JtmoVtg_4AERcH9Jjta05v5Qj-GQTMOGLKKRPKsTnX2IkmDDyLMBvGUqeUKbkVUCC_eskfRwGNO54TWRiqCve3eN8xujH8Uz1-BPixLOpSIMa47_OMgVzVr6cDZUaUoULKhislPMwn0F3Uz3osWiyypJr5T1DmQKVG_sEn4TL7D3E1AR7TAgKBsRHwZk7YjroDVKjgoWHmVN_CUc5oVuxoao5qc7CVpxbou38lswxpZ9JrngeIE5cpNeDW_sIOj-iv4KujqArsS68JOnZBiJPCNyYjzcefVlRY8nES1CB0QnZpSEaTxAAFH6k3MeOBQNCy5lycbq5959SvJ7b2SkAX3zB7qDY0Y9xb0xFWAX4KQbIw5u5gxgXshx2zJTwT2crrYpHO9E82Q0cvF-__oMQoM9UnuM-DyghJuXJxc8Nh4Q1nYFIyivEjY1yVRDuKnnTDtqybFd58VDx205YpvTfajOk5U6Fx0pLL4aHR29aT6mTwy4O6BxOQuZidGDDxnzM4",
      });
      print('response is ${response.body}');

      return  AllUsersModel.fromJson(jsonDecode(response.body));
    }catch(error){
      print('error message ${error.toString()}');
    }

  }
//---------------------------AddUser--------------------------------

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
          'team_id':user.team_id
        },
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer ${GetStorage().read('token')}',
          'Accept': 'application/json'
        }


    );

    Map<String,dynamic> json=jsonDecode(response.body);
    print(response.statusCode);
    if(json['the user is:'] == null)
      return null;
    return User.fromJson(json['the user is:']);
  }

//-------------------------EditUser---------------------------
  static Future editUser(User user,int id_user)async{

    var response = await http.put(
        Uri.parse(ServerConfig.domainName+ServerConfig.editUser+'${id_user}'),

        body: {
          'first_name':user.first_name,
          'last_name':user.last_name,
          'email':user.email,
          'employee_identical':user.employee_identical,
          'password':user.password,
          'role_id':user.role_id,
          'team_id':user.team_id
        },
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer ${GetStorage().read('token')}',
          'Accept': 'application/json'
        }


    );

    Map<String,dynamic> json=jsonDecode(response.body);
    print(response.statusCode);
    if(json['the user is:'] == null)
      return null;

    return User.fromJson(json['the user is:']);


  }

//----------------------DeleteUser-------------------------------

  static Future deleteUser(int id_user)async{


    var response=await http.delete(
      Uri.parse(ServerConfig.domainName+ServerConfig.deleteUser+'${id_user}'),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer ${GetStorage().read('token')}',
        'Accept': 'application/json'
      },
    );
    Map<String,dynamic> json=jsonDecode(response.body);
    print(response.statusCode);
    print(json['message']);
    if(response.statusCode ==  200){
      return json['message'];
    }
    else
    {
      return 'Failed to delete user.';
    }
  }
//-----------------------showAllUsers-------------------------

  static Future<List<User>>  servAllUsaer()async{

    var response = await http.get(  Uri.parse(ServerConfig.domainName + ServerConfig.showUsers)
        ,
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer ${GetStorage().read(
              'token')}',
          'Accept': 'application/json'
        });


    Map<String,dynamic> json = jsonDecode(response.body);
    List users = json['the users'];

    List< User > models = [];
    print(response.statusCode);


    for(var us in users){
      models.add(User.fromJson(us));}
    print(models);
    if(models != null) {
      return models;
    }
    else{
      return [];
    }





  }


//---------------------------------------------------











}




