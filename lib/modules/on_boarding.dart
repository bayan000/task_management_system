

import 'package:flutter/material.dart';

import 'package:tracker/shared/constants.dart';
class OnBarding extends StatelessWidget {
  const OnBarding({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return  Scaffold(
      body: SafeArea(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: size.width*0.03, vertical:size.width*0.03),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Tasko',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
              ),
              SizedBox(height: size.height*0.02,),
              Image.asset('images/first.png'),
              SizedBox(height: size.height*0.02,),
              Text(
                'the Greate Idea ',
                style: TextStyle(fontSize: 25),
              ),
              Text(
                "Welcome to our application where ."
                    "you find comfort and safety."
                    "Welcome to our application where ."
                    "you find comfort and safety.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, color: Colors.grey),
              ),





            ],
          ),

        ),
      ),
      floatingActionButton: FloatingActionButton(backgroundColor:kblue,onPressed: (){
        Navigator.pushNamed(context, '/login');

      },child: Icon(Icons.arrow_forward_outlined),),
    );
  }
}