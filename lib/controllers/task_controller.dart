

import 'package:tracker/models/task_model.dart';
import 'package:tracker/services/task_service.dart';
import 'package:tracker/services/user_service.dart';

class TaskController{




  Future  onClickAddTask()async{

    TaskModel taskModel=TaskModel(


    );
    await TaskService.addTask(taskModel);


  }



}