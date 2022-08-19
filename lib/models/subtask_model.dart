

import 'package:json_annotation/json_annotation.dart';
import 'package:tracker/models/user_model.dart';
part 'subtask_model.g.dart';
@JsonSerializable(explicitToJson: true)
class ModelSubTask {
  var id;
  String? title;
  String? description;
  String? start_at;
  String? end_at;
  var priority_id;
  var status_id;
  var task_id;
  List<User?>? users;
  //this one get used to add or edit
  List<int>? participants;

  ModelSubTask(
      {this.priority_id,
        this.id,
        this.start_at,
        this.status_id,
        this.description,
        this.title,
        this.end_at,
        this.task_id,
        this.users,
        this.participants
      });

  factory ModelSubTask.fromJson(Map <String,dynamic> json) => _$ModelSubTaskFromJson(json);

  Map<String, dynamic> toJson() => _$ModelSubTaskToJson(this);
}