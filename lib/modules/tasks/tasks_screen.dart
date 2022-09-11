import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tracker/shared/components.dart';
import 'package:tracker/models/mod_tasks.dart';
import 'package:tracker/modules/tasks/card_task.dart';

import 'package:tracker/shared/constants.dart';

import '../../controllers/task_controller.dart';
import '../../controllers/task_controller.dart';
import '../../models/task_model.dart';
import '../../shared/menu_item.dart';



class TaskScre extends StatefulWidget {
  const TaskScre({Key? key}) : super(key: key);

  @override
  _TaskScreState createState() => _TaskScreState();
}

class _TaskScreState extends State<TaskScre> {
  int selected = 0;
  var pageController = PageController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var taskController=Provider.of< TaskController >(context);
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: buildAppBar(onPressedPre: (){
        Navigator.pop(context);


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

            child:  ttaskList(
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

          Navigator.pushNamed(context, '/AddTask');



        },child: Icon(Icons.add),) ,

    );
  }

}
class ttaskList extends StatelessWidget {



  int selected;
  Function callBack;
  PageController pageController;
  TaskController taskController;






  ttaskList({required this.selected,required this.callBack,
    required this.pageController,required this.taskController});




  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Map<String,Future<List< Task >>> menu = {
      "All":taskController. onClickshowTasks(),
      "Completed":taskController. onClickshowCompletedTasks(),
      "Missed":taskController.onClickshowMissedTasks(),
      "Progress":taskController. onClickshowOnProgressTasks(),
      "ToDo":taskController.onClickshowToDoTasks()

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



                            Column(children: [
                              GestureDetector(
                                onTap: (){

                                  taskController.id_task=snapShot.data![index].id;

                                  //  taskController.testy();

                                  Navigator.pushNamed(context,'/TaskDetail');
                                },



                                child:
                                Container(height: size.height*0.15,width: double.infinity,
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
                                                    '${snapShot.data![index].end_date}'

                                                    ,
                                                    style: TextStyle(
                                                        fontSize: 13, color: Colors.blue,fontWeight: FontWeight.w500),
                                                  ),
                                                ],
                                              )



                                            ]), ),


                                        PopupMenuButton<MenuItem>(
                                          onSelected: (item) {

                                            taskController.id_task=snapShot.data![index].id;
                                            //userController.toAssignId(snapShot.data![index].id);

                                            print('id of task........');
                                            print(taskController.id_task);
                                            return onSelected(
                                                context, item, taskController);
                                          },
                                          itemBuilder: (context) => [
                                            ...MenuItems.items
                                                .map(buildItem)
                                                .toList()
                                          ],
                                        )


                                      ],)



                                ),
                              ),
                              Divider(color:Colors.grey)

                            ],)
                    );



                if(snapShot.hasError)
                  return Center(
                    child: Text('Empty'),
                  );

                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            ) ]

      )


    ;
  }
  void onSelected(BuildContext context, MenuItem item, TaskController taskContr) {
    switch (item) {
      case MenuItems.itemDelete:
        showCupertinoDialog(
            context: context,
            builder: (context) =>

                CupertinoAlertDialog(
                  title: Text(
                    ' Are you sure about deleting?',
                    style: TextStyle(fontSize: 20),
                  ),
                  content: Text(
                    'This will completely delete the task',
                    style: TextStyle(fontSize: 16),
                  ),
                  actions: [
                    CupertinoDialogAction(
                      child:
                      Text('OK'),
                      onPressed: () async {

                        await taskContr.onClickDeleteTask();
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Deleted the task '),
                        ));
                        print('ok');
                        //update to list
                        Navigator.pop(context);
                      },
                    ),
                    CupertinoDialogAction(
                      child: Text('Cancel'),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    )
                  ],
                )

        );

        break;
      case MenuItems.itemEdit:
        print('yes edited');

        Navigator.pushNamed(context,'/EditTask');

        break;
    }
  }


}
class Categoriess extends StatelessWidget {
  int selected;
  Function callBack;
  Categoriess({required this.selected, required this.callBack});

  List<String> categories = ["All", "Completed", "Missed", "Progress","ToDo"];

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
        height: 30,
        child: ListView.builder(
            itemCount: categories.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => GestureDetector(
              onTap: () => callBack(index),
              child: Container(
                  alignment: Alignment.center,
                  padding:
                  EdgeInsets.symmetric(horizontal: kDefaultPadding),
                  margin: EdgeInsets.only(
                      left: kDefaultPadding,
                      right: index == categories.length - 1
                          ? kDefaultPadding
                          : 0),
                  decoration: BoxDecoration(
                    color: index == selected
                        ? Colors.white.withOpacity(0.4)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    categories[index],
                    style: TextStyle(color: Colors.white,fontWeight: FontWeight.w300),
                  )),
            )));
  }
}