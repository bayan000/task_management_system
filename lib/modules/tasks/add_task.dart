import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tracker/modules/user/add_user.dart';
import 'package:tracker/models/team_model.dart';
import 'package:tracker/modules/tasks/selected_team.dart';
import 'package:tracker/shared/constants.dart';
import '../../controllers/task_controller.dart';
import '../../models/subtask_task_status_model.dart';
import '../../shared/components.dart';

class AddTask extends StatefulWidget {
  TeamModel? team;
  final _formKey=GlobalKey<FormState>();
  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    var taskController=Provider.of<TaskController>(context);
    return Scaffold(

      appBar: buildAppBar( text: 'Add Task',

          color: Colors.blue,      prefixIcon: Icons.arrow_back,

          onPressedPre: (){
            Navigator.pop(context);

          }
      ),
      body:    Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
          child:

          SingleChildScrollView(
            child: Form(
              key:widget._formKey,
              child: Column(children: [

                //---------TitleTask-------------------------------------
                InputField(widget: CustomField(

                  height: MediaQuery.of(context).size.height * 0.07,
                  allBorder:true,hintText:'Title',
                  validator: (title)=> title !=null && title.isEmpty ? 'Title Cannot be empty ':null ,

                  hintColor: Colors.grey[700],
                  isPassword: false,
                  controller:taskController.titleController ,
                  colorField: Colors.grey[100],)


                    , title: 'Title'),


//------------------------------description-----------------------------
                InputField(widget: CustomField(

                  height: MediaQuery.of(context).size.height * 0.07,
                  allBorder:true,hintText:'Descroption', isPassword: false,
                  controller:taskController.descriptionController,
                  validator: (title)=> title !=null && title.isEmpty ? 'Description Cannot be empty ':null ,

                  hintColor: Colors.grey[700],
                  colorField: Colors.grey[100],)
                    , title: 'Description'),

//-------------------start_date------------------------
                InputField(widget: CustomField(
                  iconWidget: IconButton(
                    icon:Icon(Icons.calendar_today_outlined,
                      color: Colors.blue,
                    ),
                    onPressed: (){

                      fetchDateFromUser(context,taskController,true);

                    },
                  ),
                  height: MediaQuery.of(context).size.height * 0.07,
                  allBorder:true,


                  hintText: DateFormat.yMd().format(taskController.selectedStartDate), isPassword: false,
                  hintColor: Colors.grey[700],
                  colorField: Colors.grey[100],)
                  , title:'Start_Date' ,

                ),

//------------------------------endDate----------------------
                InputField(widget: CustomField(
                  iconWidget: IconButton(
                      icon:Icon(Icons.calendar_today_outlined),
                      color: Colors.blue,
                      onPressed: () {

                        fetchDateFromUser(context,taskController,false);

                      }
                  ),
                  height: MediaQuery.of(context).size.height * 0.07,
                  allBorder:true,
                  hintText: DateFormat.yMd().format(taskController.selectedEndDate),
                  isPassword: false,


                  hintColor: Colors.grey[700],
                  colorField: Colors.grey[100],)
                  , title:'End_Date' ,

                ),

//------------------teamid-----------------------------

                InputField(widget:

                Container(
                    height: MediaQuery.of(context).size.height * 0.07,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border:Border.all(color: Colors.black12, width: 1.5),

                      color:Colors.grey[100],

                    ),
                    child:ListTile(
                      onTap: ()async{

                        final TeamModel?   team = await Navigator.push(context, MaterialPageRoute(builder:(context)=>TeamSelected(),));

                        if(team == null ) return ;
                        setState(()

                        => this.widget.team=team

                        );
                        taskController.selectedIdTeam=widget.team!.id;

                      },
                      title: Text(widget.team == null ? 'No Team ':'${widget.team!.id}',style: TextStyle(
                          fontSize: 14.4,color:Colors.grey[700]),)
                      ,


                      trailing: Icon(Icons.arrow_drop_down,color:Colors.grey[600], size: 30,),


                    )
                )

                    , title: 'IdTeam'),

//------------------------------StatusID----------------------------------






              ]


              ),
            ),
          )
      ),




      floatingActionButton: FloatingActionButton(backgroundColor:Colors.purple,
        onPressed: ()async{

          final isValid=widget._formKey.currentState!.validate();
          if(isValid == true) {
            EasyLoading.show(status: 'loading...');
            await taskController.onClickAddTask();

            if (taskController.addedTask != null) {
              EasyLoading.showSuccess('new task is added');
              Navigator.of(context).pop();
            }
            else {
              EasyLoading.showError('can not add ');
            }
          }
        },child: Icon(Icons.check_outlined),) ,

    );
  }

  DropdownMenuItem<String> kkbuildMenuItem(StatusModel item) => DropdownMenuItem(
      value: item.name!,
      child: Text(item.name!)
  );



  fetchDateFromUser(var context,TaskController taskContr,bool isStartDate)async{
    DateTime? pickerDate= await showDatePicker(
        context: context,initialDate:DateTime.now() ,firstDate:DateTime.now(),
        lastDate:DateTime(2126)

    );

    if(pickerDate !=null){
      if(isStartDate ==true) {
        if(pickerDate.isAfter(taskContr.selectedEndDate)){
          taskContr.selectedEndDate=pickerDate;
        }


        setState(() {
          taskContr.selectedStartDate = pickerDate;

          print(taskContr.selectedStartDate);
        });
      }
      else if(isStartDate == false){
        if(pickerDate.isBefore(taskContr.selectedStartDate)){
          taskContr.selectedStartDate=pickerDate;
        }


        setState(() {
          taskContr.selectedEndDate = pickerDate;
          print(taskContr.selectedEndDate);
        });


      }


    }



  }

}