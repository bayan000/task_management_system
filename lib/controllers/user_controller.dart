import 'package:flutter/material.dart';
import 'package:tracker/services/user_service.dart';
import 'package:tracker/models/user_model.dart';
import 'package:provider/provider.dart';
import '../models/all_u_models.dart';

class UserController  with  ChangeNotifier {
//------------------------addUser------------------------------

  List<User> list_of_Users = [];
  //update res
  int id_user = 0;

  var addedUser;
  var edit_User;
  TextEditingController fnameController = TextEditingController();
  TextEditingController lnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController idController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String? choosRoleId;
  String? choosteamId;

  //--------------AddUser---------------------

  onClickAddUser() async {
    User user = User(
        first_name: fnameController.text,
        last_name: lnameController.text,
        email: emailController.text,
        employee_identical: idController.text,
        password: passwordController.text,
        role_id: choosRoleId,
        team_id: choosteamId);
    addedUser = await UserService.addUser(user);
    list_of_Users.add(addedUser);
    notifyListeners();
  }
//--------------EditeUser---------------------

  onClickEditUser() async {
    print(id_user);
    User user = User(

        first_name: fnameController.text,
        last_name: lnameController.text,
        email: emailController.text,
        employee_identical: idController.text,
        password: passwordController.text,
        role_id: choosRoleId,
        team_id: choosteamId
    );


    edit_User=await UserService.editUser(user, id_user);
    for(var us in list_of_Users){
      if(us.id == id_user){
        us=edit_User;
        notifyListeners();
        break;
      }

    }
  }

//--------------DeleteUser---------------------

  onClickDeleteUser() async {

    print(id_user);

    await UserService.deleteUser(id_user);
    //int index,int id
    for (var us in list_of_Users) {
      if (us.id == id_user) {
        list_of_Users.remove(us);
        notifyListeners();
        break;
      }
    }

  }


//---------------------ShowAllUsers---------------

  Future<List<User>> onClickShowAllUser() async {

    list_of_Users = await UserService.servAllUsaer();

    return list_of_Users;

  }
  var im;
  Future<User> onClickShowUser(var id) async {

    im= await UserService.servAUsaer(id);

return im;
  }




}