
import 'dart:convert';
import 'dart:io';

import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:tracker/config/server_config.dart';
import 'dart:async';


import 'package:tracker/models/profile_model.dart';

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
  static Future AddProfile(ProfileModel profileModel)async{



    var request = http.MultipartRequest('POST', Uri.parse('http://192.168.43.139:8000/api/leader/create'));

    request.fields.addAll({
      'phone':profileModel.phone,
      'experience':profileModel.experience,
      'education':profileModel.education,
      'contact':profileModel.contact,
    });

    request.headers.addAll({
      HttpHeaders.authorizationHeader: 'Bearer ${GetStorage().read('token')}',
      'Accept': 'application/json'
    });


    request.files.add(await http.MultipartFile.fromPath('img_profile',profileModel.img_profile!));

    var response = await request.send();

    var json = jsonDecode(await response.stream.bytesToString());


    print(response.statusCode);

    print(json['the info:']["img_profile"]);
    print(json['the info:']["phone"]);
    print(json['the info:']["contact"]);
    print(json['the info:']["education"]);
    print('message is');
    print(json['message']);



    if(json['the info:'] == null)
      return null;

    return ProfileModel.fromJson(json['the info:']);











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