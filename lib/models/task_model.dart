
import 'package:json_annotation/json_annotation.dart';
import 'package:tracker/models/subtask_model.dart';
part 'task_model.g.dart';
@JsonSerializable(explicitToJson: true)
class Task{



  String? title;
  String? description;
  String? start_date;
  String? end_date;
  var status_id;
  var team_id;
  var id ;
  List<ModelSubTask?>? subtasks;

//var subtasks;

  Task({

    this.title,
    this.description,
    this.start_date,
    this.end_date,
    this.status_id,
    this.team_id,
    this.id,
    this.subtasks

  });

  factory Task.fromJson(Map <String,dynamic> json) => _$TaskFromJson(json);

  Map<String, dynamic> toJson() => _$TaskToJson(this);
}