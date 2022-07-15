

class TaskModel{

  /*
        "title": "hospital management system",
        "description": "this system will help doctors and patients",
        "start_date": "2022-08-01",
        "end_date": "2022-10-15",
        "status_id": "2",
        "team_id": "2",
        "id": 6
   */

  String? title;
  String? description;
  String? start_date;
  String? end_date;
  String? status_id;
  String? team_id;
  String? id ;


  TaskModel({
    this.title,
    this.description,
    this.start_date,
    this.end_date,
    this.status_id,
    this.team_id,
    this.id

  });
  factory  TaskModel.fromJson(Map<String,dynamic> json)=>
      TaskModel(
          title: json['title'],
          description: json['description'],
          start_date: json['start_date'],
          end_date:json['end_date'],
          status_id:json['status_id'],
          team_id:json['team_id'],
          id:json['id']

      );
}