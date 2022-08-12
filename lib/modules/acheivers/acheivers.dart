import 'package:flutter/material.dart';
import 'package:tracker/controllers/achivers_controller.dart';

import '../../config/server_config.dart';
import '../../models/user_model.dart';
import '../../shared/constants.dart';

class Acheivers extends StatelessWidget {
  const Acheivers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AcheiversController acheiversController=AcheiversController();
    Size size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
      backgroundColor: appFo,
        appBar: AppBar(
          backgroundColor: appCo,
          shadowColor: appCo,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {},
          ),
          title: Text("Acheivers", style: trackerStyle),),
        body: SafeArea(
            child:
            Container(
              color: appFo,
              child: Padding(
                padding:  EdgeInsets.only(
                    left:size.width*0.025,right: size.width*0.025  ),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Container(
                      color: appFo,
                      child: FutureBuilder(
                          future:acheiversController.fetchAcheivers(),
                        builder: (context,snapshot) {
                          return Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              height:size.height*0.25,
                                              width: size.width*0.3,
                                              decoration: const BoxDecoration(color: appFo,
                                                image:DecorationImage(image: AssetImage("assets/images/medalsF.jpg"),
                                                    fit: BoxFit.fill
                                                ),),
                                            ),
                                            Container(
                                              width: size.width*0.65,
                                              height: size.height*0.1,
                                              decoration: BoxDecoration(

                                                  color: Colors.yellow[700],
                                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(30),bottomLeft: Radius.circular(30) )
                                              ),

                                            )

                                          ],
                                        ),
                                        Row(

                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: ListView.separated(
                                                    physics: const BouncingScrollPhysics(),
                                                    scrollDirection: Axis.vertical,
                                                    shrinkWrap: true,
                                                    itemBuilder: (context, index) {

                                                      return buildAcheiverItem(size,acheiversController.goldies,index);
                                                    },
                                                    separatorBuilder: (context, index) =>SizedBox(height: size.height*0.015,),

                                                    itemCount:acheiversController.goldies.length!=0?
                                                    acheiversController.goldies.length:
                                                        1
                                                ),
                                              ),
                                            ),


                                          ],
                                        ),




                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              height:size.height*0.25,
                                              width: size.width*0.3,

                                              decoration: const BoxDecoration(color: appFo,

                                                image:DecorationImage(image: AssetImage("assets/images/medalss.jpg"),
                                                    fit: BoxFit.fill
                                                ),),
                                            ),

                                            Container(
                                              width: size.width*0.65,
                                              height: size.height*0.1,
                                              decoration: BoxDecoration(

                                                  color: Colors.brown[100],
                                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(30),bottomLeft: Radius.circular(30) )
                                              ),

                                            )

                                          ],
                                        ),
                                        Row(

                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: ListView.separated(
                                                    physics: const BouncingScrollPhysics(),
                                                    scrollDirection: Axis.vertical,
                                                    shrinkWrap: true,
                                                    itemBuilder: (context, index) {

                                                      return buildAcheiverItem(size,acheiversController.silvers,index);
                                                    },
                                                    separatorBuilder: (context, index) =>SizedBox(height: size.height*0.015,),

                                                    itemCount:acheiversController.silvers.length!=0?
                                                        acheiversController.silvers.length:1
                                                ),
                                              ),
                                            ),


                                          ],
                                        ),




                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              height:size.height*0.25,
                                              width: size.width*0.3,

                                              decoration: const BoxDecoration(color: appFo,

                                                image:DecorationImage(image: AssetImage("assets/images/medalsTh.jpg"),
                                                    fit: BoxFit.fill
                                                ),),
                                            ),
                                            SizedBox(width: size.width*0.01,),
                                            Container(
                                              width: size.width*0.64,
                                              height: size.height*0.1,
                                              decoration: BoxDecoration(

                                                  color: Colors.yellow[900],
                                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(30),bottomLeft: Radius.circular(30) )
                                              ),

                                            )

                                          ],
                                        ),
                                        Row(

                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: ListView.separated(
                                                    physics: const BouncingScrollPhysics(),
                                                    scrollDirection: Axis.vertical,
                                                    shrinkWrap: true,
                                                    itemBuilder: (context, index) {

                                                      return buildAcheiverItem(size,acheiversController.bronzers,index);
                                                    },
                                                    separatorBuilder: (context, index) =>SizedBox(height: size.height*0.015,),

                                                    itemCount:acheiversController.bronzers.length!=0?acheiversController.bronzers.length:1
                                                ),
                                              ),
                                            ),


                                          ],
                                        ),




                                      ],
                                    ),
                                  ),
                                ],
                              ),
/****/
                            ],
                          );
                        }
                      )
                  ),
                ),
              ),
            )

        ));
  }
  buildAcheiverItem(Size size,List<User> users,var i)=>
  users.length!=0?
      Row(
        children: [
          users[i].img_profile==null?
          CircleAvatar(
              radius: 25.0,
              backgroundImage:

            AssetImage("assets/images/team.jpg")

          ):
          CircleAvatar(
              radius: 25.0,
              backgroundImage:

              NetworkImage('${ServerConfig.domainName}'+'${users[i].img_profile}')

          ),

          SizedBox(width: size.width*0.03),
          Text('${users[i].first_name as String }'+" "+'${users[i].last_name as String }',
             style: const TextStyle(fontSize: 18),),
        ],
      ):
      Container(
        height: size.height*0.04,
        width: size.width,
        color: appFo,
        child: Center(
          child:Text('No one is on this list',style: TextStyle(color: pu),)
        ),
      )
  ;
}