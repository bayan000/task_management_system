// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subtask_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ModelSubTask _$ModelSubTaskFromJson(Map<String, dynamic> json) {
  return ModelSubTask(
    priority_id: json['priority_id'],
    id: json['id'],
    start_at: json['start_at'] as String?,
    status_id: json['status_id'],
    description: json['description'] as String?,
    title: json['title'] as String?,
    end_at: json['end_at'] as String?,
    task_id: json['task_id'],
    users: (json['users'] as List<dynamic>?)
        ?.map(
            (e) => e == null ? null : User.fromJson(e as Map<String, dynamic>))
        .toList(),
    participants:
        (json['participants'] as List<dynamic>?)?.map((e) => e as int).toList(),
  );
}

Map<String, dynamic> _$ModelSubTaskToJson(ModelSubTask instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'start_at': instance.start_at,
      'end_at': instance.end_at,
      'priority_id': instance.priority_id,
      'status_id': instance.status_id,
      'task_id': instance.task_id,
      'users': instance.users?.map((e) => e?.toJson()).toList(),
      'participants': instance.participants,
    };
