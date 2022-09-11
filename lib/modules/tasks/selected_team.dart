
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tracker/models/team_model.dart';
import 'package:tracker/shared/constants.dart';

import '../../controllers/teams_controller.dart';
class TeamSelected extends StatefulWidget {
  @override
  State<TeamSelected> createState() => _TeamSelectedState();
}

class _TeamSelectedState extends State<TeamSelected> {
  bool isSelected=false;

  TeamModel? teamSel;
  int? id;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var teamContr=Provider.of< TeamsController >(context);

    var arrwo_back;
    return Scaffold(
      appBar: buildAppBar( text: 'Selected Team' ,color:Colors.blue,
          prefixIcon: Icons.arrow_back,onPressedPre: (){Navigator.pop(context);}),

      body:





      Padding(
        padding: const EdgeInsets.only(top:8.0),
        child:

        FutureBuilder<List<TeamModel>>(
          future:teamContr.fetchTeams(),
          builder: (context,snapShot){ //AsyncSnapShot
            if(snapShot.hasData)
              return

                ListView.builder(itemCount: snapShot.data!.length,itemBuilder: (context,index)=>



                    Column(children: [
                      ListTile(
                          onTap: (){
                            setState(() {
                              isSelected=!isSelected;
                              id=snapShot.data![index].id;
                            });
                            this.teamSel=snapShot.data![index];
                            print(isSelected);
                          },
                          leading: CircleAvatar(backgroundColor: Colors.blue,child:Text('${snapShot.data![index].id}',style: TextStyle(color: Colors.white),)),

                          title:

                          Text('${snapShot.data![index].name}',style: isSelected &&
                              id==snapShot.data![index].id ?
                          TextStyle(fontWeight: FontWeight.w500,color:Colors.black):

                          TextStyle(fontWeight: FontWeight.w500 ),),


                          trailing: isSelected && id==snapShot.data![index].id ?
                          Icon(Icons.check_circle,color: Colors.purple,):
                          Icon(Icons.check_circle_outlined,color:Colors.grey)

                      ),
                      Divider(color: Colors.grey,),

                    ],)

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

        ,
      ),

      floatingActionButton: FloatingActionButton(onPressed: ()=> Navigator.pop(context, teamSel ),
        child: Text('select '),backgroundColor: Colors.purple,),

    );
  }
}