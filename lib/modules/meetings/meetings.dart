import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:tracker/config/server_config.dart';
import 'package:tracker/controllers/meetings_controller.dart';
import 'package:tracker/models/meetingModel.dart';
import 'package:tracker/services/meeting_service.dart';
import 'package:tracker/shared/components.dart';
import '../../shared/constants.dart';
import '../add meeting/add_meeting.dart';
import '../meeting/meeting.dart';
class Meetings extends StatelessWidget {
  var status;
   Meetings({Key? key}) : super(key: key);

  @override

  Widget build(BuildContext context) {
    var meeting;
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
 Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        SingleChildScrollView(

                          physics: const NeverScrollableScrollPhysics(),
                          child: Column(
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
                                    height: size.height*0.84,
                                    decoration:    BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(topRight: Radius.circular(r),topLeft:Radius.circular(r) )),
                                    padding: const EdgeInsets.only(top: 30),
                                    child: SingleChildScrollView(
                                      physics: const BouncingScrollPhysics(),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Consumer<MeetingsController>(
                                            builder: (context,meetingsController,child) {
                                              return FutureBuilder<List<MeetingModel>>(
                                                future: meetingsController.fetchMeetings(),
                builder: (context,snapshot){
                if(snapshot.connectionState==ConnectionState.waiting)
                {return Column(
                children: [
                SizedBox(height: size.height*0.37,),
                Container(
                height: size.height*0.5,
                alignment: AlignmentDirectional.bottomCenter,
                child: Center(child: Column(children: [
                CircularProgressIndicator(),
                SizedBox(height: size.height*0.01,),
                Text('loading...',style: TextStyle(fontSize: 15),),],)),),
                ],
                );}
                if(snapshot.hasError)
                {
                return Center(child: Text('Error !',style: TextStyle(fontSize: 20),),);
                }
                else{
                return ListView.separated (
                physics: const BouncingScrollPhysics(),
                shrinkWrap:true,
                itemBuilder: (context, index) {

                meeting=snapshot.data?[index];
                return buildMeetingItem(context,size,meeting,meetingsController,
                meetingsController.statesMap[meeting?.meeting_status]);
                },
                separatorBuilder: (context, index) =>index%2==0?

                Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(width: size.width,height: size.height*0.005,color:appCo,),
                ):
                Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(width: size.width,height: size.height*0.005,color:pu,),
                ),

                itemCount:snapshot.data?.length ??0
                );}}
                );
                                            }
                                          ),

                                        ],
                                      ),

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
                            onPressed: () {
                              Navigator.pushReplacementNamed(
                                  context, '/add_meeting');
                            },
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
                  )
    );}

              }


Widget buildMeetingItem(BuildContext context,Size size,MeetingModel meetingModel,
    MeetingsController meetingsController,String status)=>

    GestureDetector(
      onTap: (){
  Navigator.of(context).pushReplacement(                                                         //new
  new MaterialPageRoute(                                                                       //new
  settings: const RouteSettings(name: '/meeting'),                                              //new
  builder: (context) => new Meeting(id: meetingModel.id,) //new
  )                                                                                            //new
  );
},
      child:Padding(
        padding:  EdgeInsets.all(size.width*0.04),
        child: Container(
          height: size.height*0.2,
          color: appFo,
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(meetingModel.meeting_date as String,
                    style: TextStyle(
                      color: pu,fontSize: size.width*0.04,fontWeight: FontWeight.bold
                  ),),
                  SizedBox(height: size.height*0.1,),
                  IconButton(color:pu,onPressed: ()async=>{
                    await showAlertDialog(context,size.width,meetingsController,meetingModel.id)}, icon: Icon(Icons.delete,color: myGray,),)
                ],
              ),
              SizedBox(width: size.width*0.05,),
              Container(height: size.height*0.17,
                width: size.width*0.002,
                color: myGray,
              ),
              SizedBox(width: size.width*0.05,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(status,style: TextStyle(color: kblack,fontSize: size.width*0.055,fontWeight: FontWeight.bold
                  ),),
                  SizedBox(height: size.height*0.03,),
                  meetingModel.participants!.length!=0?
                  Row(children: [

                    Row(
                      children:[

                         meetingModel.participants ![0]?.img_profile==null?
               CircleAvatar(
                  radius: 20.0,
                    backgroundImage: AssetImage('assets/images/avatary.jpg'
                    )
                ):

                 CircleAvatar(
                    radius: 20.0,
                    backgroundImage: NetworkImage(meetingModel.participants?[0]?.img_profile as String)

              ),

                        SizedBox(width: size.width*0.03,),
                    meetingModel.participants!.length>=2 &&meetingModel.participants ![1]?.img_profile==null?
                    CircleAvatar(
                        radius: 20.0,
                        backgroundImage: AssetImage('assets/images/avatary.jpg'
                        )
                    ):
                    meetingModel.participants!.length>=2 &&meetingModel.participants ![1]?.img_profile!=null?

                    CircleAvatar(
                        radius: 20.0,
                        backgroundImage: NetworkImage(meetingModel.participants?[1]?.img_profile as String)

                    ):
                    SizedBox(width: size.width*0.03,),
                        meetingModel.participants!.length>=3 &&meetingModel.participants ![2]?.img_profile==null?
                        Row(
                          children: [
                            SizedBox(width: size.width*0.03,),
                            CircleAvatar(
                                radius: 20.0,
                                backgroundImage: AssetImage('assets/images/avatary.jpg'
                                )
                            ),
                            SizedBox(width: size.width*0.03,),
                            Text('..',style: TextStyle(fontSize: size.width*0.1,color: kblack),)
                          ],
                        ):
                        meetingModel.participants!.length>=3 &&meetingModel.participants ![2]?.img_profile!=null?

                        Row(
                          children: [
                            SizedBox(width: size.width*0.03,),
                            CircleAvatar(
                                radius: 20.0,

                                backgroundImage: NetworkImage(meetingModel.participants?[2]?.img_profile as String)

                            ),
                            SizedBox(width: size.width*0.03,),
                            Text('..',style: TextStyle(fontSize: size.width*0.1,color: kblack),)
                          ],
                        ):
                        SizedBox(width: size.width*0.03,),
                      ]
                    )


                  ],):

                  Column(
                    children: [
                      SizedBox(height: size.height*0.01,),
                      Text('Did not select participants',style: TextStyle(fontSize: size.width*0.04,color: appCo),),
                      SizedBox(height: size.height*0.03,),
                    ],
                  ),

                  SizedBox(height: size.height*0.03,),
                  Text(getTheHour(meetingModel.start_at as String))

                ],
              ),
            ],
          ),
        ),
      ) ,
    );


  showAlertDialog(BuildContext context,double w,MeetingsController meetingsController,int id) {


    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed:  () =>{ Navigator.pop(context)},
    );
    Widget continueButton = TextButton(
      child: Text("Delete"),
      onPressed:  ()async {await meetingsController.deletion(id);
      if (meetingsController.message=="200" || meetingsController.message=="201")
      {
       // EasyLoading.showSuccess("meeting deleted successfully");
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('meeting deleted successfully'),
        ));
        Navigator.pop(context);
      }
      else
      {
        EasyLoading.showError('oops! error'+meetingsController.message.toString());

      }
      },

    );
    Widget iconty=Icon(Icons.delete,size: w*0.1,);

    AlertDialog alert = AlertDialog(
      title:iconty,
      content: Text("Do you really want to delete this meeting ?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }


