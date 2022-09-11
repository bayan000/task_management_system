import 'dart:collection';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:tracker/models/subtask_model.dart';
import '../models/subtask_task_status_model.dart';
import '../models/user_model.dart';
import '../services/subtask_service.dart';
class AddSubtaskProvider extends ChangeNotifier{
  List<User> list_of_Users = [];
  ModelSubTask? modelSubTask;
  //priority id to name
  var priorities;
  //status id to name
  var substates;
  //status name to id
  var stateId;
  var stateeee;
  var state;
  var priority;
  //priority name to id
  var proiorityId;
  var proiorityyyy;
  var message;
  String? tit;
  String? des;
  TextEditingController title=TextEditingController();
  TextEditingController description=TextEditingController();
  String? start;
  String? end;
  List<int> l=[];
  //list of priority names
  static List<String> st=[];
  //list of status names
  static List<String> stt=[];
  changeDOS(var dodo)
  {
    start=dodo;
    notifyListeners();

  }
  changeS(var value){
    stateeee=value;

    notifyListeners();
  }
  changepro(var value){
    proiorityyyy=value;

    notifyListeners();
  }
  printDOS()
  {
    return start;
  }
  changeEO(var dodo)
  {
    end=dodo;
    notifyListeners();

  }
  printEO()
  {
    return end;
  }
  Future onAddS(var taskId)async{
    ModelSubTask modelSubTask=ModelSubTask(
      task_id: taskId,
      start_at: start,
      end_at: end,
      title: title.text,
      description: description.text,
      status_id: stateeee,
      priority_id: proiorityyyy,
      participants: l
    );
  message=  await SubTaskService.addSub(modelSubTask);

  }

  Future<List<StatusModel>> fetchPriorites() async
  {
    await SubTaskService.subPr();
    proiorityId=await SubTaskService.idMap;
    priorities=await SubTaskService.priority;
    st=await SubTaskService.st;
    return await SubTaskService.subPr();
  }
  Future<List<StatusModel>> fetchStates() async
  {
    await SubTaskService.subSt();
    stateId=await SubTaskService.idMapp;
    substates=await SubTaskService.suStatu;
    stt=await SubTaskService.stt;
    print(substates);
    return await SubTaskService.subSt();
  }
  savingSelectedItems(HashSet<User> selectedItem){

    if(selectedItem.length!=0)
    {
      selectedItem.forEach((element) {l.add(element.id);});
      notifyListeners();
    }
    notifyListeners();
  }
}