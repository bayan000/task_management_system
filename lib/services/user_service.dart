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

class UserService{
  static Future updateUser(UserModel userModel) async{
    try {
      print('start updating');
      final http.Response response = await http.put(
          Uri.parse(ServerConfig.domainName + ServerConfig.updateUser + '${userModel.userId}' ),
          body: json.encode({
            "first_name": userModel.firstName,
            "last_name": userModel.lastName,
            "email": userModel.email,
            "employee_identical": userModel.employeeIdentical,
            "password": userModel.password,
            "role_id": userModel.roleId == 3 ? 2 : 3,
            "team_id":userModel.teamId
          }),
          headers: {
            "content-type": "application/json",
            "Accept": "application/json",
            "Authorization": "Bearer ${GetStorage().read('token')}",
           // "Authorization": "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiOWM3N2FhNWIxZjg3NmUwNjliMTI4Y2I5ZjNiZTNiODMxZjNmYTcyOWJjMTBiZjk1ODI3ZWEzZGJmMzUxOWY5NjVmOWJlNDQzYmE4MjExMjgiLCJpYXQiOjE2NTgwNDMxOTUuNzg0MzYyLCJuYmYiOjE2NTgwNDMxOTUuNzg0MzcxLCJleHAiOjE2ODk1NzkxOTUuNTU5MTQyLCJzdWIiOiIxIiwic2NvcGVzIjpbXX0.XAJzzkF38XBX8OdP6FXZnmE1KGqt-lOG-GlxcXDktlWgDTa10u2uWXv3M1zH9ZwqxEek3XMS6Pq-D1LMF32qUj6v256MOAJ3dEOeYv1b_LV19zVhyH34GcwAvweAw_lvcvs9NzCMKyCxC9Pf58bsR4uNKtbrPPBDRqAu8sebnl4unjNx3Ndca237KySsNH6dp5K1qey_tQx_yVVhj25_LgdLAFDFqGzsSfQFIFxGx1wotc4i2RjIgf9oXetfUpc_A7SaAkhg4iMRy6NdsgAVPOn46Eu-qLAnqQVFi2GN2jlghl_-9BpnbWVJb0qusXX8z9liKm63Cn2i65MTsKNISPBGNpaQvyeKxDF42uGOusfBupbLDehjy6GzP8M6wNGL6rIlk8tGoInl0q8K6NuNoaYR6jXAzJLZdJ2C10D7lp-RdYUMABRr7HQRHOxogTpJFUzGHF9V7m82K2E2TQ0wGAhcKr-HjfPjQ68RyoDA2HJHrxKcvqMnYRoGIBBwIJCLJT4zhSpqOWp1pRPPKj8oZrQ9IxijaBtWm2qk4pEZccT00CHrXpMRv18YWpEG8IEAuR0qpjT3Nedz-J7Zf0JSZqOcRR8JVrSEXqStvBEEQdMzG8jro1wqMsvLWg0po6lGcBG3hQ5EkUhmMRzU7AkklKWm50i17oS9MFq3SYxwgcQ",
          });
      print('update is ${response.body}');
    }catch(error){
      print('error is $error ');
      return Future.error(error);
    }
  }
  static Future getAllUsers() async{


    var url = ServerConfig.domainName + ServerConfig.showUsers;
    try {
      var response = await http.get(Uri.parse(url), headers: {

        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": "Bearer ${GetStorage().read('token')}",
      });
      print('response is ${response.body}');
      AllUsersModel allUsersModel = AllUsersModel();
      allUsersModel.allUser = [];
      jsonDecode(response.body).forEach((v){
        v.forEach((v1){
          allUsersModel.allUser!.add(UserModel.fromJson(v1));
        });
      });
print(allUsersModel);
      return allUsersModel;
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




