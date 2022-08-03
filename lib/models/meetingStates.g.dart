// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meetingStates.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MeetingStates _$MeetingStatesFromJson(Map<String, dynamic> json) {
  return MeetingStates(
    id: json['id'],
    name: json['name'] as String?,
    created_at: json['created_at'] as String?,
    updated_at: json['updated_at'] as String?,
  );
}

Map<String, dynamic> _$MeetingStatesToJson(MeetingStates instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at,
    };
