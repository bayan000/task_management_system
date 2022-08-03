

import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class User{
  String? first_name;
  String? last_name;
  String? email;
  String? employee_identical;
  String? password;
  var role_id;
  String? team_id;
  var id;
  String? img_profile;

  User({
    this.first_name,
    this.last_name,
    this.email,
    this.employee_identical,
    this.password,
    this.role_id,
    this.team_id,
    this.id,
    this.img_profile
  });
  factory User.fromJson(Map <String,dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
/*
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
*/






}