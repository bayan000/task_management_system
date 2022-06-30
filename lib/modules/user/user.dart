import 'package:flutter/material.dart';

import '../../shared/constants.dart';

class User extends StatelessWidget {
  const User({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
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
                    fit: BoxFit.fill,),)

            ),
            Container(height: size.height*0.06,),
          ],
        ),

         Column(
           children: [

             const CircleAvatar(
                  radius: 55,
                  backgroundImage: AssetImage('assets/images/kogoro.jpg')
              ),
             SizedBox(height: size.height*0.01,),
             const Text('Mouri kogoro',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
           ],
         ),


        ]
      ),

      SizedBox(height: size.height*0.02,),
      Row(
        children: [
           const Icon(Icons.email),
          SizedBox(width: size.width*0.03,),
        const  Text('Metante.Kogoro@gmail.com',style:TextStyle(fontSize: 16,color: Colors.grey) ,),
        ],
      ),
      SizedBox(height: size.height*0.01,),
      Row(
        children: [
          const Icon(Icons.phone),
          SizedBox(width: size.width*0.03,),
          const Text('+81 72 8123456',style:TextStyle(fontSize: 16,color: Colors.grey) ,),
        ],
      ),
      SizedBox(height: size.height*0.01,),
      Row(
        children: [
          const Text('member ''at '),
          SizedBox(width: size.width*0.03,),
          const Text('detecting team',style:TextStyle(fontSize: 16,color: Colors.grey) ,),
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
