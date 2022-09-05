

import 'package:flutter/material.dart';
import 'package:tracker/models/task_model.dart';
import 'package:tracker/services/task_service.dart';
import 'package:tracker/services/user_service.dart';

import '../models/subtask_task_status_model.dart';
import '../services/search_service.dart';

class TaskController with ChangeNotifier{

  var model;
  List<String> list_Name_states=[];
  Map<String,int>map_nameStates_id={};

  var l_One_task;
  String? query;


  List<Task> list_of_tasks=[];
  List<Task> comp_tasks=[];
  List<Task> miss_tasks=[];
  List<Task> prog_tasks=[];
  List<Task> todo_tasks=[];

  toSearch(String ? value){
    query=value;
    notifyListeners();

  }






  //************************8888
  List<Task> listSearch=[];

  Future<List <Task>> searchTasksFromapi() async {
    Task task=Task(title: query.toString());
    if(query ==''){
      return listSearch;
    }

    else {
      listSearch = await SearchService.fetchMyTasks(task);
      return listSearch;
    }



  }


//************************888

  var nameStatus;
  TextEditingController titleController=TextEditingController();
  TextEditingController descriptionController=TextEditingController();
  int?  selectedIdTeam;
  int?   mychoosStatusId;
  DateTime selectedStartDate=DateTime.now();
  DateTime selectedEndDate=DateTime.now();
  int  id_task=0;
  var addedTask;
  var editedTask;





//--------------AddTask-------------------------------------
  Future  onClickAddTask()async{

    Task taskModel=Task(title:titleController.text ,
        description:descriptionController.text ,
        start_date:selectedStartDate.toString() ,
        end_date:selectedEndDate.toString() ,
        team_id:selectedIdTeam.toString() );

    addedTask=await TaskService.addTask(taskModel);
    list_of_tasks.add(addedTask);
    notifyListeners();



  }
//--------------EditTask-------------------------------------
  Future onClickEditTask()async{

    Task taskModel=Task(title:titleController.text ,description:descriptionController.text ,
        start_date:selectedStartDate.toString()
        ,end_date:selectedEndDate.toString() ,status_id: mychoosStatusId.toString()
        ,team_id:selectedIdTeam.toString() );


    editedTask=await TaskService.editTask(taskModel,id_task);
    for(var us in list_of_tasks){
      if(us.id == id_task){
        us=editedTask;
        notifyListeners();
        //notifyListeners();
        break;
      }
    }



  }
  var message;
//-------------------------------
  onClickDeleteTask() async {

    print(id_task);

    message=await await TaskService.deleteTask(id_task);
    for(var us in list_of_tasks){
      if(us.id == id_task){
        list_of_tasks.remove(us);
        notifyListeners();
        break;
      }
    }





  }


//--------------ShowAllTask-------------------------------------

  Future<List<Task>> onClickshowTasks()async{
    await fetchStates();
    list_of_tasks = await TaskService.servAllTasks();

    return list_of_tasks;
  }


  Future<List<StatusModel>> fetchStates() async
  {
    var h;
    h =await TaskService.subSt();
    //map[id]=name
    taskstates=await TaskService.suStatu;

    //list of name states tasks
    list_Name_states=await TaskService.stt;
    print('name  status tasks');
    print(list_Name_states);

    map_nameStates_id=await TaskService.idMap;
    print(' map_nameStates_id');
    print( map_nameStates_id);

    // return all obj status
    return h;
  }


  var taskstates;


//--------------ShowOneTask-------------------------------------
  var l;
  Future <Task> testy()async{
    await fetchStates();
    l=await TaskService.serTesty(id_task);
    return l;



  }


//----------------showCompletedTasks-----------
  Future<List<Task>> onClickshowCompletedTasks()async{
    comp_tasks=await TaskService. servCompletedTasks();
    return   comp_tasks;

  }

  //-----------------MissedTasks------------------
  Future<List<Task>> onClickshowMissedTasks()async{
    miss_tasks=await TaskService. servMissedTasks();
    return  miss_tasks;
  }

  //-----------------OnProgressTasks------------------
  Future<List<Task>> onClickshowOnProgressTasks()async{

    prog_tasks=await TaskService. servOnprogressTasks();
    return  prog_tasks;
  }

  //-------------------

  Future<List<Task>> onClickshowToDoTasks()async{
    todo_tasks=await TaskService.servToDoTasks();
    return  todo_tasks;
  }

  List<Task> led_todo_task=[];
  Future <List<Task>> lShowToDoTasks()async{
    led_todo_task=await TaskService.lToDoTasks();
    return led_todo_task;
  }

  List<Task> led_all_task=[];
  Future<List<Task>> lShowALLTasks()async{
    led_all_task=await TaskService.lAllTasks();
    return  led_all_task;
  }




}