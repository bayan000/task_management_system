
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import 'package:tracker/shared/components.dart';
import 'package:tracker/models/model_user.dart';

import 'package:tracker/shared/constants.dart';

import '../controllers/user_controller.dart';
import '../models/user_model.dart';
import '../shared/menu_item.dart';


class Users extends StatefulWidget {
  @override
  State<Users> createState() => _UsersState();

}

class _UsersState extends State<Users> {
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    context.read<UserController>().getAllUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('hello all users');


    Size size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
        body:
        Stack(children: [
          Container(
//height: size.height * 0.3,
            color: kblue,
          ),
          SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(top: 9.0),
                child: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.arrow_back_outlined, size: 27,
                            color: Colors.white),
                      ),
                      Text(
                        'AllUser',
                        style: TextStyle(color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.w500),
                      ),
                      //Spacer(),
                      IconButton(
                        icon: Icon(Icons.notifications_outlined,
                            size: 27, color: Colors.white),
                        onPressed: () {},
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.width * 0.06,
                  ),

                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child:
                    CustomField(
                        height: size.height * 0.065,
                        prefixIcon: Icon(Icons.search),
                        borderRadius: 40,
                        allBorder: false,
                        hintText: 'Search',
                        isPassword: false,
                        controller: searchController),

                  )

                  , SizedBox(
                    height: size.width * 0.07,
                  ),

                  Expanded(child: Container(

                      decoration: BoxDecoration(color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30))),

                      child: Padding(
                          padding: const EdgeInsets.only(
                              top: 20, left: 15.0, right: 15, bottom: 15),
                          child: context
                              .watch<UserController>()
                              .allUsersModel != null ?
                          ListView.builder(itemCount: context
                              .watch<UserController>()
                              .allUsersModel!
                              .theUsers!
                              .length, itemBuilder: (context, index) =>
                              InkWell(
                                onTap: () {
                                  Navigator.pushNamed(context, '/user',
                                      arguments: {
                                        'user': context
                                            .read<UserController>()
                                            .allUsersModel!
                                            .theUsers![index],
                                        'image': DataUser.dataUs[index].Img
                                      });
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(bottom: 20.0),
                                  child: Row(children: [

                                    CircleAvatar(radius: 30,
                                        backgroundImage: NetworkImage(
                                            DataUser.dataUs[index].Img

                                        )),
                                    SizedBox(width: 10,),
                                    Expanded(
                                      child: Row(

                                        //mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                        children: [

                                          Expanded(
                                            child: Column(

                                              crossAxisAlignment: CrossAxisAlignment
                                                  .start,

                                              children: [

                                                Text(context
                                                    .watch<UserController>()
                                                    .allUsersModel!
                                                    .theUsers![index]
                                                    .firstName!),

                                                SizedBox(height: 3,),

                                                Text(context
                                                    .watch<UserController>()
                                                    .allUsersModel!
                                                    .theUsers![index].email!),


                                              ],),
                                          ),
                                          SizedBox(width: 18,),
                                          Text(context
                                              .watch<UserController>()
                                              .allUsersModel!
                                              .theUsers![index].roleId == 2
                                              ? 'leader'
                                              : 'member'),
                                          SizedBox(width: 30,),

                                          PopupMenuButton( icon: const Icon(Icons.more_vert),
                                            onSelected: (value){
                                              if(value == 1){
                                                //TODO: promote or demote user
                                              }else{
                                                //TODO: delete user
                                              }
                                            },
                                            itemBuilder: (BuildContext context) {
                                              String changeTo = context
                                                  .read<UserController>()
                                                  .allUsersModel!
                                                  .theUsers![index].roleId == 2 ? "demote to member" : "promote to leader";

                                              return [
                                                PopupMenuItem<int>(
                                                  value: 1,
                                                  child: Text(changeTo),
                                                ),
                                                const PopupMenuItem<int>(
                                                  value: 2,
                                                  child: Text("delete"),
                                                ),
                                              ];

                                            },)

                                        ],),
                                    ),

                                  ],),
                                ),
                              ),
                          ) : const Center(child: CircularProgressIndicator()))
                  )),


                ],),

              )


          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(10),
                width: 120,

                decoration: BoxDecoration(
                    color: Colors.pinkAccent,
                    borderRadius: BorderRadius.circular(4)),
                child:
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed('/add_user');
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.add, color: Colors.white,),
                      Text(
                        'Add User',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      )

                    ],),
                )

            ),
          )

        ]));
  }




}



