
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:tracker/controllers/edit_subtask_controller.dart';

import '../models/subtask_task_status_model.dart';
import '../shared/components.dart';
import '../shared/constants.dart';

class EditSubtask extends StatefulWidget {
  EditSubtask({Key? key}) : super(key: key);

  @override
  State<EditSubtask> createState() => _EditSubtaskState();

}

class _EditSubtaskState extends State<EditSubtask> {
  static var datoStarto;
  static var datoEndo;
  @override
  Widget build(BuildContext context) {
    DateTime _dateS;
    DateTime _dateEn;
    Size size =MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: appCo,
          shadowColor: appCo,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),

            onPressed: () {
              Navigator.pushReplacementNamed(
                  context, '/l_subtask');
            },
          ),
          title: Text('Edit subtask',style: trackerStyle,),
        ),
        backgroundColor: appCo,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(size.height*0.025),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:  [
                  Container(
                      height: size.height*0.25,
                      decoration:  BoxDecoration(
                        borderRadius: BorderRadius.only(topRight: Radius.circular(r),topLeft: Radius.circular(r),
                            bottomLeft:Radius.circular(r),bottomRight:Radius.circular(r) ),
                        image:const DecorationImage(image: AssetImage("assets/images/addEditSubtask.jpg"),
                          fit: BoxFit.fill,),)),
                  SizedBox(height: size.height*0.05,),
                  Consumer<EditSubtaskProvider>(
                      builder: (context,esp,child) {
                        return Row(
                          children: [
                            ElevatedButton(
                                style:  ButtonStyle(backgroundColor: MaterialStateProperty.all(appFo),
                                    shadowColor:MaterialStateProperty.all(pu) ,
                                    elevation:MaterialStateProperty.all(10)),
                                child: Text('starts at',style: TextStyle(color: pu,
                                    fontSize: size.width*0.04),),
                                onPressed: (){
                                  showDatePicker(context: context,
                                      initialDatePickerMode: DatePickerMode.day,
                                      initialEntryMode: DatePickerEntryMode.calendarOnly,
                                      initialDate: DateTime.now(),
                                      firstDate:  DateTime.now(),
                                      lastDate: DateTime(2050),
                                      builder: (context,picker){
                                        return Theme(data:ThemeData.light().copyWith(
                                            colorScheme: ColorScheme.light(primary: pu
                                            )),
                                          child:picker!,);}).then((date){
                                    if(date!=null)
                                    {
                                      _dateS=date;
                                      datoStarto=_dateS.year.toString()+"-"+_dateS.month.toString()+"-"+_dateS.day.toString();
                                      esp.changeDOS(datoStarto);
                                    }
                                  });
                                }),
                            SizedBox(width: size.width*0.08),
                            Text(esp.start==null?
                            'When does it start?':esp.printDOS(),style: TextStyle(color: appFo,fontSize: size.width*0.045),),
                          ],
                        );
                      }
                  ),
                  SizedBox(height:size.height*0.02),
                  Consumer<EditSubtaskProvider>(
                      builder: (context,esp,child) {
                        return Row(
                          children: [
                            ElevatedButton(
                                style:  ButtonStyle(backgroundColor: MaterialStateProperty.all(appFo),
                                    shadowColor:MaterialStateProperty.all(pu) ,
                                    elevation:MaterialStateProperty.all(10)),
                                child: Text('ends at',style: TextStyle(color: pu,
                                    fontSize: size.width*0.04),),
                                onPressed: (){
                                  showDatePicker(context: context,
                                      initialDatePickerMode: DatePickerMode.day,
                                      initialEntryMode: DatePickerEntryMode.calendarOnly,
                                      initialDate: DateTime.now(),
                                      firstDate:  DateTime.now(),
                                      lastDate: DateTime(2050),
                                      builder: (context,picker){
                                        return Theme(data:ThemeData.light().copyWith(
                                            colorScheme: ColorScheme.light(primary: pu
                                            )),
                                          child:picker!,);}).then((date){
                                    if(date!=null)
                                    {
                                      _dateEn=date;
                                      datoEndo=_dateEn.year.toString()+"-"+_dateEn.month.toString()+"-"+_dateEn.day.toString();
                                      esp.changeEO(datoEndo);
                                    }
                                  });
                                }),
                            SizedBox(width: size.width*0.08),
                            Text(esp.end==null?
                            'When does it end?':esp.printEO()
                              ,style: TextStyle(color: appFo,fontSize: size.width*0.045),),

                          ],
                        );
                      }
                  ),
                  SizedBox(height:size.height*0.02),
                  Consumer<EditSubtaskProvider>(
                      builder: (context,esp,child) {
                        return Padding(
                          padding:const EdgeInsets.only(right: 20),
                          // padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(borderRadius: BorderRadius.only(topRight: Radius.circular(size.width*0.0096),topLeft: Radius.circular(size.width*0.0096),
                                bottomLeft:Radius.circular(size.width*0.0096),bottomRight:Radius.circular(size.width*0.0096) ),
                                color: appFo
                            ),
                            child: defaultTextFormField(controller:esp.title,

                                hint: 'Title',
                                type: TextInputType.name,
                                validate:(value){if(value!.isEmpty){
                                  return 'Write a title please ! ';
                                }
                                return null;} ,
                                label: '', prefix: Icons.title),
                          ),
                        );
                      }
                  ),
                  SizedBox(height:size.height*0.02),
                  Consumer<EditSubtaskProvider>(
                      builder: (context,esp,child) {
                        return Padding(
                          padding:const EdgeInsets.only(right: 20),
                          // padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(borderRadius: BorderRadius.only(topRight: Radius.circular(size.width*0.0096),topLeft: Radius.circular(size.width*0.0096),
                                bottomLeft:Radius.circular(size.width*0.0096),bottomRight:Radius.circular(size.width*0.0096) ),
                                color: appFo
                            ),
                            child: defaultTextFormField(controller:esp.description,

                                hint: 'Description',
                                type: TextInputType.name,
                                validate:(value){if(value!.isEmpty){
                                  return 'Write a description please ! ';
                                }
                                return null;},
                                label: '', prefix: Icons.description),
                          ),
                        );
                      }
                  ),
                  SizedBox(height:size.height*0.02),
                  Consumer<EditSubtaskProvider>(
                      builder: (context,esp,child) {
                        return FutureBuilder<List<StatusModel>>(
                            future:esp.fetchStates(),
                            builder: (context,snapshot){return Row(
                              children: [
                                Text('subtask status',style: TextStyle(color: appFo,fontSize: size.width*0.045),),
                                SizedBox(width:size.width*0.08),
                                DropdownButton<String>(
                                    dropdownColor: pu,
                                    style: TextStyle(color: appFo,fontSize: size.width*0.045),
                                    icon: Icon(Icons.arrow_drop_down,color: appFo,),
                                    value:esp.state,
                                    items: EditSubtaskProvider.stt.map(buildMenuItem).toList(),
                                    onChanged: (String? value)=>setState(() {
                                      esp.state=value.toString();
                                      esp.stateeee= esp.stateId[esp.state];
                                    })
                                )
                              ],
                            );}
                        );
                      }
                  )
                  ,SizedBox(height:size.height*0.02),
                  Consumer<EditSubtaskProvider>(
                      builder: (context,esp,child) {
                        return FutureBuilder<List<StatusModel>>(
                            future:esp.fetchPriorites(),
                            builder: (context,snapshot){return Row(
                              children: [
                                Text('subtask priority',style: TextStyle(color: appFo,fontSize: size.width*0.045),),
                                SizedBox(width:size.width*0.08),
                                DropdownButton<String>(
                                    dropdownColor: pu,
                                    style: TextStyle(color: appFo,fontSize: size.width*0.045),
                                    icon: Icon(Icons.arrow_drop_down,color: appFo,),
                                    value:esp.priority,
                                    items: EditSubtaskProvider.st.map(buildMenuItem).toList(),
                                    onChanged: (String? value)=>setState(() {
                                      //string
                                      esp.priority=value.toString();
                                      //int
                                      esp.proiorityyyy= esp.proiorityId[esp.priority];
                                      print(esp.priority);
                                      print(esp.proiorityyyy);
                                    })
                                )
                              ],
                            );}
                        );
                      }
                  ),
                  Row(children:[
                    const Text(
                      'add ',
                      style: TextStyle(
                        fontSize: 18,
                        color:appFo ,
                      ),
                    ),
                    Consumer<EditSubtaskProvider>(
                        builder: (context,esp,child) {
                          return TextButton(onPressed: (){
                            if(esp.l.length!=0) {
                              esp.l.length=0;
                            }
                            Navigator.pushReplacementNamed(
                                context, '/selectToEditSubtask');

                          }, child: const Text(
                            'Members',
                            style:TextStyle(
                              fontSize: 20,
                              color:appFo,
                            ),
                          ),
                          );
                        }
                    )
                  ],
                  ),
                  SizedBox(height:size.height*0.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Consumer<EditSubtaskProvider>(
                          builder: (context,esp,child) {
                            return ElevatedButton(
                              onPressed:() async{
                                EasyLoading.show(status: 'Loading....');
                                if(esp.l.isEmpty||esp.description==null||esp.title==null||esp.proiorityyyy==null||
                                    esp.stateeee==null||esp.end==null||esp.state==null)
                                  EasyLoading.showError('All fields are required ');
                                else
                                {
                                  await esp.onEditS();
                                  if (esp.message=="200" || esp.message=="201")
                                  {
                                    EasyLoading.showSuccess("subtask edited successfully");
                                    /*  Navigator.pushReplacementNamed(
                                            context, '/Task');*/
                                  }
                                  else
                                  {
                                    EasyLoading.showError('oops! error');

                                  }
                                }
                              }
                              ,child:  Text('edit',style: TextStyle(color: appFo,fontSize: size.width*0.045)),
                              style: ButtonStyle(
                                //elevation: MaterialStateProperty.all(40),
                                shape: MaterialStateProperty.all(const CircleBorder()),
                                padding: MaterialStateProperty.all(const EdgeInsets.all(20)),
                                foregroundColor: MaterialStateProperty.all(appFo),
                                backgroundColor: MaterialStateProperty.all(pu), // <-- Button color
                                overlayColor: MaterialStateProperty.resolveWith<Color?>((states) {
                                  if (states.contains(MaterialState.pressed)) return pu; // <-- Splash color
                                }),
                              ),
                            );
                          }
                      )
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
