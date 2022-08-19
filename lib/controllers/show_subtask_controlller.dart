import 'package:flutter/material.dart';

import '../models/subtask_model.dart';
import '../models/subtask_task_status_model.dart';
import '../services/subtask_service.dart';

class ShowSubtaskController extends ChangeNotifier{
  var priorities;
  var substates;
var subtaskModel;
  String? message;
 Future<ModelSubTask> fetchSubtask(var id) async
  {
    await fetchStates();
    await fetchPriorites();
    priorities=await SubTaskService.priority;
    substates=await SubTaskService.suStatu;
    subtaskModel=await SubTaskService.showSubtask(id);
    return subtaskModel;

  }
  Future deletion(int id) async{
    message= await SubTaskService.deleteSubtask(id);
    return message;
  }
  Future<List<StatusModel>> fetchStates() async
  {
    await SubTaskService.subSt();
    substates=await SubTaskService.suStatu;
    print(substates);
    print('kkk');
    return await SubTaskService.subSt();
  }
  Future<List<StatusModel>> fetchPriorites() async
  {
    await SubTaskService.subPr();
    priorities=await SubTaskService.priority;
    return await SubTaskService.subPr();
  }
  }
