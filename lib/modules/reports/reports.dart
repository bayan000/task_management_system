import 'package:flutter/material.dart';

import '../../shared/components.dart';
import '../../shared/constants.dart';

class Reports extends StatelessWidget {
  const Reports({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> members=['Rama','Deema','Sara'];
    List<String> subtasks=['subtasks1','subtasks2','subtasks3',];
    List<String> status=['done','done','done',];
    Size size =MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title:  Text('Reports',style: trackerStyle,),
        automaticallyImplyLeading: false,
        // centerTitle: true,

        backgroundColor: appCo,
        shadowColor: appCo,
        elevation: 0,

      ),
      backgroundColor: appCo,
        body: SafeArea(
          child:Padding(

              padding:  EdgeInsets.only(
                  top:size.height*0.01,left:size.width*0.025,right: size.width*0.025  ),//.all(size.width*0.025),
              child:SingleChildScrollView(
                physics: const BouncingScrollPhysics(),

                child: Container(
                  decoration:   BoxDecoration(
                      color: appFo,
                      borderRadius: BorderRadius.only(topRight: Radius.circular(r),topLeft:Radius.circular(r) )),
                  child: ListView.separated(
                    physics:  const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) => buildReportItem(size.height*0.35,size.width*0.9,members,subtasks,status),
                    separatorBuilder: (context, index) =>
                        Container(width: size.width,height: size.height*0.001,color:Colors.grey,),
                    itemCount: 6,
                  ),
                ),
              )


          ),
        )
    );
  }
  Widget buildReportItem(double h,double w,List<String> members,List<String> subtasks,List<String> status) =>
      SizedBox(

        height: h,
        width: w,

        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: h*0.01,),
                 Text('Task name',style: TextStyle(overflow:TextOverflow.ellipsis,fontSize: 20,
                    fontWeight: FontWeight.bold,color: pu),),
                SizedBox(height: h*0.04,),
                Row(
                  children: [
                    const Text('Team',style: TextStyle(overflow:TextOverflow.ellipsis,fontSize: 18,
                        fontWeight: FontWeight.bold,color: Colors.black87),),
                    SizedBox(width: w*0.03,),
                    const Text('Team name',style: TextStyle(overflow:TextOverflow.ellipsis,fontSize: 18,
                        fontWeight: FontWeight.bold,color: Colors.black54),),
                  ],
                ),
                SizedBox(height: h*0.04,),
                const Text('members',style: TextStyle(overflow:TextOverflow.ellipsis,fontSize: 18,
                    fontWeight: FontWeight.bold,color: Colors.black87),),
                SizedBox(height: h*0.04,),
                getTextWidgets(members),
                SizedBox(height: h*0.04,),
                Row(
                  children: [
                    const Text('Dead line',style: TextStyle(overflow:TextOverflow.ellipsis,fontSize: 18,
                        fontWeight: FontWeight.bold,color: Colors.black87),),
                    SizedBox(width: w*0.03,),
                    const Text('1/1/2023',style: TextStyle(overflow:TextOverflow.ellipsis,fontSize: 18,
                        fontWeight: FontWeight.bold,color: Colors.black54),),
                  ],
                ),
                SizedBox(height: h*0.04,),
                Row(
                  children: [
                    const Text('Task status',style: TextStyle(overflow:TextOverflow.ellipsis,fontSize: 18,
                        fontWeight: FontWeight.bold,color: Colors.black87),),
                    SizedBox(width: w*0.03,),
                    const Text('done',style: TextStyle(overflow:TextOverflow.ellipsis,fontSize: 18,
                        fontWeight: FontWeight.bold,color: Colors.black54),),

                  ],

                ),
                SizedBox(height: h*0.04,),
                Stack(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: w*0.5,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              getTextWidgets(subtasks),
                            ],
                          ),
                        ),
                       // SizedBox(width: w*0.1,),
                        SizedBox(
                          width: w*0.4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              getTextWidgets(status),
                            ],
                          ),
                        )
                      ],
                    ),

                  ],
                )

              ],
            ),
          ),
        ),
      );
  //list of text widgets for members/subtasks/status



}
