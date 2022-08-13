
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:provider/provider.dart';
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
  //UserController userController = UserController();

  TextEditingController searchController = TextEditingController();

  @override
  State<Users> createState() => _UsersState();
}

class _UsersState extends State<Users> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        body: Stack(children: [
          Container(
//height: size.height * 0.3,
            color: Colors.blue,
          ),
          SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(top: 9.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {

                            Navigator.pop(context);

                          },
                          icon: Icon(Icons.arrow_back_outlined,
                              size: 27, color: Colors.white),
                        ),
                        Text(
                          'AllUser',
                          style: TextStyle(
                              color: Colors.white,
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

                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30))),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 20, left: 15.0, right: 15, bottom: 15),
                          child:



                          Consumer<UserController>(
                              builder: (context, userController, child) {
                                return


                                  FutureBuilder<List<User>>(
                                    future: userController.onClickShowAllUser(),
                                    builder: (context, snapShot) {
                                      //AsyncSnapShot
                                      if (snapShot.hasData)
                                        return ListView.builder(
                                          itemCount: snapShot.data!.length,
                                          itemBuilder: (context, index) => Padding(
                                            padding: EdgeInsets.only(bottom: 20.0),
                                            child: Row(
                                              children: [
                                                CircleAvatar(
                                                    radius: 30,
                                                    backgroundImage: NetworkImage(
                                                      // DataUser.dataUs[index].Img
                                                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRH6Uyi30Ty2WkMb0ZjuFLoXmkRwrrMObm-X2zztWtGbOgyA-i7mFzuiSKltN14HLAJDVM&usqp=CAU',
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
                                        );

                                      if(snapShot.hasError)
                                        return Center(
                                          child: Text(snapShot.error.toString()),
                                        );
                                      return Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    },
                                  );
                              }),
                        ),
                      ),
                    ),
                  ],
                ),
              )),
          Positioned(
            bottom: 0,
            right: 0,
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/AddUser');
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

  PopupMenuItem<MenuItem> buildItem(MenuItem item) => PopupMenuItem<MenuItem>(
    value: item,
    child: Row(
      children: [
        Icon(
          item.icon,
          color: Colors.black,
          size: 20,
        ),
        SizedBox(
          width: 12,
        ),
        Text(item.text),
      ],
    ),
  );

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
              content: Text(
                'This will completely delete the user',
                style: TextStyle(fontSize: 16),
              ),
              actions: [
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
                ),
                CupertinoDialogAction(
                  child: Text('Cancel'),
                  onPressed: () {
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