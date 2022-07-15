import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tracker/config/server_config.dart';


import 'dart:async';

import 'package:tracker/models/user_model.dart';
import 'package:get_storage/get_storage.dart';

class AuthService {
// تابع يطلب ال api
  static var message ;
  static var token;
//-----------------------------LOGIN-----------------------------------------
  static Future loginfun(User user) async {
    var response = await http
        .post(Uri.parse(ServerConfig.domainName + ServerConfig.login), body: {
      'employee_identical': user.employee_identical,
      'password': user.password
    });
    Map<String, dynamic> json = jsonDecode(response.body);
    print(response.statusCode);
    // print(response.body);

    if (response.statusCode == 201 || response.statusCode == 200){
      message=json['message:'];
      print(json['message:']);

//print(json['the user:']['token']);
//print('the user');
//print(json['the user:']['user']);

      await GetStorage().write('token', json['the user:']['token']);

      print(await GetStorage().read('token'));
      return User.fromJson(json['the user:']['user']);
//return true;
    } else if (response.statusCode == 422 || response.statusCode == 402) {

      message=json['errors'];
      print(json['errors']);
      return null;
//      return false;
    } else {
      return null;
      //  return false;
    }}
//-------------------------LOGOUT----------------------------------------
  static Future<String> logoutfun()async{
    var response = await http.get(
      Uri.parse(ServerConfig.domainName +ServerConfig.logout),
      headers: {
        'auth': 'Bearer  ${GetStorage().read('token')}',
        'Accept': 'application/json',

      },);
    Map<String,dynamic> json=jsonDecode(response.body);
    print(await GetStorage().read('token'));
    await GetStorage().remove('token');

    return json['message'];

  }




//-------------------------------------------------------------------------------------



}