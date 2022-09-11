// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationModel _$NotificationModelFromJson(Map<String, dynamic> json) {
  return NotificationModel(
    id: json['id'],
    type: json['type'] as String?,
    notifiable_id: json['notifiable_id'],
    notifiable_type: json['notifiable_type'] as String?,
    data: json['data'] == null
        ? null
        : LDataModel.fromJson(json['data'] as Map<String, dynamic>),
  )..readed = json['readed'] as bool;
}

Map<String, dynamic> _$NotificationModelToJson(NotificationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'notifiable_type': instance.notifiable_type,
      'notifiable_id': instance.notifiable_id,
      'readed': instance.readed,
      'data': instance.data?.toJson(),
    };
