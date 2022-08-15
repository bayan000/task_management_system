

import 'package:flutter/material.dart';
import 'package:tracker/models/task_model.dart';
import 'package:tracker/services/task_service.dart';
import 'package:tracker/services/user_service.dart';

import '../models/subtask_task_status_model.dart';
import '../services/search_service.dart';

class TaskController with ChangeNotifier{

  var model;
  List<Task> list_of_tasks=[];
  String? valueTitle;

  toSearch(String value){

    valueTitle =value;
    // notifyListeners();
  }

  Future SearchTask(String  value)async{

    Task task=Task(
        title: value

    );
    print('iii');
    list_of_tasks=await SearchService.fetchTask(task);
    notifyListeners();
    print('ooooo');


  }




  var nameStatus;
  TextEditingController titleController=TextEditingController();
  TextEditingController descriptionController=TextEditingController();
  int selectedIdStatus=1;
  int selectedIdTeam=1;
  DateTime selectedStartDate=DateTime.now();
  DateTime selectedEndDate=DateTime.now();
  int  id_task=0;
  var addedTask;
  var editedTask;

//--------------AddTask-------------------------------------
  Future  onClickAddTask()async{

    Task taskModel=Task(title:titleController.text ,description:descriptionController.text ,
        start_date:selectedStartDate.toString() ,end_date:selectedEndDate.toString() ,status_id:selectedIdStatus.toString() ,team_id:selectedIdTeam.toString() );

    addedTask=await TaskService.addTask(taskModel);
    list_of_tasks.add(addedTask);
    notifyListeners();




  }
//--------------EditTask-------------------------------------
  Future onClickEditTask()async{

    Task taskModel=Task(title:titleController.text ,description:descriptionController.text ,
        start_date:selectedStartDate.toString()
        ,end_date:selectedEndDate.toString() ,status_id:selectedIdStatus.toString()
        ,team_id:selectedIdTeam.toString() );


    editedTask=await TaskService.editTask(taskModel,id_task);
    for(var us in list_of_tasks){
      if(us.id == id_task){
        us=editedTask;
        notifyListeners();
        break;
      }
    }
  }
  var message;
//-------------------------------
  onClickDeleteTask() async {

    print(id_task);

    message=await await TaskService.deleteTask(id_task);

    //int index,int id
    for (var us in list_of_tasks) {
      if (us.id == id_task) {
        list_of_tasks.remove(us);
        notifyListeners();
        break;
      }
    }



  }


//--------------ShowAllTask-------------------------------------

  Future<List<Task>> onClickshowTasks()async{

    if(valueTitle != null){
      Task task=Task(
          title: valueTitle

      );

      print(valueTitle);
      list_of_tasks=await  SearchService.fetchTask(task);
    }
    else {
      list_of_tasks = await TaskService.servAllTasks();
    }
    return list_of_tasks;
  }


  Future<List<StatusModel>> fetchStates() async
  {
    await TaskService.subSt();
    taskstates=await TaskService.suStatu;
    print(taskstates);
    print('kkk');
    return await TaskService.subSt();
  }


  var taskstates;


//--------------ShowOneTask-------------------------------------

  Future<Task>  onClickshowOneTask()async{
    await fetchStates();



    taskstates=await TaskService.suStatu;
    model=await TaskService.servOneTask(id_task);
    return model;

  }






//----------------showCompletedTasks-----------
  Future<List<Task>> onClickshowCompletedTasks()async{

    return  await TaskService. servCompletedTasks();
  }

  //-----------------MissedTasks------------------
  Future<List<Task>> onClickshowMissedTasks()async{

    return  await TaskService. servMissedTasks();
  }

  //-----------------OnProgressTasks------------------
  Future<List<Task>> onClickshowOnProgressTasks()async{

    return  await TaskService. servOnprogressTasks();
  }

  //-------------------

  Future<List<Task>> onClickshowToDoTasks()async{

    return  await TaskService.servToDoTasks();
  }



  Map<String,Future<List< Task >>> menu = {
    "All":TaskService. servAllTasks(),
    "Completed":TaskService.servCompletedTasks(),
    "Missed":TaskService. servMissedTasks(),
    "Progress":TaskService. servOnprogressTasks(),
    "ToDo":TaskService.servToDoTasks()

  };




}