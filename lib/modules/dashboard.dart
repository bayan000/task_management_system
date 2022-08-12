import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:tracker/controllers/login_controller.dart';

import '../shared/constants.dart';

class Dashboard extends StatelessWidget {
  //UserController  userController=UserController();
  //MeetingController meetingController=MeetingController();
  // TaskController taskController=TaskController();
  List<String> nameArea = [
    'teams',
    'Users',
    'Report',
    'Tasks',
    'Calender',
    'Meetings'
  ];

  List imgArea=[
    'assets/images/metting.png',
    'assets/images/first.png',
    'assets/images/first.png',
    'assets/images/tasks.png',
    'assets/images/first.png',
    'assets/images/metting.png'




  ];
  List pushtoArea=[

    '/teams',
   // '/Users',
    '/Users',
    '/Report',
    '/Users',
    '/Tasks',
    //  '/Calender',
    '/meetings',
    //   '/Metting'
    //'/meetings'

  ];

  LoginController loginController = LoginController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return  Scaffold(
      backgroundColor:Colors.blue,
      appBar: buildAppBar(text: 'Dashboard',fontsize: 23, suffixIcon:Icons.notifications_outlined,
          prefixIcon: Icons.menu,onPressedPre: ()async{


            EasyLoading.show(status: 'Loading....');
            await loginController.onClickLogout();

            Navigator.pushReplacementNamed(
                context, '/login');
            EasyLoading.showSuccess(loginController.message);




          },
          onPressedSuf: (){
            Navigator.pushNamed(context,  '/PageOne');


          }


      ),

      body:   Padding(
        padding: EdgeInsets.only(
            top: size.width * 0.06,
            bottom: 0,
            left: size.width * 0.004,
            right: size.width * 0.004),
        child: StaggeredGridView.countBuilder(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          itemCount: nameArea.length,
          itemBuilder: (context, index) => InkWell(
              onTap: () {


                Navigator.pushNamed(context, pushtoArea[index]);
              },
              child:

              // cardArea(nameArea: nameArea,index:index),
              cardArea(index)),
          staggeredTileBuilder: (int index) =>
          (index + 1) % 3 == 0
              ? StaggeredTile.extent(2, size.width * 0.44)
              : StaggeredTile.extent(1, size.width * 0.43),
        ),
      ),





    );






  }

  Container cardArea(int index) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: (index + 1) % 3 == 0 ? Colors.white : Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                offset: Offset(-2, -2),
                blurRadius: 3,
              )
            ]),
        child:
        Column(

          children: [
            Text(
              nameArea[index],
              style: TextStyle(
                  color: (index + 1) % 3 == 0 ? Colors.black: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 20),
            ),

            Expanded(child:  Image.asset(imgArea[index]),)
          ],
        )


    );
  }
}