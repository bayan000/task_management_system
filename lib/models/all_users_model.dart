class AllUsersModel {
  List<TheUsers>? theUsers;

  AllUsersModel({this.theUsers});

  AllUsersModel.fromJson(Map<String, dynamic> json) {
    print('json is $json');
    if (json['the users'] != null) {
      theUsers = [];
      json['the users'].forEach((v) {
        theUsers!.add(new TheUsers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.theUsers != null) {
      data['the users'] = this.theUsers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TheUsers {
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  String? employeeIdentical;
  int? roleId;
  int? teamId;
  Null? rememberToken;
  String? createdAt;
  String? updatedAt;

  TheUsers(
      {this.id,
        this.firstName,
        this.lastName,
        this.email,
        this.employeeIdentical,
        this.roleId,
        this.teamId,
        this.rememberToken,
        this.createdAt,
        this.updatedAt});

  TheUsers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    employeeIdentical = json['employee_identical'];
    roleId = json['role_id'];
    teamId = json['team_id'];
    rememberToken = json['remember_token'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['employee_identical'] = this.employeeIdentical;
    data['role_id'] = this.roleId;
    data['team_id'] = this.teamId;
    data['remember_token'] = this.rememberToken;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}