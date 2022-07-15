import 'package:flutter/material.dart';
import 'package:tracker/shared/components.dart';
import 'package:tracker/models/mod_tasks.dart';
import 'package:tracker/modules/card_task.dart';

import 'package:tracker/shared/constants.dart';


class Task extends StatelessWidget {
  TextEditingController searchController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body:
      Stack(
        children: [
          Container(
            height: size.height * 0.3,
            decoration: BoxDecoration(
              color: kblue,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(size.width*0.14),
                  bottomRight: Radius.circular(size.width*0.14)),
            ),
          ),
          SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(top: 9.0),
                child: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.arrow_back_outlined, size: 27, color: Colors.white),
                      ),
                      Text(
                        'Tasks',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                      //Spacer(),
                      IconButton(
                        icon: Icon(Icons.notifications_outlined,
                            size: 28, color: Colors.white),
                        onPressed: () {},
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.width*0.07,
                  ),

                  //ReTextField(enableBorder:false,hintText: 'Search',isPassword: false,borderRadius: 40,controller:searchController ,prefixIcon: Icon(Icons.search),)
                  Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      child:
                      CustomField(
                          height: size.height*0.068,
                          prefixIcon: Icon(Icons.search),
                          borderRadius: 40,
                          allBorder:false, hintText: 'Search', isPassword: false, controller: searchController)





                  )

                  ,SizedBox(
                    height: size.width*0.06,
                  ),
                  Expanded(
                      child: ListView.builder(
                        itemCount: dataTasks.dataT.length,
                        itemBuilder: (context, index) => Padding(
                          padding:  EdgeInsets.symmetric(vertical:  size.width*0.023,horizontal: size.width*0.028),
                          child: cardTask(index: index),
                        ),
                      ))
                ]),
              )),
        ],
      ),

    );
  }
}