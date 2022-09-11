
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tracker/modules/calendar/add_event.dart';
import '../../controllers/calendar_controller.dart';
import '../../models/calenadar_model.dart';
import '../../shared/constants.dart';
import '../../shared/menu_item.dart';

class AllEvents extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(

      appBar:buildAppBar( text:'All Events',color: Colors.blue,
          prefixIcon: Icons.arrow_back,onPressedPre: (){

            Navigator.pop(context);
          }

      ),
      body:


      Consumer<MyCalendarCont>(builder:(context,pro,_)=>
          FutureBuilder< List<ModelCalendar> >(
            future: pro.fetchAllEvent(),
            builder: (context,snapShot){
              //AsyncSnapShot
              if(snapShot.hasData)
                return
                  ListView.builder(  itemCount:snapShot.data!.length,
                      itemBuilder: (context, index) =>



                          Column(children: [
                            Container(height: size.height*0.10,width: double.infinity,
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

                                              '${snapShot.data![index].event_name}'
                                              ,
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.black),
                                            ),

                                          ],),
                                          Spacer(),
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
                                                '${snapShot.data![index].date_of_event}'

                                                ,
                                                style: TextStyle(
                                                    fontSize: 13, color: Colors.blue,fontWeight: FontWeight.w500),
                                              ),
                                            ],
                                          )



                                        ]), ),


                                    PopupMenuButton<MenuItem>(
                                      onSelected: (item) {

                                        pro.id_event=snapShot.data![index].id;
                                        //userController.toAssignId(snapShot.data![index].id);

                                        print('id of event........');
                                        print(pro.id_event);
                                        return onSelected(
                                            context, item,pro );
                                      },
                                      itemBuilder: (context) => [
                                        ...MenuItems.items
                                            .map(buildItem)
                                            .toList()
                                      ],
                                    )


                                  ],)



                            ),
                            Divider(color:Colors.grey)

                          ],));




              if(snapShot.hasError)
                return Center(
                  child: Text(snapShot.error.toString()),
                );

              return Center(
                child: CircularProgressIndicator(),
              );
            },
          )



      )



      ,  floatingActionButton: FloatingActionButton(backgroundColor:Colors.purple,
        onPressed: ()async{

          Navigator.of(context).push(MaterialPageRoute(builder:(context)=> AddEventScr()),);



        },child: Icon(Icons.add)) ,



    );
  }
  void onSelected(BuildContext context, MenuItem item, MyCalendarCont contr) {
    switch (item) {
      case MenuItems.itemDelete:
        showCupertinoDialog(
            context: context,
            builder: (context) =>

                CupertinoAlertDialog(
                  title: Text(
                    'Are you sure about deleting?',
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
                        await contr.showDeleteEvent();
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Deleted the event '),
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


        Navigator.pushNamed(context,'/EditEvent');
        break;
    }
  }


}