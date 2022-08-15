// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Task _$TaskFromJson(Map<String, dynamic> json) {
  return Task(
    title: json['title'] as String?,
    description: json['description'] as String?,
    start_date: json['start_date'] as String?,
    end_date: json['end_date'] as String?,
    status_id: json['status_id'],
    team_id: json['team_id'],
    id: json['id'],
    subtasks: (json['subtasks'] as List<dynamic>?)
        ?.map((e) =>
            e == null ? null : ModelSubTask.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$TaskToJson(Task instance) => <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'start_date': instance.start_date,
      'end_date': instance.end_date,
      'status_id': instance.status_id,
      'team_id': instance.team_id,
      'id': instance.id,
      'subtasks': instance.subtasks?.map((e) => e?.toJson()).toList(),
    };
