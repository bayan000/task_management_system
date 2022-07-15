// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'team_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TeamModel _$TeamModelFromJson(Map<String, dynamic> json) {
  return TeamModel(
    name: json['name'] as String,
    id: json['id'],
    created_at: json['created_at'] == null
        ? null
        : DateTime.parse(json['created_at'] as String),
    updated_at: json['updated_at'] == null
        ? null
        : DateTime.parse(json['updated_at'] as String),
  );
}

Map<String, dynamic> _$TeamModelToJson(TeamModel instance) => <String, dynamic>{
      'name': instance.name,
      'updated_at': instance.updated_at?.toIso8601String(),
      'created_at': instance.created_at?.toIso8601String(),
      'id': instance.id,
    };
