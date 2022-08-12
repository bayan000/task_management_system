class ReoprtModel {
ReoprtModel({
  required this.theTask,
  required this.thePercentage,
});

final List<TheTask> theTask;
final int thePercentage;

factory ReoprtModel.fromJson(Map<String, dynamic> json) => ReoprtModel(
theTask: List<TheTask>.from(json["the task"].map((x) => TheTask.fromJson(x))),
thePercentage: json["the percentage"],
);

Map<String, dynamic> toJson() => {
  "the task": List<dynamic>.from(theTask.map((x) => x.toJson())),
  "the percentage": thePercentage,
};
}

class TheTask {
  TheTask({
    required this.id,
    required this.title,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.statusId,
    required this.teamId,
    required this.createdAt,
    required this.updatedAt,
    required this.subtasks,
  });

  final int id;
  final String title;
  final String description;
  final DateTime startDate;
  final DateTime endDate;
  final int statusId;
  final int teamId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<Subtask> subtasks;

  factory TheTask.fromJson(Map<String, dynamic> json) => TheTask(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    startDate: DateTime.parse(json["start_date"]),
    endDate: DateTime.parse(json["end_date"]),
    statusId: json["status_id"],
    teamId: json["team_id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    subtasks: List<Subtask>.from(json["subtasks"].map((x) => Subtask.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "start_date": "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
    "end_date": "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
    "status_id": statusId,
    "team_id": teamId,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "subtasks": List<dynamic>.from(subtasks.map((x) => x.toJson())),
  };
}

class Subtask {
  Subtask({
    required this.id,
    required this.title,
    required this.description,
    required this.startAt,
    required this.endAt,
    required this.priorityId,
    required this.statusId,
    required this.taskId,
    required this.createdAt,
    required this.updatedAt,
    required this.members,
  });

  final int id;
  final String title;
  final String description;
  final DateTime startAt;
  final DateTime endAt;
  final int priorityId;
  final int statusId;
  final int taskId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<Member> members;

  factory Subtask.fromJson(Map<String, dynamic> json) => Subtask(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    startAt: DateTime.parse(json["start_at"]),
    endAt: DateTime.parse(json["end_at"]),
    priorityId: json["priority_id"],
    statusId: json["status_id"],
    taskId: json["task_id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    members: List<Member>.from(json["members"].map((x) => Member.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "start_at": "${startAt.year.toString().padLeft(4, '0')}-${startAt.month.toString().padLeft(2, '0')}-${startAt.day.toString().padLeft(2, '0')}",
    "end_at": "${endAt.year.toString().padLeft(4, '0')}-${endAt.month.toString().padLeft(2, '0')}-${endAt.day.toString().padLeft(2, '0')}",
    "priority_id": priorityId,
    "status_id": statusId,
    "task_id": taskId,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "members": List<dynamic>.from(members.map((x) => x.toJson())),
  };
}

class Member {
  Member({
    required this.firstName,
    required this.lastName,
    required this.imgProfile,
  });

  final String firstName;
  final String lastName;
  final String? imgProfile;

  factory Member.fromJson(Map<String, dynamic> json) => Member(
    firstName: json["first_name"],
    lastName: json["last_name"],
    imgProfile: json["img_profile"] == null ? null : json["img_profile"],
  );

  Map<String, dynamic> toJson() => {
    "first_name": firstName,
    "last_name": lastName,
    "img_profile": imgProfile == null ? null : imgProfile,
  };
}
