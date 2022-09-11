import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tracker/modules/tasks/add_task.dart';
import 'package:tracker/modules/user/add_user.dart';
import 'package:tracker/modules/tasks/selected_team.dart';

import '../../controllers/task_controller.dart';
import '../../controllers/task_controller.dart';
import '../../shared/components.dart';
import 'package:tracker/models/team_model.dart';

import '../../shared/constants.dart';
class EditTask extends StatefulWidget {
  final _formKey=GlobalKey<FormState>();







  TeamModel? team;

  @override
  State<EditTask> createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {

  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    var taskController=Provider.of<TaskController>(context);
    return Scaffold(

      appBar: buildAppBar( text: 'Edit Task',

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
                  validator: (title)=> title !=null && title.isEmpty ? ' Cannot be empty ':null ,

                  height: MediaQuery.of(context).size.height * 0.07,
                  allBorder:true,hintText:'Title',
                  hintColor: Colors.grey[700],
                  isPassword: false,
                  controller:taskController.titleController ,
                  colorField: Colors.grey[100],)


                    , title: 'Title'),


//------------------------------description-----------------------------
                InputField(widget: CustomField(
                  validator: (title)=> title !=null && title.isEmpty ? 'Title Cannot be empty ':null ,

                  height: MediaQuery.of(context).size.height * 0.07,
                  allBorder:true,hintText:'Descroption', isPassword: false,
                  controller:taskController.descriptionController,
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
                InputField(widget:
                CustomField(
                 // validator: (title)=> title !=null && title.isEmpty ? 'Title Cannot be empty ':null ,

                  iconWidget:

                  DropdownButtonHideUnderline(
                    child:   DropdownButton(
                      // dropdownColor: Colors.purple,
                      icon:Icon(Icons.arrow_drop_down,color:Colors.grey[600], size: 30,),
                      iconSize: 30,
                      elevation: 4,

                      items: taskController.list_Name_states.map((e)=> DropdownMenuItem(

                        child:Text('${e}'),value: e,)).toList(),

                      onChanged:(var value)=>
                          setState(() {
                            taskController.mychoosStatusId=taskController.map_nameStates_id[value] as int;
                          }),

                    ),
                  ),



                  height: MediaQuery.of(context).size.height * 0.07,

                  allBorder:true,hintText:taskController.mychoosStatusId == null ? 'selected_Id_Status' :'${taskController.mychoosStatusId}' , isPassword: false,

                  hintColor: Colors.grey[700],

                  colorField: Colors.grey[100],),


                    title: 'IdStatus'),

                SizedBox(height: 40,),
                CustomButton(height: 50, width: 180, buttonName: 'Save ',
                    buttonColor:Colors.blue,fontSize: 18, onTap: ()async{
                      final isValid=widget._formKey.currentState!.validate();
// if found title
                      if(isValid == true) {



                        EasyLoading.show(status: 'loading...');
                        await taskController.onClickEditTask();

                        if(taskController.editedTask != null){
                          EasyLoading.showSuccess('task edited successfully');
                          Navigator.of(context).pop();


                        }
                        else {
                          EasyLoading.showError('can not edit ');
                        }}



                    })

              ]


              ),
            ),
          )
      ),

    );


  }


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