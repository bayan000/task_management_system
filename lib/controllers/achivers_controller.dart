import 'package:flutter/material.dart';
import 'package:tracker/models/user_model.dart';
import 'package:tracker/services/acheivers_service.dart';
import 'package:provider/provider.dart';
class AcheiversController extends ChangeNotifier{
   List<User> goldies=[];
   List<User> silvers=[];
   List<User> bronzers=[];
  Future fetchAcheivers() async{
    print('lala');
    await AcheiversService.achivers();
    print('la');
    goldies= await AcheiversService.goldies;
    print('la');
    silvers=await AcheiversService.silvers;
    bronzers=await AcheiversService.bronzers;
    print('lalala');
  }
}