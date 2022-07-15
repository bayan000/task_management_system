import 'package:json_annotation/json_annotation.dart';
/*In Dart, private members are accessible within the same library.
 With import you import a library and can access only its public members.
 With part/part of you can split one library into several files and private members are accessible
 for all code within these files.*/
part 'team_model.g.dart';
@JsonSerializable()
class TeamModel{

  String name;
  DateTime? updated_at;
  DateTime? created_at;
  var id;

   TeamModel({ required this.name,this.id,this.created_at,this.updated_at});

  factory TeamModel.fromJson(Map <String,dynamic> json) => _$TeamModelFromJson(json);
  Map<String, dynamic> toJson() => _$TeamModelToJson(this);

  @override
  String toString() {
    return 'TeamModel{name: $name, updated_at: $updated_at, created_at: $created_at, id: $id}';
  }
}