// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meetingModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MeetingModel _$MeetingModelFromJson(Map<String, dynamic> json) {
  return MeetingModel(
    meeting_date: json['meeting_date'] as String?,
    start_at: json['start_at'] as String?,
    meeting_status: json['meeting_status'],
    updated_at: json['updated_at'] as String?,
    created_at: json['created_at'] as String?,
    id: json['id'],
    participants: (json['participants'] as List<dynamic>?)
        ?.map(
            (e) => e == null ? null : User.fromJson(e as Map<String, dynamic>))
        .toList(),
    participant_list: (json['participant_list'] as List<dynamic>?)
        ?.map((e) => e as int)
        .toList(),
  );
}

Map<String, dynamic> _$MeetingModelToJson(MeetingModel instance) =>
    <String, dynamic>{
      'meeting_date': instance.meeting_date,
      'start_at': instance.start_at,
      'meeting_status': instance.meeting_status,
      'updated_at': instance.updated_at,
      'created_at': instance.created_at,
      'id': instance.id,
      'participant_list': instance.participant_list,
      'participants': instance.participants?.map((e) => e?.toJson()).toList(),
    };
