import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:tracker/modules/card_subtask.dart';
import 'package:tracker/modules/subtask/a_subtask.dart';

import '../controllers/task_controller.dart';
import '../models/subtask_model.dart';
import '../models/task_model.dart';
import '../shared/components.dart';
import '../shared/constants.dart';


class TaskDetail extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var taskController=Provider.of< TaskController >(context);
    return Scaffold(
      appBar: buildAppBar( text: 'Task Details',color: Colors.blue,centerTitle: false,
          prefixIcon: Icons.arrow_back,
          onPressedPre: (){

            Navigator.pop(context);
          }

      ),
      body:

      Container(
          margin: EdgeInsets.symmetric(horizontal: 8,vertical: 20),
          width: double.infinity,
          child:

          FutureBuilder< Task >(
            future: taskController.testy(),
            builder: (context, snapShot) {
              //AsyncSnapShot
              if (snapShot.hasData)
                return

                  Column(
                    children: [
                      Text(

                        '${snapShot.data!.title}'
                        ,
                        style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),
                      ),
                      SizedBox(height: 15,),
                      Text(

                        '${snapShot.data!.description}'
                        ,
                        maxLines: 6,
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color:Colors.grey[700]
                        ),
                      ),






                      Container(
                        margin: EdgeInsets.only(top:35,bottom:40),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [


                              Row(children: [

                                Text('The Status of this Task is :',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),),
                                SizedBox(width: 10,),

                                Text( '${taskController.taskstates[snapShot.data!.status_id]}'   ,style: TextStyle(color:Colors.purple,fontWeight: FontWeight.bold),)
                              ],),

                              SizedBox(height: 20,),
                              Row(children: [
                                Text(' The Statrt Date is :',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),),
                                SizedBox(width: 10,),
                                Text('${snapShot.data!.start_date}',style: TextStyle(color:Colors.purple,fontWeight: FontWeight.bold,),),


                              ],),
                              SizedBox(height: 20,),
                              Row(children: [
                                Text(' The End Date is :',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500)),
                                SizedBox(width: 10,),
                                Text('${snapShot.data!.end_date}',style: TextStyle(color:Colors.purple,fontWeight: FontWeight.bold),),


                              ],),





                            ]),
                      ),






                      Text('The SubTasks of this task',style: TextStyle(color:Colors.blue,fontWeight: FontWeight.bold,fontSize: 15))

                      ,Divider(color: Colors.grey,),




                      Expanded(
                          child:
                          ListView.builder(



                              itemCount: snapShot.data!.subtasks!.length,
                              itemBuilder: (context, index) =>
                                  GestureDetector(


                                    onTap: (){


                                      Navigator.of(context).push(                                                         //new
                                          new MaterialPageRoute(                                                                       //new
                                              settings: const RouteSettings(name: '/a_subtask'),                                              //new
                                              builder: (context) => new ASubTask(id:  snapShot.data!.subtasks![index]!.id as int,) //new
                                          )                                                                                            //new
                                      );

                                    },

                                    child: Column(children: [

                                      Container(height: size.height*0.14,width: double.infinity,
                                          padding: EdgeInsets.fromLTRB(10,15,10,8),

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

                                                        '${snapShot.data!.subtasks![index]!.title}'
                                                        ,
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            fontWeight: FontWeight.w500,
                                                            color: Colors.black),
                                                      ),

                                                    ],),
                                                    SizedBox(height: 8,),
                                                    Text(

                                                      '${snapShot.data!.subtasks![index]!.description}'
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
                                                      height: size.width*0.07,
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
                                                          '${snapShot.data!.subtasks![index]!.end_at}'

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

                          )




                      )




                    ],);

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




    );
  }
}