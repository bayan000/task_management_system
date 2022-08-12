import 'package:flutter/material.dart';
import 'package:tracker/controllers/show_team_controller.dart';
import 'package:tracker/models/showTeamModel.dart';
import 'package:tracker/modules/edit%20team/edit_team.dart';


import '../../controllers/teams_controller.dart';
import '../../shared/constants.dart';

class TeamL extends StatelessWidget{

  TeamL({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var name;
    ShowTeamController showTeamController=ShowTeamController();
    Size size =MediaQuery.of(context).size;
    return FutureBuilder<ShowTeamModel>(
      future: showTeamController.fetchLyTeam(),
      builder: (context,snapshot){
        if(snapshot.connectionState==ConnectionState.waiting)
        {

          return Column(
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
          ShowTeamModel show=showTeamController.t as ShowTeamModel;


          return  Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back),

                  onPressed: () {

                  },
                ),
                title:  Text('My team',style: trackerStyle,),
                automaticallyImplyLeading: false,
                backgroundColor: appCo,
                shadowColor: appCo,
                elevation: 0,

              ),
              backgroundColor: appFo,
              body: SafeArea(
                child:Padding(

                    padding:  EdgeInsets.only(
                        top:size.height*0.01,left:size.width*0.025,right: size.width*0.025  ),//.all(size.width*0.025),
                    child:SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      // physics: const NeverScrollableScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [ListView.separated(
                            physics:  const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) => buildMemberItem(show,index,size),
                            separatorBuilder: (context, index) =>
                            const SizedBox(
                              height: 10,
                            ),
                            itemCount: show.teamMembers?.length ??0,
                        ),],
                      ),
                    )


                ),
              )
          );

        }

      },
    );

  }
  Widget buildMemberItem(ShowTeamModel showTeamModel,var index,Size size) =>

      Row(
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomEnd,
            children:  [
              showTeamModel.teamMembers?[index]?.img_profile==null?
              CircleAvatar(
                  radius: 30.0,
                  backgroundImage: AssetImage('assets/images/avatary.jpg'
                  )
              ):
              CircleAvatar(
                  radius: 30.0,
                  backgroundImage:  NetworkImage(showTeamModel.teamMembers?[index]?.img_profile as String)
              )

            ],
          ),
          SizedBox(
            width: size.width*0.05,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${showTeamModel.teamMembers?[index]?.first_name as String }'+" "+'${showTeamModel.teamMembers?[index]?.last_name as String }',

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
                  const [
                    Expanded(
                      child: Text(
                        'member',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),


                  ],
                ),
              ],
            ),
          ),
        ],
      );
}