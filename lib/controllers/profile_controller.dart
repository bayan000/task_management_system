
import 'package:flutter/material.dart';

import '../models/profile_model.dart';
import '../models/user_model.dart';
import '../services/profile_service.dart';

class   ProfileController with ChangeNotifier{
  var  profileobj;
  var editedPr;


  TextEditingController email=TextEditingController();
  TextEditingController phone=TextEditingController();
  TextEditingController contact=TextEditingController();
  TextEditingController education=TextEditingController();
  TextEditingController experince=TextEditingController();






  Future onClickEditProfile(String img_path,var id)async{
    print('controller');
    print(img_path);
    User profileModel=User(
        img_profile:img_path,
        phone:phone.text,
        education:education.text,
        experience: experince.text,
        contact:contact.text
    );


    editedPr =await ProfileService.EditProfile(profileModel,id);
    print('resp');

    print(editedPr);
    print('img response');
    print(editedPr!.img_profile);

    return editedPr;


  }
// Edit for Memmber
  Future onClickMEditProfile(String img_path,var id)async{
    print('controller');
    print(img_path);
    User profileModel=User(
        img_profile:img_path,
        phone:phone.text,
        education:education.text,
        contact:contact.text
    );


    editedPr =await ProfileService.MEditProfile(profileModel,id);
    print('resp');

    print(editedPr);
    print('img response');
    print(editedPr!.img_profile);

    return editedPr;


  }

  Future onClickAddProfile(String? img_path)async{

    print(phone.text);
    print(education.text);
    print( experince.text);
    print(contact.text);
    print(img_path);

    User profileModel=User(
        img_profile:img_path,
        phone:phone.text,
        education:education.text,
        experience: experince.text,
        contact:contact.text
    );

    profileobj =await ProfileService.AddProfile(profileModel);
    print(profileobj);
    return profileobj;

  }
  //add for memb
  Future onClickMAddProfile(String? img_path)async{

    print(phone.text);
    print(education.text);
    print(contact.text);
    print(img_path);

    User profileModel=User(
        img_profile:img_path,
        phone:phone.text,
        education:education.text,

        contact:contact.text
    );

    profileobj =await ProfileService.MAddProfile(profileModel);
    print(profileobj);
    return profileobj;

  }


  User  modelProfile=User();
//***************************Fetch_Leader_Profile *******************************8
  Future<User> LfetchProfile()async{
    modelProfile=await ProfileService.serveLProfile();
    if(modelProfile.phone == null){
      print('m');
    }
    return  modelProfile;
  }

//**************************Add_Profile_For_Leader***********************







}