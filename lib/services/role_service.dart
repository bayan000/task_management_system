
import 'dart:convert';
import 'dart:io';

import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:tracker/config/server_config.dart';
import 'package:tracker/models/role_model.dart';
class RoleService{


  // map[id]=name
  static Map<dynamic,String>idMapRole={};
  //map[name]=id
  static Map<String,int> nameMapRole={};
  static List<String> name_Roles=[];


  static Future ShowAllRole()async{
    List<RoleModel> roles=[];
    var response = await http.get(
      Uri.parse(ServerConfig.domainName +'api/show4'),



    );


    List<dynamic> r = jsonDecode(response.body);

    print(response.statusCode);

    print(r[0]["id"]);


    for (var i=0; i<r.length ;i++)//var t in jsonData
        {
      roles.add( RoleModel.fromJson(r[i]));


      idMapRole[roles[i].id]=roles[i].position!;

      print(' idMapRole[roles[0].id]  :');
      print( idMapRole[roles[0].id]);

      nameMapRole[roles[i].position!]=roles[i].id;
      print('  nameMapRole[roles[i].position!] :');

      print( nameMapRole[roles[i].position!]);
      print('here.......');



      if((!roles.contains(roles[i].position ) )&&  roles[i].position !='admin' ){

        name_Roles.add(roles[i].position!);
      }

      print(name_Roles);





    }
    return roles;
  }





//------------------------------OneStatus----------------

  static Future ShowOneRole()async{

    var response = await http.get(
        Uri.parse(ServerConfig.domainName + ServerConfig.showOneRole)
        ,
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer ${GetStorage().read(
              'token')}',
          'Accept': 'application/json'
        });


    Map<String, dynamic> json = jsonDecode(response.body);

    return
      RoleModel.fromJson(json);

  }







}