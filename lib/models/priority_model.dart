class PriorityModel{

  var id;
  String? name;
  String? created_at;
  String? updated_at;

  PriorityModel({this.id,this.name,this.created_at,this.updated_at});


  factory   PriorityModel.fromJson(Map<String,dynamic> json )=>

      PriorityModel(
          id: json['id'],
          name: json['name'],
          created_at: json['created_at'] ,
          updated_at: json['updated_at']


      );



}