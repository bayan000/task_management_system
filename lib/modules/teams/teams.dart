import 'package:flutter/material.dart';


import '../../shared/constants.dart';
import '../add team/add_team.dart';

class Teams extends StatelessWidget {
  const Teams({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size =MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Teams'),
        automaticallyImplyLeading: false,
        // centerTitle: true,
        titleTextStyle: const TextStyle(fontSize: 25,color:pu,fontWeight: fw),
        backgroundColor: appCo,
        shadowColor: appCo,
        elevation: 0,

      ),
      backgroundColor: appFo,
        body: SafeArea(
          child:Padding(

              padding:  EdgeInsets.only(
                  top:size.height*0.01,left:size.width*0.025,right: size.width*0.025  ),//.all(size.width*0.025),
              child:Stack(
                alignment: Alignment.bottomRight,
                children: [SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  // physics: const NeverScrollableScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [ListView.separated(
                      physics:  const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) => buildTeamItem(size.height*0.3,size.width*0.9),
                      separatorBuilder: (context, index) =>
                      Container(width: size.width,height: size.height*0.001,color:Colors.grey,),
                      itemCount: 10,
                    ),],
                  ),
                ),
                  Padding(
                    padding:  EdgeInsets.all(size.width*0.07),
                    child: ElevatedButton(
                      onPressed: () {Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const AddTeam()));},
                      child: const Icon(Icons.add),
                      style: ButtonStyle(
                        elevation: MaterialStateProperty.all(40),
                        shape: MaterialStateProperty.all(const CircleBorder()),
                        padding: MaterialStateProperty.all(const EdgeInsets.all(20)),
                        foregroundColor: MaterialStateProperty.all(appFo),
                        backgroundColor: MaterialStateProperty.all(appCo), // <-- Button color
                        overlayColor: MaterialStateProperty.resolveWith<Color?>((states) {
                          if (states.contains(MaterialState.pressed)) return pu; // <-- Splash color
                        }),
                      ),
                    ),
                  )
                ],

              )


          ),
        )
    );
  }
  Widget buildTeamItem(double h,double w) =>
      Row(
        children: [
      Stack(

        alignment: Alignment.topLeft,
        children:[Row(
          children: [

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: h*0.1,),
                SizedBox(
                  height: h*0.2,
                    width: w,
                    child: const Text('Team name ',style: TextStyle(overflow:TextOverflow.ellipsis,fontSize: 20,
                        fontWeight: FontWeight.bold,color: Colors.black87),))
                ,Container(
                  height: h*0.85,
                  width: w,

                  decoration: const BoxDecoration(color: appFo,
                    image:DecorationImage(image: AssetImage("assets/images/team.jpg"),
                        fit: BoxFit.contain
                    ),),
                ),
              ],),

          ],
        ),


        ]
      )
        ],
      );

}
