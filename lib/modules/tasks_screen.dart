import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tracker/shared/components.dart';
import 'package:tracker/models/mod_tasks.dart';
import 'package:tracker/modules/card_task.dart';

import 'package:tracker/shared/constants.dart';

import '../controllers/task_controller.dart';
import '../models/task_model.dart';
import '../shared/menu_item.dart';


class TaskScreen extends StatefulWidget {
  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  //TextEditingController searchController = TextEditingController();

  int selected = 0;
  var pageController = PageController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var taskController=Provider.of< TaskController >(context);
    // var searchTaskController=Provider.of<SearchTaskController>(context);
    return Scaffold(
      backgroundColor: appCo,
      appBar: buildAppBar(text:'Tasks',fontsize:30,suffixIcon:Icons.notifications_outlined

      ),
      body: Column(

        children: [
          SearchBox(onChanded: (value){

            taskController.SearchTask(value);

          }),
          Categoriess(
            selected: selected,
            callBack: (int index) {
              setState(() {
                selected = index;
              });
              pageController.jumpToPage(index);
            },
          ),
          SizedBox(
            height: kDefaultPadding / 2,
          ),
          Expanded(
            child: Stack(
              children: [
                Container(
                  margin:EdgeInsets.only(top:60),
                  decoration: BoxDecoration(
                    color: kBackgroundColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                ),


                taskList(
                    selected: selected,
                    callBack: (int index){
                      setState(() {
                        selected =index;

                      });
                    },
                    pageController: pageController, taskController: taskController)




                ,

              ],
            ),

          )
        ],
      ),

      floatingActionButton: FloatingActionButton(backgroundColor:Colors.indigo,
        onPressed: ()async{
          Navigator.pushReplacementNamed(
              context, '/AddTask');
//Provider.of<UserController>(context,listen:false).onClickAddUser();



        },child: Icon(Icons.add),) ,

    );
  }


}

class taskList extends StatelessWidget {
  int selected;
  Function callBack;
  PageController pageController;
  TaskController taskController;

  taskList({required this.selected,required this.callBack,
    required this.pageController,required this.taskController});




  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var category=taskController.menu.keys.toList();
    return  Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child:PageView(
            controller: pageController,
            onPageChanged: (index) => callBack(index),
            children:
            [ FutureBuilder< List<Task> >(
              future:taskController.menu[category[selected]]!,
              builder: (context,snapShot){ //AsyncSnapShot
                if(snapShot.hasData)
                  return

                    ListView.builder(
                      itemCount: snapShot.data!.length,
                      itemBuilder: (context, index) => Padding(
                        padding:  EdgeInsets.symmetric(vertical:  size.width*0.023,),
                        child:



                        cardTask(item:snapShot.data![index],id:snapShot.data![index].id),
                      ),
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


    );
  }
}



class Categoriess extends StatelessWidget {
  int selected;
  Function callBack;
  Categoriess({required this.selected, required this.callBack});

  List<String> categories = ["All", "Completed", "Missed", "Progress"];

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
                    style: TextStyle(color: Colors.white),
                  )),
            )));
  }
}
class SearchBox extends StatelessWidget {
  var onChanded;
  SearchBox({this.onChanded});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(kDefaultPadding),
        padding: EdgeInsets.symmetric(
            horizontal: kDefaultPadding, vertical: kDefaultPadding / 4),
        decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.4),
            borderRadius: BorderRadius.circular(20)),
        child: TextField(
          onChanged: onChanded,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              icon: Icon(Icons.search, color: Colors.white),
              hintText: 'Search',
              hintStyle: TextStyle(color: Colors.white)),
        ));
  }
}


class cardTask extends StatefulWidget {

  int id;
  Task item;
  cardTask({required this.item,required this.id});

  @override
  State<cardTask> createState() => _cardTaskState();
}

class _cardTaskState extends State<cardTask> {
  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    var taskController=Provider.of<TaskController>(context);
    return

      GestureDetector(
        onTap: (){
          print(widget.item.description);
          print(widget.item.title);
          print('${widget.item.end_date}');

          taskController.id_task=widget.item.id;


          Navigator.pushNamed(context,'/TaskDetail');
        },
        child:


        Container(
          height: size.width*0.32,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.grey[200],
//color:Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  //color:Colors.red,
                  offset: Offset(-2, -2),
                  // spreadRadius: 13,
                  blurRadius: 8,
                )
              ]),
          child: Padding(
              padding:  EdgeInsets.fromLTRB(size.width*0.044, size.width*0.047, size.width*0.042, size.width*0.01),
              child: Row(
                children: [
                  Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(

                            '${widget.item.title}'
                            ,
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          SizedBox(
                            height: size.width*0.012,
                          ),
                          Text(
                            '${widget.item.description}',
                            style: TextStyle(
                              fontSize: 13,
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
                                size: 20,
                                color: kblue,
                              ),
                              SizedBox(
                                width: size.width*0.016,
                              ),
                              Text(
                                '${widget.item.end_date}'

                                ,
                                style: TextStyle(
                                    fontSize: 13, color: Colors.indigo,fontWeight: FontWeight.bold),
                              ),
                            ],
                          )
                        ],
                      )),

                  PopupMenuButton<MenuItem>(
                    onSelected: (item) {

                      taskController.id_task=widget.id;
                      //userController.toAssignId(snapShot.data![index].id);

                      print('id of user........');
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
                ],
              )),
        ),
      );
  }

  PopupMenuItem<MenuItem> buildItem(MenuItem item) => PopupMenuItem<MenuItem>(
    value: item,
    child: Row(
      children: [
        Icon(
          item.icon,
          color: Colors.black,
          size: 20,
        ),
        SizedBox(
          width: 12,
        ),
        Text(item.text),
      ],
    ),
  );

  void onSelected(BuildContext context, MenuItem item, var taskContr) {
    switch (item) {
      case MenuItems.itemDelete:
        showCupertinoDialog(
            context: context,
            builder: (context) => CupertinoAlertDialog(
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
                  child: Text('OK'),
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
            ));

        break;
      case MenuItems.itemEdit:
        print('yes edited');

        Navigator.pushNamed(context,'/EditTask');

        break;
    }
  }

}