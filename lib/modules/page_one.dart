import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../controllers/profile_controller.dart';

////for testinggggggggggggggggggggggggg
class PageOne extends StatefulWidget {
  ProfileController profileController=ProfileController();
  String? img_path;
  @override
  _PageOneState createState() => _PageOneState();
}

class _PageOneState extends State<PageOne> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text('Profile'),
        ),
        body: Column(
            children: [
              GestureDetector(
                onTap:
                    () async {
                  XFile? xfile = await ImagePicker().pickImage(source: ImageSource.gallery);
                  if(xfile != null)
                    setState(() {
                      widget.img_path = xfile.path;
                    });
                }


                ,
                child: Container(
                  height: size.height*0.3,
                  width: double.infinity,
                  margin: EdgeInsets.all(size.width*0.025),
                  padding: EdgeInsets.all(size.width*0.025),
                  decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(size.width*0.025),
                      image: widget.img_path != null ? DecorationImage(
                          image: FileImage(File(widget.img_path!)),
                          fit: BoxFit.contain
                      ) : null

                  ),
                  child: Icon(Icons.add_a_photo_outlined),
                  alignment: Alignment.center,
                ),
              ),


              ElevatedButton.icon(
                onPressed: () async {
                  print('path');
                  print(await widget.img_path);


                  await widget.profileController.onClickAddProfile(
                      widget.img_path!);

                  /*
                  if (widget.profileController.profileobj != null) {
                   // print(widget.profileController.profileobj!.img_profile);
                    EasyLoading.showSuccess('information Added successfully');
                  }
                  else{
                    EasyLoading.showError('error');
                  }
*/
                }   , icon: Icon(Icons.add),
                label: Text('add profile')
                , ),









            ]));
  }
}