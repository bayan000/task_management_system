import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tracker/shared/components.dart';

import '../../shared/constants.dart';

class AddTeam extends StatelessWidget {
  const AddTeam({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController teamNameController=TextEditingController();

    Size size =MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add team'),
        automaticallyImplyLeading: false,
        // centerTitle: true,
        titleTextStyle: const TextStyle(fontSize: 25,color:pu,fontWeight: fw),
        backgroundColor: appCo,
        shadowColor: appCo,
        elevation: 0,
      ),
      backgroundColor: appCo,
      body:  SafeArea(
        child:Padding(

    padding:  EdgeInsets.only(
    top:size.height*0.01,left:size.width*0.025,right: size.width*0.025  ),//.all(size.width*0.025),
    child:SingleChildScrollView(
    physics: const BouncingScrollPhysics(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: size.height*0.10,),
        Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children:[
            Container(
                height: size.height*0.4,
                decoration: const BoxDecoration(borderRadius: BorderRadius.only(topRight: Radius.circular(30),topLeft: Radius.circular(30)),
                  image:DecorationImage(image: AssetImage("assets/images/teamy.jpg"),
                    fit: BoxFit.fill,),)
            ),
            Container(
            color: appFo,
            child: Padding(
              padding:EdgeInsets.only(right: 20,left:20,top: 5),
             // padding: const EdgeInsets.all(8.0),
              child: defaultTextFormField(controller: teamNameController,
                  type: TextInputType.name,
                  validate: (value){
                if(value!=null){print(value);}
                  }, label: 'Team name', prefix: Icons.group),
            ),
          ),]
        ),
        SizedBox(height:size.height*0.06),
        TextButton(onPressed: (){}, child: const Text(' Add ',
          style: TextStyle(fontSize: 20,color:pu,fontWeight: fw),)),

      ],
    ),
    )))
    );
  }
}
