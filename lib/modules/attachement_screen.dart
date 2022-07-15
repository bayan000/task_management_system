import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:tracker/shared/constants.dart';

class Attachement_Screen extends StatelessWidget {
  List<String> urls = [
    'https://www.youtube.com/results?search_query=url+launcher+flutter',
    'https://translate.google.com/?hl=ar&sl=en&tl=ar&text=launch&op=translate',
    'https://pub.dev/packages/url_launcher',
    'https://www.youtube.com/results?search_query=url+launcher+flutter',
    'https://translate.google.com/?hl=ar&sl=en&tl=ar&text=launch&op=translate',
    'https://pub.dev/packages/url_launcher',
    'https://www.youtube.com/results?search_query=url+launcher+flutter',
    'https://translate.google.com/?hl=ar&sl=en&tl=ar&text=launch&op=translate',
    'https://pub.dev/packages/url_launcher',
    'https://www.youtube.com/results?search_query=url+launcher+flutter',
    'https://translate.google.com/?hl=ar&sl=en&tl=ar&text=launch&op=translate',
    'https://pub.dev/packages/url_launcher',
    'https://www.youtube.com/results?search_query=url+launcher+flutter',
    'https://translate.google.com/?hl=ar&sl=en&tl=ar&text=launch&op=translate',
    'https://pub.dev/packages/url_launcher',
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Stack(children: [
          Container(
//height: size.height * 0.3,
            color: kblue,
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
                          icon: Icon(Icons.arrow_back_outlined,
                              size: 27, color: Colors.white),
                        ),
                        Text(
                          'Attachements Links',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.w500),
                        ),
                        //Spacer(),
                        IconButton(
                          icon: Icon(Icons.notifications_outlined,
                              size: 27, color: Colors.white),
                          onPressed: () {},
                        ),
                      ],
                    ),
                    SizedBox(
                      height: size.width * 0.09,
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30))),
                        child: ListView.builder(
                          itemCount: urls.length,
                          itemBuilder: (context, index) => GestureDetector(
                            onTap: () async {
                              if (await canLaunch(urls[index])) {
                                await launch(
                                  urls[index],
                                  forceSafariVC: false,
                                  forceWebView: false,
                                  enableJavaScript: false,
                                );
                              }
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.grey[100],
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10))),
                                margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
                                height: 90,
                                child: Row(
                                  children: [
                                    Container(
                                        decoration: BoxDecoration(
                                            color: Colors.black12,
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(10))),
                                        width: 100,
                                        child: Center(
                                          child: Icon(
                                            Icons.attachment,
                                            size: 26,
                                            color: Colors.white,
                                          ),
                                        )),
                                    Expanded(
                                        child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0,
                                                top: 20,
                                                right: 8,
                                                bottom: 10),
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Text(urls[index]),
                                                Spacer(),
                                                Text(
                                                  Uri.parse(urls[index]).host,
                                                  style: TextStyle(
                                                      color: Colors.grey[500]),
                                                )
                                              ],
                                            )))
                                  ],
                                )),
                          ),
                        ),
                      ),
                    ),
                  ])))
        ]));
  }
}