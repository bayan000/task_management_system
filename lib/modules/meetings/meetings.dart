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
      appBar: trackerBar(),
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
                      height: size.height*0.125,
                      width: double.infinity,
                      child:  Text('  Meetings',
                        style:trackerStyle,
                      ),),
                    Container(
                      color: appCo,
                      child: Container(
                        height: size.height*0.775,//size.height*0.87,//620,
                        //constraints: BoxConstraints( maxHeight: double.infinity, ),
                        decoration:   const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(topRight: Radius.circular(70),topLeft:Radius.circular(70) )),

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
                    foregroundColor: MaterialStateProperty.all(pu.shade300),
                    backgroundColor: MaterialStateProperty.all(appCo), // <-- Button color
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

