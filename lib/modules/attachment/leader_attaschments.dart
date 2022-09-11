
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../controllers/attachment_controller.dart';
import '../../models/attachment_model.dart';
import '../../shared/constants.dart';

class LAttachementScr extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar( color: Colors.blue,text:'Attachement',prefixIcon: Icons.arrow_back,onPressedPre: (){

        Navigator.pop(context);

      }),
      body:
      Consumer<AttachementController>(builder:(context,controller,_)=>   FutureBuilder< List<AttachementModel> >(
        future: controller.fetchAttachement(),
        builder: (context,snapShot){
          //AsyncSnapShot

          if(snapShot.hasData && controller.attachement_list.length == 0 ){
            return Center(
                child:   Text('No links found',style: TextStyle(fontSize: 15),)
            );
          }
          if(snapShot.hasData)
            return

              ListView.builder(
                itemCount: snapShot.data!.length,
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () async {
                    if (await canLaunch('${snapShot.data![index].description}'.toString())) {
                      await launch(
                        '${snapShot.data![index].description}'.toString(),
                        forceSafariVC: false,
                        forceWebView: false,
                        enableJavaScript: false,
                      );
                    }
                  },
                  child: Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10))),
                      margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
                      height: 90,
                      child: Row(
                        children: [
                          Container(
                              decoration: BoxDecoration(
                                  color: Colors.black12,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10))),
                              width: 90,
                              child: Center(
                                child: Icon(
                                  Icons.attachment,
                                  size: 26,
                                  color: Colors.white,
                                ),
                              )),
                          Expanded(
                              child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0,
                                      top: 20,
                                      right: 8,
                                      bottom: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text('${snapShot.data![index].description}',maxLines: 2,overflow: TextOverflow.ellipsis,),
                                      Spacer(),
                                      Text(
                                        Uri.parse('${snapShot.data![index].description}').host,
                                        style: TextStyle(
                                            color: Colors.grey[500]),
                                      )
                                    ],
                                  )))
                        ],
                      )),
                ),
              );



          if(snapShot.hasError)
            return Center(
              child: Text(snapShot.error.toString()),
            );

          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ) )


      ,




    );
  }
}