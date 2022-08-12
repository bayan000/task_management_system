import 'dart:collection';

import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:tracker/models/meetingModel.dart';
import 'package:tracker/models/subtask_model.dart';
import 'package:tracker/services/meeting_service.dart';

import '../models/user_model.dart';
import '../services/user_service.dart';
class AddSubtaskProvider extends ChangeNotifier{
  List<User> list_of_Users = [];
  ModelSubTask? modelSubTask;
  var statesMap;
  var stateId;
  var stateeee;
  var message;
}