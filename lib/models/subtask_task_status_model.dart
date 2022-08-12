class StatusModel{




  var id;
  String? name;
  String? created_at;
  String? updated_at;

  StatusModel({this.id,this.name,this.created_at,this.updated_at});


  factory   StatusModel.fromJson(Map<String,dynamic> json )=>

      StatusModel(
          id: json['id'],
          name: json['name'] as String,
          created_at: json['created_at'] ,
          updated_at: json['updated_at']


      );






}