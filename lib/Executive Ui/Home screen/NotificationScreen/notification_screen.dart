
// ignore_for_file: unused_local_variable, unused_element

import 'package:flutter/material.dart';
import 'package:matrimonial_app/Ui/Home_screen/Notification/chat_screen.dart';
import 'package:matrimonial_app/Utils/app_constants.dart';
import 'package:matrimonial_app/Utils/image_path_constants.dart';
import 'package:matrimonial_app/Utils/text_styles.dart';
import 'package:matrimonial_app/Utils/value_constant.dart';
import 'package:matrimonial_app/widget/commonappbar_search.dart';

class E_Notification_Screen extends StatefulWidget {
  const E_Notification_Screen({Key? key}) : super(key: key);

  @override
  State<E_Notification_Screen> createState() => _E_Notification_ScreenState();
}

class _E_Notification_ScreenState extends State<E_Notification_Screen> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<Map<String, dynamic>> notify = [
    {
      IMAGE: ImagePath.notify1,
      NAME: AppConstants.notifyname,
      SUBNAME: AppConstants.messageText1,
      SUBNAME1: AppConstants.view,
    },
    {
      IMAGE: ImagePath.notify2,
      NAME: AppConstants.stevesmith,
      SUBNAME: AppConstants.messageText1,
      SUBNAME1: AppConstants.view,
    },
    {
      IMAGE: ImagePath.notify3,
      NAME: AppConstants.stevesmith,
      SUBNAME: AppConstants.messageText1,
      SUBNAME1: AppConstants.view,
    },
  ];
  List<Map<String, dynamic>> notifymessage = [
    {
      IMAGE: ImagePath.notify1,
      NAME: AppConstants.notifyname,
      SUBNAME: AppConstants.messageWord,
    },
    {
      IMAGE: ImagePath.notify2,
      NAME: AppConstants.stevesmith,
      SUBNAME: AppConstants.messageWord
    },
    {
      IMAGE: ImagePath.notify3,
      NAME: AppConstants.stevesmith,
      SUBNAME: AppConstants.messageWord,
    },
    {
      IMAGE: ImagePath.notify3,
      NAME: AppConstants.stevesmith,
      SUBNAME: AppConstants.messageWord,
    },
    {
      IMAGE: ImagePath.notify3,
      NAME: AppConstants.stevesmith,
      SUBNAME: AppConstants.messageWord,
    },
    {
      IMAGE: ImagePath.notify3,
      NAME: AppConstants.stevesmith,
      SUBNAME: AppConstants.messageWord,
    },
    {
      IMAGE: ImagePath.notify3,
      NAME: AppConstants.stevesmith,
      SUBNAME: AppConstants.messageWord,
    },
    {
      IMAGE: ImagePath.notify3,
      NAME: AppConstants.stevesmith,
      SUBNAME: AppConstants.messageWord,
    },
    {
      IMAGE: ImagePath.notify3,
      NAME: AppConstants.stevesmith,
      SUBNAME: AppConstants.messageWord,
    },
    {
      IMAGE: ImagePath.notify3,
      NAME: AppConstants.stevesmith,
      SUBNAME: AppConstants.messageWord,
    },
  ];

  List<Map<String, dynamic>> week = [
    {
      IMAGE: ImagePath.notify1,
      NAME: AppConstants.notifyname,
      SUBNAME: AppConstants.message,
    },
    {
      IMAGE: ImagePath.notify2,
      NAME: AppConstants.stevesmith,
      SUBNAME: AppConstants.message
    },
    {
      IMAGE: ImagePath.notify3,
      NAME: AppConstants.stevesmith,
      SUBNAME: AppConstants.message,
    },
    {
      IMAGE: ImagePath.notify3,
      NAME: AppConstants.stevesmith,
      SUBNAME: AppConstants.message,
    },
  
  ];
  List<Map<String, dynamic>> lastmonth = [
    {
      IMAGE: ImagePath.notify1,
      NAME: AppConstants.notifyname,
      SUBNAME: AppConstants.message,
    },
    {
      IMAGE: ImagePath.notify2,
      NAME: AppConstants.stevesmith,
      SUBNAME: AppConstants.message
    },
    {
      IMAGE: ImagePath.notify3,
      NAME: AppConstants.stevesmith,
      SUBNAME: AppConstants.message,
    },
    {
      IMAGE: ImagePath.notify3,
      NAME: AppConstants.stevesmith,
      SUBNAME: AppConstants.message,
    },
    {
      IMAGE: ImagePath.notify3,
      NAME: AppConstants.stevesmith,
      SUBNAME: AppConstants.message,
    },
    {
      IMAGE: ImagePath.notify3,
      NAME: AppConstants.stevesmith,
      SUBNAME: AppConstants.message,
    },
    {
      IMAGE: ImagePath.notify3,
      NAME: AppConstants.stevesmith,
      SUBNAME: AppConstants.message,
    },
    {
      IMAGE: ImagePath.notify3,
      NAME: AppConstants.stevesmith,
      SUBNAME: AppConstants.message,
    },
    {
      IMAGE: ImagePath.notify3,
      NAME: AppConstants.stevesmith,
      SUBNAME: AppConstants.message,
    },
    {
      IMAGE: ImagePath.notify3,
      NAME: AppConstants.stevesmith,
      SUBNAME: AppConstants.message,
    },
  ];
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonAppbar1(name: AppConstants.notification),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 215,
                      child: ListView.separated(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: notify.length,
                        itemBuilder: (context, index) {
                          return Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: 53,
                                  width: 53,
                                  child: CircleAvatar(
                                    backgroundImage:
                                        AssetImage(notify[index][IMAGE]),
                                  ),
                                ),
                                SizedBox(
                                  width: 13,
                                ),
                                RichText(
                                  text: TextSpan(
                                      text: 'Your Friend ',
                                      style: friend.copyWith(
                                          fontWeight: FontWeight.w600),
                                      children: [
                                        TextSpan(
                                            text:
                                                'Mark Parker \nGoing Live  -2 min',
                                            style: mark)
                                      ]),
                                ),
                                SizedBox(
                                  width: 33,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _onItemTapped(index);
                                    });
                                  },
                                  child: Container(
                                    height: 31,
                                    width: 81,
                                    decoration: _selectedIndex == index
                                        ? BoxDecoration(
                                            color: Color(0xffFB5A57),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          )
                                        : BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            border: Border.all(
                                                color: Color(0xffCBCBCB),
                                                width: 1),
                                          ),
                                    child: Center(
                                        child: Text(
                                      _selectedIndex == index
                                          ? notify[index][SUBNAME1]
                                          : notify[index][SUBNAME],
                                      style: _selectedIndex == index
                                          ? mess1
                                          : mess,
                                    )),
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return Divider();
                        },
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          AppConstants.week,
                          style: month,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      child: ListView.separated(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        itemCount: week.length,
                        itemBuilder: (context, index) {
                          return Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: 53,
                                  width: 53,
                                  child: CircleAvatar(
                                    backgroundImage:
                                        AssetImage(week[index][IMAGE]),
                                  ),
                                ),
                                SizedBox(
                                  width: 13,
                                ),
                                RichText(
                                  text: TextSpan(
                                      text: 'Your Friend ',
                                      style: friend.copyWith(
                                          fontWeight: FontWeight.w600),
                                      children: [
                                        TextSpan(
                                            text:
                                                'Mark Parker \nGoing Live  -2 min',
                                            style: mark)
                                      ]),
                                ),
                                SizedBox(
                                  width: 33,
                                ),
                                _message()
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return Divider();
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Text(
                          AppConstants.month,
                          style: month,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      child: ListView.separated(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: lastmonth.length,
                        itemBuilder: (context, index) {
                          return Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: 53,
                                  width: 53,
                                  child: CircleAvatar(
                                    backgroundImage:
                                        AssetImage(lastmonth[index][IMAGE]),
                                  ),
                                ),
                                SizedBox(
                                  width: 13,
                                ),
                                RichText(
                                  text: TextSpan(
                                      text: 'Your Friend ',
                                      style: friend.copyWith(
                                          fontWeight: FontWeight.w600),
                                      children: [
                                        TextSpan(
                                            text:
                                                'Mark Parker \nGoing Live  -2 min',
                                            style: mark)
                                      ]),
                                ),
                                SizedBox(
                                  width: 33,
                                ),
                                _message()
                              ],
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
            ),
          ],
        ),
      ),
    );
  
  }

  _view() {
    return Container(
      height: 31,
      width: 81,
      decoration: BoxDecoration(
          color: Color(0xffFB5A57),
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Color(0xffCBCBCB), width: 1)),
      child: Center(
          child: Text(
        AppConstants.view,
        style: mess.copyWith(color: Colors.white),
      )),
    );
  }

  _message() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Chat_screen()));
      },
      child: Container(
        height: 31,
        width: 81,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Color(0xffCBCBCB), width: 1)),
        child: Center(
            child: Text(
          AppConstants.messageWord,
          style: mess,
        )),
      ),
    );
  }
}
