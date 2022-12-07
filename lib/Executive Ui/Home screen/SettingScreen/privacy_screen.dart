/* import 'package:flutter/material.dart';
import 'package:matrimonial_app/Utils/app_constants.dart';
import 'package:matrimonial_app/Utils/image_path_constants.dart';
import 'package:matrimonial_app/Utils/text_styles.dart';
import 'package:matrimonial_app/widget/commonappbar.dart';
import 'package:matrimonial_app/widget/commonappbar_search.dart';

class E_About_Screen extends StatefulWidget {
  const E_About_Screen({Key? key}) : super(key: key);

  @override
  State<E_About_Screen> createState() => _E_About_ScreenState();
}

class _E_About_ScreenState extends State<E_About_Screen> {
  List<bool> isOpen = [];
  List<String> aboutList = [
    AppConstants.terms,
    AppConstants.privacy,
    AppConstants.community
  ];
  void showHide(int i) {
    setState(() {
      isOpen[i] = !isOpen[i];
    });
  }

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < aboutList.length; i++) {
      isOpen.add(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            children: [
              CommonAppbar1(name: AppConstants.aboutUs),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    child: Column(
                      children: [
                        ListView.builder(
                            physics: BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: aboutList.length,
                            itemBuilder: ((context, index) {
                              return Column(
                                children: [
                                  Divider(
                                    thickness: 2,
                                    color: Color(0xffF1F2F6),
                                  ),
                                  SizedBox(height: 20),
                                  GestureDetector(
                                    onTap: () {
                                      showHide(index);
                                    },
                                    child: isOpen[index]
                                        ? Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(width: 16),
                                              Text(
                                                aboutList[index],
                                                style: headerstyle.copyWith(
                                                  fontSize: 16,
                                                  color: Color(0xff333F52),
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              Spacer(),
                                              Image.asset(
                                                  ImagePath.settingArrow,
                                                  height: 24,
                                                  width: 24),
                                              SizedBox(width: 16),
                                            ],
                                          )
                                        : Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  SizedBox(width: 16),
                                                  Text(
                                                    aboutList[index],
                                                    style: headerstyle.copyWith(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                  Spacer(),
                                                  Image.asset(
                                                      ImagePath.downArrow,
                                                      height: 24,
                                                      width: 24),
                                                  SizedBox(width: 16),
                                                ],
                                              ),
                                              SizedBox(height: 8),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 16, right: 16),
                                                child: Text(
                                                  AppConstants
                                                      .privacyPolicyText,
                                                  style: headerstyle.copyWith(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400,
                                                    color: Color(0xff67707D),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                  ),
                                  SizedBox(height: 20),
                                ],
                              );
                            })),
                      ],
                    ),
                  ),
                ),
              ),
              Text('App Version 1.0.1 (120)'),
              SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }
}
 */

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:matrimonial_app/Core/Constant/CommonUtils.dart';
import 'package:matrimonial_app/Core/Constant/url_constant.dart';
import 'package:matrimonial_app/ModelClass/UserPanel_ModelClass/aboutus_model.dart';
import 'package:matrimonial_app/Utils/app_constants.dart';
import 'package:matrimonial_app/Utils/color_constants.dart';
import 'package:matrimonial_app/Utils/image_path_constants.dart';
import 'package:matrimonial_app/Utils/text_styles.dart';
import 'package:matrimonial_app/widget/commonappbar_search.dart';

import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';

class E_About_Screen extends StatefulWidget {
  const E_About_Screen({Key? key}) : super(key: key);

  @override
  State<E_About_Screen> createState() => _E_About_ScreenState();
}

class _E_About_ScreenState extends State<E_About_Screen> {
  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
    buildSignature: 'Unknown',
  );
  String? version;
  String? appName;

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
      version = info.version;
      appName = info.appName;
    });
    print(version);
    print(appName);
  }

  Widget _infoTile(String title, String subtitle) {
    return ListTile(
      title: Text(title),
      subtitle: Text(subtitle.isEmpty ? 'Not set' : subtitle),
    );
  }

  AboutUsModel _aboutUsModel = AboutUsModel(success: true);
  List<bool> isOpenPrivacy = [];
  List<bool> isOpenTerms = [];
  List<bool> isOpenAbout = [];
  List<String> aboutList = [
    AppConstants.terms,
    AppConstants.privacy,
    AppConstants.community
  ];
  void showHidePrivacy(int i) {
    setState(() {
      isOpenPrivacy[i] = !isOpenPrivacy[i];
    });
  }

  void showHideAbout(int i) {
    setState(() {
      isOpenAbout[i] = !isOpenAbout[i];
    });
  }

  void showHideTerms(int i) {
    setState(() {
      isOpenTerms[i] = !isOpenTerms[i];
    });
  }

  @override
  void initState() {
    getAbouUs();

    super.initState();

    _initPackageInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            children: [
              CommonAppbar1(name: AppConstants.aboutUs),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: Text(
                            "Privacy policy",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: AppColors.greyColor),
                          ),
                        ),
                        ListView.separated(
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: (_aboutUsModel.data != null &&
                                  _aboutUsModel.data!.privacyPolicy != null)
                              ? _aboutUsModel.data!.privacyPolicy!.length
                              : 0,
                          itemBuilder: ((context, index) {
                            return Column(
                              children: [
                                SizedBox(height: 20),
                                GestureDetector(
                                  onTap: () {
                                    showHidePrivacy(index);
                                  },
                                  child: isOpenPrivacy[index] == false
                                      ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(width: 16),
                                            Text(
                                              _aboutUsModel.data!
                                                  .privacyPolicy![index].title
                                                  .toString(),
                                              style: headerstyle.copyWith(
                                                fontSize: 16,
                                                color: Color(0xff333F52),
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            Spacer(),
                                            Image.asset(ImagePath.settingArrow,
                                                height: 24, width: 24),
                                            SizedBox(width: 16),
                                          ],
                                        )
                                      : Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                SizedBox(width: 16),
                                                Text(
                                                  _aboutUsModel
                                                      .data!
                                                      .privacyPolicy![index]
                                                      .title
                                                      .toString(),
                                                  style: headerstyle.copyWith(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                                Spacer(),
                                                Image.asset(ImagePath.downArrow,
                                                    height: 24, width: 24),
                                                SizedBox(width: 16),
                                              ],
                                            ),
                                            SizedBox(height: 8),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 16, right: 16),
                                              child: Text(
                                                _aboutUsModel
                                                    .data!
                                                    .privacyPolicy![index]
                                                    .content!,
                                                textAlign: TextAlign.start,
                                                style: headerstyle.copyWith(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                  color: Color(0xff67707D),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                ),
                                SizedBox(height: 20),
                              ],
                            );
                          }),
                          separatorBuilder: (BuildContext context, int index) {
                            return Divider(
                              thickness: 2,
                              color: Color(0xffF1F2F6),
                            );
                          },
                        ),
                        Divider(
                          thickness: 2,
                          color: Color(0xffF1F2F6),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: Text(
                            "About Us",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: AppColors.greyColor),
                          ),
                        ),
                        ListView.separated(
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: (_aboutUsModel.data != null &&
                                  _aboutUsModel.data!.aboutUs != null)
                              ? _aboutUsModel.data!.aboutUs!.length
                              : 0,
                          itemBuilder: ((context, index) {
                            return Column(
                              children: [
                                SizedBox(height: 20),
                                GestureDetector(
                                  onTap: () {
                                    showHideAbout(index);
                                  },
                                  child: isOpenAbout[index] == false
                                      ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(width: 16),
                                            Text(
                                              _aboutUsModel
                                                  .data!.aboutUs![index].title
                                                  .toString(),
                                              style: headerstyle.copyWith(
                                                fontSize: 16,
                                                color: Color(0xff333F52),
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            Spacer(),
                                            Image.asset(ImagePath.settingArrow,
                                                height: 24, width: 24),
                                            SizedBox(width: 16),
                                          ],
                                        )
                                      : Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                SizedBox(width: 16),
                                                Text(
                                                  _aboutUsModel.data!
                                                      .aboutUs![index].title
                                                      .toString(),
                                                  style: headerstyle.copyWith(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                                Spacer(),
                                                Image.asset(ImagePath.downArrow,
                                                    height: 24, width: 24),
                                                SizedBox(width: 16),
                                              ],
                                            ),
                                            SizedBox(height: 8),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 16, right: 16),
                                              child: Text(
                                                _aboutUsModel.data!
                                                    .aboutUs![index].content!,
                                                textAlign: TextAlign.start,
                                                style: headerstyle.copyWith(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                  color: Color(0xff67707D),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                ),
                                SizedBox(height: 20),
                              ],
                            );
                          }),
                          separatorBuilder: (BuildContext context, int index) {
                            return Divider(
                              thickness: 2,
                              color: Color(0xffF1F2F6),
                            );
                          },
                        ),
                        Divider(
                          thickness: 2,
                          color: Color(0xffF1F2F6),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: Text(
                            "Terms & Conditions",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: AppColors.greyColor),
                          ),
                        ),
                        ListView.separated(
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: (_aboutUsModel.data != null &&
                                  _aboutUsModel.data!.termCondition != null)
                              ? _aboutUsModel.data!.termCondition!.length
                              : 0,
                          itemBuilder: ((context, index) {
                            return Column(
                              children: [
                                SizedBox(height: 20),
                                GestureDetector(
                                  onTap: () {
                                    showHideTerms(index);
                                  },
                                  child: isOpenTerms[index] == false
                                      ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(width: 16),
                                            Text(
                                              _aboutUsModel.data!
                                                  .termCondition![index].title
                                                  .toString(),
                                              style: headerstyle.copyWith(
                                                fontSize: 16,
                                                color: Color(0xff333F52),
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            Spacer(),
                                            Image.asset(ImagePath.settingArrow,
                                                height: 24, width: 24),
                                            SizedBox(width: 16),
                                          ],
                                        )
                                      : Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                SizedBox(width: 16),
                                                Text(
                                                  _aboutUsModel
                                                      .data!
                                                      .termCondition![index]
                                                      .title
                                                      .toString(),
                                                  style: headerstyle.copyWith(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                                Spacer(),
                                                Image.asset(ImagePath.downArrow,
                                                    height: 24, width: 24),
                                                SizedBox(width: 16),
                                              ],
                                            ),
                                            SizedBox(height: 8),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 16, right: 16),
                                              child: Text(
                                                _aboutUsModel
                                                    .data!
                                                    .termCondition![index]
                                                    .content!,
                                                textAlign: TextAlign.start,
                                                style: headerstyle.copyWith(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                  color: Color(0xff67707D),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                ),
                                SizedBox(height: 20),
                              ],
                            );
                          }),
                          separatorBuilder: (BuildContext context, int index) {
                            return Divider(
                              thickness: 2,
                              color: Color(0xffF1F2F6),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Text(_packageInfo.appName + ' ' + _packageInfo.version),
              SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }

  void getAbouUs() async {
    // CommonUtils.showProgressLoading(context);
    var response = await http.get(
      Uri.parse(ABOUT_US),
    );

    if (response.statusCode == 200) {
      if (mounted) {
        setState(() {
          _aboutUsModel = AboutUsModel.fromJson(jsonDecode(response.body));
        });
      }
      print("privacy policy ::: ${response.body}");
      for (int i = 0; i < _aboutUsModel.data!.privacyPolicy!.length; i++) {
        isOpenPrivacy.add(false);
      }
      for (int i = 0; i < _aboutUsModel.data!.aboutUs!.length; i++) {
        isOpenAbout.add(false);
      }
      for (int i = 0; i < _aboutUsModel.data!.termCondition!.length; i++) {
        isOpenTerms.add(false);
      }
      CommonUtils.hideProgressLoading();
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
      CommonUtils.hideProgressLoading();
    }
  }
}
