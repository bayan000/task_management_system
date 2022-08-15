import 'package:flutter/material.dart';

import '../../config/server_config.dart';
import '../../controllers/user_controller.dart';
import '../../models/all_users_model.dart';
import '../../models/user_model.dart';
import '../../shared/constants.dart';

class UserScreen extends StatelessWidget {
  var id;
   UserScreen({Key? key,this.id}) : super(key: key);
  @override
  Widget build(BuildContext context) {
User use=User();
     UserController userController=UserController();
    //userController.onClickShowUser(this.id);
    print(this.id);
    //print('ok');
    //print(userController.im.img_profile);

    Size size =MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),

            onPressed: () {
              Navigator.pushReplacementNamed(
                  context, '/Users');
            },
          ),
          title:  Text(appName,style: trackerStyle,),
          automaticallyImplyLeading: false,
          // centerTitle: true,
          titleTextStyle:  const TextStyle(fontSize: 25,color:appFo,fontWeight: fw),
          backgroundColor: appCo,
          shadowColor: appCo,
          elevation: 0,

        ),
        backgroundColor: appFo,
        body: SafeArea(
            child: SingleChildScrollView(
                child: Padding(

                    padding: EdgeInsets.all(size.height*0.025),

                    child: FutureBuilder<User>(
                        future:userController.onClickShowUser(id),

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
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                                alignment: AlignmentDirectional.bottomCenter,
                                children: [Column(
                                  children: [
                                    Container(
                                        height: size.height*0.25,

                                        decoration: const BoxDecoration(color: appFo,
                                          image:DecorationImage(
                                            image: AssetImage("assets/images/cover.jpg"),
                                            fit: BoxFit.fill,),)

                                    ),
                                    Container(height: size.height*0.06,),
                                  ],
                                ),

                                  Column(
                                    children: [
                                      /*CircleAvatar(
                                                      radius: 30,
                                                      backgroundImage:AssetImage('assets/images/avatary.jpg'
                                                      )):
                                                  CircleAvatar(
                                                      radius: 30,
                                                      backgroundImage: NetworkImage(
                                                        ServerConfig.domainName+'${snapShot.data![index].img_profile}',
                                                      )),*/
snapshot.data!.img_profile==null?
                                      const CircleAvatar(
                                          radius: 55,
                                          backgroundImage:

                                          AssetImage('assets/images/avatary.jpg')
                                      ):
                                    CircleAvatar(
                                        radius: 55,
                                        backgroundImage: NetworkImage(
                                          ServerConfig.domainName+'${snapshot.data!.img_profile}',
                                        )),
                                      SizedBox(height: size.height*0.01,),
                                       Text('${snapshot.data!.first_name}'+' '+'${snapshot.data!.last_name}',
                                         style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                                    ],
                                  ),


                                ]
                            ),

                            SizedBox(height: size.height*0.02,),
                            Row(
                              children: [
                                const Icon(Icons.email),
                                SizedBox(width: size.width*0.03,),
                                Text('${snapshot.data!.email}',
                                  style:TextStyle(fontSize: 16,color: Colors.grey) ,),
                              ],
                            ),
                            SizedBox(height: size.height*0.01,),
                            snapshot.data!.phone!=null?
                            Row(
                              children: [
                                const Icon(Icons.phone),
                                SizedBox(width: size.width*0.03,),
                                 Text('${snapshot.data!.phone}',style:TextStyle(fontSize: 16,color: Colors.grey) ,),
                              ],
                            ):
                            Row(
                              children: [
                                const Icon(Icons.phone),
                                SizedBox(width: size.width*0.03,),
                                Text('Not available',style:TextStyle(fontSize: 16,color: Colors.grey) ,),
                              ],
                            ) ,
                            SizedBox(height: size.height*0.01,),
                            snapshot.data!.teamName!=null?
                            Row(
                              children: [
                                const Text('member ''at '),
                                SizedBox(width: size.width*0.03,),
                                 Text('${snapshot.data!.teamName}',style:TextStyle(fontSize: 16,color: Colors.grey) ,),
                              ],
                            ):
                            Row(
                              children: [
                                const Text('member ''at '),
                                SizedBox(width: size.width*0.03,),
                                Text('no team',style:TextStyle(fontSize: 16,color: Colors.grey) ,),
                              ],
                            )
                          ],
                        );}
                      }
                    )
                )
            )
        )
    );
  }
}