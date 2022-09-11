
class AttachementModel{

  var id;
  String? title;
  String? description;
  var user_id;
  var task_id;

  AttachementModel({this.description,this.title,this.id,this.user_id,this.task_id});


  factory AttachementModel.fromJson(Map<String,dynamic> json)=>AttachementModel(
      description: json['description'],
      title: json['title'],
      id: json['id'],
      user_id: json['user_id'],
      task_id: json['task_id']

  );



}