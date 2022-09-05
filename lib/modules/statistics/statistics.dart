
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:tracker/shared/constants.dart';

import '../../controllers/statistics.dart';
import '../../models/statistics_model.dart';

class StatisticsScre extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    var pro=Provider.of<StatisticsController>(context);
    return  SafeArea(child: Scaffold(
      appBar: buildAppBar( text: 'Statistics',
          color:appCo,prefixIcon: Icons.arrow_back,
          onPressedPre: (){

            Navigator.pop(context);
          }

      ),

      body:
      FutureBuilder<StatisticsModel>(
        future: pro.onClickfetchStatistics(),
        builder: (context,snapShot){ //AsyncSnapShot
          if(snapShot.hasData)
            return

              Column(children: [
                Container(
                    margin: EdgeInsets.fromLTRB(20,20,20,15),
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
                    height: 500,
                    width: double.infinity,
                    child: SfCircularChart(

                      // color

                      palette: const <Color>[
                        Color(0xff277BC0),



                        Colors.greenAccent,
                        Color(0xff319DA0),
                        Color(0xff781C68),
                        Color(0xffFFD39A),
                        Color(0xffFFB200),
                        Colors.yellowAccent,
                        Colors.indigo,
                        Colors.purple,
                        Colors.deepPurpleAccent,






                      ],

                      backgroundColor: Colors.white70,

                      title: ChartTitle(

                          text: 'Circular Chart Screen ',
                          alignment: ChartAlignment.near,
                          textStyle: TextStyle(fontSize: 20,)
                      ),

                      legend: Legend(
                        isVisible: true,
                        textStyle: TextStyle(fontWeight: FontWeight.w500),
                        overflowMode: LegendItemOverflowMode.wrap,
                        position: LegendPosition.bottom,
                      ),
                      tooltipBehavior: pro.tooltipBehaviory,
                      series: <CircularSeries>[
                        RadialBarSeries<MyData,String>(



                          dataSource:pro.sta_percentage,
                          legendIconType: LegendIconType.circle,

                          xValueMapper:(MyData data,_)=> data.name,
                          yValueMapper: (MyData data,_)=> data.percent,
                          dataLabelSettings: DataLabelSettings(isVisible: true),
                          enableTooltip: true,
                          //cornerStyle: CornerStyle.bothCurve,

                          //maximumValue: 100

                        )


                      ],


                    )),
                //  SizedBox(height: 20,),
                Expanded(child:


                GridView.builder(
                    itemCount: pro.sta_num.length,


                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,

                      childAspectRatio: MediaQuery.of(context).size.width /
                          (MediaQuery.of(context).size.height / 4),
                    ),
                    itemBuilder: (context,index)=>Container(
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.all(20),
                      // height: 3,

                      decoration: BoxDecoration(

                          borderRadius: BorderRadius.circular(20),

                          color: Colors.grey[100],

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
                      child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: Column(

                          children: [

                            Text('${pro.sta_num[index].name}', style: TextStyle(fontWeight: FontWeight.w500),),
                            SizedBox(height: 10,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [


                                Text('-', style: TextStyle(fontWeight: FontWeight.bold,)),
                                Text('${pro.sta_num[index].percent}',
                                  style: TextStyle(color:  Color(0xff319DA0),fontWeight: FontWeight.bold,),),
                                Text('-', style: TextStyle(fontWeight: FontWeight.bold,)),


                              ],)

                          ],),
                      ),
                    )



                )





                )

              ],);



          if(snapShot.hasError)
            return Center(
              child: Text(snapShot.error.toString()),
            );

          return Center(
            child: CircularProgressIndicator(color: Colors.purple,),
          );
        },
      )

      ,



    ));
  }
}