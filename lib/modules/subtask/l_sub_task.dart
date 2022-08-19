import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:percent_indicator/percent_indicator.dart';
import 'package:tracker/config/server_config.dart';
import 'package:tracker/controllers/add_subtask_controller.dart';

import '../../controllers/show_subtask_controlller.dart';
import '../../models/subtask_model.dart';
import '../../models/user_model.dart';
import '../../shared/constants.dart';

class LeaderSubTask extends StatelessWidget {
  const LeaderSubTask({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size =MediaQuery.of(context).size;
    ShowSubtaskController showSubtaskController=ShowSubtaskController();
    return Scaffold(
      body: SafeArea(child: FutureBuilder<ModelSubTask>(
          future: showSubtaskController.fetchSubtask(6),
            builder: (context,snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Column(

                  children: [
                    SizedBox(height: size.height * 0.37,),
                    Container(
                      height: size.height * 0.5,
                      alignment: AlignmentDirectional.bottomCenter,
                      child: Center(child: Column(children: [
                        CircularProgressIndicator(),
                        SizedBox(height: size.height * 0.01,),
                        Text('loading...', style: TextStyle(fontSize: 15),),
                      ],)),),
                  ],
                );
              }
              if (snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error.toString(), style: TextStyle(fontSize: 20),),);
              }
              else {
                return
                  Stack(
                    children: [
                      Positioned(
                        right: 0,
                        top: 0,
                        child: Container(
                          height: 350,
                          width: 200,
                          decoration: BoxDecoration(
                              color: appCo,
                              borderRadius:
                              BorderRadius.only(bottomLeft: Radius.circular(
                                  800))),
                        ),
                      ),
                      Positioned(
                        left: 0,
                        bottom: 0,
                        child: Container(
                          height: 350,
                          width: 200,
                          decoration: BoxDecoration(
                              color: pu,
                              borderRadius:
                              BorderRadius.only(topRight: Radius.circular(
                                  800))),
                        ),
                      ),
                      Container(
                          margin: EdgeInsets.symmetric(
                              vertical: 40, horizontal: 25),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  offset: Offset(-3, -3),
                                  spreadRadius: 4,
                                  blurRadius: 6,
                                )
                              ]),
                          child:
                          Padding(
                            padding: EdgeInsets.only(
                              top: 15,
                              right: 20,
                              left: 20,
                              bottom: 15,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10, bottom: 35.0),
                                  child: Row(
                                    mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                    children: [
                                      CircleAvatar(
                                        radius: 18,
                                        backgroundColor: Colors.grey[100],
                                        child: Icon(
                                            Icons.arrow_back_ios_outlined,
                                            color: Colors.black, size: 20),
                                      ),
                                      Text('SubTask Details',
              style: GoogleFonts.chewy(textStyle:const TextStyle(fontWeight: FontWeight.w100,color: myGray,fontSize: 27, letterSpacing: .5))


              ),

                                      TextButton( onPressed: () { Navigator.pushReplacementNamed(
                                          context, '/editsubtask');

                                      }, child: Text('edit',style: TextStyle(fontWeight: FontWeight.bold,fontSize: size.width*0.05,color: appCo),))

                                    ],
                                  ),
                                ),
//SizedBox(height: 20,),
                                Row(children: [
                                  Expanded(
                                    child: Text(
                                      showSubtaskController.subtaskModel.title,
                                      style: TextStyle(
                                          fontSize: 18.3,
                                          fontWeight: FontWeight.bold),
                                      //   overflow: TextOverflow.ellipsis,
                                    ),

                                  ),
                                  SizedBox(
                                    width: 17,
                                  ),
                                  Container(
                                      padding: EdgeInsets.all(10),
                                      width: 70,
                                      decoration: BoxDecoration(
                                          color: appCo,
                                          borderRadius: BorderRadius.circular(
                                              4)),
                                      child: Text(
                                      showSubtaskController.priorities[showSubtaskController.subtaskModel.priority_id]

                                        ,
                                        style: TextStyle(color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.center,
                                      ))
                                ]),
                                SizedBox(
                                  height: 27,
                                ),
                                Text(
                                  'task memmbers',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.grey[600]),
                                ),

Container(
  height: size.height*0.1,
  child:   Row(

    children: [

          ListView.separated(



        scrollDirection: Axis.horizontal,



        physics: const BouncingScrollPhysics(),



        shrinkWrap:true,



        itemBuilder: (context, index) {return buildSubItem(size, showSubtaskController.subtaskModel.users, index);},



        separatorBuilder: (context, index) =>SizedBox(width: size.width*0.03),



        itemCount:showSubtaskController.subtaskModel.users.length??0 ,







      ),

    ],

  ),
),

                                Row(
                                  children: [
                                    Icon(Icons.attachment),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      'Description',
                                      style: TextStyle(fontSize: 17,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                //SizedBox(height: 15,),

                                Container(
                                    margin: EdgeInsets.only(
                                        top: 15, bottom: 36),
                                    padding: EdgeInsets.all(13),
                                    height: 140,
                                    color: Colors.grey[100],
                                    child: ListView(
                                      children: [
                                        Text(
                                          showSubtaskController.subtaskModel.description,  maxLines: 6,
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.grey[500],
                                          ),
                                        )
                                      ],
                                    )),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start,
                                      children: [
                                        Text(
                                          'Start time',
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: pu,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Container(
                                            color: Colors.grey[200],
                                            margin: EdgeInsets.symmetric(
                                                vertical: 13),
                                            padding: EdgeInsets.all(10),
                                            child: Row(children: [
                                              Icon(
                                                  Icons.calendar_today_outlined,
                                                  size: 20),
                                              SizedBox(width: 5,),
                                              Text(showSubtaskController.subtaskModel.start_at,
                                                style: TextStyle(
                                                    fontWeight: FontWeight
                                                        .bold),),
                                            ])),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start,
                                      children: [
                                        Text(
                                          'Dead Line',
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: pu,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Container(
                                            color: Colors.grey[200],
                                            margin: EdgeInsets.symmetric(
                                                vertical: 13),
                                            padding: EdgeInsets.all(10),
                                            child: Row(children: [
                                              Icon(
                                                  Icons.calendar_today_outlined,
                                                  size: 20),
                                              SizedBox(width: 5,),
                                              Text(showSubtaskController.subtaskModel.end_at,
                                                style: TextStyle(
                                                    fontWeight: FontWeight
                                                        .bold),),
                                            ])
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 28,
                                ),


                                Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween,
                                  children: [
                                    Container(
                                        padding: EdgeInsets.all(10),
                                        width: 90,
                                        decoration: BoxDecoration(
                                            color:pu,
                                            borderRadius: BorderRadius.circular(
                                                4)),
                                        child: Text(

                                          showSubtaskController.substates[showSubtaskController.subtaskModel.status_id]
                                          ,
                                          style: TextStyle(color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                          textAlign: TextAlign.center,
                                        )),

                                    Padding(
                                      padding:  EdgeInsets.only(right: size.width*0.07,left: size.width*0.07),
                                      child: ElevatedButton(
                                        onPressed: ()async{
                                          await showAlertDialog(context, size.width, showSubtaskController, 72);

                                        },
                                        child: Text('delete'),
                                        style: ButtonStyle(
                                          shape: MaterialStateProperty.all(const CircleBorder()),
                                          padding: MaterialStateProperty.all(const EdgeInsets.all(20)),
                                          foregroundColor: MaterialStateProperty.all(appFo),
                                          backgroundColor: MaterialStateProperty.all(myGray), // <-- Button color
                                          overlayColor: MaterialStateProperty.resolveWith<Color?>((states) {
                                            if (states.contains(MaterialState.pressed)) return appFo; // <-- Splash color
                                          }),
                                        ),
                                      ),
                                    )
                                  ],),




                              ],
                            ),
                          )),
                    ],
                  );
              }
            }),
      ),

    );
  }
  Widget buildSubItem(Size size,List<User> users,var i) =>
      Row(
        children: [
          users[i].img_profile==null?
          CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage('assets/images/avatary.jpg'
              )):
          CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(ServerConfig.domainName+'${users[i].img_profile as String}')
          ),

       ],
      );

}

showAlertDialog(BuildContext context,double w,ShowSubtaskController showSubtaskController,int id) {


  Widget cancelButton = TextButton(
    child: Text("Cancel"),
    onPressed:  () =>{ Navigator.pop(context)},
  );
  Widget continueButton = TextButton(
    child: Text("Delete"),
    onPressed:  ()async {await showSubtaskController.deletion(id);
    if (showSubtaskController.message=="200" || showSubtaskController.message=="201")
    {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('subtask deleted successfully'),
      ));
      //**********navigate to task
      /*Navigator.pushReplacementNamed(
                                          context, '');*/
    }
    else
    {
      EasyLoading.showError('oops! error'+showSubtaskController.message.toString());

    }
    },

  );
  Widget iconty=Icon(Icons.delete,size: w*0.1,);

  AlertDialog alert = AlertDialog(
    title:iconty,
    content: Text("Do you really want to delete this subtask ?"),
    actions: [
      cancelButton,
      continueButton,
    ],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}