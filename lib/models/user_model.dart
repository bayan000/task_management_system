
import 'package:flutter/cupertino.dart';
/*
"first_name": "samer",
        "last_name": "Khdeelr",
        "email": "samerkh4@gmail.com",
        "employee_identical": "430219",
        "password": "$2y$10$f1I7rX1H8bGhzc1DKaKdQ.jZ1GMF/rCBHZpnBhKLAZi/Bo5oOcuiq",
        "role_id": "3",
        "team_id": "1",
        "updated_at": "2022-07-03T20:26:03.000000Z",
        "created_at": "2022-07-03T20:26:03.000000Z",
        "id": 13
 */

class User{
  String? first_name;
  String? last_name;
  String? email;
  String? employee_identical;
  String? password;
  var role_id;
  String? team_id;
  var id;

  User({
    this.first_name,
    this.last_name,
    this.email,
    this.employee_identical,
    this.password,
    this.role_id,
    this.team_id,
    this.id
  });


  factory  User.fromJson(Map<String,dynamic> json)=>
      User(
          first_name: json['first_name'],
          last_name: json['first_name'],
          email:json['email'],
          employee_identical:json['employee_identical'],
          password:json['password'],
          role_id:json['role_id'],
          team_id:json['team_id'],
          id: json['id']
      );







}