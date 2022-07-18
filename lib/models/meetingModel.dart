import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
part 'meetingModel.g.dart';

@JsonSerializable()

class MeetingModel{
String? meeting_date;
String? start_at;
var meeting_statuses_id;
DateTime? updated_at;
DateTime? created_at;
var id;
List<int>? participant_list;
MeetingModel({this.meeting_date,this.start_at,this.meeting_statuses_id="2",this.updated_at,this.created_at,this.id,this.participant_list});
factory MeetingModel.fromJson(Map <String,dynamic> json) => _$MeetingModelFromJson(json);
Map<String, dynamic> toJson() => _$MeetingModelToJson(this);
}