import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:matrimonial_app/Core/Constant/CommonUtils.dart';
import 'package:matrimonial_app/Core/Constant/url_constant.dart';
import 'package:matrimonial_app/Core/Constant/value_constants.dart';
import 'package:matrimonial_app/Executive%20Ui/ProfileScreen/Update_Profile_Details.dart';
import 'package:matrimonial_app/ModelClass/Executive_ModelClass/Get_Profile_Model.dart';
import 'package:matrimonial_app/Utils/DropDownList.dart';
import 'package:matrimonial_app/Utils/app_constants.dart';
import 'package:matrimonial_app/Utils/color_constants.dart';
import 'package:matrimonial_app/Utils/image_path_constants.dart';
import 'package:matrimonial_app/Utils/text_styles.dart';
import 'package:matrimonial_app/Utils/value_constant.dart';
import 'package:matrimonial_app/widget/commondivider.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:matrimonial_app/ModelClass/UserPanel_ModelClass/DropDown_Datas/state_model.dart'
    as stateModel;
import 'package:url_launcher/url_launcher.dart';

import 'package:http/http.dart' as http;

class E_Executive_Profile extends StatefulWidget {
  const E_Executive_Profile({Key? key}) : super(key: key);

  @override
  State<E_Executive_Profile> createState() => _E_Executive_ProfileState();
}

final List<String> _selectedItems = [];

class _E_Executive_ProfileState extends State<E_Executive_Profile> {
  Dio dio = Dio();
  bool isSelf = false;
  GetExeProfileModel? _getExeProfileModel;
  List<String> addLanguage = [];
  List<String> _selectedItems = [];
  TextEditingController _textFieldController = TextEditingController();
  String? dropdowngender;
  String? dropdownlanguage;
  TextEditingController _aboutMeController = TextEditingController();
  stateModel.StateModel? _stateModel;
  stateModel.Data? _data;
  List<String> droplanguage = [AppConstants.hindi, AppConstants.english];
  List<String> genderdropdown = [AppConstants.girl, AppConstants.boy];
  bool isTextFieldEnable = true;
  List<Map<String, dynamic>> profilevisiter = [
    {
      IMAGE: ImagePath.profilevisitors_1,
      NAME: AppConstants.isaiah,
    },
    {
      IMAGE: ImagePath.profilevisitors_2,
      NAME: AppConstants.ethel,
    },
    {
      IMAGE: ImagePath.profilevisitors_3,
      NAME: AppConstants.hayden,
    },
    {
      IMAGE: ImagePath.profilevisitors_4,
      NAME: AppConstants.hunter,
    },
    {
      IMAGE: ImagePath.profilevisitors_5,
      NAME: AppConstants.hunter,
    },
  ];
  List<String> portfolio = [
    "assets/images/portfolio_1.png",
    "assets/images/portfolio_2.png",
    "assets/images/portfolio_3.png",
    "assets/images/portfolio_1.png",
    "assets/images/portfolio_3.png",
    "assets/images/portfolio_2.png",
  ];
  void _showMultiSelect() async {
    final List<String> _items = [
      'Gujarati',
      'Hindi',
      'English',
      'German',
      'Romanian',
      'Spanish',
      'Italian',
      'Korean',
      'French'
    ];

    final List<String>? results = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return MultiSelect(items: _items);
      },
    );

    if (results != null) {
      setState(() {
        _selectedItems = results;
      });
    }
  }

  bool _showPreview = false;
  String _image = "assets/images/portfolio_1.png";

  List<Map<String, dynamic>> reviewdetail = [
    {
      IMAGE: ImagePath.review_1,
      NAME: AppConstants.miaSmith,
      MAIL: AppConstants.reviewEmail,
      RATING: ImagePath.rating_1,
      RAT: AppConstants.rating1,
      DETAIL: AppConstants.reviewDetails,
    },
    {
      IMAGE: ImagePath.review_2,
      NAME: AppConstants.miaSmith,
      MAIL: AppConstants.reviewEmail,
      RATING: ImagePath.rating_2,
      RAT: AppConstants.rating2,
      DETAIL: AppConstants.reviewDetails,
    },
  ];

  @override
  void initState() {
    super.initState();
    checkConnection();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    height: 232,
                    width: MediaQuery.of(context).size.width * 4,
                    decoration: (_getExeProfileModel != null &&
                            _getExeProfileModel!.data != null &&
                            _getExeProfileModel!.data!.coverImage!.length > 0)
                        ? BoxDecoration(
                            image: DecorationImage(
                                image: CachedNetworkImageProvider(
                                  _getExeProfileModel!
                                      .data!.coverImage![0].filePath
                                      .toString(),
                                ),
                                fit: BoxFit.fill),
                          )
                        : BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                  ImagePath.executiveBackground,
                                ),
                                fit: BoxFit.fill),
                          ),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(16, 20, 16, 0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Image.asset(ImagePath.leftArrow,
                                  height: 28, width: 28)),
                          Spacer(),
                          Text(
                            AppConstants.profile,
                            style: headingStyle.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(width: 25),
                          Spacer(),
                        ],
                      ),
                    ),
                  ),
                  Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 200),
                        child: Container(
                          height: 100,
                          width: MediaQuery.of(context).size.width * 4,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(0),
                              topRight: Radius.circular(0),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(0, 7, 16, 0),
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.topRight,
                                  child: Container(
                                    height: 45,
                                    width: 45,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Color(0xffE6E6E6),
                                      ),
                                    ),
                                    child: Center(
                                        child: Image.asset(ImagePath.share,
                                            height: 25, width: 25)),
                                  ),
                                ),
                                Text(
                                  _getExeProfileModel != null &&
                                          _getExeProfileModel!.data != null
                                      ? _getExeProfileModel!.data!.firstname
                                              .toString() +
                                          " " +
                                          _getExeProfileModel!.data!.lastname
                                              .toString()
                                      : AppConstants.elonMusk,
                                  style: headingStyle,
                                ),
                                Text(
                                  _getExeProfileModel != null &&
                                          _getExeProfileModel!.data != null
                                      ? _getExeProfileModel!.data!.email
                                          .toString()
                                      : AppConstants.elonMuskUserName,
                                  style: headingStyle.copyWith(
                                      color: AppColors.grey,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      /* Positioned(
                        bottom: 55,
                        child: CircularPercentIndicator(
                          backgroundColor: Color(0xffEAEAEA),
                          animation: true,
                          animationDuration: 100,
                          radius: 55.0,
                          lineWidth: 6.0,
                          percent: 0.2,
                          startAngle: 150.0,
                          center: (_getExeProfileModel != null &&
                                  _getExeProfileModel!.data != null &&
                                  _getExeProfileModel!
                                          .data!.profileImage!.length >
                                      0)
                              ? Container(
                                  height: 98,
                                  width: 98,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        image: CachedNetworkImageProvider(
                                          _getExeProfileModel!
                                              .data!.profileImage![0].filePath
                                              .toString(),
                                        ),
                                        fit: BoxFit.fill),
                                  ),
                                )
                              : Container(
                                  height: 98,
                                  width: 98,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: Image.asset(ImagePath.eProfileImage,fit: BoxFit.fill),
                                ),
                          progressColor: Color(0xffFB5A57),
                          animateFromLastPercent: true,
                          circularStrokeCap: CircularStrokeCap.round,
                        ),

                        /* (_getExeProfileModel != null &&
                                _getExeProfileModel!.data != null &&
                                _getExeProfileModel!
                                        .data!.profileImage!.length >
                                    0)
                            ? Container(
                                height: 105,
                                width: 105,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white),
                                alignment: Alignment.center,
                                child: Container(
                                  height: 98,
                                  width: 98,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        image: CachedNetworkImageProvider(
                                          _getExeProfileModel!
                                              .data!.profileImage![0].filePath
                                              .toString(),
                                        ),
                                        fit: BoxFit.fill),
                                  ),
                                ),
                              )
                            : Container(
                                height: 98,
                                width: 98,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                child: Image.asset(ImagePath.profileimage),
                              ), */
                      ),
                    */
                      Positioned(
                        bottom: 55,
                        child:
                            Stack(alignment: Alignment.bottomCenter, children: [
                          Column(
                            children: [
                              CircularPercentIndicator(
                                backgroundColor: Color(0xffEAEAEA),
                                animation: true,
                                animationDuration: 100,
                                radius: 55.0,
                                lineWidth: 6.0,
                                percent: 0.2,
                                startAngle: 150.0,
                                center: (_getExeProfileModel != null &&
                                        _getExeProfileModel!.data != null &&
                                        _getExeProfileModel!
                                                .data!.profileImage!.length >
                                            0)
                                    ? Container(
                                        height: 105,
                                        width: 105,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.white),
                                        alignment: Alignment.center,
                                        child: Container(
                                          height: 98,
                                          width: 98,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                                image:
                                                    CachedNetworkImageProvider(
                                                  _getExeProfileModel!.data!
                                                      .profileImage![0].filePath
                                                      .toString(),
                                                ),
                                                fit: BoxFit.fill),
                                          ),
                                        ),
                                      )
                                    : Container(
                                        height: 98,
                                        width: 98,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                        ),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          child: (_getExeProfileModel != null &&
                                                  _getExeProfileModel!.data !=
                                                      null &&
                                                  _getExeProfileModel!
                                                          .data!.gender ==
                                                      "Male")
                                              ? Image.asset(
                                                  ImagePath.maleProfile)
                                              : Image.asset(
                                                  ImagePath.femaleProfile),
                                        )),
                                progressColor: Color(0xffFB5A57),
                                animateFromLastPercent: true,
                                circularStrokeCap: CircularStrokeCap.round,
                              ),
                            ],
                          ),
                          Positioned(
                            bottom: -6,
                            left: 70,
                            child: GestureDetector(
                              onTap: () {
                                showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                    title:
                                        Center(child: const Text('Pick Image')),
                                    actions: <Widget>[
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          TextButton(
                                            onPressed: () async {},
                                            child: const Text('Gallery'),
                                          ),
                                          TextButton(
                                            onPressed: () async {},
                                            child: Text('Camera'),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              },
                              child: Container(
                                child: Image.asset(
                                  ImagePath.editprofile,
                                  width: 35,
                                  height: 35,
                                ),
                              ),
                            ),
                          )
                        ]),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: (() {
                          setState(() {
                            _openFacebook();
                          });
                        }),
                        child: Container(
                          color: Colors.transparent,
                          child: Column(
                            children: [
                              Image.asset(
                                ImagePath.profileFacebookNew,
                                width: 28,
                                height: 22,
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              _fbconnectbutton()
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: (() {
                          setState(() {
                            _launchInstagram();
                          });
                        }),
                        child: Container(
                          color: Colors.transparent,
                          child: Column(
                            children: [
                              Image.asset(
                                ImagePath.profileInstaNew,
                                width: 28,
                                height: 22,
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              _instaconnectbutton()
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: (() {
                          setState(() {
                            openTwitter();
                          });
                        }),
                        child: Container(
                          color: Colors.transparent,
                          child: Column(
                            children: [
                              Image.asset(
                                ImagePath.profiletwitter,
                                width: 28,
                                height: 22,
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              _twitterconnectbutton()
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 15),
              Common_divider(),
              SizedBox(height: 15),
              Padding(
                padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppConstants.aboutMe,
                      style: headingStyle.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    (isSelf == true)
                        ? GestureDetector(
                            onTap: () {
                              isSelf = false;
                              setState(() {});
                            },
                            child: Container(
                              width: 50,
                              height: 20,
                              decoration: BoxDecoration(
                                  gradient: AppColors.appColor,
                                  borderRadius: BorderRadius.circular(5)),
                              alignment: Alignment.center,
                              child: Text(
                                'Save',
                                style: appBtnStyle.copyWith(fontSize: 14),
                              ),
                            ),
                          )
                        : GestureDetector(
                            onTap: () {
                              setState(() {
                                isSelf = true;
                                if (isSelf == true) {
                                  _aboutMeController.text =
                                      AppConstants.aboutMeText;
                                }
                              });
                            },
                            child: Image.asset(
                              ImagePath.editprofile,
                              width: 30,
                              height: 30,
                            ),
                          ),
                  ],
                ),
              ),
              SizedBox(height: 15),
              Padding(
                  padding: EdgeInsets.fromLTRB(16, 0, 0, 0),
                  child: isSelf == true
                      ? TextFormField(
                          textCapitalization: TextCapitalization.sentences,
                          controller: _aboutMeController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          )),
                          onFieldSubmitted: (value) {
                            print(value);
                            setState(() {});
                          },
                        )
                      : Text(
                          AppConstants.aboutMeText,
                          style: description1,
                        )),
              SizedBox(height: 10),
              Common_divider(),
              Padding(
                padding: EdgeInsets.fromLTRB(16, 16, 16, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppConstants.portFolio,
                      style: headingStyle.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Spacer(),
                    Text(
                      AppConstants.addMore,
                      style: headingStyle.copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: AppColors.green,
                      ),
                    ),
                    SizedBox(width: 5),
                    Image.asset(ImagePath.seemoreimage, height: 8, width: 5),
                  ],
                ),
              ),
              Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                    child: GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisExtent: 115,
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 5),
                      itemCount: portfolio.length,
                      itemBuilder: (BuildContext ctx, index) {
                        return ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: index == 0
                                ? Radius.circular(10)
                                : Radius.circular(0),
                            topRight: index == 2
                                ? Radius.circular(10)
                                : Radius.circular(0),
                            bottomLeft: index == 3
                                ? Radius.circular(10)
                                : Radius.circular(0),
                            bottomRight: index == 5
                                ? Radius.circular(10)
                                : Radius.circular(0),
                          ),
                          child: GestureDetector(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (_) => new Dialog(
                                        backgroundColor: Colors.transparent,
                                        child: new Container(
                                            alignment: FractionalOffset.center,
                                            height: height * 0.5,
                                            width: width,
                                            padding: EdgeInsets.all(0.0),
                                            child: Container(
                                              child: Image.asset(
                                                portfolio[index],
                                                fit: BoxFit.cover,
                                              ),
                                            )),
                                      ));
                            },
                            child: Image.asset(
                              portfolio[index],
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  if (_showPreview) ...[
                    BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaX: 5.0,
                        sigmaY: 5.0,
                      ),
                      child: Container(
                        color: Colors.white.withOpacity(0.6),
                      ),
                    ),
                    Container(
                      child: Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image.asset(
                            _image,
                            height: 300,
                            width: 300,
                          ),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
              SizedBox(height: 15),
              // Common_divider(),
              /* SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                child: Text(
                  AppConstants.languageKnown,
                  style: headingStyle.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                child: Wrap(
                  children: _selectedItems
                      .map((e) => Chip(
                            label: Text(e),
                          ))
                      .toList(),
                ),
              ),
              SizedBox(height: 12),
              InkWell(
                onTap: () {
                  _showMultiSelect();
                },
                child: Padding(
                  padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                  child: Container(
                    height: 30,
                    width: 150,
                    child: DottedBorder(
                        dashPattern: [3, 3],
                        radius: Radius.circular(10),
                        strokeWidth: 0,
                        strokeCap: StrokeCap.butt,
                        child: Center(
                            child: Text(
                          'Add language',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ))),
                  ),
                ),
              ), */
              Container(
                width: width,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 6, right: 6, top: 0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.grey.withOpacity(0.1),
                        ),
                        width: width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 5.0),
                              child: Text(
                                "Profile Details",
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold),
                              ),
                            ),
                            GestureDetector(
                              onTap: () async {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            UpdateProfileDetails()));
                              },
                              child: Padding(
                                padding: EdgeInsets.only(top: 8.0),
                                child: Image.asset(
                                  ImagePath.editprofile,
                                  width: 30,
                                  height: 30,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 8.0, right: 8, top: 5),
                      child: Container(
                        color: Colors.white,
                        padding: EdgeInsets.only(bottom: 10, top: 10),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 5),
                              child: Row(
                                children: [
                                  Container(
                                    width: width / 2 - 10,
                                    child: Text(
                                      "Full Name",
                                      style: TextStyle(
                                        color: Color(
                                          0xff838994,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Text(':'),
                                  Container(
                                    width: width / 2 - 10,
                                    child: Text(
                                      _getExeProfileModel != null &&
                                              _getExeProfileModel!.data !=
                                                  null &&
                                              _getExeProfileModel!
                                                      .data!.firstname !=
                                                  null
                                          ? " " +
                                              _getExeProfileModel!
                                                  .data!.firstname
                                                  .toString() +
                                              " " +
                                              _getExeProfileModel!
                                                  .data!.lastname
                                                  .toString()
                                          : " N/A",
                                      style: TextStyle(height: 1.5),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 5),
                              child: Row(
                                children: [
                                  Container(
                                    width: width / 2 - 10,
                                    child: Text(
                                      "Mobile Number",
                                      style: TextStyle(
                                        color: Color(
                                          0xff838994,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Text(':'),
                                  Container(
                                    width: width / 2 - 10,
                                    child: Text(
                                      _getExeProfileModel != null &&
                                              _getExeProfileModel!.data !=
                                                  null &&
                                              _getExeProfileModel!
                                                      .data!.mobile !=
                                                  null
                                          ? " " +
                                              _getExeProfileModel!.data!.mobile
                                                  .toString()
                                          : " N/A",
                                      style: TextStyle(height: 1.5),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 5),
                              child: Row(
                                children: [
                                  Container(
                                    width: width / 2 - 10,
                                    child: Text(
                                      "Email Address",
                                      style: TextStyle(
                                        color: Color(
                                          0xff838994,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Text(':'),
                                  Container(
                                    width: width / 2 - 10,
                                    child: Text(
                                      _getExeProfileModel != null &&
                                              _getExeProfileModel!.data !=
                                                  null &&
                                              _getExeProfileModel!
                                                      .data!.email !=
                                                  null
                                          ? " " +
                                              _getExeProfileModel!.data!.email
                                                  .toString()
                                                  .toString()
                                          : " N/A",
                                      style: TextStyle(height: 1.5),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 5),
                              child: Row(
                                children: [
                                  Container(
                                    width: width / 2 - 10,
                                    child: Text(
                                      "Date of Birth",
                                      style: TextStyle(
                                        color: Color(
                                          0xff838994,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Text(':'),
                                  Container(
                                    width: width / 2 - 10,
                                    child: Text(
                                      _getExeProfileModel != null &&
                                              _getExeProfileModel!.data !=
                                                  null &&
                                              _getExeProfileModel!.data!.dob !=
                                                  null
                                          ? " " +
                                              _getExeProfileModel!.data!.dob
                                                  .toString()
                                          : " N/A",
                                      style: TextStyle(height: 1.5),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 5),
                              child: Row(
                                children: [
                                  Container(
                                    width: width / 2 - 10,
                                    child: Text(
                                      "Gender",
                                      style: TextStyle(
                                        color: Color(
                                          0xff838994,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Text(':'),
                                  Container(
                                    width: width / 2 - 10,
                                    child: Text(
                                      _getExeProfileModel != null &&
                                              _getExeProfileModel!.data !=
                                                  null &&
                                              _getExeProfileModel!
                                                      .data!.gender !=
                                                  null
                                          ? " " +
                                              _getExeProfileModel!.data!.gender
                                                  .toString()
                                          : " N/A",
                                      style: TextStyle(height: 1.5),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 5),
                              child: Row(
                                children: [
                                  Container(
                                    width: width / 2 - 10,
                                    child: Text(
                                      "Profession",
                                      style: TextStyle(
                                        color: Color(
                                          0xff838994,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Text(':'),
                                  Container(
                                    width: width / 2 - 10,
                                    child: Text(
                                      _getExeProfileModel != null &&
                                              _getExeProfileModel!.data !=
                                                  null &&
                                              _getExeProfileModel!
                                                      .data!.profession !=
                                                  null
                                          ? " " +
                                              _getExeProfileModel!
                                                  .data!.profession
                                                  .toString()
                                          : " N/A",
                                      style: TextStyle(height: 1.5),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 5),
                              child: Row(
                                children: [
                                  Container(
                                    width: width / 2 - 10,
                                    child: Text(
                                      "Subprofession",
                                      style: TextStyle(
                                        color: Color(
                                          0xff838994,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Text(':'),
                                  Container(
                                    width: width / 2 - 10,
                                    child: Text(
                                      _getExeProfileModel != null &&
                                              _getExeProfileModel!.data !=
                                                  null &&
                                              _getExeProfileModel!
                                                      .data!.subprofession !=
                                                  null
                                          ? " " +
                                              _getExeProfileModel!
                                                  .data!.subprofession
                                                  .toString()
                                          : " N/A",
                                      style: TextStyle(height: 1.5),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 5),
                              child: Row(
                                children: [
                                  Container(
                                    width: width / 2 - 10,
                                    child: Text(
                                      "Work with",
                                      style: TextStyle(
                                        color: Color(
                                          0xff838994,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Text(':'),
                                  Container(
                                    width: width / 2 - 10,
                                    child: Text(
                                      _getExeProfileModel != null &&
                                              _getExeProfileModel!.data !=
                                                  null &&
                                              _getExeProfileModel!
                                                      .data!.workWith !=
                                                  null
                                          ? " " +
                                              _getExeProfileModel!
                                                  .data!.workWith
                                                  .toString()
                                          : " N/A",
                                      style: TextStyle(height: 1.5),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 5),
                              child: Row(
                                children: [
                                  Container(
                                    width: width / 2 - 10,
                                    child: Text(
                                      "Inital Fees",
                                      style: TextStyle(
                                        color: Color(
                                          0xff838994,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Text(':'),
                                  Container(
                                    width: width / 2 - 10,
                                    child: Text(
                                      " N/A",
                                      style: TextStyle(height: 1.5),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 5),
                              child: Row(
                                children: [
                                  Container(
                                    width: width / 2 - 10,
                                    child: Text(
                                      "Final Fees",
                                      style: TextStyle(
                                        color: Color(
                                          0xff838994,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Text(':'),
                                  Container(
                                    width: width / 2 - 10,
                                    child: Text(
                                      " N/A",
                                      style: TextStyle(height: 1.5),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 5),
                              child: Row(
                                children: [
                                  Container(
                                    width: width / 2 - 10,
                                    child: Text(
                                      "District",
                                      style: TextStyle(
                                        color: Color(
                                          0xff838994,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Text(':'),
                                  Container(
                                    width: width / 2 - 10,
                                    child: Text(
                                      _getExeProfileModel != null &&
                                              _getExeProfileModel!.data !=
                                                  null &&
                                              _getExeProfileModel!
                                                      .data!.distict !=
                                                  null
                                          ? " " +
                                              _getExeProfileModel!.data!.distict
                                                  .toString()
                                          : " N/A",
                                      style: TextStyle(height: 1.5),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 5),
                              child: Row(
                                children: [
                                  Container(
                                    width: width / 2 - 10,
                                    child: Text(
                                      "State",
                                      style: TextStyle(
                                        color: Color(
                                          0xff838994,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Text(':'),
                                  Container(
                                    width: width / 2 - 10,
                                    child: Text(
                                      _getExeProfileModel != null &&
                                              _getExeProfileModel!.data !=
                                                  null &&
                                              _getExeProfileModel!
                                                      .data!.state !=
                                                  null
                                          ? " " +
                                              _getExeProfileModel!.data!.state
                                                  .toString()
                                          : " N/A",
                                      style: TextStyle(height: 1.5),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 5),
                              child: Row(
                                children: [
                                  Container(
                                    width: width / 2 - 10,
                                    child: Text(
                                      "Pincode",
                                      style: TextStyle(
                                        color: Color(
                                          0xff838994,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Text(':'),
                                  Container(
                                    width: width / 2 - 10,
                                    child: Text(
                                      _getExeProfileModel != null &&
                                              _getExeProfileModel!.data !=
                                                  null &&
                                              _getExeProfileModel!
                                                      .data!.pincode !=
                                                  null
                                          ? " " +
                                              _getExeProfileModel!.data!.pincode
                                                  .toString()
                                          : " N/A",
                                      style: TextStyle(height: 1.5),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 5),
                              child: Row(
                                children: [
                                  Container(
                                    width: width / 2 - 10,
                                    child: Text(
                                      "Language Known",
                                      style: TextStyle(
                                        color: Color(
                                          0xff838994,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Text(':'),
                                  Container(
                                    width: width / 2 - 10,
                                    child: Text(
                                      " N/A",
                                      style: TextStyle(height: 1.5),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              /* Padding(
                padding: EdgeInsets.only(left: 16, right: 16),
                child: SingleChildScrollView(
                  physics: NeverScrollableScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        scrollPhysics: NeverScrollableScrollPhysics(),
                        controller: _textFieldController,
                        readOnly: true,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: _getExeProfileModel != null &&
                                  _getExeProfileModel!.data != null
                              ? _getExeProfileModel!.data!.firstname
                                      .toString() +
                                  " " +
                                  _getExeProfileModel!.data!.lastname.toString()
                              : "Sara Williamson",
                          hintStyle: TextStyle(
                              color: Color(
                                0xff333F52,
                              ),
                              fontWeight: FontWeight.w500,
                              fontSize: 17),
                          labelText: 'Full Name',
                          labelStyle: TextStyle(
                            color: Color(0xff838994),
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      Container(
                        height: 2,
                        color: Color(0xffE4E7F1),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Mobile Number',
                            style: TextStyle(
                              color: Color(0xff838994),
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                            ),
                          ),
                          Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                  color: Color(0xffE4E7F1),
                                ))),
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 8),
                                  child: CountryCodePicker(
                                    padding: EdgeInsets.zero,
                                    onChanged: print,
                                    initialSelection: 'IN',
                                    showCountryOnly: false,
                                    showOnlyCountryWhenClosed: false,
                                    alignLeft: false,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 20),
                                  child: Container(
                                    child: TextField(
                                      keyboardType: TextInputType.number,
                                      readOnly: true,
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(10)
                                      ],
                                      decoration: InputDecoration(
                                        hintText: _getExeProfileModel != null &&
                                                _getExeProfileModel!.data !=
                                                    null
                                            ? _getExeProfileModel!.data!.mobile
                                            : '',
                                        hintStyle: TextStyle(
                                            color: Color(
                                              0xff333F52,
                                            ),
                                            fontWeight: FontWeight.w500,
                                            fontSize: 18),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                      TextField(
                        readOnly: true,
                        keyboardType: TextInputType.number,
                        inputFormatters: [LengthLimitingTextInputFormatter(6)],
                        decoration: InputDecoration(
                          hintText: _getExeProfileModel != null &&
                                  _getExeProfileModel!.data != null
                              ? _getExeProfileModel!.data!.email
                              : '',
                          hintStyle: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                              fontSize: 17),
                          labelText: 'Email Address',
                          labelStyle: TextStyle(
                            color: Color(0xff838994),
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      TextField(
                        readOnly: true,
                        decoration: InputDecoration(
                          hintText: 'Manhattan Lower, NY, 13655',
                          hintStyle: TextStyle(
                            color: Color(
                              0xff333F52,
                            ),
                            fontWeight: FontWeight.w500,
                            fontSize: 17,
                          ),
                          labelText: 'Address',
                          labelStyle: TextStyle(
                            color: Color(0xff838994),
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 163,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'District',
                                  style: TextStyle(
                                    color: Color(0xff838994),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  width: 164,
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton2<String>(
                                      dropdownDecoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(13),
                                      ),
                                      icon: Container(
                                        height: 24,
                                        width: 19,
                                        child: Image.asset(
                                          ImagePath.downarrow,
                                          height: 24,
                                          width: 19,
                                        ),
                                      ),
                                      hint: Text('Select District'),
                                      dropdownMaxHeight: 200,
                                      itemHeight: 20,
                                      customItemsHeight: 20,
                                      items:
                                          _addDividersAfterItems(districtList),
                                      customItemsIndexes: _getDividersIndexes(),
                                      value: district,
                                      onChanged: (newValue) {
                                        print(newValue);
                                        setState(() {
                                          district = newValue;
                                        });
                                      },
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Container(
                            width: 160,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'State',
                                  style: TextStyle(
                                    color: Color(0xff838994),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  width: 163,
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton2<stateModel.Data>(
                                      dropdownDecoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(13),
                                      ),
                                      icon: Container(
                                        height: 24,
                                        width: 19,
                                        child: Image.asset(
                                          ImagePath.downarrow,
                                          height: 24,
                                          width: 19,
                                        ),
                                      ),
                                      hint: Text('Pune'),
                                      dropdownMaxHeight: 200,
                                      itemHeight: 20,
                                      items: addDividersAfterItemsStateModel(
                                          (_stateModel != null)
                                              ? _stateModel!.data!
                                              : []),
                                      customItemsIndexes: getDividersIndexes(
                                          (_stateModel != null)
                                              ? _stateModel!.data!
                                              : []),
                                      value: _data,
                                      onChanged: (newValue) {
                                        print(newValue);
                                        setState(() {
                                          _data = newValue;
                                        });
                                      },
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            height: 2,
                            width: 160,
                            color: Color(0xffE4E7F1),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Container(
                            height: 2,
                            width: 160,
                            color: Color(0xffE4E7F1),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 163,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Religion',
                                  style: TextStyle(
                                    color: Color(0xff838994),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                  ),
                                ),
                                Container(
                                  width: 163,
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton2(
                                      dropdownDecoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(13),
                                      ),
                                      icon: Container(
                                        height: 24,
                                        width: 19,
                                        child: Image.asset(
                                          ImagePath.downarrow,
                                          height: 24,
                                          width: 19,
                                        ),
                                      ),
                                      hint: Text('Hindi'),
                                      dropdownMaxHeight: 200,
                                      itemHeight: 20,
                                      items: getDropdown()
                                          .addDividersAfterItems(droplanguage),
                                      customItemsIndexes: getDropdown()
                                          .getDividersIndexes(droplanguage),
                                      value: dropdownlanguage,
                                      onChanged: (value) {
                                        setState(() {
                                          dropdownlanguage = value as String;
                                        });
                                      },
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            child: Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 16),
                                    child: Text(
                                      'Age',
                                      style: TextStyle(
                                        color: Color(0xff838994),
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 16),
                                    child: TextField(
                                      keyboardType: TextInputType.number,
                                      readOnly: true,
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(2)
                                      ],
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: '25',
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            height: 2,
                            width: 163,
                            color: Color(0xffE4E7F1),
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          Container(
                            height: 2,
                            width: 148,
                            color: Color(0xffE4E7F1),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 163,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Are you Looking for?',
                                  style: TextStyle(
                                    color: Color(0xff838994),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                  ),
                                ),
                                Container(
                                  width: 163,
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton2(
                                      dropdownDecoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(13),
                                      ),
                                      icon: Container(
                                        height: 24,
                                        width: 19,
                                        child: Image.asset(
                                          ImagePath.downarrow,
                                          height: 24,
                                          width: 19,
                                        ),
                                      ),
                                      hint: Text('Male'),
                                      dropdownMaxHeight: 200,
                                      itemHeight: 20,
                                      items: getDropdown()
                                          .addDividersAfterItems(
                                              genderdropdown),
                                      customItemsIndexes: getDropdown()
                                          .getDividersIndexes(genderdropdown),
                                      value: dropdowngender,
                                      onChanged: (value) {
                                        setState(() {
                                          dropdowngender = value as String;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                              child: Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 16),
                                  child: Text(
                                    'PIN Code',
                                    style: TextStyle(
                                      color: Color(0xff838994),
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 16),
                                  child: TextField(
                                    readOnly: true,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(6)
                                    ],
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'NYCB055G8',
                                      hintStyle: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black,
                                          fontSize: 17),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ))
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            height: 2,
                            width: 163,
                            color: Color(0xffE4E7F1),
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          Container(
                            height: 2,
                            width: 148,
                            color: Color(0xffE4E7F1),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ), */
            ],
          ),
        ),
      ),
    );
  }

  void checkConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      getProfileAPI();
      getState();
    } else if (connectivityResult == ConnectivityResult.wifi) {
      getProfileAPI();
      getState();
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
                  child: const Text("Ok"),
                ),
              ],
            );
          });
    }
  }

  getState() async {
    var response = await http.get(
      Uri.parse(GET_STATE_URL),
    );

    if (response.statusCode == 200) {
      if (mounted) {
        setState(() {
          _stateModel =
              stateModel.StateModel.fromJson(jsonDecode(response.body));
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
    } else {
      CommonUtils.hideProgressLoading();
    }
  }

  getProfileAPI() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var exeToken = pref.getString(EXE_TOKEN);
    CommonUtils.showProgressLoading(context);
    final queryParameters = {
      "token": exeToken.toString(),
    };
    String queryString = Uri(queryParameters: queryParameters).query;
    var response = await dio.get(GET_EXE_PROFILE_URL + "?" + queryString);
    if (response.statusCode == 200) {
      CommonUtils.hideProgressLoading();
      var result = response.data;
      if (result['success'] == true) {
        setState(() {
          _getExeProfileModel = GetExeProfileModel.fromJson(result);
        });
      }

      print(response.data);
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

  String? district;
  List<DropdownMenuItem<String>> _addDividersAfterItems(
      List<Map<String, dynamic>> district) {
    List<DropdownMenuItem<String>> _menuItems = [];
    for (var item in districtList) {
      _menuItems.addAll(
        [
          DropdownMenuItem<String>(
            value: item['name'],
            child: Padding(
              padding: EdgeInsets.only(top: 2.0, left: 0),
              child: Text(
                item['name'],
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
          ),
          //If it's last item, we will not add Divider after it.
          if (item != districtList.last)
            const DropdownMenuItem<String>(
              enabled: false,
              child: Divider(
                height: 0,
              ),
            ),
        ],
      );
    }
    return _menuItems;
  }

  List<int> _getDividersIndexes() {
    List<int> _dividersIndexes = [];
    for (var i = 0; i < (districtList.length * 2) - 1; i++) {
      //Dividers indexes will be the odd indexes
      if (i.isOdd) {
        _dividersIndexes.add(i);
      }
    }
    return _dividersIndexes;
  }

  List<DropdownMenuItem<stateModel.Data>> addDividersAfterItemsStateModel(
      List<stateModel.Data> items) {
    List<DropdownMenuItem<stateModel.Data>> _menuItems = [];
    for (var item in items) {
      _menuItems.addAll(
        [
          DropdownMenuItem<stateModel.Data>(
            value: item,
            child: Padding(
              padding: EdgeInsets.only(top: 2.0, left: 10),
              child: Text(
                item.name.toString(),
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
          ),
          if (item != items.last)
            const DropdownMenuItem<stateModel.Data>(
              enabled: false,
              child: Divider(
                height: 0,
              ),
            ),
        ],
      );
    }
    return _menuItems;
  }

  getDividersIndexes(items) {
    List<int> _getDividersIndexes() {
      List<int> _dividersIndexes = [];
      for (var i = 0; i < (items.length * 2) - 1; i++) {
        if (i.isOdd) {
          _dividersIndexes.add(i);
        }
      }
      return _dividersIndexes;
    }
  }

  _connectbutton() {
    return Container(
      width: 100,
      height: 20,
      decoration: BoxDecoration(
          gradient: AppColors.appColor, borderRadius: BorderRadius.circular(5)),
      alignment: Alignment.center,
      child: Text(
        'Connect',
        style: appBtnStyle.copyWith(fontSize: 15),
      ),
    );
  }

  _twitterconnectbutton() {
    return GestureDetector(
      onTap: () {
        openTwitter();
      },
      child: Container(
        width: 100,
        height: 20,
        decoration: BoxDecoration(
            color: Color(0xffFB5A57), borderRadius: BorderRadius.circular(5)),
        alignment: Alignment.center,
        child: Text(
          'Connect',
          style: appBtnStyle.copyWith(fontSize: 15),
        ),
      ),
    );
  }

  _instaconnectbutton() {
    return GestureDetector(
      onTap: () {
        _launchInstagram();
      },
      child: Container(
        width: 100,
        height: 20,
        decoration: BoxDecoration(
            color: Color(0xffFB5A57), borderRadius: BorderRadius.circular(5)),
        alignment: Alignment.center,
        child: Text(
          'Connect',
          style: appBtnStyle.copyWith(fontSize: 15),
        ),
      ),
    );
  }

  openTwitter() async {
    var url = "https://twitter.com/";
    if (await canLaunch(url)) {
      await launch(url, forceWebView: false, enableJavaScript: false);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchInstagram() async {
    var url = 'https://www.instagram.com/<INSTAGRAM_PROFILE>/';

    if (await canLaunch(url)) {
      await launch(
        url,
        universalLinksOnly: true,
      );
    } else {
      throw 'There was a problem to open the url: $url';
    }
  }

  _fbconnectbutton() {
    return GestureDetector(
      onTap: () {
        _openFacebook();
      },
      child: Container(
        width: 100,
        height: 20,
        decoration: BoxDecoration(
            color: Color(0xffFB5A57), borderRadius: BorderRadius.circular(5)),
        alignment: Alignment.center,
        child: Text(
          'Connect',
          style: appBtnStyle.copyWith(fontSize: 15),
        ),
      ),
    );
  }

  _openFacebook() async {
    String fbProtocolUrl;
    if (Platform.isIOS) {
      fbProtocolUrl = 'fb://profile/page_id';
    } else {
      fbProtocolUrl = 'fb://page/page_id';
    }

    String fallbackUrl = 'https://www.facebook.com/page_name';

    try {
      bool launched = await launch(fbProtocolUrl, forceSafariVC: false);

      if (!launched) {
        await launch(fallbackUrl, forceSafariVC: false);
      }
    } catch (e) {
      await launch(fallbackUrl, forceSafariVC: false);
    }
  }
}

class MultiSelect extends StatefulWidget {
  final List<String> items;
  const MultiSelect({Key? key, required this.items}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MultiSelectState();
}

class _MultiSelectState extends State<MultiSelect> {
  void _itemChange(String itemValue, bool isSelected) {
    setState(() {
      if (isSelected) {
        _selectedItems.add(itemValue);
      } else {
        _selectedItems.remove(itemValue);
      }
    });
  }

  void _cancel() {
    Navigator.pop(context);
  }

  void _submit() {
    Navigator.pop(context, _selectedItems);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(13)),
      child: AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
        insetPadding: EdgeInsets.all(25),
        elevation: 0,
        contentPadding: EdgeInsets.all(5),
        backgroundColor: Colors.white,
        title: Column(
          children: [
            Text('Select Language'),
            SizedBox(
              height: 20,
            ),
          ],
        ),
        content: Builder(builder: (context) {
          return Container(
            height: 250,
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              child: ListBody(
                children: widget.items
                    .map((item) => CheckboxListTile(
                          activeColor: Colors.white,
                          checkColor: Colors.blue,
                          tileColor: Colors.white,
                          value: _selectedItems.contains(item),
                          title: Text(item),
                          controlAffinity: ListTileControlAffinity.leading,
                          onChanged: (isChecked) =>
                              _itemChange(item, isChecked!),
                        ))
                    .toList(),
              ),
            ),
          );
        }),
        actions: [
          TextButton(
            child: const Text(
              'Cancel',
              style: TextStyle(color: Colors.black),
            ),
            onPressed: _cancel,
          ),
          InkWell(
            onTap: () {
              _submit();
            },
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(13),
                  gradient: AppColors.appColor),
              height: 30,
              width: 80,
              child: Center(
                  child: Text(
                'Submit',
                style: TextStyle(color: Colors.white),
              )),
            ),
          )
        ],
      ),
    );
  }
}
