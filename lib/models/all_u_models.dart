
class AllUsersModel{
  List<UserModel>?allUser;
}

class UserModel{
  int?id;
  String? firstName;
  String? lastName;
  String? email;
  String? employeeIdentical;
  String? password;
  int? roleId;
  int? teamId;
  Null? rememberToken;
  String? createdAt;
  String? updatedAt;
  String? imgProfile;
  String? phone;
  String? contact;
  String? education;
  String? experience;
  int? userId;

  UserModel(
      {this.id,
        this.firstName,
        this.lastName,
        this.email,
        this.employeeIdentical,
        this.password,
        this.roleId,
        this.teamId,
        this.rememberToken,
        this.createdAt,
        this.updatedAt,
        this.imgProfile,
        this.phone,
        this.contact,
        this.education,
        this.experience,
        this.userId});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    employeeIdentical = json['employee_identical'];
    password = json['password'];
    roleId = json['role_id'];
    teamId = json['team_id'];
    rememberToken = json['remember_token'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    imgProfile = json['img_profile'];
    phone = json['phone'];
    contact = json['contact'];
    education = json['education'];
    experience = json['experience'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['employee_identical'] = this.employeeIdentical;
    data['password'] = this.password;
    data['role_id'] = this.roleId;
    data['team_id'] = this.teamId;
    data['remember_token'] = this.rememberToken;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['img_profile'] = this.imgProfile;
    data['phone'] = this.phone;
    data['contact'] = this.contact;
    data['education'] = this.education;
    data['experience'] = this.experience;
    data['user_id'] = this.userId;
    return data;
  }
}