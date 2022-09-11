

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
  var team_id;
  var id;
  String?  img_profile;
  String? phone;
  String? teamName;
  String? contact;
  String? education;
  String? experience;
  var user_id;


  User({
    this.first_name,
    this.last_name,
    this.email,
    this.employee_identical,
    this.password,
    this.role_id,
    this.team_id,
    this.id,
    this.img_profile,
    this.phone,
    this.user_id,
    this.contact,this.education,this.experience,
    this.teamName
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is User && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  factory User.fromJson(Map <String,dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);


}