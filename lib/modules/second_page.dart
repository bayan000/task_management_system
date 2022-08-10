
////for testinggggggggggggggggggggggggg
import 'package:flutter/material.dart';
import 'package:tracker/controllers/profile_controller.dart';

class SecondPage extends StatelessWidget {
  ProfileController profileController=ProfileController();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(

      body: SafeArea(

        child:Center(
            child:FutureBuilder<dynamic>(
              future: profileController.onClickShowProfile(),
             builder: (context,snapshot)
             { if(snapshot.connectionState==ConnectionState.waiting)
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
               return Center(child: Text(snapshot.error.toString(),style: TextStyle(fontSize: 20),),);
             }
               return   Container(
                   height: size.height*0.3,
                   width: double.infinity,
                   margin: EdgeInsets.all(size.width*0.025),
                   padding: EdgeInsets.all(size.width*0.025),
                   decoration: BoxDecoration(
                       color: Colors.grey.withOpacity(0.2),
                       borderRadius: BorderRadius.circular(size.width*0.025),

                       image: profileController.image
                           != null ?
                       DecorationImage(
                         //image:Image
                           image:AssetImage('${profileController.image}'),
                           fit: BoxFit.contain
                       ) : null



                   ));
             }

            )


        ),



      ),


    );
  }
}