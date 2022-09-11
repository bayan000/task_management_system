import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

import '../../controllers/attachment_controller.dart';
import '../../shared/components.dart';
import '../../shared/constants.dart';
import '../user/add_user.dart';

class AddAttachement extends StatelessWidget {
  final _formKey=GlobalKey<FormState>();
  var id;
  AddAttachement({Key? key,this.id}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    /////...
    var pro=Provider.of<AttachementController>(context);
    return Scaffold(


        appBar:


        AppBar(title: Text('add attachement ',style: trackerStyle,), leading: CloseButton(),

        )
        ,body:Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Form(
          key:_formKey,
          child:
          Column(

            children: [

              InputField(widget: CustomField(

                height: MediaQuery.of(context).size.height * 0.07,
                allBorder:true,hintText:'title', isPassword: false,
                controller:pro.titleContoller,
                validator: (title)=> title !=null && title.isEmpty ? 'Title Cannot be empty ':null ,
                hintColor: Colors.grey[700],
                colorField: Colors.grey[100],)
                  , title: 'title'),

              InputField(widget: CustomField(

                height: MediaQuery.of(context).size.height * 0.07,
                allBorder:true,hintText:'description', isPassword: false,
                keyboard:TextInputType.url,
                controller:pro.descriptionController,
                validator: (title)=> title !=null && title.isEmpty ? 'description Cannot be empty ':null ,
                hintColor: Colors.grey[700],
                colorField: Colors.grey[100],)
                  , title: 'description'),


            ],


          )



      ),
    ),





        floatingActionButton: FloatingActionButton(backgroundColor:Colors.purple,onPressed:() async {

          final isValid=_formKey.currentState!.validate();
          if(isValid == true){

            final provider=Provider.of<AttachementController>(context,listen:false);
            EasyLoading.show(status: 'Loading....');

            await provider.fetchAdedAttachement(id);

            if (provider.addedAttachement != null) {
              EasyLoading.showSuccess('added is done.');
              Navigator.of(context).pop();
            }
            else{
              EasyLoading.showError(
                'error page',
              );
              print('there are errors ');
            }

          }


        }


          ,child: Text('Save'),)





    );


  }


}