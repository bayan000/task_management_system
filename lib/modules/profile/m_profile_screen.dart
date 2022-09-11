import 'package:flutter/material.dart';
import 'package:tracker/modules/profile/m_edit_profile.dart';

import '../../config/server_config.dart';
import '../../controllers/profile_controller.dart';
import '../../models/user_model.dart';
import '../../shared/components.dart';

class MProfileScr extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    ProfileController profileController= ProfileController();
    Size size =MediaQuery.of(context).size;
    return

      SafeArea(
          child:
          FutureBuilder<User>(
              future:profileController.LfetchProfile(),

              builder: (context,snapshot) {


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
                  return Center(child: Text(snapshot.error.toString()//'Error !'
                    ,style: TextStyle(fontSize: 20),),);
                }
                else{
                  return








                    Column(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                            alignment: AlignmentDirectional.bottomCenter,
                            children: [

                              Column(

                                children: [
                                  Container(
                                    height: size.height*0.25,
                                    color: Colors.blue,

                                  ),
                                  Container(height: size.height*0.06,),


                                ],
                              ),
                              Positioned(
                                left: 0,
                                top: 8,
                                child: IconButton(
                                    onPressed: () {
                                      Navigator.pushNamed(context, '/DashboardTeamLeader');
                                    },
                                    icon: Icon(
                                      Icons.arrow_back,
                                      color: Colors.white,
                                    )),
                              ),

                              Column(
                                children: [

                                  //  (ServerConfig.domainName+'${GetStorage().read('img_profile')}' )== (ServerConfig.domainName+'null')?

                                  snapshot.data!.img_profile !=null?

                                  CircleAvatar(
                                      radius: 70,
                                      backgroundImage: NetworkImage(
                                        ServerConfig.domainName+'${snapshot.data!.img_profile}',
                                      )):
                                  const CircleAvatar(
                                      radius: 70,
                                      backgroundImage:

                                      AssetImage('assets/images/avatary.jpg'
                                      )
                                  ),




                                ],
                              ),



                            ]
                        ),
                        SizedBox(height: size.height*0.02,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('${snapshot.data!.first_name}',style: TextStyle(fontSize: 20),),
                            SizedBox(width: 5,),
                            Text('${snapshot.data!.last_name}',style: TextStyle(fontSize: 20),),
                          ],),
                        SizedBox(height: size.height*0.03,),



                        Row(
                          children: [
                            const Icon(Icons.email),
                            SizedBox(width: size.width*0.03,),
                            Text('${snapshot.data!.email}',
                              style:TextStyle(fontSize: 18,color:Colors.grey[700]) ,),
                          ],
                        ),
                        SizedBox(height: size.height*0.02,),




                        snapshot.data!.phone !=null ?
                        Row(
                          children: [
                            const Icon(Icons.phone),
                            SizedBox(width: size.width*0.03,),
                            Text('${snapshot.data!.phone}',style:TextStyle(fontSize: 18,color: Colors.grey[700]) ,),
                          ],
                        ):
                        Row(
                          children: [
                            const Icon(Icons.phone),
                            SizedBox(width: size.width*0.03,),
                            Text('Not available',style:TextStyle(fontSize: 18,color: Colors.grey[700]) ,),
                          ],
                        ),

                        SizedBox(height: size.height*0.02,),
                        snapshot.data!.contact !=null ?
                        Row(
                          children: [
                            const Icon(Icons.link),
                            SizedBox(width: size.width*0.03,),
                            Text('${snapshot.data!.contact}',style:TextStyle(fontSize: 18,color: Colors.grey[700]) ,),
                          ],
                        ):
                        Row(
                          children: [
                            const Icon(Icons.phone),
                            SizedBox(width: size.width*0.03,),
                            Text('Not available',style:TextStyle(fontSize: 18,color: Colors.grey[700]) ,),
                          ],
                        ),


                        SizedBox(height: size.height*0.02,),
                        snapshot.data!.education !=null ?
                        Row(
                          children: [
                            const Icon(Icons.phone),
                            SizedBox(width: size.width*0.03,),
                            Text('${snapshot.data!.education}',style:TextStyle(fontSize: 18,color: Colors.grey[700]) ,),
                          ],
                        ):
                        Row(
                          children: [
                            const Icon(Icons.phone),
                            SizedBox(width: size.width*0.03,),
                            Text('Not available',style:TextStyle(fontSize: 18,color: Colors.grey[700]) ,),
                          ],
                        ),



                        Spacer(),



                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                          child: CustomButton(height: 40, width: double.infinity,buttonColor: Colors.blue, buttonName: 'Edit My Profile',
                              onTap:(){
                                print('jjj');
                                print(profileController.modelProfile.id);

                                Navigator.of(context).pushReplacement(//new
                                    new MaterialPageRoute(
                                      //new
                                        settings: const RouteSettings(
                                            name: '/MEditProfile'), //new
                                        builder: (context) => new MEditProfile(
                                          id: profileController.modelProfile.id as int,
                                          img:profileController.modelProfile.img_profile as String?,

                                        ) //new
                                    ) //new
                                );
                                //Navigator.pushNamed(context,'/EditProfile');


                              }),
                        )


                      ],
                    );}})
      );
  }
}