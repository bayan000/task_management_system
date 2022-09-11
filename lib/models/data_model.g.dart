// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LDataModel _$LDataModelFromJson(Map<String, dynamic> json) {
  return LDataModel(
    json['note'] as String,
    json['title'],
  );
}

Map<String, dynamic> _$LDataModelToJson(LDataModel instance) =>
    <String, dynamic>{
      'note': instance.note,
      'title': instance.title,
    };
