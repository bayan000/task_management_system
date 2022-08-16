import 'package:flutter/material.dart';

import '../../controllers/report_controller.dart';
import '../../models/report_model.dart';
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
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),

            onPressed: () {
              Navigator.pushReplacementNamed(
                  context, '/Dashboard');
            },
          ),
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
                  child: FutureBuilder<List<ReoprtModel>>(
                      future: ReportController.reports(),
                      builder: (context,snapShot) {
                        if(snapShot.hasData)
                          return ListView.separated(
                            physics:  const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) => buildReportItem(size,size.height*0.35,size.width*0.9,snapShot.data![index]),
                            separatorBuilder: (context, index) =>
                                Container(width: size.width,height: size.height*0.001,color:Colors.grey,),
                            itemCount: snapShot.data!.length,
                          );
                        if(snapShot.hasError)
                          return Center(child: Text('Error!! ${snapShot.error}'),);
                        return Center(child: Text('Loading...'),);
                      }
                  ),
                ),
              )


          ),
        )
    );
  }
  Widget buildReportItem(Size size,double h,double w,ReoprtModel model) =>
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
                Text('Task name : ${model.theTask[0].title}',style: TextStyle(overflow:TextOverflow.ellipsis,fontSize: 20,
                    fontWeight: FontWeight.bold,color: pu),),
                SizedBox(height: h*0.04,),
                Row(
                  children: [
                    const Text('Team :',style: TextStyle(overflow:TextOverflow.ellipsis,fontSize: 18,
                        fontWeight: FontWeight.bold,color: Colors.black87),),
                    SizedBox(width: w*0.03,),
                    Text(model.theTask[0].teamName.toString(),style: TextStyle(overflow:TextOverflow.ellipsis,fontSize: 18,
                        fontWeight: FontWeight.bold,color: Colors.black54),),
                  ],
                ),
                SizedBox(height: h*0.04,),
                const Text('members',style: TextStyle(overflow:TextOverflow.ellipsis,fontSize: 18,
                    fontWeight: FontWeight.bold,color: Colors.black87),),
                SizedBox(height: h*0.04,),
                for(var s in model.theTask[0].subtasks)
                  for(var s2 in s.members)
                    Text(s2.firstName + ' ' + s2.lastName,style:TextStyle(overflow:TextOverflow.ellipsis,fontSize: 16,
                        fontWeight: FontWeight.bold,color: Colors.black87),),
                SizedBox(height: h*0.04,),
                //getTextWidgets(members,size),
                SizedBox(height: h*0.04,),
                Row(
                  children: [
                    const Text('Dead line',style: TextStyle(overflow:TextOverflow.ellipsis,fontSize: 18,
                        fontWeight: FontWeight.bold,color: Colors.black87),),
                    SizedBox(width: w*0.03,),
                    Builder(
                        builder: (context) {
                          var dl = model.theTask[0].endDate;
                          return Text('${dl.day}/${dl.month}/${dl.year}',style: TextStyle(overflow:TextOverflow.ellipsis,fontSize: 18,
                              fontWeight: FontWeight.bold,color: Colors.black54),);
                        }
                    ),
                  ],
                ),
                SizedBox(height: h*0.04,),
                Row(
                  children: [
                    const Text('Task status',style: TextStyle(overflow:TextOverflow.ellipsis,fontSize: 18,
                        fontWeight: FontWeight.bold,color: Colors.black87),),
                    SizedBox(width: w*0.03,),
                    Text(' ${model.thePercentage}% is done',style: TextStyle(overflow:TextOverflow.ellipsis,fontSize: 18,
                        fontWeight: FontWeight.bold,color: appCo),),

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
                              //getTextWidgets(subtasks,size),
                            ],
                          ),
                        ),
                        // SizedBox(width: w*0.1,),
                        SizedBox(
                          width: w*0.4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // getTextWidgets(status,size),
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
