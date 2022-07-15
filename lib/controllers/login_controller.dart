
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tracker/models/user_model.dart';
import 'package:tracker/services/auth_service.dart';
class LoginController extends ChangeNotifier{

  TextEditingController passwordController=TextEditingController();
  TextEditingController idController=TextEditingController();

  User? modelUser=User();
  var  check=false;
  var message ;
  Future onClickLogin()async{
    User user=User( password: passwordController.text, employee_identical: idController.text);

    modelUser= await AuthService.loginfun(user);
    //message =await AuthService.message;
    //check= await AuthService.loginfun(user);
  }

  Future onClickLogout()async{

    message=await AuthService.logoutfun();

  }


}