

class StatisticsModel{





  var total_tasks_num;
  var num_of_completed;
  var percentage_completed;
  var num_of_progress;
  var percentage_progress;
  var num_of_missed;
  var   percentage_missed;
  var num_of_todo;
  var percentage_todo;

  StatisticsModel({this.num_of_completed, this.num_of_missed,



    this.num_of_progress, this.num_of_todo, this.percentage_completed,
    this.percentage_missed, this.percentage_progress,
    this.percentage_todo, this.total_tasks_num

  });

  factory StatisticsModel.fromJson(Map<String,dynamic> json)=> StatisticsModel(
      num_of_completed:json['num_of_completed'],
      num_of_missed:json['num_of_missed'],
      num_of_progress: json['num_of_progress'],
      num_of_todo:json['num_of_todo'],
      percentage_completed:json['percentage_completed'],
      percentage_missed:json['percentage_missed'],
      percentage_progress:json[' percentage_progress'],
      percentage_todo:json[' percentage_todo'],
      total_tasks_num: json['total_tasks_num']);



}


class MyData{

  String? name;
  var percent;


  MyData(this.name,this.percent);
}