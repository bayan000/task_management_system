
class ModelCalendar{



  String event_name;
  var user_id;
  var date_of_event;
  String? to;
  var id;

  ModelCalendar({required this.event_name,this.user_id,this.id,this.date_of_event, this.to});




  factory  ModelCalendar.fromJson(Map<String,dynamic> json)=>
      ModelCalendar(
          event_name: json['event_name'],
          id:json['id'],
          user_id: json['user_id'],
          date_of_event:json['date_of_event'],
          to:json['to']

      );

}