import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:tracker/controllers/add_subtask_controller.dart';
import 'package:tracker/controllers/edit_subtask_controller.dart';

import '../../controllers/task_controller.dart';
import '../../models/task_model.dart';
import '../../shared/constants.dart';
import '../attachment/add_attachment.dart';
import '../subtask/l_sub_task.dart';
import '../subtask/m_subtask.dart';

class LDetailsTask extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var taskController=Provider.of< TaskController >(context);
    int role_id = GetStorage().read(
        'role_id');
    return Scaffold(
      appBar:role_id==2?
     buildAppBar( text: 'Task Details ',suffixIcon:Icons.add,color: Colors.blue,centerTitle: false,
          prefixIcon: Icons.arrow_back,
          onPressedPre: (){

            Navigator.pushNamed(context,'/LedTaskScreen');
          },
         onPressedSuf: ()async{
           Navigator.pushNamed(context,'/addsubtask');



         }
      ):
      buildAppBar( text: 'Task Details ',color: Colors.blue,centerTitle: false,
          prefixIcon: Icons.arrow_back,
          onPressedPre: (){

            Navigator.pushNamed(context,    '/MTaskScr',
            );
          },
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
                                  Consumer<EditSubtaskProvider>(
                                    builder: (context,editSubPr,child) {
                                      return Consumer<AddSubtaskProvider>(
                                        builder: (context,addSubPr,chil) {
                                          return GestureDetector(

                                            onTap: () async {
                                              editSubPr.subtaskuId=snapShot.data!.subtasks![index]!.id as int;

                                              int role_id = await GetStorage().read(
                                                  'role_id');
                                              if (role_id == 2) {

                                                Navigator.of(context).push(                                                         //new
                                                    new MaterialPageRoute(                                                                       //new
                                                        settings: const RouteSettings(name:  '/l_subtask'),                                              //new
                                                        builder: (context) => new LeaderSubTask(id:  snapShot.data!.subtasks![index]!.id as int,) //new
                                                    )                                                                                            //new
                                                );

                                              }
                                              else if(role_id == 3){
                                                Navigator.of(context).push(                                                         //new
                                                    new MaterialPageRoute(                                                                       //new
                                                        settings: const RouteSettings(name: '/msubtask'),                                              //new
                                                        builder: (context) => new MemSubTask(id: snapShot.data!.subtasks![index]!.id as int) //new
                                                    )                                                                                            //new
                                                );




                                              }







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
                                          );
                                        }
                                      );
                                    }
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
      floatingActionButton: FloatingActionButton(backgroundColor:Colors.purple,
          onPressed: ()async{
            print(taskController.id_task);
            Navigator.of(context).pushReplacement(                                                         //new
                new MaterialPageRoute(                                                                       //new
                    settings: const RouteSettings(name: '/AddAttachement'),                                              //new
                    builder: (context) =>  AddAttachement(id: taskController.id_task as int,) //new
                )                                                                                            //new
            );





          },child: Row(children: [Icon(Icons.add),Icon(Icons.attachment)],)),




    );
  }
}