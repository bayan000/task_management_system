import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:tracker/services/team_service.dart';
import 'package:tracker/models/team_model.dart';

import '../../controllers/teams_controller.dart';
import '../../shared/constants.dart';
import '../add team/add_team.dart';

class Teams extends StatefulWidget {
   Teams({Key? key}) : super(key: key);

  @override
  State<Teams> createState() => _TeamsState();
}

class _TeamsState extends State<Teams> {


  @override
  Widget build(BuildContext context) {
    TeamsController teamsController=TeamsController();
teamsController.fetchTeams();
    Size size =MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title:  Text('Teams',style: trackerStyle,),
        automaticallyImplyLeading: false,
        // centerTitle: true,
        backgroundColor: appCo,
        shadowColor: appCo,
        elevation: 0,

      ),
      backgroundColor: appFo,
        body: SafeArea(
          child:Padding(

              padding:  EdgeInsets.only(
                  top:size.height*0.01,left:size.width*0.025,right: size.width*0.025  ),//.all(size.width*0.025),
              child:Stack(
                alignment: Alignment.bottomRight,
                children: [SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  // physics: const NeverScrollableScrollPhysics(),

                  /*child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [ListView.separated(
                      physics:  const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) => buildTeamItem(size.height*0.3,size.width*0.9),
                      separatorBuilder: (context, index) =>
                      Container(width: size.width,height: size.height*0.001,color:Colors.grey,),
                      itemCount: 10,
                    ),],
                  ),*/

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      FutureBuilder<List<TeamModel>>(
                      future: teamsController.fetchTeams(),
                    builder: (context,snapshot){
                        if(snapshot.connectionState==ConnectionState.waiting)
                        {return Column(
                          children: [
                            SizedBox(height: size.height*0.37,),
                            Container(
                              alignment: AlignmentDirectional.bottomCenter,
                              child: Center(child: Column(children: [
                                CircularProgressIndicator(),
                                SizedBox(height: size.height*0.01,),
                                Text('loading...',style: TextStyle(fontSize: 15),),],)),),
                          ],
                        );}
                        if(snapshot.hasError)
                          {
                            return Column(
                              children: [
                                SizedBox(height: size.height*0.37,),
                                Container(
                                  alignment: AlignmentDirectional.bottomCenter,
                                  child: Center(child: Text('Error',style: TextStyle(fontSize: 20),)),),
                              ],
                            );
                          }
                        else{
                          return Column(
                            children: [
                              ListView.separated(
                                itemBuilder: (context, index) {
                                  var team=snapshot.data?[index];
                                  return buildTeamItem(size.height*0.3,size.width*0.9,
                                    '${team?.name}',

                                    // '${snapshot.data.teams[index].name}',
                                  );},
                                separatorBuilder: (context, index) =>

                                    Container(width: size.width,height: size.height*0.001,color:Colors.grey,),

                                itemCount:snapshot.data?.length ??0, //snapshot.data.length //TeamService.teams.length,
                              ),
                      Padding(
                      padding:  EdgeInsets.all(size.width*0.07),
                      child: ElevatedButton(
                      onPressed: () {Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const AddTeam()));},
                      child: const Icon(Icons.add),
                      style: ButtonStyle(
                      elevation: MaterialStateProperty.all(40),
                      shape: MaterialStateProperty.all(const CircleBorder()),
                      padding: MaterialStateProperty.all(const EdgeInsets.all(20)),
                      foregroundColor: MaterialStateProperty.all(appFo),
                      backgroundColor: MaterialStateProperty.all(pu), // <-- Button color
                      overlayColor: MaterialStateProperty.resolveWith<Color?>((states) {
                      if (states.contains(MaterialState.pressed)) return pu; // <-- Splash color
                      }),)))
                            ],
                          );
                        }

    }


                    ),],
                  ),
                ),

                ],

              )


          ),
        )
    );
  }

  Widget buildTeamItem(double h,double w,String name) =>
      Row(
        children: [
      Stack(

        alignment: Alignment.topLeft,
        children:[Row(
          children: [

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: h*0.1,),
                SizedBox(
                  height: h*0.2,
                    width: w,
                    child:  Text('$name',style: TextStyle(overflow:TextOverflow.ellipsis,fontSize: 20,
                        fontWeight: FontWeight.bold,color: Colors.black87),))
                ,Container(
                  height: h*0.85,
                  width: w,

                  decoration: const BoxDecoration(color: appFo,
                    image:DecorationImage(image: AssetImage("assets/images/team.jpg"),
                        fit: BoxFit.contain
                    ),),
                ),
              ],),

          ],
        ),


        ]
      )
        ],
      );

String nameChecker(var name){
  if(name==null)
    {
      name='No team has been found';
    }
  return name;
}
}
