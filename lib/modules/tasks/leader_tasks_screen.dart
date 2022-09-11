
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tracker/modules/tasks/tasks_screen.dart';

import '../../controllers/task_controller.dart';
import '../../models/task_model.dart';
import '../../shared/constants.dart';

class LedTaskScreen extends StatefulWidget {


  @override
  _LedTaskScreenState createState() => _LedTaskScreenState();
}

class _LedTaskScreenState extends State<LedTaskScreen> {
  int selected = 0;
  var pageController = PageController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var taskController=Provider.of< TaskController >(context);
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: buildAppBar(onPressedPre: (){
        Navigator.pushNamed(context,'/DashboardTeamLeader');


      },prefixIcon: Icons.arrow_back,text:'Tasks',
          suffixIcon:Icons.search,onPressedSuf: (){

            Navigator.pushNamed(context,'/SearchPage');


          }),
      body:Column
        (children: [

        Container(height:size.height*0.13,color: Colors.blue,width: double.infinity,






          child:Column(

            children: [
              SizedBox(height: size.height*0.05,),
              Categoriess(
                selected: selected,
                callBack: (int index) {
                  setState(() {
                    selected = index;
                  });
                  pageController.jumpToPage(index);
                },
              ),
              SizedBox(height: 8,)

            ],),



        ),
        Expanded(child: Container(color: Colors.white,
            width: double.infinity,

            child:  ltaskList(
                selected: selected,
                callBack: (int index){
                  setState(() {
                    selected =index;

                  });
                },
                pageController: pageController, taskController: taskController)




        )),



      ],) ,

      floatingActionButton: FloatingActionButton(backgroundColor:Colors.purple,
        onPressed: ()async{

          Navigator.pushNamed(context, '/LAttachementScr');



        },child: Icon(Icons.attachment),),


    );
  }

}
class ltaskList extends StatelessWidget {



  int selected;
  Function callBack;
  PageController pageController;
  TaskController taskController;






  ltaskList({required this.selected,required this.callBack,
    required this.pageController,required this.taskController});




  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Map<String,Future<List< Task >>> menu = {
      "All":taskController.lShowALLTasks(),
      "Completed":taskController. onClickshowCompletedTasks(),
      "Missed":taskController.onClickshowMissedTasks(),
      "Progress":taskController. onClickshowOnProgressTasks(),
      "ToDo":taskController.lShowToDoTasks()

    };
    var category=menu.keys.toList();
    return
      PageView(
          controller: pageController,
          onPageChanged: (index) => callBack(index),
          children:
          [

            FutureBuilder< List<Task> >(
              future: menu[category[selected]]!,
              builder: (context,snapShot){
                //AsyncSnapShot
                if(snapShot.hasData)
                  return

                    ListView.builder(
                        itemCount:snapShot.data!.length,
                        itemBuilder: (context, index) =>



                            GestureDetector(
                              onTap: (){

                                taskController.id_task=snapShot.data![index].id;


                                Navigator.pushNamed(context, '/LDetailsTask');

                              },
                              child: Column(children: [
                                Container(height: size.height*0.15,width: double.infinity,
                                  padding: EdgeInsets.fromLTRB(20,20,10,10),

                                  child:

                                  Column(
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
                                              '${snapShot.data![index].end_date}'

                                              ,
                                              style: TextStyle(
                                                  fontSize: 13, color: Colors.blue,fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        )



                                      ]),


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
            ) ]

      )


    ;
  }


}