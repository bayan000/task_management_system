
class RoleModel{




  var id;
  String? position;
  String? created_at;
  String? updated_at;

  RoleModel({this.id,this.position,this.created_at,this.updated_at});


  factory   RoleModel.fromJson(Map<String,dynamic> json )=>

      RoleModel(
          id: json['id'],
          position: json['position'],
          created_at: json['created_at'] ,
          updated_at: json['updated_at']


      );





}