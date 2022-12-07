import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:blur/blur.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:matrimonial_app/Core/Constant/CommonUtils.dart';
import 'package:matrimonial_app/Core/Constant/url_constant.dart';
import 'package:matrimonial_app/Core/Constant/value_constants.dart';
import 'package:matrimonial_app/ModelClass/UserPanel_ModelClass/UpdateLanguageModel.dart';
import 'package:matrimonial_app/ModelClass/UserPanel_ModelClass/user_profile_about_model.dart';
import 'package:matrimonial_app/Ui/AboutScreen/about_screen.dart';
import 'package:matrimonial_app/Ui/Drawer/AccountSettingScreen/ContactUs/contact_us.dart';
import 'package:matrimonial_app/Ui/Drawer/ProfileScreen/profile_screenn.dart';
import 'package:matrimonial_app/Ui/Home_screen/Notification/notification.dart';
import 'package:matrimonial_app/Ui/Login/login_screen.dart';
import 'package:matrimonial_app/Utils/app_constants.dart';
import 'package:matrimonial_app/Utils/color_constants.dart';
import 'package:matrimonial_app/Utils/image_path_constants.dart';
import 'package:matrimonial_app/Utils/text_styles.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import 'package:get/get.dart';

class Account_Setting extends StatefulWidget {
  String? gender;
  Account_Setting({Key? key, this.gender}) : super(key: key);

  @override
  State<Account_Setting> createState() => _Account_SettingState();
}

bool blurImage = false;
UserAboutMeModel? _userAboutMeModel;
List<Color> currentGradient = [Color(0xffFC7358), Color(0xffFA2457)];
Color currentColor = Color.fromARGB(255, 250, 65, 65);
int isSelected = 0;

class _Account_SettingState extends State<Account_Setting> {
  Dio dio = Dio();
  bool requestContact = true;
  bool onlineOffline = true;
  late final Function onChnage;
  int selectedlanguag = 0;
  updateLanguageModel? _languageModel;
  bool isEnglishSelected = true;
  List<List<Color>> _col = [
    [
      Color(0xffFC7358),
      Color(0xffFA2457),
    ],
    [
      Color(0xff6398FC),
      Color(0xff6398FC),
    ],
    [
      const Color(0xffEE7502),
      const Color(0xffEE7502),
    ],
  ];

  void setColor(int index) {
    setState(() {
      isSelected = index;
      currentGradient = _col[index];
      currentColor = _col[index][1];
    });
  }

  final List locale = [
    {'name': 'ENGLISH', 'locale': Locale('en', 'US')},
    {'name': 'हिंदी', 'locale': Locale('hi', 'IN')},
  ];

  updateLanguage(Locale locale) {
    Get.back();
    Get.updateLocale(locale);
  }

  buildLanguageDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (builder) {
          return AlertDialog(
            title: Column(
              children: [
                Text('Choose Your Language'),
                Container(
                  height: 1,
                  color: Colors.black,
                  width: MediaQuery.of(context).size.width * 1,
                )
              ],
            ),
            content: Container(
              child: ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      child: Text(locale[index]['name']),
                      onTap: () {
                        print(locale[index]['name']);

                        updateLanguageApi(index);
                      },
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Divider(
                      color: Colors.grey,
                    );
                  },
                  itemCount: locale.length),
            ),
          );
        });
  }

  @override
  void initState() {
    super.initState();
    checkConnection();
  }

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
                    Material(
                      type: MaterialType.transparency,
                      child: InkWell(
                        splashColor: Colors.grey.withOpacity(0.5),
                        splashFactory: InkRipple.splashFactory,
                        onTap: () {
                          Navigator.pop(context, "blurImg");
                        },
                        child: Image.asset(
                          ImagePath.leftArrow,
                          height: 28,
                          width: 28,
                          color: Color(0xff2C3E50),
                        ),
                      ),
                    ),
                    Text(
                      "setting".tr,
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
                              Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                      builder: (context) => Profile(
                                            fromValue: "Drawer",
                                          )));
                            },
                            child: Container(
                              color: Colors.transparent,
                              child: Row(
                                children: [
                                  SizedBox(width: 10),
                                  onlineOffline == true
                                      ? Stack(
                                          children: [
                                            Container(
                                              height: 67,
                                              width: 67,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                  border: Border.all(
                                                      width: 2,
                                                      color: currentColor)),
                                              child: (_userAboutMeModel !=
                                                          null &&
                                                      _userAboutMeModel!.data !=
                                                          null &&
                                                      _userAboutMeModel!
                                                              .data!
                                                              .profileImage!
                                                              .length >
                                                          0)
                                                  ? blurImage == true
                                                      ? Blur(
                                                          blur: 1,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(50),
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        50),
                                                            child:
                                                                Image.network(
                                                              _userAboutMeModel!
                                                                  .data!
                                                                  .profileImage![
                                                                      0]
                                                                  .filePath
                                                                  .toString(),
                                                              height: 67,
                                                              width: 67,
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ))
                                                      : ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(50),
                                                          child: Image.network(
                                                            _userAboutMeModel!
                                                                .data!
                                                                .profileImage![
                                                                    0]
                                                                .filePath
                                                                .toString(),
                                                            height: 67,
                                                            width: 67,
                                                            fit: BoxFit.cover,
                                                          ),
                                                        )
                                                  : (widget.gender == "Male")
                                                      ? Image.asset(
                                                          ImagePath.profile,
                                                          height: 67,
                                                          width: 67,
                                                        )
                                                      : Image.asset(
                                                          ImagePath
                                                              .femaleProfileUser,
                                                          height: 67,
                                                          width: 67,
                                                        ),
                                            ),
                                            Positioned(
                                              top: 50,
                                              left: 50,
                                              child: Container(
                                                height: 16,
                                                width: 16,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.white,
                                                ),
                                                alignment: Alignment.center,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Color(0xff31F173),
                                                  ),
                                                  height: 12,
                                                  width: 12,
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      : Stack(
                                          children: [
                                            (_userAboutMeModel != null &&
                                                    _userAboutMeModel!.data !=
                                                        null &&
                                                    _userAboutMeModel!
                                                            .data!
                                                            .profileImage!
                                                            .length >
                                                        0)
                                                ? blurImage == true
                                                    ? Blur(
                                                        blur: 1,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50),
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(50),
                                                          child: Image.network(
                                                            _userAboutMeModel!
                                                                .data!
                                                                .profileImage![
                                                                    0]
                                                                .filePath
                                                                .toString(),
                                                            height: 67,
                                                            width: 67,
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ))
                                                    : ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50),
                                                        child: Image.network(
                                                          _userAboutMeModel!
                                                              .data!
                                                              .profileImage![0]
                                                              .filePath
                                                              .toString(),
                                                          height: 67,
                                                          width: 67,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      )
                                                : Image.asset(
                                                    ImagePath.settingProfile,
                                                    height: 67,
                                                    width: 67,
                                                  ),
                                            Positioned(
                                              top: 50,
                                              left: 50,
                                              child: Container(
                                                height: 16,
                                                width: 16,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.white,
                                                ),
                                                alignment: Alignment.center,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Color(0xffD2D2D2),
                                                  ),
                                                  height: 12,
                                                  width: 12,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                  SizedBox(width: 15),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: 20),
                                        Text(
                                          (_userAboutMeModel != null &&
                                                  _userAboutMeModel!.data !=
                                                      null)
                                              ? _userAboutMeModel!
                                                  .data!.fullName
                                                  .toString()
                                              : AppConstants.elonMusk,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: headingStyle.copyWith(
                                              color: Color(0xff333F52),
                                              fontSize: 19,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          (_userAboutMeModel != null &&
                                                  _userAboutMeModel!.data !=
                                                      null)
                                              ? _userAboutMeModel!.data!.mobile
                                                  .toString()
                                              : AppConstants.profileContact,
                                          style: headingStyle.copyWith(
                                              color: AppColors.grey,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                      ],
                                    ),
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
                              Material(
                                type: MaterialType.transparency,
                                elevation: 10,
                                animationDuration: Duration(seconds: 1),
                                child: InkWell(
                                  splashColor: Colors.grey.withOpacity(0.5),
                                  splashFactory: InkRipple.splashFactory,
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        CupertinoPageRoute(
                                            builder: (context) =>
                                                Notification_Screen()));
                                  },
                                  child: Container(
                                    height: 25,
                                    color: Colors.transparent,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(width: 16),
                                        Image.asset(ImagePath.notification,
                                            height: 21, width: 21),
                                        SizedBox(width: 16),
                                        Text(
                                          "notification".tr,
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
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 6, right: 6),
                                child: Divider(),
                              ),
                              Material(
                                type: MaterialType.transparency,
                                elevation: 10,
                                animationDuration: Duration(seconds: 1),
                                child: InkWell(
                                  splashColor: Colors.grey.withOpacity(0.5),
                                  splashFactory: InkRipple.splashFactory,
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        CupertinoPageRoute(
                                            builder: (context) =>
                                                About_Screen()));
                                  },
                                  child: Container(
                                    height: 25,
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
                                          "privacy & policy".tr,
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
                              ),
                              SizedBox(height: 5),
                            ],
                          ),
                        ),
                        SizedBox(height: 15),
                        _viewContainer(
                          83,
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(height: 5),
                              Material(
                                type: MaterialType.transparency,
                                elevation: 10,
                                animationDuration: Duration(seconds: 1),
                                child: InkWell(
                                  splashColor: Colors.grey.withOpacity(0.5),
                                  splashFactory: InkRipple.splashFactory,
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                Contact_Us()));
                                  },
                                  child: Container(
                                    height: 25,
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
                                          "contact us".tr,
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
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 6, right: 6),
                                child: Divider(),
                              ),
                              Material(
                                type: MaterialType.transparency,
                                elevation: 10,
                                animationDuration: Duration(seconds: 1),
                                child: InkWell(
                                  splashColor: Colors.grey.withOpacity(0.5),
                                  splashFactory: InkRipple.splashFactory,
                                  onTap: () {
                                    setState(() {
                                      buildLanguageDialog(context);
                                    });
                                  },
                                  child: Container(
                                    height: 25,
                                    color: Colors.transparent,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(width: 16),
                                        Image.asset(ImagePath.language,
                                            height: 21, width: 21),
                                        SizedBox(width: 16),
                                        Text(
                                          "language".tr,
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
                              ),
                              SizedBox(height: 5),
                            ],
                          ),
                        ),
                        SizedBox(height: 15),
                        _viewContainer(
                          209,
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(height: 5),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(width: 16),
                                  Image.asset(ImagePath.blurImage,
                                      height: 21, width: 21),
                                  SizedBox(width: 16),
                                  Text(
                                    "blur image".tr,
                                    style: headingStyle.copyWith(
                                        color: Color(0xff333F52),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Spacer(),
                                  FlutterSwitch(
                                    width: 39.0,
                                    height: 25.0,
                                    toggleSize: 16.0,
                                    value: blurImage,
                                    borderRadius: 30.0,
                                    activeColor: currentColor,
                                    onToggle: (val) {
                                      setState(() {
                                        blurImage = val;
                                      });
                                    },
                                  ),
                                  SizedBox(width: 16),
                                ],
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 6, right: 6),
                                child: Divider(),
                              ),
                              InkWell(
                                splashColor: Colors.grey.withOpacity(0.5),
                                splashFactory: InkRipple.splashFactory,
                                onTap: () {
                                  _preferredCommunication();
                                  // openWhatsApp();
                                },
                                child: Container(
                                  color: Colors.transparent,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(width: 16),
                                      Image.asset(ImagePath.communication,
                                          height: 21, width: 21),
                                      SizedBox(width: 16),
                                      Text(
                                        "prefreede".tr,
                                        style: headingStyle.copyWith(
                                            color: Color(0xff333F52),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Spacer(),
                                      Image.asset(ImagePath.wp,
                                          height: 21, width: 21),
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
                              InkWell(
                                onTap: () {
                                  _selectColor();
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(width: 16),
                                    Image.asset(ImagePath.theme,
                                        height: 21, width: 21),
                                    SizedBox(width: 16),
                                    Text(
                                      "change theme".tr,
                                      style: headingStyle.copyWith(
                                          color: Color(0xff333F52),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Spacer(),
                                    Container(
                                      height: 21,
                                      width: 21,
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                            colors: currentGradient),
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    SizedBox(width: 4),
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
                                  Image.asset(ImagePath.requestContact,
                                      height: 21, width: 21),
                                  SizedBox(width: 16),
                                  Text(
                                    "request to contact".tr,
                                    style: headingStyle.copyWith(
                                        color: Color(0xff333F52),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Spacer(),
                                  FlutterSwitch(
                                    width: 39.0,
                                    height: 25.0,
                                    toggleSize: 16.0,
                                    value: requestContact,
                                    borderRadius: 30.0,
                                    activeColor: currentColor,
                                    onToggle: (val) {
                                      setState(() {
                                        requestContact = val;
                                      });
                                    },
                                  ),
                                  SizedBox(width: 16),
                                ],
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
                                  Image.asset(ImagePath.onlineOffline,
                                      height: 21, width: 21),
                                  SizedBox(width: 16),
                                  Expanded(
                                    child: Text(
                                      "control to show".tr,
                                      style: headingStyle.copyWith(
                                          color: Color(0xff333F52),
                                          fontSize: 13.6,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  FlutterSwitch(
                                    width: 39.0,
                                    height: 25.0,
                                    toggleSize: 16.0,
                                    value: onlineOffline,
                                    borderRadius: 30.0,
                                    activeColor: currentColor,
                                    onToggle: (val) {
                                      setState(() {
                                        onlineOffline = val;
                                      });
                                    },
                                  ),
                                  SizedBox(width: 16),
                                ],
                              ),
                              SizedBox(height: 5),
                            ],
                          ),
                        ),
                        SizedBox(height: 27),
                        GestureDetector(
                          onTap: () {
                            _disableDialogBox();
                          },
                          child: Container(
                            height: 41,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: currentColor.withOpacity(0.2),
                            ),
                            child: Row(
                              children: [
                                SizedBox(width: 16),
                                currentColor == Color(0xff6398FC)
                                    ? Image.asset(ImagePath.disableBlue,
                                        height: 21, width: 21)
                                    : currentColor == const Color(0xffEE7502)
                                        ? Image.asset(ImagePath.disableOrange,
                                            height: 21, width: 21)
                                        : Image.asset(ImagePath.disable,
                                            height: 21, width: 21),
                                SizedBox(width: 16),
                                Text(
                                  "disable account".tr,
                                  style: headingStyle.copyWith(
                                      color: currentColor,
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

  checkConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      CommonUtils.showProgressLoading(context);
      getProfileAPI();
    } else if (connectivityResult == ConnectivityResult.wifi) {
      CommonUtils.showProgressLoading(context);
      getProfileAPI();
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Alert"),
              content: const Text("Check Your Internet Connection"),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Ok")),
              ],
            );
          });
    }
  }

  updateLanguageApi(int index) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var userToken = pref.getString(USER_TOKEN);

    final queryParameters = {
      "token": userToken.toString(),
    };
    String queryString = Uri(queryParameters: queryParameters).query;

    var params = {
      "lang": "${index + 1}",
    };
    try {
      var response =
          await dio.post(LANGUAGE_UPDATE_URL + "?" + queryString, data: params);
      if (response.statusCode == 200) {
        updateLanguage(locale[index]['locale']);
        var data = jsonDecode(response.data);
        if (data['success'] == 'Token is Expired') {
          pref.setString(USER_TOKEN, "");
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (dialogcontext) => Login()),
              (route) => false);
        } else {
          updateLanguageModel _languageModel =
              updateLanguageModel.fromJson(response.data);
        }
      } else if (response.statusCode == 500) {
        CommonUtils.hideProgressLoading();
        Fluttertoast.showToast(
            msg: "Internal Server Error",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Color(0xffE16284),
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        var data = response.data;
      }
    } on DioError catch (e) {
      print(e);
    }
  }

  getProfileAPI() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString(USER_TOKEN);
    final queryParameters = {
      "token": token.toString(),
    };
    String queryString = Uri(queryParameters: queryParameters).query;
    var response =
        await http.get(Uri.parse(GET_PROFILE_ABOUT + "?" + queryString));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      if (data['status'] == "Token is Expired") {
        pref.setString(USER_TOKEN, "");
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (dialogcontext) => Login()),
            (route) => false);
      } else {
        setState(() {
          _userAboutMeModel =
              UserAboutMeModel.fromJson(jsonDecode(response.body));
          CommonUtils.hideProgressLoading();
          log("profile res=========== " + response.body);
        });
      }
    } else if (response.statusCode == 500) {
      CommonUtils.hideProgressLoading();
      Fluttertoast.showToast(
          msg: "Internal Server Error",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Color(0xffE16284),
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  _viewContainer(double height, Widget child) {
    return Container(
      height: height,
      width: MediaQuery.of(context).size.width * 4,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: child,
    );
  }

  _selectColor() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder:
              (BuildContext context, void Function(void Function()) setState) {
            AlertDialog dialog = AlertDialog(
              insetPadding: EdgeInsets.symmetric(horizontal: 16),
              contentPadding: EdgeInsets.zero,
              backgroundColor: Colors.transparent,
              content: Container(
                height: 240,
                width: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      SizedBox(height: 2),
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
                      Text(
                        "pick color".tr,
                        style: TextStyle(fontSize: 26),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(_col.length, (index) {
                          return InkWell(
                            onTap: () {
                              setState(() {
                                setColor(index);
                              });
                            },
                            child: Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    (isSelected == index)
                                        ? BoxShadow(
                                            color: Colors.black,
                                            blurRadius: 5,
                                            spreadRadius: 3)
                                        : BoxShadow()
                                  ],
                                  shape: BoxShape.circle,
                                  color: _col[index][0],
                                  gradient:
                                      LinearGradient(colors: _col[index])),
                            ),
                          );
                        }),
                      ),
                      SizedBox(height: 30),
                      GestureDetector(
                        onTap: () async {
                          SharedPreferences pref =
                              await SharedPreferences.getInstance();
                          pref.setInt(SELECTCOLOR, currentColor.value);

                          Navigator.pop(context);
                        },
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: currentGradient),
                            borderRadius: BorderRadius.circular(9),
                          ),
                          child: Center(
                            child: Text(
                              "done".tr,
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 5)
                    ],
                  ),
                ),
              ),
            );
            return dialog;
          },
        );
      },
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
              height: 300,
              width: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  SizedBox(height: 2),
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
                  Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(ImagePath.disableImage))),
                  ),
                  Container(
                    child: Padding(
                      padding: EdgeInsets.only(left: 40, right: 40),
                      child: TextFormField(
                        scrollPadding: EdgeInsets.zero,
                        decoration: InputDecoration(
                          hintText: "reason".tr,
                          hintStyle: headerstyle.copyWith(
                            color: Color(0xffAFAFAF),
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10, right: 10, top: 8),
                    child: Container(
                      child: Text(
                        "disableaccount".tr,
                        style: headingStyle.copyWith(
                          color: Color(0xff333F52),
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 13),
                  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: Text(
                      "reach you".tr,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      style: headingStyle.copyWith(
                        color: Color(0xffAFAFAF),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  Padding(
                      padding: EdgeInsets.only(left: 23, right: 23),
                      child: Container(
                        height: 45,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(colors: currentGradient),
                          borderRadius: BorderRadius.circular(9),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          "disable".tr,
                          style: appBtnStyle,
                        ),
                      )),
                  SizedBox(height: 12),
                ],
              ),
            ),
          );
        });
  }

  _preferredCommunication() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (BuildContext context,
                void Function(void Function()) setState) {
              AlertDialog dialog = AlertDialog(
                insetPadding: EdgeInsets.symmetric(horizontal: 16),
                contentPadding: EdgeInsets.zero,
                backgroundColor: Colors.transparent,
                content: Container(
                  height: 180,
                  width: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(height: 2),
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
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "prefreede".tr,
                          style: TextStyle(fontSize: 17),
                        ),
                        SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Image.asset(
                                ImagePath.eMangalKaryaMsg,
                                height: 50,
                                width: 50,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Image.asset(
                                ImagePath.eMailMsg,
                                height: 45,
                                width: 45,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                openWhatsApp();
                                Navigator.pop(context);
                              },
                              child: Image.asset(
                                ImagePath.eWpMsg,
                                height: 45,
                                width: 45,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
              return dialog;
            },
          );
        });
  }

  openWhatsApp() async {
    var url = 'https://wa.me/%2B91' +
        _userAboutMeModel!.data!.mobile.toString() +
        '?text=hello';
    log(url);
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
