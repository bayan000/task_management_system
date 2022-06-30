import 'package:flutter/material.dart';


import '../../shared/constants.dart';

class Team extends StatelessWidget{
  const Team({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size =MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title:  Text('Team name',style: trackerStyle,),
          automaticallyImplyLeading: false,
         // centerTitle: true,

          backgroundColor: appCo,
          shadowColor: appCo,
          elevation: 0,

    ),
        backgroundColor: appFo,
        body: SafeArea(
        child:Padding(

          padding:  EdgeInsets.only(
        top:size.height*0.01,left:size.width*0.025,right: size.width*0.025  ),//.all(size.width*0.025),
          child:SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
           // physics: const NeverScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [ListView.separated(
                physics:  const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) => buildMemberItem(),
                separatorBuilder: (context, index) =>
                   const SizedBox(
                      height: 10,
                    ),
                itemCount: 15,
              ),],
            ),
          )


        ),
        )
    );

  }
  Widget buildMemberItem() =>
  Row(
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomEnd,
            children: const [
              CircleAvatar(
                radius: 30.0,
                backgroundImage: AssetImage('assets/images/kogoro.jpg')
              ),

            ],
          ),
          const SizedBox(
            width: 20.0,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'kogoro mouri',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(
                  height: 5.0,
                ),
                Row(
                  children:
                  const [
                    Expanded(
                      child: Text(
                        'member',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),


                  ],
                ),
              ],
            ),
          ),
        ],
      );
}