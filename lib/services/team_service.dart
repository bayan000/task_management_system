import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:tracker/models/team_model.dart';

import '../config/server_config.dart';
import 'package:http/http.dart' as http;
class TeamService{
  //add team function *********************************
  static Future   addTeam(TeamModel teamModel) async {

    var url=ServerConfig.domainName+ServerConfig.addTeam;
    // var token="eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiNWI3YmZlYTk5YTQzYjhjNDVlNjFlMTNlM2Q3MjBmYzFhMmY3NDQ1YTcxYmU4NDFjYTY2ZWQ5NzRmNTE1Nzk0OWFhZmUwNWE1OGZiZmY2NTciLCJpYXQiOjE2NTU5Nzk3MzMuMDM5NjAzLCJuYmYiOjE2NTU5Nzk3MzMuMDM5NjEsImV4cCI6MTY4NzUxNTczMi45ODQyNDcsInN1YiI6IjEiLCJzY29wZXMiOltdfQ.wVyZI0Nepr8dGcHBU8rQx04xCgtRHiSh3NLKs6dw_xw7pCpd2XrsqfGbdd6DIMJqXer225gp41uUoO0T3plqGL2UlOwUW1IYeAfFZWbAehFsqS69248T5I55a6KY3lktG5YkmGinKhFYwkYs8qfLfuizH4T4idy1NpSk49LILOKKJUvv7xc6tCcOfjNVgvqfE9Rupc7WhAuCa5W8yOqeKdqS94xTT1_wYeTdDbs_rdh5qEdX-ecQw3l8nbPTCGms_N22VEgp5QMSzDbRlm4asjtGP6slpqdAv8Arxv-J_9snkCqxcnAHaq-fpoGoOOLiCNc6kCv_C2NV9w4ZyxicQ-jw3sK81syn4RY0mio4gQIMLmAvpsKobvNfUJdYf05BJXG3UuykP9l9PS0v6IvgRyOrUI4EP8wq2hNCIM64O6xaF_5d5Ju91RD09SJ0OTMybmsrMzdT7mAMRR1d3KhKC-iok0IyLvv1g3Z2wKNY81Noky2i_7iXAtQhiT9zQO9AF47tQly6aYWpCIbK1sRrc0TVGRec6o6ESTu9ikJXYFto8BgTpQ52g5150vk6fVH2BMlFwpDcstdZ32QD_IAsacwWwF2jewhAxQGTDjGcpv0ADpKu0VGS5VJRmYxMG9XL-FNiNve1maay5WvKRgZvK4Ox4RMn-lIX2sd_GBqkupA";
    //used parse to generate URI obj out of my string url
    var response =await http.post(Uri.parse(url),body: {
      "name":teamModel.name
    },headers: {
      'Authorization':'Bearer  ${GetStorage().read('token')}',
      'Accept':'application/json',
    },);
    Map<String, dynamic> ateam = jsonDecode(response.body);
    print(response.statusCode);
    return TeamModel.fromJson(ateam['tha department:']);
    }

//edit team function *********************************
  static Future   editTeam(TeamModel teamModel) async {

    var url=ServerConfig.domainName+ServerConfig.editTeam+teamModel.id.toString();
    var response =await http.post(Uri.parse(url),body: {
      "name":teamModel.name
    },headers: {
      'Authorization':'Bearer  ${GetStorage().read('token')}',
      'Accept':'application/json',
    },);
    Map<String, dynamic> eteam = jsonDecode(response.body);
    print(response.statusCode);
    return TeamModel.fromJson(eteam['0']);
  }
  }
