// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    first_name: json['first_name'] as String?,
    last_name: json['last_name'] as String?,
    email: json['email'] as String?,
    employee_identical: json['employee_identical'] as String?,
    password: json['password'] as String?,
    role_id: json['role_id'],
    team_id: json['team_id'],
    id: json['id'],
    img_profile: json['img_profile'] as String?,
    phone: json['phone'] as String?,
    teamName: json['teamName'] as String?,
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'first_name': instance.first_name,
      'last_name': instance.last_name,
      'email': instance.email,
      'employee_identical': instance.employee_identical,
      'password': instance.password,
      'role_id': instance.role_id,
      'team_id': instance.team_id,
      'id': instance.id,
      'img_profile': instance.img_profile,
      'phone': instance.phone,
      'teamName': instance.teamName,
    };
