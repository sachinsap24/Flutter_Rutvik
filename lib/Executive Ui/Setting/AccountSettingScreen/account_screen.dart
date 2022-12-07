
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:matrimonial_app/Executive%20Ui/ReviewScreen/review_screen.dart';
import 'package:matrimonial_app/Ui/Home_screen/Notification/message_screen.dart';

import '../../../Utils/app_constants.dart';
import '../../../Utils/color_constants.dart';
import '../../../Utils/image_path_constants.dart';
import '../../../Utils/text_styles.dart';
import 'Community/community_screen.dart';
import 'ContactUs/contact_us.dart';

class Executive_Account_Setting extends StatefulWidget {
  const Executive_Account_Setting({Key? key}) : super(key: key);

  @override
  State<Executive_Account_Setting> createState() =>
      _Executive_Account_SettingState();
}

class _Executive_Account_SettingState extends State<Executive_Account_Setting> {
  bool blurImage = false;
  bool requestContact = false;
  bool onlineOffline = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Color(0xffE5E5E5).withOpacity(.5),
          body: Column(
            children: [
              SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Image.asset(
                        ImagePath.leftArrow,
                        height: 28,
                        width: 28,
                        color: Color(0xff2C3E50),
                      ),
                    ),
                    Text(
                      AppConstants.setting,
                      style: headingStyle.copyWith(
                          color: Color(0xff440312),
                          fontSize: 20,
                          fontWeight: FontWeight.w600),
                    ),
                    Container(width: 25)
                  ],
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: Column(
                      children: [
                        _viewContainer(
                          87,
                          GestureDetector(
                            onTap: () {
                            },
                            child: Container(
                              color: Colors.transparent,
                              child: Row(
                                children: [
                                  SizedBox(width: 10),
                                  Image.asset(ImagePath.settingProfile,
                                      height: 67, width: 67),
                                  SizedBox(width: 15),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 10),
                                      Text(
                                        AppConstants.elonMusk,
                                        style: headingStyle.copyWith(
                                            color: Color(0xff333F52),
                                            fontSize: 19,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Text(
                                        AppConstants.profileContact,
                                        style: headingStyle.copyWith(
                                            color: AppColors.grey,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Text(
                                        AppConstants.elonMuskUserName,
                                        style: headingStyle.copyWith(
                                            color: AppColors.grey,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 15),
                        _viewContainer(
                          83,
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(height: 5),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(width: 16),
                                  Image.asset(ImagePath.notification,
                                      height: 21, width: 21),
                                  SizedBox(width: 16),
                                  Text(
                                    AppConstants.notification,
                                    style: headingStyle.copyWith(
                                        color: Color(0xff333F52),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Spacer(),
                                  Image.asset(ImagePath.settingArrow,
                                      height: 20, width: 20),
                                  SizedBox(width: 16),
                                ],
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 6, right: 6),
                                child: Divider(),
                              ),
                              GestureDetector(
                                onTap: () {
                              
                                },
                                child: Container(
                                  color: Colors.transparent,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(width: 16),
                                      Image.asset(ImagePath.privacyPolicy,
                                          height: 21, width: 21),
                                      SizedBox(width: 16),
                                      Text(
                                        AppConstants.privacyPolicy,
                                        style: headingStyle.copyWith(
                                            color: Color(0xff333F52),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Spacer(),
                                      Image.asset(ImagePath.settingArrow,
                                          height: 20, width: 20),
                                      SizedBox(width: 16),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 5),
                            ],
                          ),
                        ),
                        SizedBox(height: 15),
                        _viewContainer(
                          167,
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(height: 5),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      CupertinoPageRoute(
                                          builder: (context) => Contact_Us()));
                                },
                                child: Container(
                                  color: Colors.transparent,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(width: 16),
                                      Image.asset(ImagePath.contactUs,
                                          height: 21, width: 21),
                                      SizedBox(width: 16),
                                      Text(
                                        AppConstants.contactUs,
                                        style: headingStyle.copyWith(
                                            color: Color(0xff333F52),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Spacer(),
                                      Image.asset(ImagePath.settingArrow,
                                          height: 20, width: 20),
                                      SizedBox(width: 16),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 6, right: 6),
                                child: Divider(),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      CupertinoPageRoute(
                                          builder: (context) =>
                                              Comunity_screen()));
                                },
                                child: Container(
                                  color: Colors.transparent,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(width: 16),
                                      Image.asset(ImagePath.community,
                                          height: 21, width: 21),
                                      SizedBox(width: 16),
                                      Text(
                                        AppConstants.community,
                                        style: headingStyle.copyWith(
                                            color: Color(0xff333F52),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Spacer(),
                                      Image.asset(ImagePath.settingArrow,
                                          height: 20, width: 20),
                                      SizedBox(width: 16),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 6, right: 6),
                                child: Divider(),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      CupertinoPageRoute(
                                          builder: (context) =>
                                              Review_screen()));
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(width: 16),
                                    Image.asset(ImagePath.legal,
                                        height: 21, width: 21),
                                    SizedBox(width: 16),
                                    Text(
                                      AppConstants.legal,
                                      style: headingStyle.copyWith(
                                          color: Color(0xff333F52),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Spacer(),
                                    Image.asset(ImagePath.settingArrow,
                                        height: 20, width: 20),
                                    SizedBox(width: 16),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 6, right: 6),
                                child: Divider(),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(width: 16),
                                  Image.asset(ImagePath.payment,
                                      height: 21, width: 21),
                                  SizedBox(width: 16),
                                  Text(
                                    AppConstants.payment,
                                    style: headingStyle.copyWith(
                                        color: Color(0xff333F52),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Spacer(),
                                  Image.asset(ImagePath.settingArrow,
                                      height: 20, width: 20),
                                  SizedBox(width: 16),
                                ],
                              ),
                              SizedBox(height: 5),
                            ],
                          ),
                        ),
                        SizedBox(height: 15),

                        GestureDetector(
                          onTap: () {
                            _disableDialogBox();
                          },
                          child: Container(
                            height: 41,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(13),
                                color: Color(0xffF4E2E2)),
                            child: Row(
                              children: [
                                SizedBox(width: 16),
                                Image.asset(ImagePath.disable,
                                    height: 21, width: 21),
                                SizedBox(width: 16),
                                Text(
                                  AppConstants.disable,
                                  style: headingStyle.copyWith(
                                      color: Color(0xffEA3B3B),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 15),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _viewContainer(double height, Widget child) {
    return Container(
      height: height,
      width: MediaQuery.of(context).size.width * 4,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(13),
      ),
      child: child,
    );
  }

  _disableDialogBox() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            insetPadding: EdgeInsets.symmetric(horizontal: 16),
            contentPadding: EdgeInsets.zero,
            backgroundColor: Colors.transparent,
            content: Container(
              height: 270,
              width: MediaQuery.of(context).size.width / 1.2,
              decoration: BoxDecoration(
                boxShadow: [BoxShadow(blurRadius: 10.0, color: Colors.black)],
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Image.asset(ImagePath.greyCross,
                            height: 28, width: 28),
                      ),
                      SizedBox(width: 8),
                    ],
                  ),
                  Image.asset(ImagePath.disableImage, height: 60, width: 60),
                  SizedBox(height: 20),
                  Text(
                    AppConstants.sureText,
                    style: headingStyle.copyWith(
                      color: Color(0xff333F52),
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: Text(
                      AppConstants.disablereason,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      style: headingStyle.copyWith(
                        color: Color(0xffAFAFAF),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => Message_screen()));
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        decoration: BoxDecoration(
                            gradient: AppColors.appColor,
                            borderRadius: BorderRadius.circular(9)),
                        alignment: Alignment.center,
                        child: Text(
                          AppConstants.disableText,
                          style: appBtnStyle,
                        ),
                      ),
                    ),
                   
                  ),
                  SizedBox(height: 12),
                ],
              ),
            ),
          );
        });
  }
}

class HeaderAppBar extends StatelessWidget {
  String name;
  HeaderAppBar({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color(0xffE5E5E5).withOpacity(.5),
      elevation: 0,
      leadingWidth: 40,
      leading: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0),
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
            fontSize: 20,
            fontWeight: FontWeight.w600),
      ),
    );
  }
}
