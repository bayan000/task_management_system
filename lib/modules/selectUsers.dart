
import 'dart:collection';
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:tracker/controllers/edit_meeting_controller.dart';

import '../controllers/user_controller.dart';
import '../models/user_model.dart';
import '../shared/constants.dart';

import '../shared/menu_item.dart';
import 'edit meeting/edit_meeting.dart';

class SelectUsers extends StatefulWidget {

  var id;
  SelectUsers({ this.id}) ;
  TextEditingController searchController = TextEditingController();

  static var selectionDone;
  @override
  State<SelectUsers> createState() => _SelectUsersState(id);
}

class _SelectUsersState extends State<SelectUsers> {
  int id;
  EditMeetingProvider editMeetingProvider=EditMeetingProvider();
  _SelectUsersState(this.id);
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
                        Consumer<EditMeetingProvider>(
                          builder: (context,emp,child) {
                            return IconButton(
                              onPressed: () {


                                  this.id=id;
if(emp.l.length!=0)
  emp.l.length=0;

                                  print(emp.l.length);
                                  Navigator.of(context).pushReplacement(                                                         //new
                                      new MaterialPageRoute(                                                                       //new
                                          settings: const RouteSettings(name: '/meeting'),                                              //new
                                          builder: (context) =>  EditMeeting(id:id,) //new
                                      )                                                                                            //new
                                  );


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



                            Consumer<EditMeetingProvider>(
                                builder: (context, editMeetingController, child) {
                                  return FutureBuilder<List<User>>(
                                    future: editMeetingController.onClickShowAllUser(),
                                    builder: (context, snapShot) {
                                      if (snapShot.hasData) {

                                        return ListView.builder(
                                          physics: const BouncingScrollPhysics(),
                                          itemCount: snapShot.data!.length,
                                          itemBuilder: (context, index) {/*
if (snapShot.data?[index].isSelected ?? false) {
  snapShot.data?[index].isSelected = false;
    }*/
                                          return    userItem(snapShot.data!,index,editMeetingController,
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
          // Consumer<EditMeetingProvider>(builder: (context,emp,child){
          child: Consumer<EditMeetingProvider>(
            builder: (context,emp,child) {
              return ElevatedButton(
                onPressed: () {

                  emp.savingSelectedItems(selectedItem);
                  if(emp.l.length==0)
                    EasyLoading.showError("you must select some users");
                  else{
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      backgroundColor: pu,
                      content: Text('selected '+'${emp.l.length}'+' users'),
                    ));
                    this.id=id;
                    Navigator.of(context).pushReplacement(                                                         //new
                        new MaterialPageRoute(                                                                       //new
                            settings: const RouteSettings(name: '/meeting'),                                              //new
                            builder: (context) =>  EditMeeting(id:id,) //new
                        )                                                                                            //new
                    );
                  }
                //  print(emp.l[2]);

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
//SizedBox(height:size.height*0.0001),
        Padding(

      padding: EdgeInsets.only(left:size.width*0.022,right:size.width*0.022,top:size.width*0.1),

      child:   Container(



        height: size.height*0.05,

        width: size.width,

        color: Colors.grey,

          child: Center(child: Text(getSelectedItemsCount(),style: TextStyle(color: appFo,fontSize: size.width*0.045),)

          ,

          )),

    ),
  ],
)
        ]));
  }
  String getSelectedItemsCount(){
    return selectedItem.isNotEmpty?selectedItem.length.toString()+" user selected":"Select users";
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

Widget userItem(List<User> users,var index,EditMeetingProvider editMeetingProvider,){

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
                 // editMeetingProvider.drawIt(users[index].id)
/*
                editMeetingProvider.map[users[index].id]==true?*/
Visibility(visible:multiSelectionEnabled,child:selectedItem.contains(users[index])?  Icon(

  Icons.check_circle,color: pu,):Icon(Icons.check_circle_outlined,color: Colors.grey,)),
                //    Icon(Icons.check_circle,color: pu,):



                ],
              ),
            ),
          ],
        ),
      ),],
    )
   /* onTap: (){
      /*setState(() {

       // users[index].isSelected=editMeetingProvider.setSelection(users[index].isSelected);
        //String m='${users[index].isSelected}';
        //print(m);
/*
        if(users[index].isSelected==true)
        {
          editMeetingProvider.addAparticipant('${users[index].first_name}','${users[index].last_name}',
              users[index].id);
          //print('hey boy');
          //selectedParticipants.add(User(first_name:'${users[index].first_name}',last_name: '${users[index].last_name}',
          //id:users[index].id,isSelected: true
          //));
          //editMeetingProvider.meetingWith.add(users[index]);
        }
        else if (users[index].isSelected==false)
        {
          editMeetingProvider.deleteAparticipant(users, index, users[index].id);
          //selectedParticipants.removeWhere((element) => element?.id==users[index].id);
          //editMeetingProvider.meetingWith.removeWhere((element) => element?.id==users[index].id);
        }
        print(editMeetingProvider.map[users[index].id]);
       // print(editMeetingProvider.l);
        //print(users[index].isSelected.toString());
        //  print(editMeetingProvider.meetingWith[index]?.isSelected.toString());*/
      });*/
    },*/
  );
}
}
