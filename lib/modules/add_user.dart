import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:tracker/modules/selected_team.dart';
import 'package:tracker/shared/components.dart';
import 'package:tracker/controllers/user_controller.dart';
import 'package:tracker/shared/constants.dart';
import 'package:tracker/models/team_model.dart';

class AddUser extends StatefulWidget {
  final _formKey=GlobalKey<FormState>();
  TeamModel? team;


  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {


  @override
  Widget build(BuildContext context) {
    var userController=Provider.of<UserController>(context);

    return

      Scaffold(

        appBar: buildAppBar( text: 'Add User',

            color: Colors.blue,      prefixIcon: Icons.arrow_back,

            onPressedPre: (){
              Navigator.pop(context);

            }
        ),


        body:
        Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: SingleChildScrollView(
              child: Form(
                key:widget._formKey,
                child: Column(children: [

                  //---------fname-------------------------------------
                  InputField(widget: CustomField(


                    height: MediaQuery.of(context).size.height * 0.07,
                    allBorder:true,hintText:'First_Name',
                    hintColor: Colors.grey[700],
                    isPassword: false,
                    controller: userController.fnameController,colorField: Colors.grey[100],)


                      , title: 'First_Name'),

                  InputField(widget: CustomField(


                    height: MediaQuery.of(context).size.height * 0.07,
                    allBorder:true,hintText:'Last_Name', isPassword: false,
                    controller: userController.lnameController,
                    hintColor: Colors.grey[700],
                    colorField: Colors.grey[100],)
                      , title: 'Last_Name'),


                  InputField(widget: CustomField(


                    keyboard:TextInputType.emailAddress,
                    height: MediaQuery.of(context).size.height * 0.07, allBorder:true,
                    hintText:'Email', isPassword: false,
                    hintColor: Colors.grey[700],
                    controller:userController.emailController,colorField: Colors.grey[100],)
                      , title: 'Email'),

                  InputField(widget: CustomField(


                    keyboard:TextInputType.visiblePassword,
                    height: MediaQuery.of(context).size.height * 0.07,
                    allBorder:true,hintText:'Password', isPassword: true,
                    controller: userController.passwordController,
                    hintColor: Colors.grey[700],
                    colorField: Colors.grey[100],)
                      , title: 'Password'),


                  InputField(widget: CustomField(

                    keyboard:TextInputType.number,
                    height: MediaQuery.of(context).size.height * 0.07, allBorder:true,
                    hintText:'Employee_Identical', isPassword: false,
                    hintColor: Colors.grey[700],
                    controller: userController.idController,colorField: Colors.grey[100],)
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

                        items: userController.list_Name_Roles.map((e)=> DropdownMenuItem(

                          child:Text('${e}'),value: e,)).toList(),

                        onChanged:(var value)=>
                            setState(() {
                              userController.selectedIdRole=userController.c_nameMapRole[value] as int;
                            }),

                      ),
                    ),



                    height: MediaQuery.of(context).size.height * 0.07,

                    allBorder:true,hintText:userController.selectedIdRole == null ? 'selected_Id_Role' :'${userController.selectedIdRole}' , isPassword: false,

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
                          userController.selectedIdTeam=widget.team!.id;

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




        floatingActionButton: FloatingActionButton(backgroundColor:Colors.purple,
          onPressed: ()async{
            EasyLoading.show(status: 'loading...');
            await userController.onClickAddUser();

            if (userController.addedUser != null) {
              EasyLoading.showSuccess('new user is added');
              Navigator.of(context).pop();
            }
            else {
              EasyLoading.showError('can not add ');
            }

          },child: Icon(Icons.check_outlined),) ,

      );
  }
}

class InputField extends StatelessWidget {
  InputField({
    required this.widget,
    required this.title,
  });

  Widget widget;
  String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16,),
          ),
          SizedBox(height:5),
          widget
        ],
      ),
    );
  }
}



DropdownMenuItem<String> buildMenuItem(int item) => DropdownMenuItem(
    value: item.toString(),
    child: Text(item.toString())
);