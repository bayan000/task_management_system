

import 'package:flutter/material.dart';
import 'package:tracker/models/mod_tasks.dart';
import 'package:tracker/shared/constants.dart';
import 'package:percent_indicator/percent_indicator.dart';

class cardTask extends StatefulWidget {
  int index;
  cardTask({required this.index});

  @override
  State<cardTask> createState() => _cardTaskState();
}

class _cardTaskState extends State<cardTask> {
  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return Container(
      height: size.width*0.43,
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
          padding:  EdgeInsets.fromLTRB(size.width*0.044, size.width*0.033, size.width*0.042, size.width*0.01),
          child: Row(
            children: [
              Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        dataTasks.dataT[widget.index].nameTask,
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      SizedBox(
                        height: size.width*0.012,
                      ),
                      Text(
                        dataTasks.dataT[widget.index].discription,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey[600],
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(
                        height: size.width*0.05,
                      ),
                      Text(
                        'Team members ',
                        style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                      ),
                      SizedBox(
                        height: size.width*0.012,
                      ),
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
                      SizedBox(
                        height: size.width*0.06,
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
                            width: size.width*0.013,
                          ),
                          Text(
                            dataTasks.dataT[widget.index].date,
                            style: TextStyle(
                                fontSize: 13, color: Colors.grey[600]),
                          ),
                        ],
                      )
                    ],
                  )),
              Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.more_horiz),
                      SizedBox(
                        height: 27,
                      ),
                      CircularPercentIndicator(
                        radius: 90,
                        lineWidth: 6,
                        percent: 0.3,
                        animation: true,
                        animationDuration: 5000,
                        center: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${dataTasks.dataT[widget.index].percent}',
                              style: TextStyle(color: Colors.teal),
                            ),
                            Text(
                              '%',
                              style: TextStyle(color: Colors.teal),
                            ),
                          ],
                        ),
                        progressColor: Colors.teal,
                      )
                    ],
                  )),
            ],
          )),
    );
  }
}