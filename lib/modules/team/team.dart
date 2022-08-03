import 'package:flutter/material.dart';
import 'package:tracker/controllers/show_team_controller.dart';
import 'package:tracker/models/showTeamModel.dart';
import 'package:tracker/modules/edit%20team/edit_team.dart';


import '../../controllers/teams_controller.dart';
import '../../shared/constants.dart';

class Team extends StatelessWidget{
  var id;
  Team({Key? key, this.id}) : super(key: key);
  //Team({this.id});
  @override
  Widget build(BuildContext context) {
    var length;
    var name;
    ShowTeamController showTeamController=ShowTeamController();
    Size size =MediaQuery.of(context).size;
    return FutureBuilder<ShowTeamModel>(
      future: showTeamController.fetchTeam(id),
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
          ShowTeamModel show=showTeamController.teamModel as ShowTeamModel;
          if(show.teamMembers?.length != null)
            {
              length=show.teamMembers?.length ;
              length++;
            }

return  Scaffold(
    appBar: AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),

        onPressed: () {
          Navigator.pushReplacementNamed(
              context, '/teams');
        },
      ),
      title:  Text(show.teamModel?.name as String,style: trackerStyle,),
      automaticallyImplyLeading: false,
      // centerTitle: true,
actions: [
  IconButton(icon: Icon(Icons.edit),
  onPressed: (){
    if(show.teamModel?.name !=null)
      name=show.teamModel?.name;
    Navigator.of(context).pushReplacement(                                                         //new
            new MaterialPageRoute(                                                                       //new
              settings: const RouteSettings(name: '/edit_team'),                                              //new
              builder: (context) => new EditTeam(id: this.id,name:name ,) //new
            )                                                                                            //new
          );

  },)
],
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
                itemCount: length//show.teamMembers?.length ??0,
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
  index==0?
  Row(

        children: [
          SizedBox(
            width: size.width*0.02,),
          Text('Team Leader',style: TextStyle(fontSize: size.width*0.05,fontWeight: FontWeight.bold,color: myGray),)
,SizedBox(
  width: size.width*0.14,),
          Stack(
            alignment: AlignmentDirectional.bottomEnd,
            children:  [
              showTeamModel.teamLeader?[0]?.img_profile==null?
              CircleAvatar(
                radius: 30.0,
                  backgroundImage: AssetImage('assets/images/avatary.jpg'
                  )
              ):
              CircleAvatar(
                  radius: 30.0,
                  backgroundImage: NetworkImage(showTeamModel.teamLeader?[0]?.img_profile as String)
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

                   '${showTeamModel.teamLeader?[0]?.first_name as String }'+" "+'${showTeamModel.teamLeader?[0]?.last_name as String }',

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

              ],
            ),
          ),

          ],
      ):Row(
    children: [
      Stack(
        alignment: AlignmentDirectional.bottomEnd,
        children:  [
          showTeamModel.teamMembers?[index-1]?.img_profile==null?
          CircleAvatar(
              radius: 30.0,
              backgroundImage: AssetImage('assets/images/avatary.jpg'
              )
          ):
          CircleAvatar(
              radius: 30.0,
              backgroundImage:  NetworkImage(showTeamModel.teamMembers?[index-1]?.img_profile as String)
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
        '${showTeamModel.teamMembers?[index-1]?.first_name as String }'+" "+'${showTeamModel.teamMembers?[index-1]?.last_name as String }',

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