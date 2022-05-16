import 'package:flutter/material.dart';



import '../../shared/constants.dart';
import '../add meeting/add_meeting.dart';


class Meetings extends StatefulWidget {
  const Meetings({Key? key}) : super(key: key);

  @override
  _MeetingsState createState() => _MeetingsState();
}

class _MeetingsState extends State<Meetings> {
  String? cell;
  @override
  Widget build(BuildContext context) {
    Size size =MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appCo,
        shadowColor: appCo,
        elevation: 0,
      ),
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
                            Table(


                              /* border: TableBorder.symmetric(
                              inside: const BorderSide(width: 1,),
                            ),*/
                              // border: TableBorder.all(),
                              columnWidths: const {
                                0: FractionColumnWidth(0.25),
                                1: FractionColumnWidth(0.25),
                                2: FractionColumnWidth(0.25),
                                3: FractionColumnWidth(0.25),
                              },
                              children: [

                                buildRow(const ['Date','Status','Start time','with'],isHeader: true),
                                buildRow(['18/12/2021','done','5:00','some guest']),
                                buildRow(['18/12/2021','done','5:00','some guest']),
                                buildRow(['18/12/2021','done','5:00','some guest']),
                                buildRow(['18/12/2021','done','5:00','some guest']),
                                buildRow(['18/12/2021','done','5:00','some guest']),
                                buildRow(['18/12/2021','done','5:00','some guest']),
                                buildRow(['18/12/2021','done','5:00','some guest']),
                                buildRow(['18/12/2021','done','5:00','some guest']),
                                buildRow(['18/12/2021','done','5:00','some guest']),
                                buildRow(['18/12/2021','done','5:00','some guest']),
                                buildRow(['18/12/2021','done','5:00','some guest']),
                                buildRow(['18/12/2021','done','5:00','some guest']),
                                buildRow(['18/12/2021','done','5:00','some guest']),
                                buildRow(['18/12/2021','done','5:00','some guest']),
                                buildRow(['18/12/2021','done','5:00','some guest']),
                                buildRow(['18/12/2021','done','5:00','some guest']),
                                buildRow(['18/12/2021','done','5:00','some guest']),
                                buildRow(['18/12/2021','done','5:00','some guest']),
                                buildRow(['18/12/2021','done','5:00','some guest']),
                                buildRow(['18/12/2021','done','5:00','some guest']),
                                buildRow(['18/12/2021','done','5:00','some guest']),
                                buildRow(['18/12/2021','done','5:00','some guest']),
                                buildRow(['18/12/2021','done','5:00','some guest']),
                                buildRow(['18/12/2021','done','5:00','some guest']),
                                buildRow(['18/12/2021','done','5:00','some guest']),
                                buildRow(['18/12/2021','done','5:00','some guest']),
                                buildRow(['18/12/2021','done','5:00','some guest']),
                                buildRow(['18/12/2021','done','5:00','some guest']),
                                buildRow(['18/12/2021','done','5:00','some guest']),
                                buildRow(['18/12/2021','done','5:00','some guest']),
                                buildRow(['18/12/2021','done','5:00','some guest']),
                                buildRow(['18/12/2021','done','5:00','some guest']),
                                buildRow(['18/12/2021','done','5:00','some guest']),
                                buildRow(['18/12/2021','done','5:00','some guest']),
                                buildRow(['18/12/2021','done','5:00','some guest']),
                                buildRow(['18/12/2021','done','5:00','some ']),


                              ],
                            ),

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
  /*TableRow buildRowFirst(List<String> cells) => TableRow(
      children:[
        //...
        //If you want to use the .map function inside ListView children,
        // you should convert map result - iterable - to list and use the spread operator to spread this list inside children
        ...cells.map((cell){
          return Padding(padding: const EdgeInsets.all(12),
            child: Center(child: Text(cell,style:const TextStyle(fontWeight: fw),overflow: TextOverflow.ellipsis,),),
          );
        })]
  );*/
  TableRow buildRow(List<String> cells,{bool isHeader=false}) => TableRow(
      children:[
        //...
        //If you want to use the .map function inside ListView children,
        // you should convert map result - iterable - to list and use the spread operator to spread this list inside children
        ...cells.map((cell){
          return Padding(padding: const EdgeInsets.all(12),
            child: Center(child: Text(cell,style:style(isHeader),overflow: TextOverflow.ellipsis,),),
          );
        })]
  );
}

