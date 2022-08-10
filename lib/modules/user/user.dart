import 'package:flutter/material.dart';

import '../../models/all_users_model.dart';
import '../../shared/constants.dart';
class UserScreen extends StatelessWidget {
  late Map<String,dynamic> passedData;
  UserScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    passedData = ModalRoute.of(context)!.settings.arguments! as Map<String,dynamic>;
    Size size =MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                            alignment: AlignmentDirectional.bottomCenter,
                            children: [Column(
                              children: [
                                Container(
                                  height: size.height*0.25,

                                  decoration: const BoxDecoration(color: appFo,
                                    image:DecorationImage(image: AssetImage("assets/images/cover.jpg"),
                                      fit: BoxFit.fill,),),

                                ),
                                Container(height: size.height*0.06,),
                              ],
                            ),

                              Column(
                                children: [

                                  CircleAvatar(
                                      radius: 55,
                                      backgroundImage: NetworkImage(passedData['image'])
                                  ),
                                  SizedBox(height: size.height*0.01,),

                                 Text((passedData['user'] as TheUsers).firstName! + " " +  (passedData['user'] as TheUsers).lastName!,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                                ],
                              ),


                            ]
                        ),

                        SizedBox(height: size.height*0.02,),
                        Row(
                          children: [
                            const Icon(Icons.email),
                            SizedBox(width: size.width*0.03,),
                            Text((passedData['user'] as TheUsers).email!,style:TextStyle(fontSize: 16,color: Colors.grey) ,),
                          ],
                        ),
                        SizedBox(height: size.height*0.01,),
                        Row(
                          children: [
                            const Icon(Icons.phone),
                            SizedBox(width: size.width*0.03,),
                            Text('+81 72 8123456',style:TextStyle(fontSize: 16,color: Colors.grey) ,),
                          ],
                        ),
                        SizedBox(height: size.height*0.01,),
                        Row(
                          children: [
                            const Text('member ''at '),
                            SizedBox(width: size.width*0.03,),
                            Text((passedData['user'] as TheUsers).employeeIdentical!,style:TextStyle(fontSize: 16,color: Colors.grey) ,),
                          ],
                        ),
                      ],
                    )
                )
            )
        )
    );
  }
}