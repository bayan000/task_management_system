// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileModel _$ProfileModelFromJson(Map<String, dynamic> json) {
  return ProfileModel(
    contact: json['contact'] as String,
    education: json['education'] as String,
    experience: json['experience'] as String,
    phone: json['phone'] as String,
    id: json['id'],
    user_id: json['user_id'],
    img_profile: json['img_profile'],
  );
}

Map<String, dynamic> _$ProfileModelToJson(ProfileModel instance) =>
    <String, dynamic>{
      'img_profile': instance.img_profile,
      'phone': instance.phone,
      'contact': instance.contact,
      'education': instance.education,
      'experience': instance.experience,
      'user_id': instance.user_id,
      'id': instance.id,
    };
