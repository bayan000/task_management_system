import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tracker/shared/constants.dart';

import '../../controllers/task_controller.dart';
import '../../models/task_model.dart';

class MTaskScr extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: buildAppBar(onPressedPre: (){
        Navigator.pushNamed(context,'/DashboardMember');


      },prefixIcon: Icons.arrow_back,text:'Tasks',
          suffixIcon:Icons.search,
          color: Colors.blue,
          onPressedSuf: (){

            Navigator.pushNamed(context,'/SearchPage');


          }),
      body:

      Consumer<TaskController>(
          builder: (context,taskController,_)=>
              FutureBuilder< List<Task> >(
                future:taskController.lShowALLTasks() ,
                builder: (context,snapShot){
                  //AsyncSnapShot
                  if(snapShot.hasData)
                    return

                      ListView.builder(itemCount: snapShot.data!.length,itemBuilder: (context,index)=>
                          GestureDetector(
                            onTap: (){
                              taskController.id_task=snapShot.data![index].id;


                              Navigator.pushNamed(context, '/LDetailsTask');

                            },
                            child: Column(children: [


                              Container(height: size.height*0.15,width: double.infinity,
                                  color: Colors.white,
                                  padding: EdgeInsets.fromLTRB(20,20,10,10),

                                  child:

                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(flex: 2,child:Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children:[


                                            Row(children: [
                                              Container(decoration: BoxDecoration(shape: BoxShape.circle,color:Colors.blue,),height: 6,width: 6,),
                                              SizedBox(width: 8,),
                                              Text(

                                                '${snapShot.data![index].title}'
                                                ,
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.black),
                                              ),

                                            ],),
                                            SizedBox(height: 8,),
                                            Text(

                                              '${snapShot.data![index].description}'
                                              ,
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.grey[600],
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),

                                            SizedBox(
                                              height: size.width*0.09,
                                            ),
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.calendar_today_outlined,
                                                  size: 15,
                                                  color:Colors.blue,
                                                ),
                                                SizedBox(
                                                  width: size.width*0.016,
                                                ),
                                                Text(
                                                  '${snapShot.data![index].start_date}'

                                                  ,
                                                  style: TextStyle(
                                                      fontSize: 13, color: Colors.blue,fontWeight: FontWeight.w500),
                                                ),
                                              ],
                                            )



                                          ]), ),





                                    ],)



                              ),

                              Divider(color:Colors.grey)

                            ],),
                          )
                      );



                  if(snapShot.hasError)
                    return Center(
                      child: Text(snapShot.error.toString()),
                    );

                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              )
      ),
      floatingActionButton: FloatingActionButton(backgroundColor:Colors.purple,
        onPressed: ()async{

          Navigator.pushNamed(context, '/LAttachementScr');



        },child: Icon(Icons.attachment),) ,






    );


  }
}