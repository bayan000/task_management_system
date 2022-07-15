import 'package:flutter/material.dart';
import 'package:tracker/shared/components.dart';
import 'package:tracker/controllers/login_controller.dart';
import 'package:tracker/models/user_model.dart';
import 'package:tracker/services/auth_service.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:tracker/shared/constants.dart';
import 'package:provider/provider.dart';

class Login extends StatelessWidget {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  LoginController loginController = LoginController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: SafeArea(
            child: Container(
                child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.04,
                        vertical: size.width * 0.06),
                    child: Form(
                      key: formKey,
                      child: ListView(children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.pop(
                                  context,
                                );
                              },
                              icon: Icon(Icons.arrow_back_ios_outlined),
                              iconSize: 23,
                              color: Colors.black,
                            ),
                            Text(
                              'Welcome To $appName',
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(),
                          ],
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Image.asset('assets/images/second.png'),

                        SizedBox(
                          height: 28,
                        ),
                        CustomField(
                            height: 65,
                            hintColor: Colors.grey[700],
                            allBorder: false,
                            hintText: 'Employee_identical',
                            labelText: 'Employee_identical',
                            colorField: Colors.grey.withAlpha(53),
                            isPassword: false,
                            controller: loginController.idController),
                        SizedBox(
                          height: 18,
                        ),
                        CustomField(
                            allBorder: false,
                            hintColor: Colors.grey[700],
                            height: 65,
                            hintText: 'Password',
                            labelText: 'Password',
                            isPassword: true,
                            colorField: Colors.grey.withAlpha(53),
                            controller: loginController.passwordController),
                        SizedBox(
                          height: 26,
                        ),

                        CustomButton(
                          height: 63,

                          width: size.width*0.9, buttonName: 'LOGIN', onTap:
                            () async {
                          EasyLoading.show(status: 'Loading....');

                          await loginController.onClickLogin();

                          if (loginController.modelUser != null) {
                            EasyLoading.showSuccess('sing up is done.');
                            Navigator.pushReplacementNamed(
                                context, '/Dashboard');
                            print('yes every things');
                          } else {
                            EasyLoading.showError(
                              'error page',
                            );
                            print('there are errors ');
                          }},




                        ),






                      ]),
                    )))));
  }
}



/*
   GestureDetector(
                          onTap: () async {
                            EasyLoading.show(status: 'Loading....');
                            //FocusScope.of(context).unfocus();
                            await loginController.onClickLogin();
                            if (loginController.modelUser != null) {
                              EasyLoading.showSuccess('sing up is done.');
                              Navigator.pushReplacementNamed(
                                  context, '/Dashboard');
                              print('yes every things');
                            } else {
                              EasyLoading.showError(
                                'error page',
                              );
                              print('there are errors ');
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: kblue,
                                borderRadius: BorderRadius.circular(12)),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Center(
                                  child: Text(
                                'LOGIN',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: size.width * 0.044,
                                    fontWeight: FontWeight.w500),
                              )),
                            ),
                          ),
                        ),
 */