
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import 'package:tracker/modules/user/user.dart';
import 'package:tracker/shared/components.dart';
import 'package:tracker/models/model_user.dart';

import 'package:tracker/shared/constants.dart';

import '../config/server_config.dart';
import '../controllers/user_controller.dart';
import '../models/user_model.dart';
import 'package:tracker/models/all_users_model.dart';
import '../shared/menu_item.dart';



class Users extends StatefulWidget {
  List<String> itemsList = ['Edit', 'Delete'];



  @override
  State<Users> createState() => _UsersState();
}

class _UsersState extends State<Users> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var userController=Provider.of<UserController>(context);
    return Scaffold(
        appBar: buildAppBar( text: 'All Users',

            color: Colors.blue,      prefixIcon: Icons.arrow_back,

            onPressedPre: (){
              Navigator.pop(context);

            }
        ),




        body: Stack(children: [
          Container(
//height: size.height * 0.3,
            color: Colors.white,

            child: Padding(
              padding: const EdgeInsets.only(
                  top: 20, left: 15.0, right: 15, bottom: 15),
              child:






              FutureBuilder<List<User>>(
                future: userController.onClickShowAllUser(),
                builder: (context, snapShot) {
                  //AsyncSnapShot
                  if (snapShot.hasData)
                    return

                      ListView.builder(
                        itemCount: snapShot.data!.length,
                        itemBuilder: (context, index) =>


                            GestureDetector(
                              onTap: (){



                                Navigator.of(context).pushReplacement(                                                         //new
                                    new MaterialPageRoute(                                                                       //new
                                        settings: const RouteSettings(name: '/user'),                                              //new
                                        builder: (context) => new UserScreen(id: snapShot.data![index].id as int,) //new
                                    )                                                                                            //new
                                );
                              },

                              child: Padding(
                                padding: EdgeInsets.only(bottom: 20.0),
                                child:

                                Row(
                                  children: [
                                    snapShot.data![index].img_profile==null?
                                    CircleAvatar(
                                        radius: 30,
                                        backgroundImage:AssetImage('assets/images/avatary.jpg'
                                        )):
                                    CircleAvatar(
                                        radius: 30,
                                        backgroundImage: NetworkImage(
                                          ServerConfig.domainName+'${snapShot.data![index].img_profile}',
                                        )),





                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: Row(


                                        children: [
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [

                                                Row(
                                                  children: [
                                                    Text(
                                                        '${snapShot.data![index].first_name}'),
                                                    SizedBox(
                                                      width: 2,
                                                    ),
                                                    Text(
                                                        '${snapShot.data![index].last_name}'),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 3,
                                                ),
                                                Text(
                                                  //DataUser.dataUs[index].email
                                                    '${snapShot.data![index].email}'),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            width: 18,
                                          ),
                                          Text(//DataUser.dataUs[index].role

                                              snapShot.data![index].role_id == 2
                                                  ? 'Leader '
                                                  : 'Member'),
                                          SizedBox(
                                            width: 30,
                                          ),
                                          PopupMenuButton<MenuItem>(
                                            onSelected: (item) {

                                              userController.id_user=snapShot.data![index].id;
                                              //userController.toAssignId(snapShot.data![index].id);

                                              print('id of user........');
                                              print(userController.id_user);
                                              return onSelected(
                                                  context, item, userController);
                                            },
                                            itemBuilder: (context) => [
                                              ...MenuItems.items
                                                  .map(buildItem)
                                                  .toList()
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                      );

                  if(snapShot.hasError)
                    return Center(
                      child: Text(snapShot.error.toString()),
                    );
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),

            ),


          ),


          Positioned(
            bottom: 0,
            right: 0,
            child: GestureDetector(
              onTap: () async{



                Navigator.pushNamed(context, '/AddUser');
                //  await userController.fetchRoles();
              },
              child: Container(
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(10),
                  width: 120,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10)),
                  child:
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                      Text(
                        'Add User',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      )
                    ],
                  )),
            ),
          )

        ]));
  }

// to build every item


  void onSelected(BuildContext context, MenuItem item, var userContr) {
    switch (item) {
      case MenuItems.itemDelete:
        showCupertinoDialog(
            context: context,
            builder: (context) => CupertinoAlertDialog(
              title: Text(
                ' Are you sure about deleting?',
                style: TextStyle(fontSize: 20),
              ),

              actions: [
                CupertinoDialogAction(
                  child: Text('Cancel'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                CupertinoDialogAction(
                  child: Text('OK'),
                  onPressed: () async {
                    await userContr.onClickDeleteUser();
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Deleted the user '),
                    ));
                    print('ok');
                    //update to list
                    Navigator.pop(context);
                  },
                )

              ],
            ));

        break;
      case MenuItems.itemEdit:
        print('yes edited');

        Navigator.pushNamed(context, '/EditUser');

        break;
    }
  }
}