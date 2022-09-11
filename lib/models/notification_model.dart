import 'package:json_annotation/json_annotation.dart';
import 'data_model.dart';

part 'notification_model.g.dart';

@JsonSerializable(explicitToJson: true)
class NotificationModel{

  /*
  "id": "4000674e-9204-47f3-b75e-bfd0d79ec0fb",
  "type": "App\\Notifications\\MeetingNotification",
  "notifiable_type": "App\\Models\\User",
  "notifiable_id": 29,
  "data":
  "note": "new meeting is add",
  "the meeting":
  */

  var id;
  String? type;
  String? notifiable_type;
  var notifiable_id;
  bool readed=false;
  LDataModel? data;
  NotificationModel({this.id,this.type,this.notifiable_id,this.notifiable_type,this.data});


  factory NotificationModel.fromJson(Map <String,dynamic> json) => _$NotificationModelFromJson(json);
  Map<String, dynamic> toJson() => _$NotificationModelToJson(this);






}