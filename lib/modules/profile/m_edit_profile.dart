import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../config/server_config.dart';
import '../../controllers/profile_controller.dart';
import '../../shared/components.dart';
import '../../shared/constants.dart';
import '../user/add_user.dart';

class MEditProfile extends StatefulWidget {
  String? _imgPath;
  var id;
  String? img;
  MEditProfile({Key? key,this.id,this.img}) : super(key: key);
  @override
  _MEditProfileState createState() => _MEditProfileState();
}

class _MEditProfileState extends State<MEditProfile> {


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var controller=Provider.of<ProfileController>(context);
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
                              child:widget._imgPath == null ?


                              widget.img == null?
                              const CircleAvatar(
                                  radius: 70,
                                  backgroundImage:

                                  NetworkImage(
                                    'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png',
                                  )
                              ):
                              CircleAvatar(
                                  radius: 70,
                                  backgroundImage: NetworkImage(

                                    ServerConfig.domainName+'${widget.img}',
                                  )):

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
                              controller: controller.phone,
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
                              controller: controller.contact,
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
                              controller: controller.education,
                              hint: 'Education',
                              type: TextInputType.text,

                              label: '',
                              prefix: Icons.school),
                        ),
                        title: 'Education',
                      )),



                ]),
          ),
        ),
        floatingActionButton:
        FloatingActionButton(
            child: Icon(Icons.check_outlined),
            backgroundColor: Colors.purple,
            onPressed: () async {
              print(widget.id);
              EasyLoading.show(status: 'Loading....');
              if (controller.phone == null || controller.education == null || controller.contact == null )
                EasyLoading.showError(' All fields are required ');
              else {
                // اذا كان في صورة مختارة سابقا وما اختار شي من المعرض
                if(widget._imgPath == null && widget.img != null){
                  //طبعا
                  if('${GetStorage().read('Path_of_imgProfile')}' == 'null' ){
                    EasyLoading.showError(' the PathImage is not saved in getStorage you can chang Img ');
                  }
                  await controller.onClickMEditProfile('${GetStorage().read('Path_of_imgProfile')}',widget.id);
                }
                //في حال اختار صورة من المعرض او اذا ما اختار اصلا ولا صورة وكانت (null)
                else{
                  if(widget._imgPath !=null){
                    await GetStorage().write('Path_of_imgProfile',widget._imgPath);
                  }
                  await controller.onClickMEditProfile(widget._imgPath!,
                      widget.id);

                }
                // await con.onClickAddProfile();
                if (controller.editedPr != null) {
                  print('im');
                  print(controller.editedPr!.img_profile);
                  EasyLoading.showSuccess('information updated successfully');
                  Navigator.of(context).pop();
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