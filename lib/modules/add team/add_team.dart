import 'dart:async';
import 'dart:convert';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:tracker/config/server_config.dart';
import 'package:tracker/services/team_service.dart';
import 'package:tracker/shared/components.dart';
import 'package:http/http.dart' as http;
//import 'dart:convert';
import '../../shared/constants.dart';
import 'package:tracker/controllers/add_team_provider.dart';

class AddTeam extends StatefulWidget {
  const AddTeam({Key? key}) : super(key: key);

  @override
  State<AddTeam> createState() => _AddTeamState();
}

class _AddTeamState extends State<AddTeam> {

  AddTeamProvider addteamprovider=AddTeamProvider();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {


    Size size =MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),

          onPressed: () {
            // handle the ess
            Navigator.pushReplacementNamed(
                context, '/teams');
          },
        ),
        title:  Text('Add team',style:trackerStyle),
        automaticallyImplyLeading: false,
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
                  decoration:  BoxDecoration(borderRadius: BorderRadius.only(topRight: Radius.circular(r),
                      topLeft: Radius.circular(r),
                      bottomLeft:Radius.circular(r),bottomRight:Radius.circular(r)),
                    image:const DecorationImage(image: AssetImage("assets/images/teamy.jpg"),
                      fit: BoxFit.fill,),)
              ),

              Container(
              color: appFo,
              child: Padding(
                padding:const EdgeInsets.only(right: 20,left:20,top: 20),
               // padding: const EdgeInsets.all(8.0),
                child: defaultTextFormField(controller:addteamprovider.teamName,

                    hint: 'Team name',
                    type: TextInputType.name,
      validate:(value){if(value!.isEmpty){
      return 'Enter team name please ! ';
      }
      return null;} ,
                     label: 'Team name', prefix: Icons.group),
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
         /* TextButton(onPressed: (){}, child:  Text('add',
            style: TextStyle(fontSize: 22,color:pu,fontWeight: fw),)),*/
          ElevatedButton(
            onPressed: ()async{
              if(formKey.currentState!.validate())
                {
                  EasyLoading.show(status: 'Loading....');

                  await addteamprovider.onAddTeam();
                  if (addteamprovider.modelTeam != null)
                  {
                    EasyLoading.showSuccess(addteamprovider.message);
                    Navigator.pushReplacementNamed(
                        context, '/teams');
                  }
                  else if (addteamprovider.modelTeam == null)
                  {
                    EasyLoading.showError('oops!'+addteamprovider.message);
                  }
                }

              },
            child:  Text('add',style: TextStyle(color: appFo,fontSize: size.width*0.045)),
            style: ButtonStyle(
              //elevation: MaterialStateProperty.all(40),
              shape: MaterialStateProperty.all(const CircleBorder()),
              padding: MaterialStateProperty.all(const EdgeInsets.all(20)),
              foregroundColor: MaterialStateProperty.all(appFo),
              backgroundColor: MaterialStateProperty.all(pu), // <-- Button color
              overlayColor: MaterialStateProperty.resolveWith<Color?>((states) {
                if (
                states.contains(MaterialState.pressed)) return appFo; // <-- Splash color
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
