import 'package:flutter/material.dart';

import 'package:percent_indicator/percent_indicator.dart';

class SubTask extends StatelessWidget {
  const SubTask({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              right: 0,
              top: 0,
              child: Container(
                height: 350,
                width: 200,
                decoration: BoxDecoration(
                    color: Colors.indigo,
                    borderRadius:
                    BorderRadius.only(bottomLeft: Radius.circular(800))),
              ),
            ),
            Positioned(
              left: 0,
              bottom: 0,
              child: Container(
                height: 350,
                width: 200,
                decoration: BoxDecoration(
                    color: Colors.indigo,
                    borderRadius:
                    BorderRadius.only(topRight: Radius.circular(800))),
              ),
            ),
            Container(
                margin: EdgeInsets.symmetric(vertical: 40, horizontal: 25),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        offset: Offset(-3, -3),
                        spreadRadius: 4,
                        blurRadius: 6,
                      )
                    ]),
                child:
                Padding(
                  padding: EdgeInsets.only(
                    top: 15,
                    right: 20,
                    left: 20,
                    bottom: 15,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 35.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CircleAvatar(
                              radius: 18,
                              backgroundColor: Colors.grey[100],
                              child: Icon(Icons.arrow_back_ios_outlined,
                                  color: Colors.black, size: 20),
                            ),
                            Text('SubTask Details',
                                style: TextStyle(
                                  fontSize: 23,

                                )),
                            CircleAvatar(
                              radius: 18,
                              backgroundColor: Colors.grey[100],
                              child: Icon(
                                Icons.more_horiz_outlined,
                                color: Colors.black,
                                size: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
//SizedBox(height: 20,),
                      Row(children: [
                        Expanded(
                          child: Text(
                            'Please Finish the onboarding in COVID_2020',
                            style: TextStyle(
                                fontSize: 18.3, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          width: 17,
                        ),
                        Container(
                            padding: EdgeInsets.all(10),
                            width: 70,
                            decoration: BoxDecoration(
                                color: Colors.pinkAccent,
                                borderRadius: BorderRadius.circular(4)),
                            child: Text(
                              'high',
                              style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ))
                      ]),
                      SizedBox(
                        height: 27,
                      ),
                      Text(
                        'task memmbers',
                        style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                      ),

                      Container(
                          width: double.infinity,
                          margin: EdgeInsets.only(top: 13, bottom: 30),
                          child: Stack(
                            alignment: Alignment.centerLeft,
                            children: [
                              CircleAvatar(
                                radius: 20,
                                backgroundImage: NetworkImage(
                                    'https://cdn-icons-png.flaticon.com/512/219/219983.png'),
                              ),
                              Positioned(
                                left: 25,
                                bottom: 0,
                                top: 0,
                                child: CircleAvatar(
                                  radius: 20,
                                  backgroundImage: NetworkImage(
                                      'https://createivo.com/images/q1.jpeg'),
                                ),
                              ),
                              Positioned(
                                left: 45,
                                bottom: 0,
                                top: 0,
                                child: CircleAvatar(
                                  radius: 20,
                                  backgroundImage: NetworkImage(
                                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRH6Uyi30Ty2WkMb0ZjuFLoXmkRwrrMObm-X2zztWtGbOgyA-i7mFzuiSKltN14HLAJDVM&usqp=CAU',
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 65,
                                bottom: 0,
                                child: CircleAvatar(
                                  radius: 20,
                                  backgroundImage: NetworkImage(
                                      'https://www.coursle.org/assets/img/user.png'),
                                ),
                              ),
                              Positioned(
                                left: 85,
                                bottom: 0,
                                top: 0,
                                child: CircleAvatar(
                                  radius: 20,
                                  backgroundImage: NetworkImage(
                                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRH6Uyi30Ty2WkMb0ZjuFLoXmkRwrrMObm-X2zztWtGbOgyA-i7mFzuiSKltN14HLAJDVM&usqp=CAU',
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 105,
                                bottom: 0,
                                top: 0,
                                child: CircleAvatar(
                                  radius: 20,
                                  backgroundImage: NetworkImage(
                                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRH6Uyi30Ty2WkMb0ZjuFLoXmkRwrrMObm-X2zztWtGbOgyA-i7mFzuiSKltN14HLAJDVM&usqp=CAU',
                                  ),
                                ),
                              ),
                            ],
                          )),
                      Row(
                        children: [
                          Icon(Icons.attachment),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Description',
                            style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      //SizedBox(height: 15,),

                      Container(
                          margin: EdgeInsets.only(top: 15, bottom: 36),
                          padding: EdgeInsets.all(13),
                          height: 140,
                          color: Colors.grey[100],
                          child: ListView(
                            children: [
                              Text(
                                'this is discription about task this is discription about task this is discription about task this is discription about task this is discription about task this is discription about task this is discription about task this is discription about task',
                                maxLines: 6,
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.grey[500],
                                ),
                              )
                            ],
                          )),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'When',
                                style: TextStyle(
                                    fontSize: 15, color: Colors.indigo,fontWeight: FontWeight.bold),
                              ),
                              Container(
                                  color: Colors.grey[200],
                                  margin: EdgeInsets.symmetric(vertical: 13),
                                  padding: EdgeInsets.all(10),
                                  child: Row(children: [
                                    Icon(Icons.calendar_today_outlined,size:20),
                                    SizedBox(width: 5,),
                                    Text('20 Sep 2020',style: TextStyle(fontWeight: FontWeight.bold),),
                                  ])),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Dead Line',
                                style: TextStyle(
                                    fontSize: 15, color: Colors.indigo,fontWeight: FontWeight.bold),
                              ),
                              Container(
                                  color: Colors.grey[200],
                                  margin: EdgeInsets.symmetric(vertical: 13),
                                  padding: EdgeInsets.all(10),
                                  child: Row(children: [
                                    Icon(Icons.calendar_today_outlined,size:20),
                                    SizedBox(width: 5,),
                                    Text('20 Sep 2020',style: TextStyle(fontWeight: FontWeight.bold),),
                                  ])
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 28,
                      ),



                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              padding: EdgeInsets.all(10),
                              width: 90,
                              decoration: BoxDecoration(
                                  color: Colors.teal,
                                  borderRadius: BorderRadius.circular(4)),
                              child: Text(
                                'ToDo ',
                                style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              )),
                          Text('80%',style: TextStyle(color:Colors.teal,fontSize: 15,fontWeight: FontWeight.bold),)

                        ],),






                      SizedBox(
                        height: 13,
                      ),
                      LinearPercentIndicator(
                        animation: true,

                        animationDuration: 8000,
                        lineHeight: 11,
                        progressColor: Colors.teal,
                        percent: 0.8,
                        //width: 70,
                        backgroundColor: Colors.grey[300],
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}