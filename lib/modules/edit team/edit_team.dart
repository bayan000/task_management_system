import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:provider/src/provider.dart';
import 'package:tracker/controllers/edit_team_provider.dart';
import '../../shared/components.dart';
import '../../shared/constants.dart';

class EditTeam extends StatefulWidget {
  const EditTeam({Key? key}) : super(key: key);

  @override
  State<EditTeam> createState() => _EditTeamState();
}

class _EditTeamState extends State<EditTeam> {
EditTeamProvider editTeamProvider=EditTeamProvider();
  @override
  Widget build(BuildContext context) {
   // var formKey = GlobalKey<FormState>();
    Size size =MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title:  Text('Edit team',style: trackerStyle,),
          automaticallyImplyLeading: false,
          // centerTitle: true,
         // titleTextStyle:  TextStyle(fontSize: 25,color:appFo,fontWeight: fw),
          backgroundColor: appCo,
          shadowColor: appCo,
          elevation: 0,
        ),
        backgroundColor: appCo,
        body:  SafeArea(
            child:Padding(

                padding:  EdgeInsets.only(
                    top:size.height*0.01,left:size.width*0.025,right: size.width*0.025  ),//.all(size.width*0.025),
                child:SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(height: size.height*0.10,),
                      Stack(
                          alignment: AlignmentDirectional.bottomCenter,
                          children:[
                            Container(
                                height: size.height*0.4,
                                decoration: const BoxDecoration(borderRadius: BorderRadius.only(topRight: Radius.circular(30),topLeft: Radius.circular(30)),
                                  image:DecorationImage(image: AssetImage("assets/images/teamy.jpg"),
                                    fit: BoxFit.fill,),)
                            ),
                            Container(
                              color: appFo,
                              child: Column(
                                children: [
                                  Padding(
                                    padding:EdgeInsets.only(right: 20,left:20,top: 20),
                                    // padding: const EdgeInsets.all(8.0),
                                    child: defaultTextFormField(controller: editTeamProvider.teamId,
                                        type: TextInputType.name,
                                        hint: 'Team id',
                                        validate: (value){
                                          if(value!=null){print(value);}
                                        }, label: 'Team id', prefix: Icons.group),
                                  ),
                                  Padding(
                                    padding:EdgeInsets.only(right: 20,left:20,top: 20),
                                    // padding: const EdgeInsets.all(8.0),
                                    child: defaultTextFormField(controller: editTeamProvider.teamName,
                                        type: TextInputType.name,
                                        hint: 'Team name',
                                        validate: (value){
                                          if(value!=null){print(value);}
                                        }, label: 'Team name', prefix: Icons.group),
                                  ),
                                ],
                              ),
                            ),]
                      ),
                      Container(

                          height: size.height*0.08,
                          decoration:  BoxDecoration( color: appFo,borderRadius: BorderRadius.only(
                              bottomLeft:Radius.circular(r),bottomRight:Radius.circular(r)),
                          )
                      ),
                      SizedBox(height:size.height*0.06),
                      ElevatedButton(
                        onPressed: ()async{
                          EasyLoading.show(status: 'Loading....');

                          await editTeamProvider.onEditTeam();
                          if (editTeamProvider.modelTeam != null)
                          {
                            EasyLoading.showSuccess('team edited successfully');
                            Navigator.pushReplacementNamed(
                                context, '/teams');
                          }
                          else if (editTeamProvider.modelTeam == null)
                          {
                            EasyLoading.showError('Something is wrong');
                          }
                        },
                        child:  Text('edit',style: TextStyle(color: appFo,fontSize: size.width*0.045)),
                        style: ButtonStyle(
                          //elevation: MaterialStateProperty.all(40),
                          shape: MaterialStateProperty.all(const CircleBorder()),
                          padding: MaterialStateProperty.all(const EdgeInsets.all(20)),
                          foregroundColor: MaterialStateProperty.all(appFo),
                          backgroundColor: MaterialStateProperty.all(pu), // <-- Button color
                          overlayColor: MaterialStateProperty.resolveWith<Color?>((states) {
                            if (states.contains(MaterialState.pressed)) return appFo; // <-- Splash color
                          }),
                        ),
                      )

                    ],
                  ),
                )))
    );
  }
}
