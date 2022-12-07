import 'dart:convert';
import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:matrimonial_app/Core/Constant/CommonUtils.dart';
import 'package:matrimonial_app/Core/Constant/url_constant.dart';
import 'package:matrimonial_app/Core/Constant/value_constants.dart';
import 'package:matrimonial_app/ModelClass/UserPanel_ModelClass/candidate_match_model.dart';
import 'package:matrimonial_app/ModelClass/UserPanel_ModelClass/get_refer_by_agent_model.dart';
import 'package:matrimonial_app/ModelClass/UserPanel_ModelClass/user_profile_about_model.dart';
import 'package:matrimonial_app/Ui/Drawer/AccountSettingScreen/account_screen.dart';
import 'package:matrimonial_app/Ui/Home_screen/Match%20Screen/Match_Details.dart';
import 'package:matrimonial_app/Ui/Home_screen/Notification/chat_screen.dart';
import 'package:matrimonial_app/Ui/Login/login_screen.dart';
import 'package:matrimonial_app/Utils/app_constants.dart';
import 'package:matrimonial_app/Utils/color_constants.dart';
import 'package:matrimonial_app/Utils/image_path_constants.dart';
import 'package:matrimonial_app/Utils/text_styles.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Match_screen extends StatefulWidget {
  String? image;
  String? name;

  Match_screen({this.image, this.name, Key? key}) : super(key: key);

  @override
  State<Match_screen> createState() => _Match_screenState();
}

class _Match_screenState extends State<Match_screen> {
  MatchCandidateModel? _matchCandidateModel;
  UserAboutMeModel? _userAboutMeModel;
  GetReferbyAgentModel? _getReferbyAgentModel;
  Dio dio = Dio();
  @override
  void initState() {
    checkConnection();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double angle = -5.0 * pi / 180.0;
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: currentColor,
        body: Container(
          height: height * 10,
          width: width * 10,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  ImagePath.background,
                ),
                fit: BoxFit.cover),
          ),
          child: Column(
            children: [
              _matchappbar(),
              Text(
                AppConstants.congratulation,
                style: congrates.copyWith(fontWeight: FontWeight.bold),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    AppConstants.matchtext,
                    style: match,
                  ),
                  Transform.rotate(
                    angle: angle,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Container(
                        width: 114,
                        color: Colors.white,
                        child: Transform.rotate(
                          angle: -angle,
                          child: Text(
                            AppConstants.match1,
                            style: match1,
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: height * 0.026,
              ),
              Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(ImagePath.matchimage))),
                height: 138,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _userAboutMeModel != null &&
                            _userAboutMeModel!.data != null &&
                            _userAboutMeModel!.data!.profileImage!.isNotEmpty &&
                            _userAboutMeModel!.data!.profileImage!.length > 0
                        ? CircleAvatar(
                            radius: 50,
                            backgroundImage: (CachedNetworkImageProvider(
                              _userAboutMeModel!.data!.profileImage![0].filePath
                                  .toString(),
                            )

                                /* CachedNetworkImageProvider(
                                "https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/1024px-No_image_available.svg.png",
                              ), */
                                ),
                          )
                        : CircleAvatar(
                            radius: 50,
                            backgroundImage: AssetImage(
                              ImagePath.femaleProfileUser,
                              // "https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/1024px-No_image_available.svg.png",
                            ),
                          ),
                    /* Container(
                      decoration: BoxDecoration(
                        image: (_userAboutMeModel != null &&
                                _userAboutMeModel!.data != null &&
                                _userAboutMeModel!
                                    .data!.profileImage!.isNotEmpty &&
                                _userAboutMeModel!.data!.profileImage!.length >
                                    0)
                            ? DecorationImage(
                                image: NetworkImage(_userAboutMeModel!
                                    .data!.profileImage![0].filePath
                                    .toString()),
                                fit: BoxFit.fitWidth)
                            : DecorationImage(
                                image: NetworkImage(
                                    "https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/1024px-No_image_available.svg.png"),
                              ),
                        shape: BoxShape.circle,
                      ),
                      height: 130,
                      width: 100,
                    ), */
                    SizedBox(
                      width: 35,
                    ),
                    ClipOval(
                      clipBehavior: Clip.none,
                      child: widget.image != null && widget.image!.isNotEmpty
                          ? CircleAvatar(
                              radius: 50,
                              backgroundImage: CachedNetworkImageProvider(
                                widget.image!,
                              )

                              /*  CachedNetworkImageProvider(
                                    "https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/1024px-No_image_available.svg.png",
                                  ), */
                              )
                          : CircleAvatar(
                              radius: 50,
                              backgroundImage: AssetImage(
                                ImagePath.femaleProfileUser,
                                // "https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/1024px-No_image_available.svg.png",
                              ),
                            ),
                    ),
                    /* Container(
                      decoration: BoxDecoration(
                        image: widget.image != null && widget.image!.isNotEmpty
                            ? DecorationImage(
                                image: NetworkImage(
                                  widget.image!,
                                ),
                                fit: BoxFit.fill)
                            : DecorationImage(
                                image: NetworkImage(
                                    "https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/1024px-No_image_available.svg.png"),
                              ),
                        shape: BoxShape.circle,
                      ),
                      height: 130,
                      width: 100,
                    ) */
                  ],
                ),
              ),
              SizedBox(
                height: height * 0.03,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 16, right: 16, top: 0, bottom: 8),
                child: Container(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        ImagePath.note,
                        height: 20,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                AppConstants.kundli,
                                style: congrates.copyWith(
                                    fontWeight: FontWeight.w600, fontSize: 15),
                              ),
                              Text(
                                _matchCandidateModel != null &&
                                        _matchCandidateModel!
                                            .data!.kundli!.isNotEmpty
                                    ? " " +
                                        _matchCandidateModel!.data!.kundli
                                            .toString()
                                    : "",
                                style: congrates.copyWith(
                                    fontWeight: FontWeight.w600, fontSize: 15),
                              ),
                              Text(
                                "%",
                                style: congrates.copyWith(
                                    fontWeight: FontWeight.w600, fontSize: 15),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          Text(
                            AppConstants.kundlimatch,
                            style: congrates.copyWith(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: Colors.white.withOpacity(0.8)),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.008,
              ),
              Divider(
                height: 1,
                color: Colors.white.withOpacity(0.5),
              ),
              SizedBox(
                height: height * 0.005,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15, right: 16, top: 0, bottom: 8),
                child: Container(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/FoodHebitWhite.png',
                        // ImagePath.foodHebitWhite,
                        height: 23,
                      ),
                      SizedBox(
                        width: width * 0.040,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                AppConstants.food,
                                style: congrates.copyWith(
                                    fontWeight: FontWeight.w600, fontSize: 15),
                              ),
                              Text(
                                _matchCandidateModel != null &&
                                        _matchCandidateModel!
                                            .data!.kundli!.isNotEmpty
                                    ? " " +
                                        _matchCandidateModel!.data!.habits
                                            .toString()
                                    : "",
                                style: congrates.copyWith(
                                    fontWeight: FontWeight.w600, fontSize: 15),
                              ),
                              Text(
                                "%",
                                style: congrates.copyWith(
                                    fontWeight: FontWeight.w600, fontSize: 15),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          Container(
                            width: width * 0.73,
                            child: Text(
                              AppConstants.foodhabits,
                              style: congrates.copyWith(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  color: Colors.white.withOpacity(0.8)),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.005,
              ),
              Divider(
                height: 1,
                color: Colors.white.withOpacity(0.5),
              ),
              SizedBox(
                height: height * 0.005,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 16, right: 16, top: 0, bottom: 8),
                child: Container(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        ImagePath.bag,
                        height: 20,
                      ),
                      SizedBox(
                        width: width * 0.040,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                AppConstants.occupation,
                                style: congrates.copyWith(
                                    fontWeight: FontWeight.w600, fontSize: 15),
                              ),
                              Text(
                                _matchCandidateModel != null &&
                                        _matchCandidateModel!
                                            .data!.kundli!.isNotEmpty
                                    ? " " +
                                        _matchCandidateModel!.data!.occupation
                                            .toString()
                                    : "",
                                style: congrates.copyWith(
                                    fontWeight: FontWeight.w600, fontSize: 15),
                              ),
                              Text(
                                "%",
                                style: congrates.copyWith(
                                    fontWeight: FontWeight.w600, fontSize: 15),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          Container(
                            width: width * 0.73,
                            child: Text(
                              AppConstants.occupationlist,
                              style: congrates.copyWith(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  color: Colors.white.withOpacity(0.8)),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.005,
              ),
              Divider(
                height: 1,
                color: Colors.white.withOpacity(0.5),
              ),
              SizedBox(
                height: height * 0.005,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 16, right: 16, top: 0, bottom: 8),
                child: Container(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        ImagePath.people,
                        height: 20,
                      ),
                      SizedBox(
                        width: width * 0.040,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                AppConstants.castmatch,
                                style: congrates.copyWith(
                                    fontWeight: FontWeight.w600, fontSize: 15),
                              ),
                              Text(
                                _matchCandidateModel != null &&
                                        _matchCandidateModel!
                                            .data!.kundli!.isNotEmpty
                                    ? " " +
                                        _matchCandidateModel!.data!.caste
                                            .toString()
                                    : "",
                                style: congrates.copyWith(
                                    fontWeight: FontWeight.w600, fontSize: 15),
                              ),
                              Text(
                                "%",
                                style: congrates.copyWith(
                                    fontWeight: FontWeight.w600, fontSize: 15),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          Container(
                            width: width * 0.73,
                            child: Text(
                              AppConstants.castmatchlist,
                              style: congrates.copyWith(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  color: Colors.white.withOpacity(0.8)),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.005,
              ),
              Divider(
                height: 1,
                color: Colors.white.withOpacity(0.5),
              ),
              SizedBox(
                height: height * 0.01,
              ),
              /*  InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MatchDetails(
                              image1: _userAboutMeModel!
                                  .data!.profileImage![0].filePath
                                  .toString(),
                              image2: widget.image)));
                },
                child: Container(
                  height: 20,
                  color: Colors.transparent,
                  child: Text(
                    "View More Details",
                    style: TextStyle(
                        color: AppColors.colorWhite,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ), */
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => Chat_screen(
                                      name: widget.name,
                                      image: widget.image,
                                    )));
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width / 2 - 25,
                        height: 50,
                        decoration: BoxDecoration(
                            color: AppColors.colorWhite,
                            borderRadius: BorderRadius.circular(9)),
                        alignment: Alignment.center,
                        child: Text('Say "Hi!"',
                            style: btnname.copyWith(fontSize: 17)),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MatchDetails(
                                    image1: (_userAboutMeModel != null &&
                                            _userAboutMeModel!.data != null &&
                                            _userAboutMeModel!
                                                    .data!.profileImage!.length > 0)
                                        ? _userAboutMeModel!
                                            .data!.profileImage![0].filePath
                                            .toString()
                                        : "",
                                    image2: widget.image)));
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width / 2 - 25,
                        height: 50,
                        decoration: BoxDecoration(
                            color: AppColors.colorWhite,
                            borderRadius: BorderRadius.circular(9)),
                        alignment: Alignment.center,
                        child: Text(
                          'View More Details',
                          style: btnname.copyWith(fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 25),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    AppConstants.skip,
                    style: appBtnStyle.copyWith(fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  _matchappbar() {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      height: 120,
      child: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Image.asset(
              ImagePath.shareframe,
              height: height * 0.020,
              width: width * 0.070,
            ),
          )
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Align(
          alignment: Alignment.center,
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Image.asset(
              ImagePath.backArrow,
              color: Colors.white,
              width: width * 0.070,
              height: height * 0.04,
            ),
          ),
        ),
      ),
    );
  }

  void checkConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      getcandidatematchApi();
      getProfileAPI();
      getReferbyAgent();
    } else if (connectivityResult == ConnectivityResult.wifi) {
      getcandidatematchApi();
      getProfileAPI();
      getReferbyAgent();
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

  getReferbyAgent() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString(USER_TOKEN);
    final queryParameters = {
      "token": token.toString(),
    };
    String queryString = Uri(queryParameters: queryParameters).query;
    try {
      var response = await dio.get(GET_REFER_BY_AGENT_URL + "?" + queryString);
      if (response.statusCode == 200) {
        setState(() {
          _getReferbyAgentModel = GetReferbyAgentModel.fromJson(response.data);
        });
        print("recent visit ::: ${response.data}");
      } else if (response.statusCode == 500) {
        Fluttertoast.showToast(
            msg: "Internal Server Error",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Color(0xffE16284),
            textColor: Colors.white,
            fontSize: 16.0);
      }
    } on DioError catch (e) {
      if (e.response!.statusCode == 404) {
        print("404");
      }
      CommonUtils.hideProgressLoading();
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
      if (data['status'] == 'Token is Expired') {
        pref.setString(USER_TOKEN, "");
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (dialogcontext) => Login()),
            (route) => false);
      } else {
        setState(() {
          _userAboutMeModel =
              UserAboutMeModel.fromJson(jsonDecode(response.body));
        });
      }
    } else if (response.statusCode == 500) {
      Fluttertoast.showToast(
          msg: "Internal Server Error",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Color(0xffE16284),
          textColor: Colors.white,
          fontSize: 16.0);
    } else {}
  }

  getcandidatematchApi() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString(USER_TOKEN);
    final queryParameters = {
      "token": token.toString(),
    };
    String queryString = Uri(queryParameters: queryParameters).query;
    try {
      var response = await dio.get(GET_Candidate_Match_URL + "?" + queryString);
      if (response.statusCode == 200) {
        setState(() {
          _matchCandidateModel = MatchCandidateModel.fromJson(response.data);
        });
        print("Near you match ::: ${response.data}");
      } else if (response.statusCode == 500) {
        Fluttertoast.showToast(
            msg: "Internal Server Error",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Color(0xffE16284),
            textColor: Colors.white,
            fontSize: 16.0);
      }
    } on DioError catch (e) {}
  }
}
