
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:tracker/controllers/add_subtask_controller.dart';

import '../../config/server_config.dart';
import '../../controllers/show_team_controller.dart';
import '../../models/showTeamModel.dart';
import '../../models/user_model.dart';
import '../../shared/constants.dart';
import '../subtask/add_subtask.dart';

class TeamLSelector extends StatefulWidget {
  TeamLSelector({Key? key}) : super(key: key);

  @override
  State<TeamLSelector> createState() => _TeamLSelectorState();
}

class _TeamLSelectorState extends State<TeamLSelector> {

  ShowTeamController showTeamController = ShowTeamController();
  AddSubtaskProvider addSubtaskProvider=AddSubtaskProvider();

  HashSet<User> selectedItem= HashSet();
  bool multiSelectionEnabled=false;
  @override
  Widget build(BuildContext context) {
    var name;

    Size size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
      appBar: AppBar(
        leading: Consumer<AddSubtaskProvider>(
            builder: (context,asp,child) {
              return IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  if(asp.l.length!=0)
                    asp.l.length=0;
                  Navigator.pushNamed(context,'/addsubtask');

                },
              );
            }
        ),
        title: Text('My team', style: trackerStyle,),
        automaticallyImplyLeading: false,
        backgroundColor: appCo,
        shadowColor: appCo,
        elevation: 0,

      ),
      backgroundColor: appFo,
      body: SafeArea(
        child: Stack(
          children: [
            Padding(

                padding: EdgeInsets.only(
                    top: size.height * 0.01,
                    left: size.width * 0.025,
                    right: size.width * 0.025), //.all(size.width*0.025),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FutureBuilder<ShowTeamModel>(
                          future:  showTeamController.fetchLyTeam(),
                          builder: (context,snapShot) {

                            if (snapShot.hasData)
                            {ShowTeamModel show = showTeamController.t as ShowTeamModel;
                            return ListView.separated(
                              physics: const BouncingScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) =>
                                  buildMemberItem(show, index, size),
                              separatorBuilder: (context, index) =>
                              const SizedBox(
                                height: 10,
                              ),
                              itemCount: show.teamMembers?.length ?? 0,
                            );}
                            if(snapShot.hasError)
                              return Center(
                                child: Text(snapShot.error.toString()),
                              );
                            return

                              Center(
                                child: CircularProgressIndicator(),
                              );
                          }
                      )


                    ],
                  ),
                )


            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding:  EdgeInsets.all(size.width*0.03),
                      child: Consumer<AddSubtaskProvider>(
                          builder: (context,asp,child) {
                            return ElevatedButton(
                              onPressed: () {

                                asp.savingSelectedItems(selectedItem);
                                if(asp.l.length==0)
                                  EasyLoading.showError("you must select some users");
                                else{

                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                    backgroundColor: pu,
                                    content: Text('selected '+'${asp.l.length}'+' users'),

                                  ));
                                  Navigator.pushReplacementNamed(
                                      context, '/addsubtask');

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
                Container(
                    height: size.height*0.05,

                    width: size.width,

                    color: Colors.grey,

                    child: Center(child: Text(getSelectedItemsCount(),style:
                    TextStyle(color: appFo,fontSize: size.width*0.045),)

                      ,

                    )),
              ],
            )
          ],
        ),
      )
      ,
    );
  }
  String getSelectedItemsCount() {
    return selectedItem.isNotEmpty ? selectedItem.length.toString() +
        " users selected" : "Select users";
  }
  void doMultiSelection(User user) {
    if (multiSelectionEnabled) {
      if (selectedItem.contains(user)) {
        selectedItem.remove(user);
      }
      else {
        selectedItem.add(user);
      }
      setState(() {

      });
    }
    else {

    }
  }
  Widget buildMemberItem(ShowTeamModel showTeamModel, var index, Size size) =>

      InkWell(
        onTap: () {
          doMultiSelection(showTeamModel.teamMembers![index] as User);
        },
        onLongPress: () {
          multiSelectionEnabled = true;
          doMultiSelection(showTeamModel.teamMembers![index] as User);
        },
        child: Stack(
          children: [
            Row(
              children: [
                Stack(
                  alignment: AlignmentDirectional.bottomEnd,
                  children: [
                    showTeamModel.teamMembers?[index]?.img_profile == null ?
                    CircleAvatar(
                        radius: 30.0,
                        backgroundImage: AssetImage(
                            'assets/images/avatary.jpg'
                        )
                    ) :
                    CircleAvatar(
                        radius: 30.0,
                        backgroundImage: NetworkImage(
                            ServerConfig.domainName +
                                '${showTeamModel.teamMembers?[index]
                                    ?.img_profile as String}')
                    )

                  ],
                ),
                SizedBox(
                  width: size.width * 0.05,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${showTeamModel.teamMembers?[index]
                            ?.first_name as String }' + " " +
                            '${showTeamModel.teamMembers?[index]
                                ?.last_name as String }',

                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      Row(
                        children:
                        [
                          Expanded(
                            child: Text(
                              'member',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          Visibility(visible: multiSelectionEnabled,
                              child: selectedItem.contains(showTeamModel
                                  .teamMembers![index] as User) ? Icon(

                                Icons.check_circle, color: pu,) :
                              Icon(Icons.check_circle_outlined, color: Colors
                                  .grey,)),

                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      );
}