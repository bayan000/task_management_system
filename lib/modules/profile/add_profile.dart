
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:tracker/shared/components.dart';

import '../../controllers/profile_controller.dart';
import '../../shared/constants.dart';
import '../user/add_user.dart';

class AddProfile extends StatefulWidget {
  String? _imgPath;
  @override
  State<AddProfile> createState() => _AddProfileState();
}

class _AddProfileState extends State<AddProfile> {


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var contr=Provider.of<ProfileController>(context);
    return Scaffold(
        body: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              //crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(alignment: AlignmentDirectional.bottomCenter, children: [
                    Column(
                      children: [
                        Container(
                          height: size.height*0.25,
                          color: Colors.blue,

                        ),
                        Container(
                          height: size.height * 0.06,
                        ),
                      ],
                    ),
                    Positioned(
                      left: 0,
                      top: 8,
                      child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          )),
                    ),
                    Column(
                        children: [
                          GestureDetector(
                              onTap: () async {


                                XFile? xfile = await ImagePicker().pickImage(source: ImageSource.gallery);
                                if(xfile != null)
                                  setState(() {
                                    widget._imgPath = xfile.path;
                                  });
                              }
                              ,
                              child:



                              widget._imgPath == null ?

                              CircleAvatar(
                                  radius: 70,
                                  backgroundImage:

                                  NetworkImage(
                                    'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png',


                                  )
                              ):
                              CircleAvatar(
                                  radius: 70,
                                  backgroundImage:

                                  FileImage(File(widget._imgPath!))
                              )



                          ),
                        ]  )
                  ],
                  ),

                  SizedBox(
                    height: size.height * 0.02,
                  ),


                  Row(

                      mainAxisAlignment:MainAxisAlignment.center,children: [
                    Text('${GetStorage().read('first_name')}',
                        style: TextStyle(
                          fontSize: 20,
                        )),
                    SizedBox(width: 5),
                    Text('${GetStorage().read('last_name')}',
                        style: TextStyle(
                          fontSize: 20,
                        )),
                  ]),
                  SizedBox(
                    height: size.height * 0.01,
                  ),


                  Padding(
                      padding: const EdgeInsets.only(right: 10, left: 10),
                      // padding: const EdgeInsets.all(8.0),
                      child:


                      InputField(
                        widget: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topRight:
                                  Radius.circular(size.width * 0.0096),
                                  topLeft: Radius.circular(size.width * 0.0096),
                                  bottomLeft:
                                  Radius.circular(size.width * 0.0096),
                                  bottomRight:
                                  Radius.circular(size.width * 0.0096)),
                              color: appFo),
                          child: defaultTextFormField(
                              controller: contr.phone,
                              hint: 'Phone',
                              type: TextInputType.phone,
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return 'Write an phone please ! ';
                                }
                                return null;
                              },
                              label: '',
                              prefix: Icons.phone),
                        ),
                        title: 'Phone',
                      )


                  ),

                  Padding(
                      padding: const EdgeInsets.only(right: 10, left: 10),
                      // padding: const EdgeInsets.all(8.0),
                      child: InputField(
                        widget: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topRight:
                                  Radius.circular(size.width * 0.0096),
                                  topLeft: Radius.circular(size.width * 0.0096),
                                  bottomLeft:
                                  Radius.circular(size.width * 0.0096),
                                  bottomRight:
                                  Radius.circular(size.width * 0.0096)),
                              color: appFo),
                          child: defaultTextFormField(
                              controller: contr.contact,
                              hint: 'Contact',
                              type: TextInputType.url,

                              label: '',
                              prefix: Icons.link),
                        ),
                        title: 'Contact',
                      )),
                  Padding(
                      padding: const EdgeInsets.only(right: 10, left: 10),
                      // padding: const EdgeInsets.all(8.0),
                      child: InputField(
                        widget: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topRight:
                                  Radius.circular(size.width * 0.0096),
                                  topLeft: Radius.circular(size.width * 0.0096),
                                  bottomLeft:
                                  Radius.circular(size.width * 0.0096),
                                  bottomRight:
                                  Radius.circular(size.width * 0.0096)),
                              color: appFo),
                          child: defaultTextFormField(
                              controller: contr.education,
                              hint: 'Education',
                              type: TextInputType.text,

                              label: '',
                              prefix: Icons.school),
                        ),
                        title: 'Education',
                      )),
                  Padding(
                      padding: const EdgeInsets.only(right: 10, left: 10),
                      // padding: const EdgeInsets.all(8.0),
                      child: InputField(
                        widget: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topRight:
                                  Radius.circular(size.width * 0.0096),
                                  topLeft: Radius.circular(size.width * 0.0096),
                                  bottomLeft:
                                  Radius.circular(size.width * 0.0096),
                                  bottomRight:
                                  Radius.circular(size.width * 0.0096)),
                              color: appFo),
                          child: defaultTextFormField(
                              controller: contr.experince,
                              hint: 'Experince',
                              type: TextInputType.text,

                              label: '',
                              prefix: Icons.add),
                        ),
                        title: 'Experince',
                      )),


                ]),
          ),
        ),
        floatingActionButton:
        FloatingActionButton(
            child: Icon(Icons.check_outlined),
            backgroundColor: Colors.purple,
            onPressed: () async {
              EasyLoading.show(status: 'Loading....');
              await GetStorage().write('Path_of_imgProfile',widget._imgPath);

              if ( contr.phone == null)
                EasyLoading.showError(' phone fields are required ');
              else {
                print('imgPath');
                print(widget._imgPath);

                await contr.onClickAddProfile(widget._imgPath);

                if (contr.profileobj != null) {
                  EasyLoading.showSuccess('new profile is created');
                  await GetStorage().write('has_profile',true);
                  print('img');
                  print(contr.profileobj.img_profile);
                  Navigator.pushNamed(context,'/ProfileScr');
                }
                else {
                  EasyLoading.showError('oops! error');
                }



              }
            }

        )










    );
  }
}