import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:tracker/controllers/login_controller.dart';

class Dashboard extends StatelessWidget {
  List<String> nameArea = [
    'teams',
    'Users',
    'Report',
    'Tasks',
    'Calender',
    'Metting'
  ];
  LoginController loginController = LoginController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return  Scaffold(
        backgroundColor: Color(0xffFFD39A),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.fromLTRB(size.width * 0.02,
                size.width * 0.03, size.width * 0.02, size.width * 0.01),
            child: Column(
              children: [
                Container(
                    margin: EdgeInsets.only(top: 10),
                    child:
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(),
                        Text(
                          'Dashboard',
                          style: TextStyle(
                              fontSize: 30,
                              color: Color(0xff2F3A8F),
                              fontWeight: FontWeight.bold),
                        ),
                        CircleAvatar(
                            radius: 18,
                            backgroundColor: Colors.grey[200],
                            child: IconButton(
                              icon: Icon(
                                Icons.logout,
                                color: Colors.black,
                              ),
                              onPressed: (() async {
                                EasyLoading.show(status: 'Loading....');
                                await loginController.onClickLogout();

                                Navigator.pushReplacementNamed(
                                    context, '/login');
                                EasyLoading.showSuccess('successfully logged out');

                              }),
                            )),
                      ],
                    )),
                Expanded(
                  child: Padding(
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
                            Navigator.pushNamed(context, '/Tasks');
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
                )
              ],
            ),
          ),
        ));
  }

  Container cardArea(int index) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: (index + 1) % 3 == 0 ? Color(0xff2F3A8F) : Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(-2, -2),
              blurRadius: 8,
            )
          ]),
      child: Center(
        child: Text(
          nameArea[index],
          style: TextStyle(
              color: (index + 1) % 3 == 0 ? Colors.white : Color(0xff2F3A8F),
              fontWeight: FontWeight.bold,
              fontSize: 20),
        ),
      ),
    );
  }
}