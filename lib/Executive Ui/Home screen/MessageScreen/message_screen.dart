// ignore_for_file: must_be_immutable, unused_import, unnecessary_import

import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:matrimonial_app/Executive%20Ui/Home%20screen/ChatScreen/chat_screen.dart';
import 'package:matrimonial_app/Ui/Home_screen/Notification/chat_screen.dart';
import 'package:matrimonial_app/Utils/app_constants.dart';
import 'package:matrimonial_app/Utils/color_constants.dart';
import 'package:matrimonial_app/Utils/image_path_constants.dart';
import 'package:matrimonial_app/Utils/text_styles.dart';
import 'package:matrimonial_app/Utils/value_constant.dart';
import 'package:matrimonial_app/src/StoryViewer/stories_for_flutter.dart';

class E_Message_screen extends StatefulWidget {
  String? fromValue;
  E_Message_screen({Key? key, this.fromValue}) : super(key: key);
  @override
  State<E_Message_screen> createState() => _E_Message_screenState();
}

class _E_Message_screenState extends State<E_Message_screen> {
  List<Map<String, dynamic>> online = [
    {
      IMAGE: ImagePath.messageonline,
      NAME: AppConstants.sara,
    },
    {
      IMAGE: ImagePath.storyonline1,
      NAME: AppConstants.sophia,
    },
    {
      IMAGE: ImagePath.storyonline2,
      NAME: AppConstants.faye,
    },
    {
      IMAGE: ImagePath.storyonline3,
      NAME: AppConstants.james,
    },
    {
      IMAGE: ImagePath.storyonline2,
      NAME: AppConstants.faye,
    },
    {
      IMAGE: ImagePath.storyonline3,
      NAME: AppConstants.james,
    },
  ];
  List<Map<String, dynamic>> onlinechat = [
    {
      IMAGE: ImagePath.chatimage1,
      NAME: AppConstants.joseph1,
      SUBNAME: AppConstants.thanks,
      TIME: AppConstants.time,
    },
    {
      IMAGE: ImagePath.chatimage2,
      NAME: AppConstants.sara,
      SUBNAME: AppConstants.thanks,
      TIME: AppConstants.time,
      COUNT: AppConstants.count,
    },
    {
      IMAGE: ImagePath.chatimage3,
      NAME: AppConstants.faye,
      SUBNAME: AppConstants.thanks,
      TIME: AppConstants.time
    },
    {
      IMAGE: ImagePath.chatimage4,
      NAME: AppConstants.faye,
      SUBNAME: AppConstants.thanks,
      TIME: AppConstants.time
    },
    {
      IMAGE: ImagePath.chatimage5,
      NAME: AppConstants.james,
      SUBNAME: AppConstants.thanks,
      TIME: AppConstants.time
    },
    {
      IMAGE: ImagePath.chatimage6,
      NAME: AppConstants.ellie,
      SUBNAME: AppConstants.thanks,
      TIME: AppConstants.time
    },
  ];
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          widget.fromValue == 'bottom'
              ? AppBarScreen(
                  name: AppConstants.messageText1,
                )
              : AppBarScreen1(name: AppConstants.messageText1),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(13),
                        color: AppColors.messagesearch,
                      ),
                      height: height * 0.069,
                      child: Row(
                        children: [
                          SizedBox(
                            width: width * 0.020,
                          ),
                          Image.asset(
                            ImagePath.search,
                            width: 15,
                            height: 15,
                          ),
                          SizedBox(
                            width: width * 0.010,
                          ),
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: AppConstants.happiness,
                                  hintStyle: happiness),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Stories(
                      circlePadding: 5,
                      displayProgress: true,
                      storyItemList: List.generate(
                        online.length,
                        (index) => StoryItem(
                            name: online[index][NAME],
                            thumbnail: index == 0
                                ? AssetImage(ImagePath.putstory)
                                : AssetImage(online[index][IMAGE]),
                            stories: [
                              Scaffold(
                                body: Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: AssetImage(
                                            'assets/images/story1.jpg')),
                                  ),
                                ),
                              ),
                              Scaffold(
                                body: Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                            "https://images.unsplash.com/photo-1522262590532-a991489a0253?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1854&q=80 ")),
                                  ),
                                ),
                              ),
                            ]),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: ListView.separated(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: onlinechat.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) => E_Chat_screen()));
                          },
                          child: Container(
                            color: Colors.white,
                            child: Row(
                              children: [
                                Container(
                                  height: 53,
                                  width: 53,
                                  child: CircleAvatar(
                                    backgroundImage:
                                        AssetImage(onlinechat[index][IMAGE]),
                                  ),
                                ),
                                SizedBox(
                                  width: 13,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: width * 0.7,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(onlinechat[index][NAME]),
                                          SizedBox(
                                            width: 90,
                                          ),
                                          Text(
                                            onlinechat[index][TIME],
                                            style: TextStyle(fontSize: 12),
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    Container(
                                      width: width * 0.7,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          index == 2
                                              ? Text(
                                                  onlinechat[index][SUBNAME],
                                                  style: TextStyle(
                                                      color: Color(0xfffb5a57)),
                                                )
                                              : Text(
                                                  onlinechat[index][SUBNAME]),
                                          SizedBox(),
                                          index == 2
                                              ? Container(
                                                  height: 20,
                                                  width: 20,
                                                  decoration: BoxDecoration(
                                                      color: Color(0xffFB5A57),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  child: Center(
                                                      child: Text(
                                                    "4",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  )))
                                              : Container()
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return Divider();
                      },
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class AppBarScreen extends StatelessWidget {
  String name;
  AppBarScreen({Key? key, required this.name}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leadingWidth: 40,
          leading: Container(
            height: 28,
            width: 28,
          ),
          /* GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Image.asset(
                ImagePath.leftArrow,
                height: 28,
                width: 28,
                color: Color(0xff2C3E50),
              ),
            ),
          ), */
          centerTitle: true,
          title: Text(
            name,
            style: headingStyle.copyWith(
                color: Color(0xff440312),
                fontSize: 21,
                fontWeight: FontWeight.w600),
          ),
        ));
  }
}

class AppBarScreen1 extends StatelessWidget {
  String name;
  AppBarScreen1({Key? key, required this.name}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leadingWidth: 40,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Image.asset(
                ImagePath.leftArrow,
                height: 28,
                width: 28,
                color: Color(0xff2C3E50),
              ),
            ),
          ),
          centerTitle: true,
          title: Text(
            name,
            style: headingStyle.copyWith(
                color: Color(0xff440312),
                fontSize: 21,
                fontWeight: FontWeight.w600),
          ),
        ));
  }
}
