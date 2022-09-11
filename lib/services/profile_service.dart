
import 'dart:convert';
import 'dart:io';

import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:tracker/config/server_config.dart';
import 'dart:async';


import 'package:tracker/models/profile_model.dart';

import '../models/user_model.dart';

class  ProfileService{

static var image;

////for testinggggggggggggggggggggggggg
static Future<String> ShowProfile()async{
  var response=await http.get(Uri.parse(ServerConfig.domainName+'/api/leader/create'),headers: {
    'Authorization':'Bearer  ${GetStorage().read('token')}',
    'Accept':'application/json',
  });
  var body=jsonDecode(response.body);
  image=body["My Profile:"][0]["img_profile"];
  print(image);
  return image;


}
  //*********************Serve_Add_Profile*************
  static Future AddProfile(User profileModel) async {
    var request = http.MultipartRequest('POST',
        Uri.parse(ServerConfig.domainName + ServerConfig.showAdedProfile));

    print('ser');
    print(profileModel.phone!);
    print(profileModel.experience!);
    print(profileModel.education!);
    print(profileModel.contact!);
    print(profileModel.img_profile?.isNotEmpty);


    request.fields.addAll({
      'phone': profileModel.phone as String,
      'experience': profileModel.experience as String,
      'education': profileModel.education as String,
      'contact': profileModel.contact as String,
    });
    print('ll');
    request.headers.addAll({
      HttpHeaders.authorizationHeader: 'Bearer ${GetStorage().read('token')}',
      'Accept': 'application/json'
    });

    print('kk');
    if (profileModel.img_profile == null) {
      print('the img is null in serve');
      print('li');
      print(request.fields['img_profile']);
      //request.fields['img_profile']=profileModel.img_profile!;
    }
    else {
      print('the img is not null in serve');
      request.files.add(
          await http.MultipartFile.fromPath(
              'img_profile', profileModel.img_profile!));
    }
    print('gg');

    var response = await request.send();
    print('rr');
    print(response);
    var json = jsonDecode(await response.stream.bytesToString());


    print(response.statusCode);

    print(json['the info:']);
    print('message is');
    print(json['message']);


    if (json['the info:'] == null)
      return null;
    return User.fromJson(json['the info:']);
  }
  //************************Member_aded_profilr
  static Future MAddProfile(User profileModel) async {
    var request = http.MultipartRequest('POST',
        Uri.parse(ServerConfig.domainName + ServerConfig.showMAdedProfile));

    print('ser');
    print(profileModel.phone!);

    print(profileModel.education!);
    print(profileModel.contact!);
    print(profileModel.img_profile?.isNotEmpty);


    request.fields.addAll({
      'phone': profileModel.phone as String,

      'education': profileModel.education as String,
      'contact': profileModel.contact as String,
    });
    print('ll');
    request.headers.addAll({
      HttpHeaders.authorizationHeader: 'Bearer ${GetStorage().read('token')}',
      'Accept': 'application/json'
    });

    print('kk');
    if (profileModel.img_profile == null) {
      print('the img is null in serve');
      print('li');
      print(request.fields['img_profile']);
      //request.fields['img_profile']=profileModel.img_profile!;
    }
    else {
      print('the img is not null in serve');
      request.files.add(
          await http.MultipartFile.fromPath(
              'img_profile', profileModel.img_profile!));
    }
    print('gg');

    var response = await request.send();
    print('rr');
    print(response);
    var json = jsonDecode(await response.stream.bytesToString());


    print(response.statusCode);

    print(json['the info:']);
    print('message is');
    print(json['message']);


    if (json['the info:'] == null)
      return null;
    return User.fromJson(json['the info:']);
  }
//********************Serve_Edited_Profile*************
  static Future<User> EditProfile(User profileModel, int id) async {
    var request = http.MultipartRequest('POST', Uri.parse(
        ServerConfig.domainName + ServerConfig.showEditedProfile + '${id}'));

    print('ser');
    print(profileModel.phone!);
    print(profileModel.experience!);
    print(profileModel.education!);
    print(profileModel.contact!);
    print(profileModel.img_profile?.isNotEmpty);


    request.fields.addAll({
      'phone': profileModel.phone as String,
      'experience': profileModel.experience as String,
      'education': profileModel.education as String,
      'contact': profileModel.contact as String,
    });
    print('ll');
    request.headers.addAll({
      HttpHeaders.authorizationHeader: 'Bearer ${GetStorage().read('token')}',
      'Accept': 'application/json'
    });

    print('kk');
    if (profileModel.img_profile == null) {
      print('the img is null in serve');
      print('li');
      print(request.fields['img_profile']);
      //request.fields['img_profile']=profileModel.img_profile!;
    }
    else {
      print('the img is not null in serve');
      request.files.add(
          await http.MultipartFile.fromPath(
              'img_profile', profileModel.img_profile!));
    }
    print('gg');

    var response = await request.send();
    print('rr');
    print(response);
    var json = jsonDecode(await response.stream.bytesToString());


    print(response.statusCode);

    print(json['the info:']['']);
    print('message is');
    print(json['message']);



    return User.fromJson(json['the info:']);
  }

  //**************Serve_Edited_Profile_for Member************
  static Future<User> MEditProfile(User profileModel, int id) async {
    var request = http.MultipartRequest('POST', Uri.parse(
        ServerConfig.domainName + ServerConfig.showMEditedProfile + '${id}'));

    print('ser');
    print(profileModel.phone!);

    print(profileModel.education!);
    print(profileModel.contact!);
    print(profileModel.img_profile?.isNotEmpty);


    request.fields.addAll({
      'phone': profileModel.phone as String,

      'education': profileModel.education as String,
      'contact': profileModel.contact as String,
    });
    print('ll');
    request.headers.addAll({
      HttpHeaders.authorizationHeader: 'Bearer ${GetStorage().read('token')}',
      'Accept': 'application/json'
    });

    print('kk');
    if (profileModel.img_profile == null) {
      print('the img is null in serve');
      print('li');
      print(request.fields['img_profile']);
      //request.fields['img_profile']=profileModel.img_profile!;
    }
    else {
      print('the img is not null in serve');
      request.files.add(
          await http.MultipartFile.fromPath(
              'img_profile', profileModel.img_profile!));
    }
    print('gg');

    var response = await request.send();
    print('rr');
    print(response);
    var json = jsonDecode(await response.stream.bytesToString());


    print(response.statusCode);

    print(json['the info:']['']);
    print('message is');
    print(json['message']);



    return User.fromJson(json['the info:']);
  }

//*******************Serve_Leader_Profile***********************
  static Future<User> serveLProfile() async {
    User LProfile = User();
    var response = await http.get(
        Uri.parse(ServerConfig.domainName + ServerConfig.showLProfile),
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer ${GetStorage().read(
              'token')}',
          'Accept': 'application/json'
        }
    );

    Map<String, dynamic> json = jsonDecode(response.body);
    print(response.statusCode);
    if (json['My Profile:'].length != 0) {
      print(json['My Profile:'][0]);

      print(json['My Profile:'][0]['first_name']);
      print(json['My Profile:'][0]['last_name']);
      print(json['My Profile:'][0]['education']);
      print(json['My Profile:'][0]['experience']);
      print(json['My Profile:'][0]['contact']);
      print(json['My Profile:'][0]['phone']);
      print(json['My Profile:'][0]['email']);
      print(json['My Profile:'][0]['user_id']);

      LProfile = User(
          first_name: json['My Profile:'][0]['first_name'] as String,
          last_name: json['My Profile:'][0]['last_name'] as String,
          education: json['My Profile:'][0]['education'] as String?,
          experience: json['My Profile:'][0]['experience'] as String?,
          contact: json['My Profile:'][0]['contact'] as String?,
          phone: json['My Profile:'][0]['phone'] as String,
          email: json['My Profile:'][0]['email'] as String,
          img_profile: json['My Profile:'][0]['img_profile'] as String?,
          user_id: json['My Profile:'][0]['user_id'],
          id:json['My Profile:'][0]['id']
      );
    }
    return LProfile;
  }

  static Future serInfo(ProfileModel profileModel)async{
    var response=await http.post(Uri.parse('http://192.168.1.103:8000/api/leader/create'),
        body:{
          'phone':profileModel.phone,
          'experience':profileModel.experience,
          'experience':profileModel.experience,
          'contact':profileModel.contact,
          'img_profile':profileModel.img_profile,
        },
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer ${GetStorage().read('token')}',
          'Accept': 'application/json'
        }


    );

    Map<String,dynamic> json=jsonDecode(response.body);
    print(response.statusCode);
    print(json['the info:']);
    print('message is');
    print(json['message']);
    if(json['the info:'] == null)
      return null;
    return ProfileModel.fromJson(json['the info:']);



  }

}