import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/src/provider.dart';
import 'package:tracker/providers/edit_team_provider.dart';
import '../../shared/components.dart';
import '../../shared/constants.dart';

class EditTeam extends StatefulWidget {
  const EditTeam({Key? key}) : super(key: key);

  @override
  State<EditTeam> createState() => _EditTeamState();
}

class _EditTeamState extends State<EditTeam> {
  editTeam(String name) async {
    var url="http://192.168.43.139:8000/api/admin/department/add";
    var token="eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiNWI3YmZlYTk5YTQzYjhjNDVlNjFlMTNlM2Q3MjBmYzFhMmY3NDQ1YTcxYmU4NDFjYTY2ZWQ5NzRmNTE1Nzk0OWFhZmUwNWE1OGZiZmY2NTciLCJpYXQiOjE2NTU5Nzk3MzMuMDM5NjAzLCJuYmYiOjE2NTU5Nzk3MzMuMDM5NjEsImV4cCI6MTY4NzUxNTczMi45ODQyNDcsInN1YiI6IjEiLCJzY29wZXMiOltdfQ.wVyZI0Nepr8dGcHBU8rQx04xCgtRHiSh3NLKs6dw_xw7pCpd2XrsqfGbdd6DIMJqXer225gp41uUoO0T3plqGL2UlOwUW1IYeAfFZWbAehFsqS69248T5I55a6KY3lktG5YkmGinKhFYwkYs8qfLfuizH4T4idy1NpSk49LILOKKJUvv7xc6tCcOfjNVgvqfE9Rupc7WhAuCa5W8yOqeKdqS94xTT1_wYeTdDbs_rdh5qEdX-ecQw3l8nbPTCGms_N22VEgp5QMSzDbRlm4asjtGP6slpqdAv8Arxv-J_9snkCqxcnAHaq-fpoGoOOLiCNc6kCv_C2NV9w4ZyxicQ-jw3sK81syn4RY0mio4gQIMLmAvpsKobvNfUJdYf05BJXG3UuykP9l9PS0v6IvgRyOrUI4EP8wq2hNCIM64O6xaF_5d5Ju91RD09SJ0OTMybmsrMzdT7mAMRR1d3KhKC-iok0IyLvv1g3Z2wKNY81Noky2i_7iXAtQhiT9zQO9AF47tQly6aYWpCIbK1sRrc0TVGRec6o6ESTu9ikJXYFto8BgTpQ52g5150vk6fVH2BMlFwpDcstdZ32QD_IAsacwWwF2jewhAxQGTDjGcpv0ADpKu0VGS5VJRmYxMG9XL-FNiNve1maay5WvKRgZvK4Ox4RMn-lIX2sd_GBqkupA";
    //used parse to generate URI obj out of my string url
    var response =await http.post(Uri.parse(url),headers: {'Accept':'application/json',
      'auth':'Bearer $token',
    },body: {
      "name":name
    });
    //var responsebody= jsonDecode(response.body);
    if(response.body.isNotEmpty) {
      json.decode(response.body);
      var responsebody= jsonDecode(response.body);
      print (responsebody);
      return responsebody;
    }
    else if(response.body.isEmpty)
      print("empty");

  }
  @override
  Widget build(BuildContext context) {
    TextEditingController teamNameController=TextEditingController();

    Size size =MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title:  Text('Edit team',style: trackerStyle,),
          automaticallyImplyLeading: false,
          // centerTitle: true,
         // titleTextStyle:  TextStyle(fontSize: 25,color:appFo,fontWeight: fw),
          backgroundColor: appCo,
          shadowColor: appCo,
          elevation: 0,
        ),
        backgroundColor: appCo,
        body:  SafeArea(
            child:Padding(

                padding:  EdgeInsets.only(
                    top:size.height*0.01,left:size.width*0.025,right: size.width*0.025  ),//.all(size.width*0.025),
                child:SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(height: size.height*0.10,),
                      Stack(
                          alignment: AlignmentDirectional.bottomCenter,
                          children:[
                            Container(
                                height: size.height*0.4,
                                decoration: const BoxDecoration(borderRadius: BorderRadius.only(topRight: Radius.circular(30),topLeft: Radius.circular(30)),
                                  image:DecorationImage(image: AssetImage("assets/images/teamy.jpg"),
                                    fit: BoxFit.fill,),)
                            ),
                            Container(
                              color: appFo,
                              child: Padding(
                                padding:EdgeInsets.only(right: 20,left:20,top: 20),
                                // padding: const EdgeInsets.all(8.0),
                                child: defaultTextFormField(controller: teamNameController,
                                    type: TextInputType.name,
                                    validate: (value){
                                      if(value!=null){print(value);}
                                    }, label: 'Team name', prefix: Icons.group),
                              ),
                            ),]
                      ),
                      Container(

                          height: size.height*0.08,
                          decoration:  BoxDecoration( color: appFo,borderRadius: BorderRadius.only(
                              bottomLeft:Radius.circular(r),bottomRight:Radius.circular(r)),
                          )
                      ),
                      SizedBox(height:size.height*0.06),
                      ElevatedButton(
                        onPressed: () {context.read<EditTeamProvider>().setTeamName(teamNameController.toString());
                        editTeam(EditTeamProvider().teamName);},
                        child:  Text('edit',style: TextStyle(color: appFo,fontSize: size.width*0.045)),
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
                      )

                    ],
                  ),
                )))
    );
  }
}
