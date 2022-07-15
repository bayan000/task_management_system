import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:tracker/modules/card_subtask.dart';

class TaskDetails extends StatefulWidget {
  List<Color> coloritem = [
    Colors.indigo,
    Colors.purple,
    Colors.deepOrange,
    Colors.orangeAccent,
    Colors.teal,
    Colors.red,
  ];


  @override
  State<TaskDetails> createState() => _TaskDetailsState();
}

class _TaskDetailsState extends State<TaskDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleAvatar(
                          radius: 18,
                          backgroundColor: Colors.grey[200],
                          child:
                          Icon(Icons.arrow_back_ios_outlined, color: Colors.black)),
                      Text(
                        'Task Details',
                        style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                      ),
                      CircleAvatar(
                          radius: 18,
                          backgroundColor: Colors.grey[200],
                          child: Icon(Icons.more_horiz, color: Colors.black)),
                    ],
                  ),

                  SizedBox(
                    height: 28,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Text(
                            'Please Finish thie onboarding in COVID_2020',
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          )),
                      Container(
                          padding: EdgeInsets.all(10),
                          width: 70,
                          decoration: BoxDecoration(
                              color: Colors.teal,
                              borderRadius: BorderRadius.circular(4)),
                          child: Text(
                            'ToDo',
                            style: TextStyle(
                                color: Colors.white, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ))
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),

                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Team Memmber',
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold)),
                            Container(
                                width: double.infinity,
                                margin: EdgeInsets.only(top: 15, bottom: 30),
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
                          ],
                        ),
                      ),
                      Spacer(),
                      CircularPercentIndicator(
                        radius: 80,
                        lineWidth: 6,
                        percent: 0.3,
                        animation: true,
                        animationDuration: 5000,
                        center: Text('40%',style: TextStyle(fontWeight: FontWeight.w500),),
                        progressColor: Colors.teal,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      Icon(Icons.attachment),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'Description',
                        style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  //SizedBox(height: 15,),

                  Container(
                      margin: EdgeInsets.only(top: 15, bottom: 30),
                      padding: EdgeInsets.all(13),
                      height: 140,
                      color: Colors.grey[100],
                      child: ListView(
                        children: [
                          Text(
                            'this is description about task this is dscription about task this is description about task this is description about task this is description about task this is description about task this is description about task this is description about task',
                            maxLines: 6,
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey[500],
                            ),
                          )
                        ],
                      )),
                  RowDate(),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'SubTasks',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                      child: ListView.builder(
                          itemCount: widget.coloritem.length,
                          itemBuilder: (context, index) =>

                              CardSubTask(color:widget.coloritem[index])

                      )),
                ],
              ),
            )));
  }
}

class RowDate extends StatelessWidget {
  const RowDate({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'When',
              style: TextStyle(
                  fontSize: 15,
                  color: Colors.indigo,
                  fontWeight: FontWeight.bold),
            ),
            Container(
                color: Colors.grey[200],
                margin: EdgeInsets.symmetric(vertical: 13),
                padding: EdgeInsets.all(10),
                child: Row(children: [
                  Icon(Icons.calendar_today_outlined, size: 20),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    '20 Sep 2020',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ])),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Dead Line',
              style: TextStyle(
                  fontSize: 15,
                  color: Colors.indigo,
                  fontWeight: FontWeight.bold),
            ),
            Container(
                color: Colors.grey[200],
                margin: EdgeInsets.symmetric(vertical: 13),
                padding: EdgeInsets.all(10),
                child: Row(children: [
                  Icon(Icons.calendar_today_outlined, size: 20),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    '20 Sep 2020',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ])),
          ],
        ),
      ],
    );
  }
}
