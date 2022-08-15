import 'dart:convert';

import 'package:get_storage/get_storage.dart';

import '../config/server_config.dart';
import '../models/user_model.dart';
import 'package:http/http.dart' as http;
class AcheiversService{
  static List<User> goldies=[];
  static List<User> silvers=[];
  static List<User> bronzers=[];
static var emp="0";
  static Future achivers() async {
    User user;
    var url=ServerConfig.domainName+'api/achiever/show/';
    var response=await http.get(Uri.parse(url),headers: {
      'Authorization':'Bearer  ${GetStorage().read('token')}',
      'Accept':'application/json',
    });
//print(GetStorage().read('token'));
    var body=jsonDecode(response.body);
    print(response.statusCode.toString());
    if(response.statusCode==401)
    print(body['message']);
    print(body["Bronze"][0][0]["id"] );
    print(["Bronze"][0][1].length.toString());
    print('hi');
if(body["Bronze"][0][0].length.toString()!=emp)
  print(["Bronze"][0][0].length.toString());
int z;
var u;
    for(var b in body["Bronze"])
      {
        u=b.length.toString();
        z=int.parse(u);
        for(int i=0;i<z;i++)
          {

            print(body["Bronze"][i]["img_profile"]);
            if( body["Bronze"][i]["img_profile"]!=null)
              {
                user=User(first_name: body["Bronze"][i]["first_name"] as String,
                  last_name: body["Bronze"][i]["last_name"] as String,
                  img_profile: body["Bronze"][i]["img_profile"] as String ,
                ) ;
                bronzers.add(user);
                print(bronzers.length);
                print(bronzers[0].img_profile);
                print('hii');
              }

            else if( body["Bronze"][i]["img_profile"]==null)
            {

              user=User(first_name: body["Bronze"][i]["first_name"].toString(),
                last_name: body["Bronze"][i]["last_name"].toString(),
              )as User ;
              print(user.first_name);
              bronzers.add(user);

              //print(bronzers[0].first_name);
            }
            print(body["Bronze"][i]["first_name"]);
            print('fun');
            print(bronzers[1].first_name);
          }

      }

   // print(silvers);

  }

}