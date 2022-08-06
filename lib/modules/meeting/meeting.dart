import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../shared/components.dart';
import '../../shared/constants.dart';

class Meeting extends StatelessWidget {
  const Meeting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

     Size size =MediaQuery.of(context).size;
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: appCo,
        shadowColor: appCo,
        elevation: 0,
        title: Text(appName,style: trackerStyle),),
      body: SafeArea(
        child: Container(
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
                                    child:  Text('23-5-2022',
                                        style: GoogleFonts.chewy(
                                            textStyle: TextStyle(
                                                fontWeight: FontWeight.w100,color: pu,fontSize: 18, letterSpacing: .5)//TextStyle(fontSize: 18,color: pu,fontWeight: FontWeight.w400
                                    )
                                ),
                                  ),
                             ]
                  ),
                  SizedBox(height:size.height*0.02),
                  Text('12:00',style: TextStyle(fontSize: 18),),
                  SizedBox(height:size.height*0.02),
                  Row(
                    children: [
                      const Text('Meeting status',style: TextStyle(overflow:TextOverflow.ellipsis,fontSize: 18,
                          fontWeight: FontWeight.bold,color: Colors.black87),),
                      SizedBox(width: size.width*0.03,),
                      const Text('Done',style: TextStyle(overflow:TextOverflow.ellipsis,fontSize: 18,
                          fontWeight: FontWeight.bold,color: Colors.black54),),
                    ],
                  ),
                  SizedBox(height:size.height*0.02),
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

                                    return buildMeetWithItem(size);
                              },
                                  separatorBuilder: (context, index) =>SizedBox(height: size.height*0.015,),

                                  itemCount:4
                                ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildMeetWithItem(Size size) =>
     Row(
       children: [
         CircleAvatar(
           radius: 20,
           backgroundImage:AssetImage('assets/images/avatary.jpg'
           ),),
         SizedBox(width: size.width*0.03),
         Text('Folan Al Folany',style: const TextStyle(fontSize: 18),),

       ],
     );
}
