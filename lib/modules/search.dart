
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

import '../controllers/task_controller.dart';
import '../models/task_model.dart';
import '../shared/constants.dart';
import '../shared/menu_item.dart';

class SearchPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var taskController=Provider.of< TaskController >(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(

        body:SafeArea(


            child:Column(


              children: [

                Row(

                  children: [

                    IconButton(icon: Icon(Icons.arrow_back,size: 25,), onPressed: () {
                      Navigator.pop(context);

                    },),

                    Expanded(child:  SearchFiled(onChanged: ( value)async{

                      if(value == ''){
                        print('null value');
                      }
                      else {
                        await taskController.toSearch(value);
                      }
                    },


                    ))
                  ],
                ),



                Divider(color: Colors.grey[700],),


                Expanded(child:


                FutureBuilder< List<Task> >(
                  future: taskController.searchTasksFromapi(),
                  builder: (context,snapShot){


                    if(snapShot.hasData && snapShot.data!.length ==0){
                      return Center(child: CircularProgressIndicator(),);
                    }


                    //AsyncSnapShot
                    if(snapShot.hasData)
                      return

                        ListView.builder(
                          itemCount:snapShot.data!.length,
                          itemBuilder: (context, index) => Padding(
                              padding:  EdgeInsets.symmetric(vertical:  size.width*0.023,),
                              child:



                              GestureDetector(
                                onTap: ()async{
                                  taskController.id_task=snapShot.data![index].id;
                                  int role_id = await GetStorage().read(
                                      'role_id');
                                  if (role_id == 1) {
                                    Navigator.pushNamed(context,'/TaskDetail');
                                  }
                                  else{
                                    Navigator.pushNamed(context, '/LDetailsTask');
                                  }

                                },
                                child: Column(children: [
                                  ListTile(

                                    leading: CircleAvatar(backgroundColor: Colors.blue,child:Text('${snapShot.data![index].id}',style: TextStyle(color: Colors.white),)),

                                    title:  Column(
                                      //mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(

                                          '${snapShot.data![index].title}'
                                          ,
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black),
                                        ),
                                        SizedBox(
                                          height: size.width*0.012,
                                        ),
                                        Text(
                                          '${snapShot.data![index].description}',
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.grey[600],
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),











                                      ],
                                    )
                                    , trailing:  PopupMenuButton<MenuItem>(

                                    onSelected: (item) {


                                      return onSelected(
                                          context, item, taskController);
                                    },
                                    itemBuilder: (context) => [
                                      ...MenuItems.items
                                          .map(buildItem)
                                          .toList()
                                    ],
                                  ),
                                  ),
                                  Divider(color: Colors.grey,),

                                ],),
                              )




                          ),
                        );



                    if(snapShot.hasError)
                      return Center(
                        child: Text('no item found '),
                      );

                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                )








                ),




              ],)


        )




    );
  }
  PopupMenuItem<MenuItem> buildItem(MenuItem item) => PopupMenuItem<MenuItem>(
    value: item,
    child: Row(
      children: [
        Icon(
          item.icon,
          color: Colors.blue,
          size: 20,
        ),
        SizedBox(
          width: 12,
        ),
        Text(item.text,style: TextStyle(color:Colors.black),),
      ],
    ),
  );

  void onSelected(BuildContext context, MenuItem item, var taskContr) {
    switch (item) {
      case MenuItems.itemDelete:
        showCupertinoDialog(
            context: context,
            builder: (context) =>

                CupertinoAlertDialog(
                  title: Text(
                    ' Are you sure about deleting?',
                    style: TextStyle(fontSize: 15),
                  ),

                  actions: [

                    CupertinoDialogAction(
                      child: Text('Cancel'),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    CupertinoDialogAction(
                      child:
                      Text('OK'),
                      onPressed: () async {
                        await taskContr.onClickDeleteTask();
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Deleted the user '),
                        ));
                        print('ok');
                        //update to list
                        Navigator.pop(context);
                      },
                    ),

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

class SearchFiled extends StatelessWidget {


  const SearchFiled({
    required this.onChanged,
  }) ;

  final ValueChanged onChanged;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top:kDefaultPadding/2,right:kDefaultPadding/2),
      padding:  EdgeInsets.symmetric(
        horizontal: kDefaultPadding,

      ),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.25),
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        onChanged: onChanged,
        style: TextStyle(color: Colors.black45),
        //  cursorColor: Colors.w,
        decoration: const InputDecoration(
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          icon: Icon(Icons.search,color: Colors.white,),
          hintText: 'Search',

        ),
      ),
    );
  }
}