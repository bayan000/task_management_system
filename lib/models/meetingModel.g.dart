// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meetingModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MeetingModel _$MeetingModelFromJson(Map<String, dynamic> json) {
  return MeetingModel(
    meeting_date: json['meeting_date'] as String?,
    start_at: json['start_at'] as String?,
    meeting_statuses_id: json['meeting_statuses_id'],
    updated_at: json['updated_at'] == null
        ? null
        : DateTime.parse(json['updated_at'] as String),
    created_at: json['created_at'] == null
        ? null
        : DateTime.parse(json['created_at'] as String),
    id: json['id'],
    participant_list: (json['participant_list'] as List<dynamic>?)
        ?.map((e) => e as int)
        .toList(),
  );
}

Map<String, dynamic> _$MeetingModelToJson(MeetingModel instance) =>
    <String, dynamic>{
      'meeting_date': instance.meeting_date,
      'start_at': instance.start_at,
      'meeting_statuses_id': instance.meeting_statuses_id,
      'updated_at': instance.updated_at?.toIso8601String(),
      'created_at': instance.created_at?.toIso8601String(),
      'id': instance.id,
      'participant_list': instance.participant_list,
    };
