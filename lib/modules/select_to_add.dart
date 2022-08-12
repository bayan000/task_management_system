
import 'dart:collection';
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

import '../controllers/add_meeting_controller.dart';
import '../controllers/user_controller.dart';
import '../models/user_model.dart';
import '../shared/constants.dart';

import '../shared/menu_item.dart';
import 'edit meeting/edit_meeting.dart';

class SelectToAddUsers extends StatefulWidget {
  SelectToAddUsers({Key? key,  }) : super(key: key) ;
  TextEditingController searchController = TextEditingController();
  static var selectionDone;
  @override
  State<SelectToAddUsers> createState() => _SelectToAddUsersState();
}

class _SelectToAddUsersState extends State<SelectToAddUsers> {
  AddMeetingProvider addMeetingProvider=AddMeetingProvider();
  HashSet<User> selectedItem= HashSet();
  bool multiSelectionEnabled=false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        body: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
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
                            Consumer<AddMeetingProvider>(
                                builder: (context,amp,child) {
                                  return IconButton(
                                    onPressed: () {



                                      if(amp.l.length!=0)
                                        amp.l.length=0;

                                      print(amp.l.length);
    Navigator.pushReplacementNamed(
    context, '/add_meeting');


                                    },
                                    icon: Icon(Icons.arrow_back_outlined,
                                        size: 27, color: Colors.white),
                                  );
                                }
                            ),
                            Text(
                                'Users',
                                style: trackerStyle),
                            //Spacer(),
                            SizedBox(
                              width: size.width * 0.06,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: size.width * 0.06,
                        ),

                        Expanded(
                          child: Padding(
                            padding:  EdgeInsets.only(
                                top:size.height*0.01,left:size.width*0.025,right: size.width*0.025  ),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(30),
                                      topRight: Radius.circular(30))),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 20, left: 15.0, right: 15),
                                child:



                                Consumer<AddMeetingProvider>(
                                    builder: (context, addMeetingController, child) {
                                      return FutureBuilder<List<User>>(
                                        future: addMeetingController.onClickShowAllUser(),
                                        builder: (context, snapShot) {
                                          if (snapShot.hasData) {

                                            return ListView.builder(
                                                physics: const BouncingScrollPhysics(),
                                                itemCount: snapShot.data!.length,
                                                itemBuilder: (context, index) {
                                                  return    userItem(snapShot.data!,index,addMeetingController,
                                                  );}
                                            );
                                          }

                                          if(snapShot.hasError)
                                            return Center(
                                              child: Text(snapShot.error.toString()),
                                            );
                                          return

                                            Center(
                                              child: CircularProgressIndicator(),
                                            );
                                        },
                                      );
                                    }),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding:  EdgeInsets.all(size.width*0.03),
                        child: Consumer<AddMeetingProvider>(
                            builder: (context,amp,child) {
                              return ElevatedButton(
                                onPressed: () {

                                  amp.savingSelectedItems(selectedItem);
                                  if(amp.l.length==0)
                                    EasyLoading.showError("you must select some users");
                                  else{

                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                      backgroundColor: pu,
                                      content: Text('selected '+'${amp.l.length}'+' users'),

                                    ));
                                    Navigator.pushReplacementNamed(
                                        context, '/add_meeting');

                                  }

                                },
                                child:  Text(' select ',style: TextStyle(color: appFo,fontSize: size.width*0.045)),
                                style: ButtonStyle(
                                  //elevation: MaterialStateProperty.all(40),
                                  shape: MaterialStateProperty.all(const CircleBorder()),
                                  padding: MaterialStateProperty.all(const EdgeInsets.all(20)),
                                  foregroundColor: MaterialStateProperty.all(appFo),
                                  backgroundColor: MaterialStateProperty.all(pu), // <-- Button color
                                  overlayColor: MaterialStateProperty.resolveWith<Color?>((states) {
                                    if (states.contains(MaterialState.pressed)) return pu; // <-- Splash color
                                  }),
                                ),
                              );
                            }
                        ),
                      )
                    ],
                  ),
                  Padding(

                    padding: EdgeInsets.only(left:size.width*0.022,right:size.width*0.022,top:size.width*0.1),

                    child:   Container(



                        height: size.height*0.05,

                        width: size.width,

                        color: Colors.grey,

                        child: Center(child: Text(getSelectedItemsCount(),style:
                        TextStyle(color: appFo,fontSize: size.width*0.045),)

                          ,

                        )),

                  ),
                ],
              )
            ]));
  }
  String getSelectedItemsCount(){
    return selectedItem.isNotEmpty?selectedItem.length.toString()+" users selected":"Select users";
  }
  void doMultiSelection(User user){
    if(multiSelectionEnabled){
      if (selectedItem.contains(user))
      {
        selectedItem.remove(user);
      }
      else
      {
        selectedItem.add(user);
      }
      setState(() {

      });
    }
    else{

    }

  }

  Widget userItem(List<User> users,var index,AddMeetingProvider addMeetingProvider,){

    return InkWell(
        onTap: (){
          doMultiSelection(users[index]);
        },
        onLongPress: (){
          multiSelectionEnabled=true;
          doMultiSelection(users[index]);
        },
        child: Stack(
          alignment: Alignment.centerRight,
          children: [Padding(
            padding: EdgeInsets.only(bottom: 20.0),
            child: Row(
              children: [
                users[index].img_profile==null?
                CircleAvatar(
                    radius: 25.0,
                    backgroundImage: AssetImage('assets/images/avatary.jpg'
                    )):
                CircleAvatar(
                    radius: 25.0,
                    backgroundImage: NetworkImage(users[index].img_profile as String)
                ),
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
                                    '${users[index].first_name}'),
                                SizedBox(
                                  width: 2,
                                ),
                                Text(
                                    '${users[index].last_name}'),
                              ],
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Text(
                                '${users[index].email}'),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 18,
                      ),
                      Text(

                          users[index].role_id == 2
                              ? 'Leader '
                              : 'Member'),
                      SizedBox(
                        width: 30,
                      ),
                      Visibility(visible:multiSelectionEnabled,child:selectedItem.contains(users[index])?  Icon(

                        Icons.check_circle,color: pu,):Icon(Icons.check_circle_outlined,color: Colors.grey,)),

                    ],
                  ),
                ),
              ],
            ),
          ),],
        )

    );
  }
}
