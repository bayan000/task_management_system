import 'package:flutter/material.dart';
import 'package:tracker/shared/components.dart';



import '../../shared/constants.dart';
import '../add meeting/add_meeting.dart';


class Meetings extends StatelessWidget {



  final String? cell;

  const Meetings({Key? key, this.cell}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size =MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appCo,
        shadowColor: appCo,
        elevation: 0,
        title:  Text('  Meetings',
        style:trackerStyle,
      )),
      body:

      SafeArea(
        child: Stack(
            alignment: Alignment.bottomRight,
            children: [
              SingleChildScrollView(

                physics: const NeverScrollableScrollPhysics(),
                child: Column(
                  //crossAxisAlignment: CrossAxisAlignment.end,
                  //mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      color: appCo,
                      height: size.height*0.06,
                      width: double.infinity,),
                    Container(
                      color: appCo,
                      child: Padding(
                        padding:  EdgeInsets.only(
                            top:size.height*0.01,left:size.width*0.025,right: size.width*0.025  ),
                        child: Container(
                          height: size.height*0.84,//size.height*0.87,//620,
                          //constraints: BoxConstraints( maxHeight: double.infinity, ),
                          decoration:    BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(topRight: Radius.circular(r),topLeft:Radius.circular(r) )),

                          padding: const EdgeInsets.only(top: 30),
                          //color: Colors.white,
                          child: ListView(

                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            children: [
                            meetingsTable(),
                            ],
                          ),
                        ),
                      ),
                    ),

                  ],

                ),
              ),
              Padding(
                padding:  EdgeInsets.all(size.width*0.07),
                child: ElevatedButton(
                  onPressed: () {Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const AddMeeting()));},
                  child: const Icon(Icons.group),
                  style: ButtonStyle(
                    elevation: MaterialStateProperty.all(40),
                    shape: MaterialStateProperty.all(const CircleBorder()),
                    padding: MaterialStateProperty.all(const EdgeInsets.all(20)),
                    foregroundColor: MaterialStateProperty.all(appFo),
                    backgroundColor: MaterialStateProperty.all(pu), // <-- Button color
                    overlayColor: MaterialStateProperty.resolveWith<Color?>((states) {
                      if (states.contains(MaterialState.pressed)) return pu; // <-- Splash color
                    }),
                  ),
                ),
              )
            ]
        ),
      ),
    );
  }


}

