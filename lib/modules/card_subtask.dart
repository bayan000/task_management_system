
import 'package:flutter/material.dart';

class CardSubTask extends StatelessWidget {
  const CardSubTask({

    required this.color
  }) ;


  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      //  width: 250,
      margin:
      EdgeInsets.symmetric(vertical: 6, horizontal: 3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: color,
        boxShadow: [
          BoxShadow(
            // color: Colors.red,
            color: Colors.black12,
            offset: Offset(-1, -1),
            spreadRadius: 2,
            blurRadius: 2,
          )
        ],
      ),
      child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
                20
            ),
            color: Colors.white,
          ),
          margin: EdgeInsets.only(left: 8),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Text(
                      'HR Manager\'s Day',
                      style: TextStyle(
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      'This is description about sub task',
                      style: TextStyle(
                          fontSize: 12, color: Colors.grey),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Icon(Icons.calendar_today_outlined,
                            size: 13),
                        SizedBox(
                          width: 7,
                        ),
                        Text(
                          '20 Sep 2020',
                          style: TextStyle(fontSize: 13),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Container(
                  padding: EdgeInsets.all(10),
                  width: 60,
                  decoration: BoxDecoration(
                      color: color,
                      borderRadius:
                      BorderRadius.circular(24)),
                  child: Text(
                    'ToDo ',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400),
                    textAlign: TextAlign.center,
                  )),
            ],
          )),
    );
  }
}