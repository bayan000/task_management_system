import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:tracker/controllers/login_controller.dart';
import 'package:tracker/models/team_model.dart';
import 'package:tracker/modules/add_user.dart';
import 'package:tracker/modules/selected_team.dart';

import '../controllers/user_controller.dart';
import '../shared/components.dart';
import '../shared/constants.dart';

class EditUser extends StatefulWidget {
  TeamModel? team;
  final _formKey=GlobalKey<FormState>();


  @override
  State<EditUser> createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {

  @override
  Widget build(BuildContext context) {
    var model= Provider.of<UserController>(context);
    return Scaffold(

      appBar: buildAppBar( text: 'Edit User',

          color: Colors.blue,      prefixIcon: Icons.arrow_back,

          onPressedPre: (){
            Navigator.pop(context);

          }
      ),



      body:    Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
          child: SingleChildScrollView(
            child: Form(
              key:widget._formKey,
              child: Column(children: [
                SizedBox(
                  height: 10,
                ),
                //---------fname-------------------------------------
                InputField(widget: CustomField(

                  height: MediaQuery.of(context).size.height * 0.07,
                  allBorder:true,hintText:'First_Name',
                  hintColor: Colors.grey[700],
                  isPassword: false,
                  controller: model.fnameController,colorField: Colors.grey[100],)


                    , title: 'First_Name'),

                InputField(widget: CustomField(


                  height: MediaQuery.of(context).size.height * 0.07,
                  allBorder:true,hintText:'Last_Name', isPassword: false,
                  controller: model.lnameController,
                  hintColor: Colors.grey[700],
                  colorField: Colors.grey[100],)
                    , title: 'Last_Name'),


                InputField(widget: CustomField(


                  keyboard:TextInputType.emailAddress,
                  height: MediaQuery.of(context).size.height * 0.07, allBorder:true,
                  hintText:'Email', isPassword: false,
                  hintColor: Colors.grey[700],
                  controller: model.emailController,colorField: Colors.grey[100],)
                    , title: 'Email'),

                InputField(
                    widget: CustomField(


                      keyboard:TextInputType.visiblePassword,
                      height: MediaQuery.of(context).size.height * 0.07,
                      allBorder:true,hintText:'Password', isPassword: true,
                      controller: model.passwordController,
                      hintColor: Colors.grey[700],
                      colorField: Colors.grey[100],)
                    , title: 'Password'),


                InputField(widget: CustomField(

                  keyboard:TextInputType.number,
                  height: MediaQuery.of(context).size.height * 0.07, allBorder:true,
                  hintText:'Employee_Identical', isPassword: false,
                  hintColor: Colors.grey[700],
                  controller: model.idController,colorField: Colors.grey[100],)
                    , title: 'Employee_Identical'),



                InputField(widget:
                CustomField(

                  iconWidget:

                  DropdownButtonHideUnderline(
                    child:   DropdownButton(
                      // dropdownColor: Colors.purple,
                      icon:Icon(Icons.arrow_drop_down,color:Colors.grey[600], size: 30,),
                      iconSize: 30,
                      elevation: 4,

                      items: model.list_Name_Roles.map((e)=> DropdownMenuItem(

                        child:Text('${e}'),value: e,)).toList(),

                      onChanged:(var value)=>
                          setState(() {
                            model.selectedIdRole=model.c_nameMapRole[value] as int;
                          }),

                    ),
                  ),



                  height: MediaQuery.of(context).size.height * 0.07,

                  allBorder:true,hintText:model.selectedIdRole == null ?
                'selected_Id_Role' :'${model.selectedIdRole}' , isPassword: false,

                  hintColor: Colors.grey[700],

                  colorField: Colors.grey[100],),


                    title: 'IdRoles'),


                //-------team_id-------

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
                        model.selectedIdTeam=widget.team!.id;

                      },
                      title: Text(widget.team == null ? 'No Team ':'${widget.team!.id}',style: TextStyle(
                          fontSize: 14.4,color:Colors.grey[700]),)
                      ,


                      trailing: Icon(Icons.arrow_drop_down,color:Colors.grey[600], size: 30,),


                    )
                )

                    , title: 'IdTeam'),



              ]


              ),
            ),
          )
      ),




      floatingActionButton: FloatingActionButton(backgroundColor:Colors.purple,onPressed: ()async{

        EasyLoading.show(status: 'loading...');
        await model.onClickEditUser();

        if(model.edit_User != null){
          EasyLoading.showSuccess('user edited successfully');
          Navigator.of(context).pop();


        }
        else {
          EasyLoading.showError('can not edit ');
        }





      },child: Icon(Icons.check_outlined),) ,

    );
  }
}

DropdownMenuItem<String> buildMenuItem(int item) => DropdownMenuItem(
    value: item.toString(),
    child: Text(item.toString())
);
