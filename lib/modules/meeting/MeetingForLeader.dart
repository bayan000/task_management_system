import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tracker/config/server_config.dart';
import 'package:tracker/controllers/meetings_controller.dart';

import '../../models/meetingModel.dart';
import '../../models/user_model.dart';
import '../../shared/components.dart';
import '../../shared/constants.dart';
//meeting for leader or member
class MeetingForLeaderOm extends StatelessWidget {

  var id;

  MeetingForLeaderOm({Key? key, this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MeetingsController meetingsController=MeetingsController();

    Size size =MediaQuery.of(context).size;
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: appCo,
        shadowColor: appCo,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),

          onPressed: () {
            Navigator.pushReplacementNamed(
                context, '/leaders_meetings');
          },
        ),

        title: Text(appName,style: trackerStyle),),

      body: SafeArea(
          child: FutureBuilder<MeetingModel>(
              future: meetingsController.fetchMeeting(id),
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
                  return Container(
                    height: size.height,
                    width: size.width,
                    color: appFo,
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Padding(
                        padding: EdgeInsets.all(size.height*0.025),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                                alignment: AlignmentDirectional.topStart,
                                children:[
                                  Container(
                                      height: size.height*0.35,
                                      decoration: const BoxDecoration(
                                        image:DecorationImage(image: AssetImage("assets/images/meeting.jpg"),
                                          fit: BoxFit.fill,),)),
                                  Padding(
                                    padding: const EdgeInsets.only(top:55,left: 70 ),
                                    child:  Text(meetingsController.meeting?.meeting_date,
                                        style: GoogleFonts.chewy(
                                            textStyle: TextStyle(
                                                fontWeight: FontWeight.w100,color: pu,fontSize: 18, letterSpacing: .5)//TextStyle(fontSize: 18,color: pu,fontWeight: FontWeight.w400
                                        )
                                    ),
                                  ),
                                ]
                            ),
                            SizedBox(height:size.height*0.02),
                            Text(getTheHour(meetingsController.meeting?.start_at as String)
                              ,style: TextStyle(fontSize: 18),),
                            SizedBox(height:size.height*0.02),
                            Row(
                              children: [
                                const Text('Meeting status',style: TextStyle(overflow:TextOverflow.ellipsis,fontSize: 18,
                                    fontWeight: FontWeight.bold,color: Colors.black87),),
                                SizedBox(width: size.width*0.03,),
                                Text(meetingsController.statesMap[meetingsController.meeting?.meeting_status],style: TextStyle(overflow:TextOverflow.ellipsis,fontSize: 18,
                                    fontWeight: FontWeight.bold,color: Colors.black54),),
                              ],
                            ),
                            SizedBox(height:size.height*0.02),
                            meetingsController.meeting?.participants?.length !=0?
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Text('Meeting with :',style: TextStyle(overflow:TextOverflow.ellipsis,fontSize: 18,
                                        fontWeight: FontWeight.bold,color: pu),),

                                  ],
                                ),
                                SizedBox(height:size.height*0.02),


                                ListView.separated(
                                    physics: const BouncingScrollPhysics(),
                                    shrinkWrap:true,
                                    itemBuilder: (context, index) {

                                      return buildMeetWithItem(size,meetingsController.meeting?.participants,index);
                                    },
                                    separatorBuilder: (context, index) =>SizedBox(height: size.height*0.015,),

                                    itemCount:meetingsController.meeting?.participants?.length??0
                                )
                              ],
                            )
                                :
                            Text('Did not select participants',style: TextStyle(fontSize: size.width*0.05,color: appCo),)
                          ],
                        ),
                      ),
                    ),
                  );
                }
              }
          )
      ),
    );
  }

  Widget buildMeetWithItem(Size size,List<User> users,var i) =>
      Row(
        children: [
          users[i].img_profile==null?
          CircleAvatar(
              radius: 25.0,
              backgroundImage: AssetImage('assets/images/avatary.jpg'
              )):
          CircleAvatar(
              radius: 25.0,
              backgroundImage: NetworkImage(ServerConfig.domainName+'${users[i].img_profile as String}')
          ),
          SizedBox(width: size.width*0.03),
          Text('${users[i].first_name as String }'+" "+'${users[i].last_name as String }',style: const TextStyle(fontSize: 18),),
        ],
      );
}
