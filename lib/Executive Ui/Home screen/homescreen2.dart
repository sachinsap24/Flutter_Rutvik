// ignore_for_file: must_be_immutable, unused_local_variable

import 'dart:convert';
import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:matrimonial_app/Core/Constant/CommonUtils.dart';
import 'package:matrimonial_app/Core/Constant/url_constant.dart';
import 'package:matrimonial_app/Core/Constant/value_constants.dart';
import 'package:matrimonial_app/Executive%20Ui/Home%20screen/SettingScreen/homescreen2story.dart';
import 'package:matrimonial_app/Executive%20Ui/Home%20screen/SettingScreen/setting_screen.dart';
import 'package:matrimonial_app/Executive%20Ui/Login/otp_screen.dart';
import 'package:matrimonial_app/Executive%20Ui/Ragister/add_profile_screen.dart';
import 'package:matrimonial_app/MatchingProfile/matching_profilescreen.dart';
import 'package:matrimonial_app/ModelClass/Executive_ModelClass/All_Executive_Candidate_Model.dart';
import 'package:matrimonial_app/ModelClass/Executive_ModelClass/refer_User_model.dart';
import 'package:matrimonial_app/ModelClass/Executive_ModelClass/user_lookin_for_model.dart';
import 'package:matrimonial_app/Utils/app_constants.dart';
import 'package:matrimonial_app/Utils/color_constants.dart';
import 'package:matrimonial_app/Utils/image_path_constants.dart';
import 'package:matrimonial_app/Utils/text_styles.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../ModelClass/Executive_ModelClass/refer_User_model.dart' as refer;
import 'package:http/http.dart' as http;

class HomeScreen1 extends StatefulWidget {
  String? name;
  String? image;
  var candidateId;
  int? imgLength;
  HomeScreen1(
      {Key? key, this.name, this.image, this.candidateId, this.imgLength})
      : super(key: key);

  @override
  State<HomeScreen1> createState() => _HomeScreen1State();
}

class _HomeScreen1State extends State<HomeScreen1> {
  bool isDeleteSelected = false;
  UserLookinForExeModel? _userLookinForExeModel;
  AllExecutiveCandidates_Model? _allExecutiveCandidates_Model;
  List imageList = [];
  List<refer.Data> archiveDeleteList = [];
  bool isVerifyProfile = false;

  List deleteIdList = [];
  ReferUserModel? _referUserModel;
  List<String> matchingProfile = [
    ImagePath.eMatchingprofile1,
    ImagePath.eMatchingprofile2,
    ImagePath.eMatchingprofile3,
  ];
  List<String> matchProfileFromMyProfile = [
    ImagePath.byCastImage,
    ImagePath.byCastImage1,
  ];

  List<String> matchProfileFromMyOther = [
    ImagePath.byCastImage2,
    ImagePath.byCastImage3,
  ];

  List<String> likedByJames = [
    ImagePath.byCastImage,
    ImagePath.byCastImage1,
  ];

  List<String> inProgress = [
    ImagePath.byCastImage,
    ImagePath.byCastImage1,
  ];

  @override
  void initState() {
    super.initState();
    getreferUser();
    getUserPreference();
    getAllExeCandidate();
    print("object ::: ${widget.image}");
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          _appBar(),
          const SizedBox(
            height: 5,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 16, right: 16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 200,
                          width: width * 0.45,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        CupertinoPageRoute(
                                            builder: (context) =>
                                                MatchingProfile_Screen(
                                                    name: widget.name,
                                                    img: widget.image,
                                                    candidateId:
                                                        widget.candidateId)));
                                  },
                                  child: Container(
                                    height: 190,
                                    width: width * 0.45,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 3, color: Color(0xffFB5A57)),
                                      borderRadius: BorderRadius.circular(22),
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: widget.image!.isNotEmpty
                                            ? NetworkImage(
                                                widget.image.toString())
                                            : NetworkImage(
                                                "https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/1024px-No_image_available.svg.png",
                                              ),
                                      ),
                                    ),
                                    child: Column(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            List<String> storiesList = [];
                                            imageList.clear();
                                            for (var i = 0;
                                                i <
                                                    _allExecutiveCandidates_Model!
                                                        .data!.length;
                                                i++) {
                                              if (widget.candidateId ==
                                                  _allExecutiveCandidates_Model!
                                                      .data![i].userId) {
                                                for (var j = 0;
                                                    j <
                                                        _allExecutiveCandidates_Model!
                                                            .data![i]
                                                            .profileImage!
                                                            .length;
                                                    j++) {
                                                  setState(() {
                                                    imageList.add(
                                                        _allExecutiveCandidates_Model!
                                                            .data![i]
                                                            .profileImage![j]);
                                                  });
                                                }
                                              }
                                            }
                                            setState(() {
                                              storiesList = List.generate(
                                                  imageList.length, (index) {
                                                return imageList.isEmpty
                                                    ? "http://www.goodmorningimagesdownload.com/wp-content/uploads/2019/12/Love-Images-1.jpg"
                                                    : imageList[index]
                                                        .filePath
                                                        .toString();
                                              });
                                            });
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        HomescreenStory(
                                                          story: storiesList,
                                                        )));
                                          },
                                          child: Align(
                                            alignment: Alignment.topRight,
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  top: 12, right: 12),
                                              child: Container(
                                                height: 18,
                                                width: 34,
                                                decoration: BoxDecoration(
                                                    color: Color(0xff000000)
                                                        .withOpacity(.30),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    left: 6,
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        widget.imgLength != null
                                                            ? widget.imgLength
                                                                .toString()
                                                            : "0",
                                                        style: TextStyle(
                                                            color: AppColors
                                                                .colorWhite,
                                                            fontSize: 10,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Image.asset(
                                                        ImagePath.camera,
                                                        height: 12,
                                                        width: 12,
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Spacer(),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 0.0),
                                          child: Container(
                                            height: 40,
                                            decoration: BoxDecoration(
                                              color: Color(0xffffffff)
                                                  .withOpacity(0.9),
                                              borderRadius: BorderRadius.only(
                                                bottomRight:
                                                    Radius.circular(18),
                                                bottomLeft: Radius.circular(18),
                                              ),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 8.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 5),
                                                          child: Text(
                                                            widget.name
                                                                .toString(),
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: TextStyle(
                                                                color: AppColors
                                                                    .blackColor,
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                          ),
                                                        ),
                                                        /*  SizedBox(height: 2),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 5),
                                                          child: Text(
                                                            AppConstants
                                                                .scientist,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          ),
                                                        ) */
                                                      ],
                                                    ),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () async {
                                                      String? data;
                                                      final value =
                                                          await Navigator.push(
                                                        context,
                                                        CupertinoPageRoute(
                                                          builder: (context) =>
                                                              AddProfileScreen(
                                                                  candidateId:
                                                                      widget
                                                                          .candidateId,
                                                                  isUpdate:
                                                                      "isUpdate"),
                                                        ),
                                                      );
                                                      setState(() {
                                                        data = value;
                                                      });
                                                      if (data ==
                                                          "UpdateData") {}
                                                      log("update data ---------$data");
                                                    },
                                                    child: Image.asset(
                                                      ImagePath.editpencile,
                                                      width: 20,
                                                      height: 20,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                /*   SizedBox(height: 4), */
                                /*    Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 5),
                                              child: Text(
                                                widget.name.toString(),
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    color: AppColors.blackColor,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ),
                                            SizedBox(height: 2),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 5),
                                              child: Text(
                                                AppConstants.scientist,
                                                style: TextStyle(
                                                    color: AppColors.eGreyColor,
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () async {
                                          String? data;
                                          final value = await Navigator.push(
                                            context,
                                            CupertinoPageRoute(
                                              builder: (context) =>
                                                  AddProfileScreen(
                                                      candidateId:
                                                          widget.candidateId,
                                                      isUpdate: "isUpdate"),
                                            ),
                                          );
                                          setState(() {
                                            data = value;
                                          });
                                          if (data == "UpdateData") {}
                                          log("update data ---------$data");
                                        },
                                        child: Image.asset(
                                          ImagePath.editpencile,
                                          width: 20,
                                          height: 20,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              */
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 5),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 7),
                            GestureDetector(
                              onTap: () {
                                addMatchmaking();
                              },
                              child: Container(
                                // width: width * 0.3,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Color(0xffFCC8D0).withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(13),
                                  border: Border.all(
                                      width: 2,
                                      color:
                                          Color(0xffFB5A57).withOpacity(0.5)),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 5.0, right: 5),
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        ImagePath.eMangalKaryaMsg,
                                        height: 30,
                                        width: 30,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        "Mangal Karyam",
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              width: 148,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Color(0xffFCC8D0).withOpacity(0.3),
                                borderRadius: BorderRadius.circular(13),
                                border: Border.all(
                                    width: 2,
                                    color: Color(0xffFB5A57).withOpacity(0.5)),
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(left: 3.0, right: 3),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, right: 8),
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        ImagePath.eWpMsg,
                                        height: 25,
                                        width: 25,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        "Whatsapp",
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              width: 148,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Color(0xffFCC8D0).withOpacity(0.3),
                                borderRadius: BorderRadius.circular(13),
                                border: Border.all(
                                    width: 2,
                                    color: Color(0xffFB5A57).withOpacity(0.5)),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 8.0, right: 8),
                                child: Row(
                                  children: [
                                    Image.asset(
                                      ImagePath.eMailMsg,
                                      height: 25,
                                      width: 25,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "Gmail",
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppConstants.userPreferences,
                          style: addedbyyou,
                        ),
                        Row(
                          children: [
                            Text(
                              AppConstants.requestEdit,
                              style: seeall,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Image.asset(
                              ImagePath.pinkforward,
                              width: 6,
                              height: 9,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 16),
                    child: Wrap(
                      children: [
                        SizedBox(width: 0),
                        Container(
                          height: 35,
                          width: 110,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Color(0xffDFDFDF)),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(width: 6),
                                Text(
                                  AppConstants.castPatelPref,
                                  style: TextStyle(
                                    color: Color(0xff747474),
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    _userLookinForExeModel != null &&
                                            _userLookinForExeModel!
                                                    .data!.lookingFor!.caste !=
                                                null
                                        ? _userLookinForExeModel!
                                            .data!.lookingFor!.caste
                                            .toString()
                                        : "",
                                    maxLines: 1,
                                    style: TextStyle(
                                        color: Color(0xff747474),
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                        overflow: TextOverflow.ellipsis),
                                  ),
                                ),
                                SizedBox(width: 6),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Padding(
                          padding: const EdgeInsets.only(top: 0, left: 0),
                          child: Container(
                            height: 35,
                            width: 100,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Color(0xffDFDFDF)),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(width: 6),
                                  Text(
                                    AppConstants.gotraPref,
                                    style: TextStyle(
                                      color: Color(0xff747474),
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      _userLookinForExeModel != null &&
                                              _userLookinForExeModel!
                                                  .data!.lookingFor!.gotra
                                                  .toString()
                                                  .isNotEmpty
                                          ? _userLookinForExeModel!
                                              .data!.lookingFor!.gotra
                                              .toString()
                                          : "",
                                      maxLines: 1,
                                      style: TextStyle(
                                          color: Color(0xff747474),
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                          overflow: TextOverflow.ellipsis),
                                    ),
                                  ),
                                  SizedBox(width: 6),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Padding(
                          padding: const EdgeInsets.only(top: 0.0),
                          child: Container(
                            height: 35,
                            width: 88,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Color(0xffDFDFDF)),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(width: 6),
                                  Text(
                                    AppConstants.agePref,
                                    style: TextStyle(
                                      color: Color(0xff747474),
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      _userLookinForExeModel != null &&
                                              _userLookinForExeModel!
                                                  .data!.lookingFor!.ageFrom
                                                  .toString()
                                                  .isNotEmpty
                                          ? _userLookinForExeModel!
                                                  .data!.lookingFor!.ageFrom
                                                  .toString() +
                                              "-" +
                                              _userLookinForExeModel!
                                                  .data!.lookingFor!.ageTo
                                                  .toString()
                                          : "",
                                      // maxLines: 1,
                                      style: TextStyle(
                                        overflow: TextOverflow.ellipsis,
                                        color: Color(0xff747474),
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 6),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Container(
                            height: 35,
                            width: 130,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Color(0xffDFDFDF)),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(width: 6),
                                  Text(
                                    AppConstants.heightPrefs,
                                    style: TextStyle(
                                      color: Color(0xff747474),
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    _userLookinForExeModel != null &&
                                            _userLookinForExeModel!
                                                .data!.lookingFor!.heightFrom
                                                .toString()
                                                .isNotEmpty
                                        ? _userLookinForExeModel!
                                                .data!.lookingFor!.heightFrom
                                                .toString() +
                                            "-" +
                                            _userLookinForExeModel!
                                                .data!.lookingFor!.heightTo
                                                .toString()
                                        : "",
                                    style: TextStyle(
                                      color: Color(0xff747474),
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(width: 6),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 18),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Container(
                            height: 35,
                            width: 148,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Color(0xffDFDFDF)),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(width: 6),
                                  Text(
                                    AppConstants.distancePref,
                                    style: TextStyle(
                                      color: Color(0xff747474),
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      _userLookinForExeModel != null &&
                                              _userLookinForExeModel!.data!
                                                  .lookingFor!.annualIncome
                                                  .toString()
                                                  .isNotEmpty
                                          ? _userLookinForExeModel!
                                              .data!.lookingFor!.annualIncome
                                              .toString()
                                          : "",
                                      maxLines: 1,
                                      style: TextStyle(
                                          color: Color(0xff747474),
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                          overflow: TextOverflow.ellipsis),
                                    ),
                                  ),
                                  SizedBox(width: 6),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 16.0,
                      right: 16,
                    ),
                    child: Container(
                      // height: 154,
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(
                              0,
                              0,
                            ),
                            color: Color(0xff000000).withOpacity(.10),
                            blurRadius: 20,
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 15),
                          Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: Text(
                              AppConstants.profileVerification,
                              style: matchscroll.copyWith(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  color: Color(0xff000000)),
                            ),
                          ),
                          SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  Image.asset(
                                      (isVerifyProfile)
                                          ? ImagePath.profileVerified
                                          : ImagePath.notVerify,
                                      height: 80,
                                      width: 80),
                                  SizedBox(height: 10),
                                  Text(
                                    AppConstants.profileVerificationPending,
                                    style: matchscroll.copyWith(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 15,
                                        color: Color(0xff000000)),
                                  ),
                                  SizedBox(height: 10),
                                  (isVerifyProfile)
                                      ? Text(
                                          AppConstants.verified,
                                          style: matchscroll.copyWith(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 15,
                                              decoration:
                                                  TextDecoration.underline,
                                              color: Color(0xff12A2AB)),
                                        )
                                      : InkWell(
                                          onTap: () async {
                                            SharedPreferences pref =
                                                await SharedPreferences
                                                    .getInstance();
                                            String? exeMobileNo =
                                                pref.getString(EXE_MOBILE);
                                            final result = await Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) => OTPScreen(
                                                        text: '123456',
                                                        mobile: exeMobileNo
                                                            .toString(),
                                                        email: '',
                                                        fromValue:
                                                            'isVerifyProfile')));
                                            print("result verify ::: $result");
                                            if (result == "verifyProfile") {
                                              setState(() {
                                                isVerifyProfile = true;
                                              });
                                            }
                                          },
                                          child: Text(
                                            AppConstants.verificationNow,
                                            style: matchscroll.copyWith(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 15,
                                                decoration:
                                                    TextDecoration.underline,
                                                color: Color(0xff12A2AB)),
                                          ),
                                        ),
                                ],
                              ),
                              Column(
                                children: [
                                  Image.asset(ImagePath.notVerify,
                                      height: 80, width: 80),
                                  SizedBox(height: 15),
                                  Text(
                                    AppConstants.userPreferences,
                                    style: matchscroll.copyWith(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 15,
                                        color: Color(0xff000000)),
                                  ),
                                  SizedBox(height: 25),
                                  InkWell(
                                    onTap: () {
                                      Fluttertoast.showToast(
                                          msg: "Request Sent Successfully");
                                    },
                                    child: Text(
                                      AppConstants.requestNow,
                                      style: matchscroll.copyWith(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15,
                                          decoration: TextDecoration.underline,
                                          color: Color(0xff12A2AB)),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )
                          /*  Row(
                            children: [
                              SizedBox(width: 15),
                              Image.asset(ImagePath.profileVerified,
                                  height: 80, width: 80),
                              SizedBox(width: 15),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    AppConstants.profileVerificationPending,
                                    style: matchscroll.copyWith(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15,
                                        color: Color(0xff000000)),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    AppConstants.verificationNow,
                                    style: matchscroll.copyWith(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15,
                                        decoration: TextDecoration.underline,
                                        color: Color(0xff12A2AB)),
                                  ),
                                ],
                              ),
                            ],
                          ), */
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: Text(
                      AppConstants.matchingProfile,
                      style: matchscroll.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: Color(0xff101620),
                      ),
                    ),
                  ),
                  isDeleteSelected
                      ? Padding(
                          padding: const EdgeInsets.only(left: 16.0, right: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isDeleteSelected = false;
                                    });
                                  },
                                  child: Text("DeSelect",
                                      style: matchscroll.copyWith(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 15,
                                          color: currentColor))),
                            ],
                          ),
                        )
                      : Container(),
                  SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: _referUserModel != null &&
                            _referUserModel!.data!.isNotEmpty
                        ? GridView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10.0,
                              mainAxisSpacing: 8.0,
                              mainAxisExtent: 220,
                            ),
                            itemCount: _referUserModel != null &&
                                    _referUserModel!.data!.length != 0
                                ? _referUserModel!.data!.length
                                : 0,
                            itemBuilder: (context, index) {
                              _referUserModel!.data!.forEach((element) {
                                archiveDeleteList.add(element);
                              });
                              return InkWell(
                                onTap: () {
                                  /*     Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) =>
                                        UserDetailScreen()));*/
                                },
                                onLongPress: () {
                                  setState(() {
                                    isDeleteSelected = true;
                                    if (archiveDeleteList[index].isSelected !=
                                        null) {
                                      archiveDeleteList[index].isSelected =
                                          !archiveDeleteList[index].isSelected!;
                                    } else {
                                      archiveDeleteList[index].isSelected =
                                          true;
                                    }
                                  });
                                  if (archiveDeleteList[index].isSelected ==
                                      true) {
                                    deleteIdList.add(
                                        _referUserModel!.data![index].userId);
                                  }
                                  log("long press  ${_referUserModel!.data![index].userId!}");
                                },
                                child: Container(
                                  height: 220,
                                  decoration: BoxDecoration(
                                    border:
                                        Border.all(color: Color(0xffECECEC)),
                                    borderRadius: BorderRadius.circular(20),
                                    color: currentColor,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Container(
                                      height: 207,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Color(0xffECECEC)),
                                        borderRadius: BorderRadius.circular(20),
                                        image: _referUserModel!.data != null &&
                                                _referUserModel!.data![index]
                                                        .profileImage!.length >
                                                    0
                                            ? DecorationImage(
                                                image: NetworkImage(
                                                    _referUserModel!
                                                        .data![index]
                                                        .profileImage![0]
                                                        .filePath
                                                        .toString()),
                                                fit: BoxFit.cover)
                                            : DecorationImage(
                                                fit: BoxFit.cover,
                                                image: AssetImage(
                                                  ImagePath.likeimage1,
                                                ),
                                              ),
                                      ),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: 10, right: 0, left: 8),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                isDeleteSelected
                                                    ? GestureDetector(
                                                        onTap: () {
                                                          print(
                                                              "tap to select");
                                                          setState(() {
                                                            isDeleteSelected =
                                                                true;
                                                            if (archiveDeleteList[
                                                                        index]
                                                                    .isSelected !=
                                                                null) {
                                                              archiveDeleteList[
                                                                          index]
                                                                      .isSelected =
                                                                  !archiveDeleteList[
                                                                          index]
                                                                      .isSelected!;
                                                            } else {
                                                              archiveDeleteList[
                                                                          index]
                                                                      .isSelected =
                                                                  true;
                                                            }
                                                          });
                                                          if (archiveDeleteList[
                                                                      index]
                                                                  .isSelected ==
                                                              true) {
                                                            deleteIdList.add(
                                                                _referUserModel!
                                                                    .data![
                                                                        index]
                                                                    .userId);
                                                          } else {
                                                            for (var i = 0;
                                                                i <
                                                                    deleteIdList
                                                                        .length;
                                                                i++) {
                                                              if (archiveDeleteList[
                                                                          index]
                                                                      .isSelected ==
                                                                  false) {
                                                                if (deleteIdList[
                                                                        i] ==
                                                                    _referUserModel!
                                                                        .data![
                                                                            index]
                                                                        .userId) {
                                                                  deleteIdList
                                                                      .removeAt(
                                                                          i);
                                                                }
                                                              }
                                                            }
                                                          }

                                                          log("delete list ::: $deleteIdList");
                                                        },
                                                        child: Icon(
                                                          archiveDeleteList[
                                                                          index]
                                                                      .isSelected ==
                                                                  true
                                                              ? Icons.check_box
                                                              : Icons
                                                                  .check_box_outline_blank,
                                                          color: Colors.red,
                                                        ),
                                                      )
                                                    : GestureDetector(
                                                        onTap: () {
                                                          /*   setState(() {
                                                _deleteDialogBox(
                                                    index);
                                              }
                                              ); */
                                                        },
                                                        child:
                                                            Container() /* Image.asset(
                                                          ImagePath.likecross,
                                                          width: 28,
                                                          height: 28,
                                                        ), */
                                                        ),
                                                SizedBox(
                                                  width: 15,
                                                ),
                                                /*      Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 8.0),
                                                  child: Container(
                                                    height: 20,
                                                    width: 34,
                                                    decoration: BoxDecoration(
                                                      color: Color(0xff000000)
                                                          .withOpacity(0.5),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                        left: 6,
                                                      ),
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            _referUserModel!
                                                                        .data !=
                                                                    null
                                                                ? _referUserModel!
                                                                    .data![
                                                                        index]
                                                                    .profileImage!
                                                                    .length
                                                                    .toString()
                                                                : "0",
                                                            style: TextStyle(
                                                                color: AppColors
                                                                    .colorWhite,
                                                                fontSize: 10,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          ),
                                                          SizedBox(
                                                            width: 5,
                                                          ),
                                                          Image.asset(
                                                            ImagePath.camera,
                                                            height: 12,
                                                            width: 12,
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                )*/
                                              ],
                                            ),
                                          ),
                                          Spacer(),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 0),
                                            child: Container(
                                              height: 34,
                                              decoration: BoxDecoration(
                                                color: Color(0xffffffff)
                                                    .withOpacity(0.5),
                                                borderRadius: BorderRadius.only(
                                                  bottomRight:
                                                      Radius.circular(13),
                                                  bottomLeft:
                                                      Radius.circular(13),
                                                ),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8, right: 14),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      _referUserModel!.data !=
                                                              null
                                                          ? _referUserModel!
                                                                  .data![index]
                                                                  .firstname
                                                                  .toString() +
                                                              _referUserModel!
                                                                  .data![index]
                                                                  .lastname
                                                                  .toString()
                                                          : AppConstants.joseph,
                                                      style: fontStyle.copyWith(
                                                          color: Colors.white),
                                                    ),
                                                    Image.asset(
                                                      ImagePath.peopleframe,
                                                      width: 22,
                                                      height: 22,
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          )

                        /*  GridView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 17.0,
                              mainAxisSpacing: 10.0,
                              mainAxisExtent: 220,
                            ),
                            itemCount: _referUserModel != null &&
                                    _referUserModel!.data != null
                                ? _referUserModel!.data!.length
                                : 0,
                            itemBuilder: (context, index) {
                              return Container(
                                height: 210,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(18),
                                    gradient: AppColors.appColor),
                                child: GestureDetector(
                                  //////////// Logn press ///////
                                  onLongPress: () {
                                    isDeleteSelected = true;
                                    print("you can long press");
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.all(4),
                                    child: Container(
                                      height: 210,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(13),
                                        image: _referUserModel!.data != null &&
                                                _referUserModel!.data![index]
                                                        .profileImage!.length >
                                                    0
                                            ? DecorationImage(
                                                image: NetworkImage(
                                                    _referUserModel!
                                                        .data![index]
                                                        .profileImage![0]
                                                        .filePath
                                                        .toString()),
                                                fit: BoxFit.cover)
                                            : DecorationImage(
                                                fit: BoxFit.cover,
                                                image: AssetImage(
                                                  ImagePath.likeimage1,
                                                ),
                                              ),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          /* Icon(
                                            Icons.check_box,
                                            color: Colors.red,
                                          ), */
                                          Spacer(),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Color(0xffffffff)
                                                    .withOpacity(0.9),
                                                borderRadius: BorderRadius.only(
                                                  bottomRight:
                                                      Radius.circular(13),
                                                  bottomLeft:
                                                      Radius.circular(13),
                                                ),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8, right: 14, top: 5),
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Image.asset(
                                                          ImagePath.dualprofile,
                                                          height: 16,
                                                          width: 16,
                                                        ),
                                                        SizedBox(
                                                          width: 5,
                                                        ),
                                                        Text(
                                                          _referUserModel !=
                                                                      null &&
                                                                  _referUserModel!
                                                                      .data!
                                                                      .isNotEmpty
                                                              ? _referUserModel!
                                                                  .data![index]
                                                                  .firstname
                                                                  .toString()
                                                              : "",
                                                          style: fontStyle
                                                              .copyWith(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 15,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          _referUserModel !=
                                                                      null &&
                                                                  _referUserModel!
                                                                      .data!
                                                                      .isNotEmpty
                                                              ? _referUserModel!
                                                                  .data![index]
                                                                  .caste
                                                                  .toString()
                                                              : "",
                                                          style: matchscroll
                                                              .copyWith(
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  color: Colors
                                                                      .black),
                                                        ),
                                                        Text(
                                                          "|",
                                                          style: matchscroll
                                                              .copyWith(
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  color: Colors
                                                                      .black),
                                                        ),
                                                        Text(
                                                          _referUserModel !=
                                                                      null &&
                                                                  _referUserModel!
                                                                      .data!
                                                                      .isNotEmpty
                                                              ? _referUserModel!
                                                                  .data![index]
                                                                  .age
                                                                  .toString()
                                                              : "",
                                                          style: matchscroll
                                                              .copyWith(
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  color: Colors
                                                                      .black),
                                                        )
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 5,
                                                              right: 0,
                                                              bottom: 5),
                                                      child: GestureDetector(
                                                        onTap: () {},
                                                        child: Container(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          height: 25,
                                                          decoration: BoxDecoration(
                                                              color: Color(
                                                                  0xffFB5A57),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          9)),
                                                          alignment:
                                                              Alignment.center,
                                                          child: Text(
                                                            'Message',
                                                            style: appBtnStyle
                                                                .copyWith(
                                                                    fontSize:
                                                                        12,
                                                                    color: Colors
                                                                        .white),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          )
                       */
                        : Container(),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: Text(
                      AppConstants.matchingProfileOther,
                      style: matchscroll.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: Color(0xff101620),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 17.0,
                        mainAxisSpacing: 10.0,
                        mainAxisExtent: 220,
                      ),
                      itemCount: matchProfileFromMyOther.length,
                      itemBuilder: (context, index) {
                        return Container(
                          height: 210,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(18),
                              gradient: AppColors.appColor),
                          child: Padding(
                            padding: EdgeInsets.all(4),
                            child: Container(
                              height: 210,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(13),
                                image: DecorationImage(
                                    image: AssetImage(
                                        matchProfileFromMyOther[index]),
                                    fit: BoxFit.cover),
                              ),
                              child: Column(
                                children: [
                                  Spacer(),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color:
                                            Color(0xffffffff).withOpacity(0.5),
                                        borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(13),
                                          bottomLeft: Radius.circular(13),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8, right: 14, top: 5),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Container(
                                                  height: 16,
                                                  width: 16,
                                                ),
                                                SizedBox(width: 5),
                                                Text(
                                                  AppConstants.joseph,
                                                  style: fontStyle.copyWith(
                                                      color: Colors.black,
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              AppConstants.castText,
                                              style: matchscroll.copyWith(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.black),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Row(
                                              children: [
                                                SizedBox(width: 3),
                                                Image.asset(
                                                  ImagePath.dualprofile,
                                                  height: 12,
                                                  width: 12,
                                                ),
                                                SizedBox(width: 3),
                                                Expanded(
                                                  child: Text(
                                                    AppConstants.addthisProfile,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 2,
                                                    style:
                                                        headingStyle2.copyWith(
                                                            color: Color(
                                                                0xff161616),
                                                            fontSize: 10,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                  ),
                                                ),
                                                SizedBox(width: 3),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 5, right: 0, bottom: 5),
                                              child: GestureDetector(
                                                onTap: () {},
                                                child: Container(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  height: 25,
                                                  decoration: BoxDecoration(
                                                      color: Color(0xffFB5A57),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              9)),
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    'Message',
                                                    style: appBtnStyle.copyWith(
                                                        fontSize: 12,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                            ),
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
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: Text(
                      AppConstants.matchingProfileMangalKaryam,
                      style: matchscroll.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: Color(0xff101620),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    height: 150,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: matchingProfile.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: GestureDetector(
                            child: Container(
                              height: 150,
                              width: 150,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  image: AssetImage(matchingProfile[index]),
                                  fit: BoxFit.fill,
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 5),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 12, right: 12),
                                    child: Align(
                                      alignment: Alignment.topRight,
                                      child: Container(
                                        height: 18,
                                        width: 54,
                                        alignment: Alignment.topRight,
                                        decoration: BoxDecoration(
                                            color: Color(0xff000000)
                                                .withOpacity(.30),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Center(
                                          child: Text(
                                            AppConstants.milesText,
                                            style: TextStyle(
                                                color: AppColors.colorWhite,
                                                fontSize: 10,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text(
                                      AppConstants.joseph,
                                      textAlign: TextAlign.start,
                                      style: gridscroll.copyWith(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white),
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: Text(AppConstants.likedByJames,
                        style: matchscroll.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            color: Color(0xff101620))),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 17.0,
                        mainAxisSpacing: 10.0,
                        mainAxisExtent: 220,
                      ),
                      itemCount: likedByJames.length,
                      itemBuilder: (context, index) {
                        return Container(
                          height: 210,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(18),
                              gradient: AppColors.appColor),
                          child: Padding(
                            padding: EdgeInsets.all(4),
                            child: Container(
                              height: 210,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(13),
                                image: DecorationImage(
                                    image: AssetImage(likedByJames[index]),
                                    fit: BoxFit.cover),
                              ),
                              child: Column(
                                children: [
                                  Spacer(),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color:
                                            Color(0xffffffff).withOpacity(0.5),
                                        borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(13),
                                          bottomLeft: Radius.circular(13),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8, right: 14, top: 5),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Image.asset(
                                                  ImagePath.dualprofile,
                                                  height: 16,
                                                  width: 16,
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  AppConstants.joseph,
                                                  style: fontStyle.copyWith(
                                                      color: Colors.black,
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              AppConstants.castText,
                                              style: matchscroll.copyWith(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.black),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 5, right: 0, bottom: 5),
                                              child: GestureDetector(
                                                onTap: () {},
                                                child: Container(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  height: 25,
                                                  decoration: BoxDecoration(
                                                      color: Color(0xffFB5A57),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              9)),
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    'Message',
                                                    style: appBtnStyle.copyWith(
                                                        fontSize: 12,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                            ),
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
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: Text(AppConstants.inProgressText,
                        style: matchscroll.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            color: Color(0xff101620))),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 17.0,
                        mainAxisSpacing: 10.0,
                        mainAxisExtent: 220,
                      ),
                      itemCount: inProgress.length,
                      itemBuilder: (context, index) {
                        return Container(
                          height: 210,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(18),
                              gradient: AppColors.appColor),
                          child: Padding(
                            padding: EdgeInsets.all(4),
                            child: Container(
                              height: 210,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(13),
                                image: DecorationImage(
                                    image: AssetImage(inProgress[index]),
                                    fit: BoxFit.cover),
                              ),
                              child: Column(
                                children: [
                                  SizedBox(height: 8),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(width: 8),
                                      Image.asset(
                                        ImagePath.inProgressDelete,
                                        height: 22,
                                        width: 22,
                                      ),
                                    ],
                                  ),
                                  Spacer(),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color:
                                            Color(0xffffffff).withOpacity(0.5),
                                        borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(13),
                                          bottomLeft: Radius.circular(13),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8, right: 14, top: 5),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Image.asset(
                                                  ImagePath.dualprofile,
                                                  height: 16,
                                                  width: 16,
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  AppConstants.joseph,
                                                  style: fontStyle.copyWith(
                                                      color: Colors.black,
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              AppConstants.castText,
                                              style: matchscroll.copyWith(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.black),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 5, right: 0, bottom: 5),
                                              child: GestureDetector(
                                                onTap: () {},
                                                child: Container(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  height: 25,
                                                  decoration: BoxDecoration(
                                                      color: Color(0xffFB5A57),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              9)),
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    'Message',
                                                    style: appBtnStyle.copyWith(
                                                        fontSize: 12,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                            ),
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
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  checkConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      getreferUser();
    } else if (connectivityResult == ConnectivityResult.wifi) {
      getreferUser();
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

  getreferUser() async {
    log("user candidate id :: ${widget.candidateId}");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var authToken = prefs.getString(EXE_TOKEN);
    // CommonUtils.showProgressLoading(context);
    final queryParameters = {"token": authToken, "user_id": widget.candidateId};
    String queryString = Uri(queryParameters: queryParameters).query;

    var response = await http.get(
      Uri.parse(GET_REFER_USER_URL + "?" + queryString),
    );

    if (response.statusCode == 200) {
      // CommonUtils.hideProgressLoading();
      if (mounted) {
        setState(() {
          _referUserModel = ReferUserModel.fromJson(jsonDecode(response.body));
          // log("condition ${_allExecutiveCandidates_Model!.data![0].userId}");
        });
      }
    } else if (response.statusCode == 500) {
      // CommonUtils.hideProgressLoading();
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

  getUserPreference() async {
    log("user candidate id :: ${widget.candidateId}");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var authToken = prefs.getString(EXE_TOKEN);
    // CommonUtils.showProgressLoading(context);
    final queryParameters = {"token": authToken, "user_id": widget.candidateId};
    String queryString = Uri(queryParameters: queryParameters).query;

    var response = await http.get(
      Uri.parse(GET_USER_LOOKING_FOR_URL + "?" + queryString),
    );

    if (response.statusCode == 200) {
      // CommonUtils.hideProgressLoading();
      if (mounted) {
        setState(() {
          _userLookinForExeModel =
              UserLookinForExeModel.fromJson(jsonDecode(response.body));
          // log("condition ${_allExecutiveCandidates_Model!.data![0].userId}");
        });
      }
    } else if (response.statusCode == 500) {
      // CommonUtils.hideProgressLoading();
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

  _appBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: Padding(
        padding: const EdgeInsets.only(left: 16),
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                width: 40,
                height: 40,
                child: Center(
                  child: Image.asset(
                    ImagePath.leftArrow,
                    height: 28,
                    width: 28,
                    color: Color(0xff2C3E50),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              ImagePath.location,
              width: 24,
              height: 24,
            ),
          ),
          const Text(
            AppConstants.header,
            style: const TextStyle(color: AppColors.coffe),
          )
        ],
      ),
      actions: [
        GestureDetector(
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  addMatchmaking() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var authToken = prefs.getString(EXE_TOKEN);
    CommonUtils.showProgressLoading(context);
    final queryParameters = {"token": authToken};
    String queryString = Uri(queryParameters: queryParameters).query;

    String ids = deleteIdList.toString().replaceAll("[", "");
    String ids1 = ids.toString().removeAllWhitespace;
    String finalIds = ids1.toString().replaceAll("]", "");
    log("finalIds :: ${finalIds}");
    var params = {
      "matching_id": finalIds,
      "user_id": widget.candidateId.toString()
    };
    var response = await http.post(
      Uri.parse(ADD_MATCHMAKING_URL + "?" + queryString),
      body: params,
      // body: params,
    );
    log("response :::: ${response.statusCode.toString()}");
    log("response :::: ${response.body.toString()}");
    if (response.statusCode == 200) {
      setState(() {
        isDeleteSelected = false;
      });
      CommonUtils.hideProgressLoading();
      if (mounted) {
        Fluttertoast.showToast(
            msg: "Matching users successfully",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Color(0xffE16284),
            textColor: Colors.white,
            fontSize: 16.0);
      }
    } else if (response.statusCode == 500) {
      setState(() {
        isDeleteSelected = false;
      });
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
      setState(() {
        isDeleteSelected = false;
      });
      CommonUtils.hideProgressLoading();
      Fluttertoast.showToast(
          msg: "unknown error",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Color(0xffE16284),
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  getAllExeCandidate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var authToken = prefs.getString(EXE_TOKEN);
    CommonUtils.showProgressLoading(context);
    final queryParameters = {"token": authToken};
    String queryString = Uri(queryParameters: queryParameters).query;

    var response = await http.get(
      Uri.parse(GET_EXE_ALLCANDIDATES_URL + "?" + queryString),
    );

    if (response.statusCode == 200) {
      CommonUtils.hideProgressLoading();
      if (mounted) {
        setState(() {
          _allExecutiveCandidates_Model =
              AllExecutiveCandidates_Model.fromJson(jsonDecode(response.body));
          // log("condition ${_allExecutiveCandidates_Model!.data![0].userId}");
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
}
