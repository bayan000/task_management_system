import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../shared/components.dart';
import '../../shared/constants.dart';

class Meeting extends StatelessWidget {
  const Meeting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     List<String> members1=['Rama','Deema','Sara'];
     Size size =MediaQuery.of(context).size;
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: appCo,
        shadowColor: appCo,
        elevation: 0,
        title: Text(appName,style: trackerStyle),),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(size.height*0.025),
            child: Column(
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
                                  child: const Text('23/5/2022',style: TextStyle(fontSize: 18,color: Colors.black54,fontWeight: fw)
                              ),
                                ),
                           ]
                ),
                SizedBox(height:size.height*0.02),
                Row(
                  children: [
                    const Text('Team',style: TextStyle(overflow:TextOverflow.ellipsis,fontSize: 18,
                        fontWeight: FontWeight.bold,color: Colors.black87),),
                    SizedBox(width: size.width*0.03,),
                    const Text('Team name',style: TextStyle(overflow:TextOverflow.ellipsis,fontSize: 18,
                        fontWeight: FontWeight.bold,color: Colors.black54),),
                  ],
                ),
                SizedBox(height:size.height*0.02),
                Row(
                  children: [
                    const Text('meeting time',style: TextStyle(overflow:TextOverflow.ellipsis,fontSize: 18,
                        fontWeight: FontWeight.bold,color: Colors.black87),),
                    SizedBox(width: size.width*0.03,),
                    const Text('2:45',style: TextStyle(overflow:TextOverflow.ellipsis,fontSize: 18,
                        fontWeight: FontWeight.bold,color: Colors.black54),),
                  ],
                ),
                SizedBox(height:size.height*0.02),
                Row(
                  children: [
                    const Text('meeting status',style: TextStyle(overflow:TextOverflow.ellipsis,fontSize: 18,
                        fontWeight: FontWeight.bold,color: Colors.black87),),
                    SizedBox(width: size.width*0.03,),
                    const Text('cancelled',style: TextStyle(overflow:TextOverflow.ellipsis,fontSize: 18,
                        fontWeight: FontWeight.bold,color: Colors.black54),),
                  ],
                ),
                SizedBox(height:size.height*0.02),
                Row(
                  children: [
                    const Text('meeting with',style: TextStyle(overflow:TextOverflow.ellipsis,fontSize: 18,
                        fontWeight: FontWeight.bold,color: Colors.black87),),

                  ],
                ),
                SizedBox(height:size.height*0.02),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    getTextWidgets(members1),

                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
