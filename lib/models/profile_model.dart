
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';
part 'profile_model.g.dart';
@JsonSerializable()
class ProfileModel{


  var img_profile;
  String phone;
  String contact;
  String  education;
  String experience;
  var user_id;
  var id;


  ProfileModel({
     required this.contact, required this.education, required this.experience,
     required this.phone, this.id, this.user_id,this.img_profile});

factory ProfileModel.fromJson(Map<String,dynamic> json)=> _$ProfileModelFromJson(json);



  /*factory  ProfileModel.fromJson(Map<String,dynamic> json)=>
      ProfileModel(
          img_profile:json['img_profile']as String,
          experience: json['experience']as String,
          created_at: json['created_at']as String,
          updated_at: json['updated_at']as String,
          phone: json[' phone']as String,
          contact: json['contact']as String,
          user_id:json['user_id'],
          id:json['id'],
          education:json['education']as String


      );*/

}