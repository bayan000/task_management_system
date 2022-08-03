// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'showTeamModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShowTeamModel _$ShowTeamModelFromJson(Map<String, dynamic> json) {
  return ShowTeamModel(
    teamModel: json['teamModel'] == null
        ? null
        : TeamModel.fromJson(json['teamModel'] as Map<String, dynamic>),
    teamLeader: (json['teamLeader'] as List<dynamic>?)
        ?.map(
            (e) => e == null ? null : User.fromJson(e as Map<String, dynamic>))
        .toList(),
    teamMembers: (json['teamMembers'] as List<dynamic>?)
        ?.map(
            (e) => e == null ? null : User.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$ShowTeamModelToJson(ShowTeamModel instance) =>
    <String, dynamic>{
      'teamModel': instance.teamModel?.toJson(),
      'teamLeader': instance.teamLeader?.map((e) => e?.toJson()).toList(),
      'teamMembers': instance.teamMembers?.map((e) => e?.toJson()).toList(),
    };
