
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tracker/modules/add_user.dart';
import '../controllers/calendar_controller.dart';
import '../shared/components.dart';
import '../shared/constants.dart';

class AddEventScr extends StatefulWidget {
  final _formKey=GlobalKey<FormState>();
  @override
  State<AddEventScr> createState() => _AddEventScrState();
}

class _AddEventScrState extends State<AddEventScr> {


  @override
  Widget build(BuildContext context) {

    /////...
    var calenderController=Provider.of<MyCalendarCont>(context);
    return Scaffold(


        appBar:


        AppBar(title: Text('add event ',style: trackerStyle,), leading: CloseButton(),
        )
        ,body:Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Form(
          key:widget._formKey,
          child:
          Column(

            children: [

              InputField(widget: CustomField(

                height: MediaQuery.of(context).size.height * 0.07,
                allBorder:true,hintText:'Descroption', isPassword: false,
                controller:calenderController.titleCotroller,
                validator: (title)=> title !=null && title.isEmpty ? 'Title Cannot be empty ':null ,
                hintColor: Colors.grey[700],
                colorField: Colors.grey[100],)
                  , title: 'Description'),

              InputField(widget: CustomField(
                iconWidget: IconButton(
                  icon:Icon(Icons.calendar_today_outlined,color:Colors.blue),
                  onPressed: (){

                    fetchDateFromUser(context,calenderController,true);

                  },
                ),
                height: MediaQuery.of(context).size.height * 0.07,
                allBorder:true,

                hintText: DateFormat.yMd().format(calenderController.selectedStartDate), isPassword: false,
                hintColor: Colors.grey[700],
                colorField: Colors.grey[100], )
                , title:'Start_Date' ,

              ),
            ],


          )



      ),
    ),





        floatingActionButton: FloatingActionButton(backgroundColor:Colors.purple,onPressed:saveForm


          ,child: Text('Save'),)





    );


  }

  Future saveForm() async{

    final isValid=widget._formKey.currentState!.validate();
// if found title
    if(isValid == true){

      final provider=Provider.of<MyCalendarCont>(context,listen:false);
      EasyLoading.show(status: 'Loading....');

      await provider.fetchAdedEvent();

      if (provider.addedEvent != null) {
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

    else{
      print('hhhhhhhhhhhhhhh');
    }

  }
  fetchDateFromUser(var context,MyCalendarCont calenderCont,bool isStartDate)async{
    DateTime? pickerDate= await showDatePicker(

      context: context,
      initialDate:DateTime.now() ,
      firstDate:DateTime.now(),
      lastDate:DateTime(2126)
      ,


      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.purple, // header background color
              onPrimary: Colors.white, // header text color
              onSurface: Colors.black, // body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: Colors.purple, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },



    );

    if(pickerDate !=null){
      if(isStartDate ==true) {
        setState(() {
          calenderCont.selectedStartDate = pickerDate;
          print(calenderCont.selectedStartDate);
        });
      }




    }
    else{}


  }
}