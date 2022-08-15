
class ModelCalendar{



  String event_name;
  var user_id;
  var id;

  ModelCalendar({required this.event_name,this.user_id,this.id});




  factory  ModelCalendar.fromJson(Map<String,dynamic> json)=>
      ModelCalendar(
          event_name: json['event_name'],
          id:json['id'],
          user_id: json['user_id']
      );

}