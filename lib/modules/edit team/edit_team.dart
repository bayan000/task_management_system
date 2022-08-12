import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:provider/src/provider.dart';
import 'package:tracker/controllers/edit_team_provider.dart';
import '../../shared/components.dart';
import '../../shared/constants.dart';
import '../team/team.dart';

class EditTeam extends StatefulWidget {

  var id,name;
   EditTeam({ this.id,this.name}) ;

  @override
  State<EditTeam> createState() => _EditTeamState(id,name);
}

class _EditTeamState extends State<EditTeam> {
  var id,name;
  _EditTeamState(this.id,this.name);
EditTeamProvider editTeamProvider=EditTeamProvider();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    Size size =MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),

            onPressed: () {
              Navigator.of(context).pushReplacement(                                                         //new
                  new MaterialPageRoute(                                                                       //new
                      settings: const RouteSettings(name: '/team'),                                              //new
                      builder: (context) => new Team(id: id,) //new
                  )                                                                                            //new
              );
            },
          ),
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
                  child: Form(
                    key: formKey,
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
                                child: Padding(
                                  padding:EdgeInsets.only(right: 20,left:20,top: 20),
                                  child: defaultTextFormField(controller: editTeamProvider.teamName,
                                      type: TextInputType.name,
                                      hint: 'New team name',
                                      validate:(value){if(value!.isEmpty){
                                        return 'Enter new team name please ! ';
                                      }
                                      return null;} ,label:this.name as String,// 'Team name',
                                      prefix: Icons.group),
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
                            if(formKey.currentState!.validate())
                              {
                                EasyLoading.show(status: 'Loading....');
                                editTeamProvider.setTeamId(this.id);
                                await editTeamProvider.onEditTeam();
                                if (editTeamProvider.modelTeam != null)
                                {
                                  EasyLoading.showSuccess(editTeamProvider.message);
                                  Navigator.pushReplacementNamed(
                                      context, '/teams');
                                }
                                else if (editTeamProvider.modelTeam == null)
                                {
                                  EasyLoading.showError('oops!'+editTeamProvider.message);
                                }
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
                  ),
                )))
    );
  }
}
