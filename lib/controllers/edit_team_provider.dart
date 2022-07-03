
import 'package:flutter/material.dart';

class EditTeamProvider with ChangeNotifier{
  String _teamName="Null";
  String get teamName => _teamName;
  void setTeamName(String tn){
    _teamName=tn;
    notifyListeners();
  }
}