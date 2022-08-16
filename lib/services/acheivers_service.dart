import 'dart:convert';
import 'dart:io';

import 'package:get_storage/get_storage.dart';

import '../config/server_config.dart';
import '../models/user_model.dart';
import 'package:http/http.dart' as http;
class AcheiversService{
  static List<User> goldies=[];
  static List<User> silvers=[];
  static List<User> bronzers=[];
static var emp="0";
  static List<int> idsB=[];
  static List<int> idsG=[];
  static List<int> idsS=[];

  static Future achivers()async {
    User user;
print('s');
    var url=ServerConfig.domainName+ServerConfig.acheivers;
    var response=await http.get(Uri.parse(url),headers: {
      'Authorization':'Bearer  ${GetStorage().read('token')}',
      'Accept':'application/json',
    });
    print('hi');
    print(response.statusCode.toString());

    var body=jsonDecode(response.body);

    if(response.statusCode==401)
    print(body['message']);

var u;
    for(var b in body["Bronze"])
      {
        if(b[0]['img_profile']!=null)
          {
            u=User(first_name: b[0]['first_name'] as String,
                last_name: b[0]['last_name']as String,
                img_profile:b[0]['img_profile'].toString(),
                id: b[0]['user_id'] as int
            );
          }
        else
        {
          u=User(first_name: b[0]['first_name'] as String,
              last_name: b[0]['last_name']as String,
             // img_profile:b[0]['img_profile'].toString(),
              id: b[0]['user_id'] as int
          );
        }

        if (!idsB.contains(b[0]['user_id'] as int))
        {
          idsB.add(b[0]['user_id'] as int);
          bronzers.add(u);
        }

      }
    for(var b in body["Silver"])
    {

      if(b[0]['img_profile']!=null)
      {
        u=User(first_name: b[0]['first_name'] as String,
            last_name: b[0]['last_name']as String,
            img_profile:b[0]['img_profile'].toString(),
            id: b[0]['user_id'] as int
        );
      }
      else
      {
        u=User(first_name: b[0]['first_name'] as String,
            last_name: b[0]['last_name']as String,
            // img_profile:b[0]['img_profile'].toString(),
            id: b[0]['user_id'] as int
        );
      }
      if (!idsS.contains(b[0]['user_id'] as int))
      {
        idsS.add(b[0]['user_id'] as int);
        silvers.add(u);
      }

    }
    for(var b in body["Golden"])
    {
      if(b[0]['img_profile']!=null)
      {
        u=User(first_name: b[0]['first_name'] as String,
            last_name: b[0]['last_name']as String,
            img_profile:b[0]['img_profile'].toString(),
            id: b[0]['user_id'] as int
        );
      }
      else
      {
        u=User(first_name: b[0]['first_name'] as String,
            last_name: b[0]['last_name']as String,
            // img_profile:b[0]['img_profile'].toString(),
            id: b[0]['user_id'] as int
        );
      }
      if (!idsG.contains(b[0]['user_id'] as int))
      {
        idsG.add(b[0]['user_id'] as int);
        goldies.add(u);
      }

    }

  }

}