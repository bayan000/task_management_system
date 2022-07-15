
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';
class CalendarScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.indigo,

        body:SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top:15.0),
            child: Column(

              children: [
                Row(


                    children: [

                      GestureDetector(onTap: (){},child: Icon(Icons.arrow_back_ios_outlined,color: Colors.white,size: 27,),),
                      SizedBox(width: 90,),
                      Text('Weekly Calendar',style: TextStyle(color:Colors.white,fontSize: 24),),
                    ]),

/*
  SizedBox(height: 30,),
              Column(children: [
                Text('Augest 19',style: TextStyle(color:Colors.white,fontSize: 20),),
                SizedBox(height: 5,),
                Text('10 Task today',style: TextStyle(color: Color(0xffC4DDFF))),
              ],),
 */


                SizedBox(height: 33,),

                Container(

                  child: DatePicker(DateTime.now(),
                    selectedTextColor: Colors.white,
                    selectionColor:  Colors.white12,

                    initialSelectedDate: DateTime.now(),
                    height: 100,
                    dateTextStyle: TextStyle(fontSize: 13,fontWeight: FontWeight.w500,color: Color(0xffC4DDFF)),
                    dayTextStyle: TextStyle(fontSize: 13,fontWeight: FontWeight.w500,color: Color(0xffC4DDFF)),
                    monthTextStyle: TextStyle(fontSize: 13,fontWeight: FontWeight.w500,color: Color(0xffC4DDFF)),

                  ),
                ),
                SizedBox(height: 28,),
///////// 0xfffcf975
                Expanded(child: Container(

                    decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30))),

                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: ListView.builder(itemCount: 11,itemBuilder: (context,index)=>
                          Row(children: [
                            Container(
                                height: 110,
                                width: 20,
                                child: TimelineTile(
                                  alignment: TimelineAlign.manual,
                                  lineXY: 0,
                                  isFirst: true,
                                  indicatorStyle: IndicatorStyle(
                                      indicatorXY: 0,
                                      width: 15,
                                      indicator: Container(
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.white,
                                            border: Border.all(
                                              width: 5,
                                              //color: coloritem[index],
                                              color: Color(0xffC4DDFF),
                                            )),
                                      )),
                                  afterLineStyle: LineStyle(
                                    thickness: 2,
                                    //color: coloritem[index]
                                    color: Color(0xffC4DDFF),
                                  ),
                                )),
                            Expanded(
                              child: Row(
                                  children:[Text('09:30 AM',style: TextStyle(fontWeight: FontWeight.w600),),
                                    Spacer(),
                                    Container(
                                      margin: EdgeInsets.all(10),
                                      height: 100,
                                      width: 280,
                                      decoration: BoxDecoration(color: Colors.indigo,
                                          borderRadius: BorderRadius.circular(10)),
                                      child: Container(

                                          decoration: BoxDecoration( color: Colors.white,

                                              boxShadow: [BoxShadow(offset: Offset(-1,-1),color:Colors.black12,blurRadius: 5),]),
                                          margin: EdgeInsets.only(left: 6),
                                          padding: EdgeInsets.only(left: 15,top:15),
                                          child:Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text('HR Manager\'s Day',style: TextStyle(fontSize: 13,fontWeight: FontWeight.w600),),
                                              SizedBox(height: 8,),
                                              Text('this id description about task ',style: TextStyle(fontSize: 10,color:Colors.grey)),
                                              SizedBox(height: 8,),
                                              Container(
                                                  width: double.infinity,
                                                  child: Stack(
                                                    alignment: Alignment.centerLeft,
                                                    children: [
                                                      CircleAvatar(
                                                        radius: 15,
                                                        backgroundImage: NetworkImage(
                                                            'https://cdn-icons-png.flaticon.com/512/219/219983.png'),
                                                      ),
                                                      Positioned(
                                                        left: 20,
                                                        bottom: 0,
                                                        top: 0,
                                                        child: CircleAvatar(
                                                          radius: 15,
                                                          backgroundImage: NetworkImage(
                                                              'https://createivo.com/images/q1.jpeg'),
                                                        ),
                                                      ),
                                                      Positioned(
                                                        left: 40,
                                                        bottom: 0,
                                                        top: 0,
                                                        child: CircleAvatar(
                                                          radius: 15,
                                                          backgroundImage: NetworkImage(
                                                            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRH6Uyi30Ty2WkMb0ZjuFLoXmkRwrrMObm-X2zztWtGbOgyA-i7mFzuiSKltN14HLAJDVM&usqp=CAU',
                                                          ),
                                                        ),
                                                      ),
                                                      Positioned(
                                                        left: 60,
                                                        bottom: 0,
                                                        child: CircleAvatar(
                                                          radius: 15,
                                                          backgroundImage: NetworkImage(
                                                              'https://www.coursle.org/assets/img/user.png'),
                                                        ),
                                                      ),
                                                    ],
                                                  )),


                                            ],)
                                      ),

                                    )


                                  ]





                              ),
                            ),
                          ],)
                        ,



                      ),
                    )))





              ],),
          ),
        )





    );
  }
}