import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

import '../../controllers/notifications.dart';
import '../../controllers/task_controller.dart';
import '../../models/notification_model.dart';
import '../../shared/constants.dart';
import '../meeting/MeetingForLeader.dart';
import '../subtask/l_sub_task.dart';
import '../subtask/m_subtask.dart';

class NotificationsScre extends StatefulWidget {
  @override
  State<NotificationsScre> createState() => _NotificationsScreState();
}

class _NotificationsScreState extends State<NotificationsScre> {
  TaskController taskController=TaskController();
  int selected = 0;
  var pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar( text: 'Notifications',
            color:Colors.blue,prefixIcon: Icons.arrow_back,
            onPressedPre: (){

              Navigator.pop(context);
            }

        ),


        body: Column(children: [

          CategoriesNoti(
            selected_cat: selected,
            callBack: (int index) {
              setState(() {
                selected = index;
              });
              pageController.jumpToPage(index);
            },
          ),
          Divider(color: Colors.grey,),
          Expanded(child:

          Consumer<NotificationController>(builder:(context,controller,_)=>

              notifiList(
                  selected: selected,
                  callBack: (int index){
                    setState(() {
                      selected =index;

                    });
                  },
                  pageController: pageController, controller: controller)


          )






          )])








    );
  }
}


class notifiList extends StatelessWidget {



  int selected;
  Function callBack;
  PageController pageController;
  NotificationController controller;

  TaskController taskController=TaskController();




  notifiList({required this.selected,required this.callBack,
    required this.pageController,required this.controller});




  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Map<String,Future<List<NotificationModel >>> menu = {
      "All":controller.cll(),
      "Read ✓":controller.ReadedNotification()

    };
    var category=menu.keys.toList();
    return
      PageView(
          controller: pageController,
          onPageChanged: (index) => callBack(index),
          children:
          [
            FutureBuilder< List<NotificationModel> >(
              future:menu[category[selected]]!,
              builder: (context,snapShot){
                if(snapShot.hasData && snapShot.data!.length ==0){
                  return Center(child:Text('no item found '));
                }

                //AsyncSnapShot
                else if(snapShot.hasData && snapShot.data!.length !=0)
                  return

                    ListView.builder(itemCount:snapShot.data!.length,itemBuilder:  (context,index)=>

                        GestureDetector(
                          onTap: ()async{


                            controller.toReaded(snapShot.data![index].id,index);


                            controller.id_notification=snapShot.data![index].id;


                            controller.CmakeReaded(snapShot.data![index].id);
                            if(controller.l_title[index].note == 'title'){
                              taskController.id_task=controller.l_title[index].title[0]['id'];

                              Navigator.pushNamed(context,'/LedTaskScreen');

                            }
                            else if(controller.l_title[index].note == 'the meeting'){
                              Navigator.of(context).pushReplacement(                                                         //new
                                  new MaterialPageRoute(                                                                       //new
                                      settings: const RouteSettings(name: '/meeting_for_leader'),                                              //new
                                      builder: (context) => new MeetingForLeaderOm(id: controller.l_title[index].title[0]['id'],) //new
                                  )                                                                                            //new
                              );
                            }
                            else   if(controller.l_title[index].note == 'the comment'){

                              Navigator.pushNamed(context,'/Comments');

                            }


                            else   if(controller.l_title[index].note == 'the attachment'){
                              Navigator.pushNamed(context,'/LAttachementScr');
                            }
                            else   if( (controller.l_title[index].note == 'sub task') ||
                                (controller.l_title[index].note == 'the sub task') ||
                                (controller.l_title[index].note == 'the subtask')){
                              print('suntask');
                              print(controller.l_title[index].title[0]['id']);

                              int role_id = await GetStorage().read(
                                  'role_id');
                              if (role_id == 2) {
                                print('role==2');
                                Navigator.of(context).push(                                                         //new
                                    new MaterialPageRoute(                                                                       //new
                                        settings: const RouteSettings(name: '/l_subtask'),                                              //new
                                        builder: (context) => new LeaderSubTask(id: controller.l_title[index].title[0]['id'] as int,) //new
                                    )                                                                                            //new
                                );

                              }
                              else if(role_id == 3){
                                print('role_id ==3');


                                Navigator.of(context).push(                                                         //new
                                    new MaterialPageRoute(                                                                       //new
                                        settings: const RouteSettings(name: '/msubtask'),                                              //new
                                        builder: (context) => new MemSubTask(id: controller.l_title[index].title[0]['id'] as int,) //new
                                    )                                                                                            //new
                                );




                              }

                            }








                            else  {
                              print('may be added new item');

                            }


                          },
                          child: Container(
                            margin: EdgeInsets.only(bottom: 8),
                            padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                            height: 80,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              //color:Color(0xffDFF6FF)
                                color: ( category[selected] =='asReaded' ) ||
                                    (  controller.message =='added to read notification' && snapShot.data![index].readed
                                    )?
                                Colors.white: Color(0xffe3f2fd),
                                boxShadow: [

                                  BoxShadow(
                                    offset: Offset(-.4,-.4),
                                    blurRadius: 2,
                                    color: Colors.black26,

                                  )



                                ]

                            ),
                            child:

                            Row(children: [
                              Container(decoration: BoxDecoration(shape: BoxShape.circle,
                                color:Colors.blue,),height: 8,width: 8,),
                              SizedBox(width: 10,),
                              Text('${snapShot.data![index].data!.note}',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black),
                              ),
                            ],),


                          ),
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
          ]

      )


    ;
  }


}



class  CategoriesNoti extends StatelessWidget {
  int selected_cat=0;
  Function callBack;

  CategoriesNoti({required this.selected_cat , required this.callBack});
  List<String> categoriesNoti = ["All", "Read ✓"];
  @override
  Widget build(BuildContext context) {
    Size size =MediaQuery.of(context).size;
    return  Container(
        margin: EdgeInsets.symmetric(horizontal:size.width*0.3 ),

        child:
        Column(

          children: [
            Container(height: 45,child:ListView.builder(
                itemCount: categoriesNoti.length,
                scrollDirection: Axis.horizontal

                ,itemBuilder: (context,index)=>
                GestureDetector(
                    onTap: () => callBack(index),
                    child:Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10),
                      child: Container(
                          decoration: BoxDecoration(border: Border(bottom: BorderSide(
                              color: Colors.blue,width:3,
                              style: selected_cat == index ? BorderStyle.solid :BorderStyle.none

                          ))),

                          margin: EdgeInsets.only(right: 10),
                          child:Text(categoriesNoti[index],
                            style: TextStyle(
                                color:selected_cat == index ?Colors.blue :Colors.grey,
                                fontWeight: FontWeight.bold,fontSize: 18,letterSpacing: 1.2),)
                      ),
                    )


                )),


            ),




          ],)


    );
  }
}