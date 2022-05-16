import 'package:flutter/material.dart';

import '../../shared/constants.dart';



class AddMeeting extends StatelessWidget {
  const AddMeeting({Key? key, this.dateTime, this.value}) : super(key: key);
   final DateTime? dateTime;
  final String? value ;
  static const items=[
    'OnGoing','Done','Cancelled'
  ];
  static const names=[
    'Doha','Salma','Laila'
  ];
  @override
  Widget build(BuildContext context) {
    Size size =MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: appCo,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(

              padding: EdgeInsets.all(size.height*0.025),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                            children:  [

                              SizedBox(height: size.height*0.049,),
                              Text('Add meeting',style: trackerStyle,),
                              SizedBox(height: size.height*0.03,),
                              Material(
                                elevation: 15,
                                child: Container(
                                  height: size.height*0.25,
                                    decoration: const BoxDecoration(
                                      image:DecorationImage(image: AssetImage("assets/images/puzzle.jpg"),
                                  fit: BoxFit.fill,),)),
                              ),
                              SizedBox(height: size.height*0.05,),
                              Row(
                                children: [
                              ElevatedButton(
                              style:  ButtonStyle(backgroundColor: MaterialStateProperty.all(appFo),
                                  shadowColor:MaterialStateProperty.all(pu) ,
                                  elevation:MaterialStateProperty.all(10)),
                             child: Text('Date of meeting',style: TextStyle(color: pu,fontSize: size.width*0.04),),
                             onPressed: (){
                                     showDatePicker(context: context,
                                                    initialDate: DateTime.now(),
                                                   firstDate: DateTime(2020),
                                                   // ignore: avoid_print
                                                   lastDate: DateTime(2050)).then((date){print('picked');});//emit here meeting's date
                                              }),
                                  SizedBox(width: size.width*0.08),
                                  Text(dateTime==null? 'when is your meeting?':dateTime.toString(),style: TextStyle(color: Colors.black45,fontSize: size.width*0.045),),
                                ],
                              ),
                              SizedBox(height:size.height*0.02),
                              Row(
                                children: [
                                  Text('Meeting status',style: TextStyle(color: Colors.black45,fontSize: size.width*0.045),),
                                  SizedBox(width:size.width*0.08),
                                  DropdownButton<String>(

                                      value: value,
                                      items: items.map(buildMenuItem).toList(),
                                      onChanged: (value)=>print('have chosen')),
                                ],
                              ),//emit meeting status
                              SizedBox(height:size.height*0.02),
                              Row(
                                children: [
                                  ElevatedButton(
                                      style:  ButtonStyle(backgroundColor: MaterialStateProperty.all(appFo),
                                          shadowColor:MaterialStateProperty.all(pu) ,
                                          elevation:MaterialStateProperty.all(10)),
                                      child: Text('time of meeting',style: TextStyle(color: pu,fontSize: size.width*0.04),),
                                      onPressed: (){
                                        // ignore: avoid_print
                                        showTimePicker(context: context, initialTime: const TimeOfDay(hour: 12, minute: 0)).then((date){print('picked');});
                                          //emit here meeting's time
                                      }),
                                  SizedBox(width: size.width*0.08),
                                  Text(dateTime==null? 'which hour is it?':dateTime.toString(),style: TextStyle(color: Colors.black45,fontSize: size.width*0.045),),
                                ],
                              ),
                              SizedBox(height:size.height*0.02),
                              Row(
                                children: [
                                  Text('Meeting with',style: TextStyle(color: Colors.black45,fontSize: size.width*0.045),),
                                  SizedBox(width:size.width*0.08),
                                  DropdownButton<String>(
                                      value: value,
                                      items: names.map(buildMenuItem).toList(),
                                      onChanged: (value)=>print('have chosen')),
                                ],
                              ),//here we'll emit
                              SizedBox(height:size.height*0.02),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextButton(onPressed: (){}, child: const Text(' Add ',
                                    style: TextStyle(fontSize: 20,color:pu,fontWeight: fw),)),
                                ],
                              ),
                              //SizedBox(height:size.height*0.02),

                            ],
              ),

            ),

          ),
        ));
  }
  DropdownMenuItem<String> buildMenuItem(String item) =>
      DropdownMenuItem(value:item,child: Text(item));

}

