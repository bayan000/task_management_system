
import 'package:json_annotation/json_annotation.dart';
part 'meetingStates.g.dart';

@JsonSerializable()
class MeetingStates{
  var id;
  String? name;
  String? created_at;
  String? updated_at;
  MeetingStates({this.id,this.name,this.created_at,this.updated_at});
  factory MeetingStates.fromJson(Map <String,dynamic> json) => _$MeetingStatesFromJson(json);
  Map<String, dynamic> toJson() => _$MeetingStatesToJson(this);
}