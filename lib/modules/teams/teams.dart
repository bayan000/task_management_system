import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:tracker/config/server_config.dart';
import 'package:tracker/models/showTeamModel.dart';
import 'package:tracker/modules/team/team.dart';
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
var team;
var team_id;
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
                //  top:size.height*0.01,
                  left:size.width*0.025,right: size.width*0.025  ),//.all(size.width*0.025),
            /**/
              child:Consumer<TeamsController>(
                builder: (context,teamsController,child) {
                  return FutureBuilder<List<TeamModel>>(
                  future: teamsController.fetchTeams(),
                    builder: (context,snapshot){
                    if(snapshot.connectionState==ConnectionState.waiting)
                    {return Column(
                      children: [
                        SizedBox(height: size.height*0.37,),
                        Container(
                          height: size.height*0.5,
                          alignment: AlignmentDirectional.bottomCenter,
                          child: Center(child: Column(children: [
                            CircularProgressIndicator(),
                            SizedBox(height: size.height*0.01,),
                            Text('loading...',style: TextStyle(fontSize: 15),),],)),),
                      ],
                    );}
                    if(snapshot.hasError)
                      {
                        return Center(child: Text('Error !',style: TextStyle(fontSize: 20),),);
                      }
                    else{
                      return Stack(
                        alignment: Alignment.bottomRight,
                        children: [SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ListView.separated(
                                physics: const BouncingScrollPhysics(),
                          shrinkWrap:true,
                                itemBuilder: (context, index) {
                                    team=snapshot.data?[index];
                                  return buildTeamItem(context,size.height*0.3,size.width*0.9,
                                    '${team?.name}',team?.id,teamsController
                                  );},
                                separatorBuilder: (context, index) =>

                                    Container(width: size.width,height: size.height*0.0005,color:Colors.grey,),

                                itemCount:snapshot.data?.length ??0, //snapshot.data.length //TeamService.teams.length,
                              ),

                            ],
                          ),

                        ),
                          Padding(
                              padding:  EdgeInsets.all(size.width*0.07),
                              child: ElevatedButton(
                                  onPressed: () {
                                   Navigator.pushReplacementNamed(
                                  context, '/add_team');
                                  },
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
                      ]);
                    }

    }


                    );
                }
              )


          )
        )
    );
  }

  Widget buildTeamItem(BuildContext context,double h,double w,String name,int id,TeamsController teamsController) =>
      GestureDetector(
        onTap: (){
          Navigator.of(context).pushReplacement(                                                         //new
            new MaterialPageRoute(                                                                       //new
              settings: const RouteSettings(name: '/team'),                                              //new
              builder: (context) => new Team(id: id,) //new
            )                                                                                            //new
          );
       },
        child: Row(
          children: [
        Stack(
          alignment: Alignment.topLeft,
          children:[Row(
            children: [

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: h*0.05,),
                  Row(
                    children: [
                      SizedBox(width: w*0.1,),
                      SizedBox(
                        height: h*0.2,
                        width: w*0.81,
                        child: Center(
                          child: Text('$name',style: TextStyle(overflow:TextOverflow.ellipsis,fontSize: 20,
                              fontWeight: FontWeight.bold,color: myGray//Colors.black87
                          ),),
                        ),
                      ),
                      SizedBox(width: w*0.009,),
                      IconButton(color:pu,onPressed: /* showAlertDialog(*/()async=>{
                        await showAlertDialog(context,w,teamsController,id)}, icon: Icon(Icons.delete))
                    ],
                  )
                  ,Container(
                    height: h*0.85,
                    width: w*0.9,

                    decoration:  BoxDecoration(color: appFo,
                      image:DecorationImage(image:
                       AssetImage("assets/images/team.jpg"),
                     //'http://192.168.43.139:8000/'
                     //'images/1660201018.png'
                          fit: BoxFit.contain
                      ),),
                  ),
                ],),

            ],
          ),


          ]
        )
          ],
        ),
      );
  showAlertDialog(BuildContext context,double w,TeamsController teamsController,int id) {


    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed:  () =>{ Navigator.pop(context)},
    );
    Widget continueButton = TextButton(
      child: Text("Delete"),
      onPressed:  ()async {await teamsController.deletion(id);
      if (teamsController.message=="200" || teamsController.message=="201")
      {
       // EasyLoading.showSuccess("team deleted successfully");
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('team deleted successfully'),
        ));
        Navigator.pop(context);
      }
      else
      {
        EasyLoading.showError('oops! error'+teamsController.message.toString());

      }
      },

    );
    Widget iconty=Icon(Icons.delete,size: w*0.1,);

    AlertDialog alert = AlertDialog(
      title:iconty,
      content: Text("Do you really want to delete this team ?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

}
