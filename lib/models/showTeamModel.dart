
import 'package:json_annotation/json_annotation.dart';
import 'package:tracker/models/team_model.dart';
import 'package:tracker/models/user_model.dart';
part 'showTeamModel.g.dart';
@JsonSerializable(explicitToJson: true)
class ShowTeamModel{
  TeamModel? teamModel;
  List<User?>? teamLeader;
  List<User?>? teamMembers;
  ShowTeamModel({
  this.teamModel,
  this.teamLeader,
this.teamMembers,
});
factory ShowTeamModel.fromJson(Map <String,dynamic> json) => _$ShowTeamModelFromJson(json);
Map<String, dynamic> toJson() => _$ShowTeamModelToJson(this);

}