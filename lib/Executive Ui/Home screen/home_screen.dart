import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:matrimonial_app/Core/Constant/CommonUtils.dart';
import 'package:matrimonial_app/Core/Constant/url_constant.dart';
import 'package:matrimonial_app/Core/Constant/value_constants.dart';
import 'package:matrimonial_app/Executive%20Ui/DashBoardScreen/dashboard_screen.dart';
import 'package:matrimonial_app/Executive%20Ui/DiscoverFeed/discoverfeedscreen.dart';
import 'package:matrimonial_app/Executive%20Ui/Home%20screen/MessageScreen/message_screen.dart';
import 'package:matrimonial_app/Executive%20Ui/Home%20screen/NotificationScreen/notification_screen.dart';
import 'package:matrimonial_app/Executive%20Ui/Home%20screen/Search/filter_screen.dart';
import 'package:matrimonial_app/Executive%20Ui/Home%20screen/Search/search_screen.dart';
import 'package:matrimonial_app/Executive%20Ui/Home%20screen/SeeAll_By_Gotra_Screen.dart';
import 'package:matrimonial_app/Executive%20Ui/Home%20screen/SeeAll_Candidate.dart';
import 'package:matrimonial_app/Executive%20Ui/Home%20screen/SettingScreen/setting_screen.dart';
import 'package:matrimonial_app/Executive%20Ui/Home%20screen/homescreen2.dart';
import 'package:matrimonial_app/Executive%20Ui/Login/login_screen.dart';
import 'package:matrimonial_app/Executive%20Ui/ProfileScreen/profile_screen.dart';
import 'package:matrimonial_app/Executive%20Ui/Home%20screen/SeeAll_ByCaste_Screen.dart';
import 'package:matrimonial_app/MatchingProfile/matching_profilescreen.dart';
import 'package:matrimonial_app/ModelClass/Executive_ModelClass/All_Executive_Candidate_Model.dart';
import 'package:matrimonial_app/ModelClass/Executive_ModelClass/Get_By_Cast_Model.dart';
import 'package:matrimonial_app/ModelClass/Executive_ModelClass/Get_By_Gotra_Model.dart';
import 'package:matrimonial_app/ModelClass/Executive_ModelClass/Get_Profile_Model.dart';
import 'package:matrimonial_app/ModelClass/UserPanel_ModelClass/All_Count_Users_Model.dart';
import 'package:matrimonial_app/Ui/Drawer/AccountSettingScreen/ContactUs/contact_us.dart';
import 'package:matrimonial_app/Ui/Drawer/RefferalScreen/refferal_screen.dart';
import 'package:matrimonial_app/Ui/RegisterScreen/security_question.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:story/story_page_view/story_page_view.dart';
import 'package:swipe_cards/draggable_card.dart';

import 'package:http/http.dart' as http;
import '../../../Utils/app_constants.dart';
import '../../../Utils/color_constants.dart';
import '../../../Utils/image_path_constants.dart';
import '../../../Utils/text_styles.dart';
import '../../Ui/Home_screen/tinder_card_component.dart';
import '../Ragister/add_profile_screen.dart';

const Color p = Color(0xff416d69);

final ZoomDrawerController z = ZoomDrawerController();

class Zoom extends StatefulWidget {
  const Zoom({Key? key}) : super(key: key);

  @override
  _ZoomState createState() => _ZoomState();
}

class _ZoomState extends State<Zoom> {
  Dio dio = Dio();
  GetExeProfileModel? _getExeProfileModel;

  @override
  void initState() {
    super.initState();
    checkConnection();
  }

  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      controller: z,
      borderRadius: 24,
      style: DrawerStyle.defaultStyle,
      showShadow: false,
      openCurve: Curves.fastOutSlowIn,
      slideWidth: MediaQuery.of(context).size.width * 0.7,
      duration: Duration(milliseconds: 500),
      angle: 0.0,
      mainScreenTapClose: true,
      mainScreen: Body(),
      menuBackgroundColor: Color.fromARGB(255, 250, 65, 65),
      menuScreen: Padding(
        padding: EdgeInsets.only(left: 8.0, top: 80),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.8,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Stack(
                    children: [
                      _getExeProfileModel != null &&
                              _getExeProfileModel!.data != null &&
                              _getExeProfileModel!
                                  .data!.profileImage!.isNotEmpty
                          ? Container(
                              width: 71,
                              height: 71,
                              child: CircleAvatar(
                                backgroundImage: NetworkImage(
                                    _getExeProfileModel!
                                        .data!.profileImage![0].filePath
                                        .toString()),
                              ),
                            )
                          : Container(
                              width: 71,
                              height: 71,
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                backgroundImage: (_getExeProfileModel != null &&
                                        _getExeProfileModel!.data != null &&
                                        _getExeProfileModel!.data!.gender ==
                                            "Male")
                                    ? AssetImage(ImagePath.maleProfile)
                                    : AssetImage(ImagePath.femaleProfile),
                              ),
                            ),
                    ],
                  ),
                  const SizedBox(
                    width: 11,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 110,
                        child: Text(
                          _getExeProfileModel != null &&
                                  _getExeProfileModel!.data != null
                              ? _getExeProfileModel!.data!.firstname
                                      .toString() +
                                  " " +
                                  _getExeProfileModel!.data!.lastname.toString()
                              : AppConstants.elonMusk,
                          style: elon,
                        ),
                      ),
                      Container(
                        width: 110,
                        child: Text(
                          _getExeProfileModel != null &&
                                  _getExeProfileModel!.data != null
                              ? _getExeProfileModel!.data!.email.toString()
                              : AppConstants.elonMuskUserName,
                          style: homestyle.copyWith(
                              color: Colors.white.withOpacity(0.60)),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                splashColor: Colors.grey.withOpacity(0.5),
                splashFactory: InkRipple.splashFactory,
                onTap: () {
                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) => Account_Setting()));
                },
                child: Container(
                  color: Colors.transparent,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 35,
                        height: 35,
                        child: Image.asset(ImagePath.profiledrawer),
                      ),
                      const SizedBox(
                        width: 24,
                      ),
                      Text(
                        AppConstants.account,
                        style: homestyle.copyWith(fontSize: 15),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              InkWell(
                splashColor: Colors.grey.withOpacity(0.5),
                splashFactory: InkRipple.splashFactory,
                onTap: () {
                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) => const E_Notification_Screen()));
                },
                child: Container(
                  color: Colors.transparent,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 35,
                        height: 35,
                        child: Image.asset(ImagePath.notifydrawer),
                      ),
                      const SizedBox(
                        width: 24,
                      ),
                      Text(
                        AppConstants.notifications,
                        style: homestyle.copyWith(fontSize: 15),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              InkWell(
                splashColor: Colors.grey.withOpacity(0.5),
                splashFactory: InkRipple.splashFactory,
                onTap: () {
                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) => Security_Questions()));
                },
                child: Container(
                  color: Colors.transparent,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 35,
                        height: 35,
                        child: Image.asset(ImagePath.lockdrawer),
                      ),
                      const SizedBox(
                        width: 24,
                      ),
                      Text(
                        AppConstants.security,
                        style: homestyle.copyWith(fontSize: 15),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              InkWell(
                splashColor: Colors.grey.withOpacity(0.5),
                splashFactory: InkRipple.splashFactory,
                onTap: () {
                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) => E_Executive_Profile()));
                },
                child: Container(
                  color: Colors.transparent,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 35,
                        height: 35,
                        child: Image.asset(ImagePath.linkeddrawer),
                      ),
                      const SizedBox(
                        width: 24,
                      ),
                      Text(
                        AppConstants.linked,
                        style: homestyle.copyWith(fontSize: 15),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              InkWell(
                splashColor: Colors.grey.withOpacity(0.5),
                splashFactory: InkRipple.splashFactory,
                onTap: () {
                  Navigator.push(context,
                      CupertinoPageRoute(builder: (contex) => Contact_Us()));
                },
                child: Container(
                  color: Colors.transparent,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 35,
                        height: 35,
                        child: Image.asset(ImagePath.helpdrawer),
                      ),
                      const SizedBox(
                        width: 24,
                      ),
                      Text(
                        AppConstants.help,
                        style: homestyle.copyWith(fontSize: 15),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              InkWell(
                splashColor: Colors.grey.withOpacity(0.5),
                splashFactory: InkRipple.splashFactory,
                onTap: () {
                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) => Refferal_screen()));
                },
                child: Container(
                  color: Colors.transparent,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 35,
                        height: 35,
                        child: Image.asset(ImagePath.refreldrawer),
                      ),
                      const SizedBox(
                        width: 24,
                      ),
                      Text(
                        AppConstants.ref,
                        style: homestyle.copyWith(fontSize: 15),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              GestureDetector(
                onTap: () {
                  _disableDialogBox();
                },
                child: Container(
                  color: Colors.transparent,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 35,
                        height: 35,
                        child: Image.asset(ImagePath.logoutdrawer),
                      ),
                      const SizedBox(
                        width: 24,
                      ),
                      Text(
                        AppConstants.logout,
                        style: homestyle.copyWith(fontSize: 15),
                      )
                    ],
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
      getExeProfileAPI();
    } else if (connectivityResult == ConnectivityResult.wifi) {
      getExeProfileAPI();
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

  getExeProfileAPI() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var exeToken = pref.getString(EXE_TOKEN);
    final queryParameters = {
      "token": exeToken.toString(),
    };
    String queryString = Uri(queryParameters: queryParameters).query;
    var response = await dio.get(GET_EXE_PROFILE_URL + "?" + queryString);
    if (response.statusCode == 200) {
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

  _disableDialogBox() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            insetPadding: const EdgeInsets.symmetric(horizontal: 16),
            contentPadding: EdgeInsets.zero,
            backgroundColor: Colors.transparent,
            content: Container(
              height: 270,
              width: MediaQuery.of(context).size.width / 1.2,
              decoration: BoxDecoration(
                boxShadow: [
                  const BoxShadow(blurRadius: 10.0, color: Colors.black)
                ],
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  const SizedBox(height: 8),
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
                      const SizedBox(width: 8),
                    ],
                  ),
                  Image.asset(ImagePath.logout, height: 60, width: 60),
                  const SizedBox(height: 20),
                  Text(
                    AppConstants.sureTextlogout,
                    style: headingStyle.copyWith(
                      color: const Color(0xff333F52),
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: Text(
                      AppConstants.ourTeamlogout,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      style: headingStyle.copyWith(
                        color: const Color(0xffAFAFAF),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: GestureDetector(
                      onTap: () async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        setState(() {
                          String token = prefs.getString(EXE_TOKEN)!;
                          if (token != null) {
                            prefs.setBool(EXESHOWLOGIN, false);
                            prefs.setBool(EXESHOWOTP, false);
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (dialogcontext) => ExeLogin()),
                                (route) => false);
                          }
                        });
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        decoration: BoxDecoration(
                            gradient: AppColors.appColor,
                            borderRadius: BorderRadius.circular(9)),
                        alignment: Alignment.center,
                        child: Text(
                          AppConstants.logout,
                          style: appBtnStyle,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
          );
        });
  }
}

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> with SingleTickerProviderStateMixin {
  int _selectedIndex = 2;
  final List<Widget> _widgetOptions = <Widget>[
    Discover_Screen(),
    AddProfileScreen(),
    HomeScreen(),
    E_Message_screen(fromValue: 'bottom'),
    DashBoardScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: const Color(0xff2F2F2F).withOpacity(0.1),
                offset: const Offset(0, 0),
                blurRadius: 10,
                spreadRadius: 0)
          ],
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        height: 66,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: new Material(
                  type: MaterialType.transparency,
                  elevation: 10,
                  animationDuration: Duration(seconds: 1),
                  child: new InkWell(
                      splashColor: Colors.grey.withOpacity(0.5),
                      splashFactory: InkRipple.splashFactory,
                      onTap: () {
                        print("kk");
                        setState(() {
                          _onItemTapped(0);
                        });
                      },
                      child: Container(
                        width: 65,
                        child: Center(
                          child: Image.asset(
                            _selectedIndex == 0
                                ? ImagePath.executive_navigation_color
                                : ImagePath.executive_navigation,
                            width: 25,
                            height: 25,
                          ),
                        ),
                      )),
                  color: Colors.transparent,
                ),
                color: Colors.white,
              ),
              /*    InkWell(
                  splashColor: Colors.grey.withOpacity(0.5),
                  splashFactory: InkRipple.splashFactory,
                  onTap: () {
                    setState(() {
                      _onItemTapped(0);
                    });
                  },
                  child: Container(
                    width: 65,
                    child: Center(
                      child: 
                           Image.asset(_selectedIndex == 0?
                              ImagePath.executive_navigation_color
                              : ImagePath.executive_navigation,
                              width: 25,
                              height: 25,
                            )
      
                    ),
                  ),), */
              Container(
                child: new Material(
                  type: MaterialType.transparency,
                  elevation: 10,
                  animationDuration: Duration(seconds: 1),
                  child: new InkWell(
                      splashColor: Colors.grey.withOpacity(0.5),
                      splashFactory: InkRipple.splashFactory,
                      onTap: () {
                        print("kk");
                        setState(() {
                          _onItemTapped(1);
                        });
                      },
                      child: Container(
                        width: 65,
                        child: Center(
                          child: Image.asset(
                            _selectedIndex == 1
                                ? ImagePath.executive_adduser_color
                                : ImagePath.executive_adduser,
                            width: 25,
                            height: 25,
                          ),
                        ),
                      )),
                  color: Colors.transparent,
                ),
                color: Colors.white,
              ),

              /*      InkWell(
                splashColor: Colors.grey.withOpacity(0.5),
                splashFactory: InkRipple.splashFactory,
                onTap: () {
                  setState(() {
                    _onItemTapped(1);
                  });
                },
                child: _selectedIndex == 1
                    ? Center(
                        child: Image.asset(
                          ImagePath.executive_adduser_color,
                          width: 25,
                          height: 25,
                        ),
                      )
                    : Image.asset(
                        ImagePath.executive_adduser,
                        width: 25,
                        height: 25,
                      ),
              ), */
              Container(
                child: new Material(
                  type: MaterialType.transparency,
                  elevation: 10,
                  animationDuration: Duration(seconds: 1),
                  child: new InkWell(
                      splashColor: Colors.grey.withOpacity(0.5),
                      splashFactory: InkRipple.splashFactory,
                      onTap: () {
                        print("kk");
                        setState(() {
                          _onItemTapped(2);
                        });
                      },
                      child: Container(
                        width: 65,
                        child: Center(
                          child: Image.asset(
                            _selectedIndex == 2
                                ? ImagePath.colorhome
                                : ImagePath.bottomhome,
                            width: 25,
                            height: 25,
                          ),
                        ),
                      )),
                  color: Colors.transparent,
                ),
                color: Colors.white,
              ),

              /*     InkWell(
                splashColor: Colors.grey.withOpacity(0.5),
                splashFactory: InkRipple.splashFactory,
                onTap: () {
                  setState(() {
                    _onItemTapped(2);
                  });
                },
                child: _selectedIndex == 2
                    ? Image.asset(
                        ImagePath.colorhome,
                        width: 25,
                        height: 25,
                      )
                    : Image.asset(
                        ImagePath.bottomhome,
                        width: 25,
                        height: 25,
                      ),
              ), */
              Container(
                child: new Material(
                  type: MaterialType.transparency,
                  elevation: 10,
                  animationDuration: Duration(seconds: 1),
                  child: new InkWell(
                      splashColor: Colors.grey.withOpacity(0.5),
                      splashFactory: InkRipple.splashFactory,
                      onTap: () {
                        print("kk");
                        setState(() {
                          _onItemTapped(3);
                        });
                      },
                      child: Container(
                        width: 65,
                        child: Center(
                          child: Image.asset(
                            _selectedIndex == 3
                                ? ImagePath.colormessage
                                : ImagePath.bottommessage,
                            width: 25,
                            height: 25,
                          ),
                        ),
                      )),
                  color: Colors.transparent,
                ),
                color: Colors.white,
              ),

              /*  InkWell(
                splashColor: Colors.grey.withOpacity(0.5),
                splashFactory: InkRipple.splashFactory,
                onTap: () {
                  setState(() {
                    _onItemTapped(3);
                  });
                },
                child: _selectedIndex == 3
                    ? Image.asset(
                        ImagePath.colormessage,
                        width: 25,
                        height: 25,
                      )
                    : Image.asset(
                        ImagePath.bottommessage,
                        width: 25,
                        height: 25,
                      ),
              ), */
              Container(
                child: new Material(
                  type: MaterialType.transparency,
                  elevation: 10,
                  animationDuration: Duration(seconds: 1),
                  child: new InkWell(
                      splashColor: Colors.grey.withOpacity(0.5),
                      splashFactory: InkRipple.splashFactory,
                      onTap: () {
                        print("kk");
                        setState(() {
                          _onItemTapped(4);
                        });
                      },
                      child: Container(
                        width: 65,
                        child: Center(
                          child: Image.asset(
                            _selectedIndex == 4
                                ? ImagePath.executive_note_color
                                : ImagePath.executive_note,
                            width: 25,
                            height: 25,
                          ),
                        ),
                      )),
                  color: Colors.transparent,
                ),
                color: Colors.white,
              ),

              /* InkWell(
                splashColor: Colors.grey.withOpacity(0.5),
                splashFactory: InkRipple.splashFactory,
                onTap: () {
                  setState(() {
                    _onItemTapped(4);
                  });
                },
                child: _selectedIndex == 4
                    ? Image.asset(
                        ImagePath.executive_note_color,
                        width: 25,
                        height: 25,
                      )
                    : Image.asset(
                        ImagePath.executive_note,
                        width: 25,
                        height: 25,
                      ),
              ), */
            ],
          ),
        ),
      ),
      body: Center(
        child: _widgetOptions[_selectedIndex],
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime? currentBackPressTime;
  String likes = '';
  int selectedMatches = 0;
  bool intro = false, right = false, left = false, down = false, main = false;
  AllExecutiveCandidates_Model? _allExecutiveCandidates_Model;
  GlobalKey keyButton = GlobalKey();
  late ValueNotifier<IndicatorAnimationCommand> indicatorAnimationController;
  late DragStartDetails startVerticalDragDetails;
  late DragUpdateDetails updateVerticalDragDetails;
  SharedPreferences? prefs;
  final sampleUsers = [
    UserModel([
      StoryModel(ImagePath.swipecard),
      StoryModel(ImagePath.swipecard2),
    ]),
  ];
  List<String> matches = [];
  List<String> imaglist = [
    "coffee",
    "coffee",
    "coffhnbnbee",
    "coffee",
    "coffee",
  ];

/*   List<Map<String, dynamic>> byCastList = [
    {
      IMAGE: ImagePath.byCastImage,
    },
    {
      IMAGE: ImagePath.byCastImage1,
    },
    {
      IMAGE: ImagePath.byCastImage2,
    },
    {
      IMAGE: ImagePath.byCastImage3,
    },
    {
      IMAGE: ImagePath.byCastImage2,
    },
    {
      IMAGE: ImagePath.byCastImage3,
    },
  ];
 */
  Dio dio = Dio();
  SlideRegion? region1;
  GetExeProfileModel? _getExeProfileModel;
  GetByCastModel? _getByCastModel;
  GetByGotraModel? _getByGotraModel;
  AllCountUsersModel? _allCountUsersModel;

  @override
  void initState() {
    checkConnection();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async => _onBackPressed(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            _appBar(),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) => const E_Executive_Profile()));
                },
                child: Container(
                  height: height * 0.1,
                  width: width,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 50,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              AppConstants.welcomeExe,
                              style: welcome,
                            ),
                            Container(
                              width: 270,
                              child: Text(
                                _getExeProfileModel != null &&
                                        _getExeProfileModel!.data != null
                                    ? _getExeProfileModel!.data!.firstname
                                            .toString() +
                                        " " +
                                        _getExeProfileModel!.data!.lastname
                                            .toString()
                                    : AppConstants.elonmuskExe,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: elonmusk,
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Container(
                          height: 53,
                          width: 53,
                          decoration: BoxDecoration(
                            border:
                                Border.all(color: Color(0xffFB5A57), width: 3),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: _getExeProfileModel != null &&
                                  _getExeProfileModel!.data != null &&
                                  _getExeProfileModel!
                                          .data!.profileImage!.length >
                                      0
                              ? CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      _getExeProfileModel!
                                          .data!.profileImage![0].filePath
                                          .toString()),
                                )
                              : CircleAvatar(
                                  backgroundColor: Colors.white,
                                  backgroundImage: (_getExeProfileModel !=
                                              null &&
                                          _getExeProfileModel!.data != null &&
                                          _getExeProfileModel!.data!.gender ==
                                              "Male")
                                      ? AssetImage(ImagePath.maleProfile)
                                      : AssetImage(ImagePath.femaleProfile),
                                ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16, right: 16),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                              width: 1,
                              color: Color(0xffC5D0DE).withOpacity(.13)),
                          borderRadius: BorderRadius.circular(13),
                          color: Color(0xffFFFFFF),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xff5E5E5E).withOpacity(.7),
                              offset: const Offset(1, 1),
                              blurRadius: 5,
                              spreadRadius: 0,
                            ),
                          ],
                        ),
                        height: height * 0.069,
                        child: Row(
                          children: [
                            SizedBox(
                              width: width * 0.025,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                        builder: (context) =>
                                            E_Search_screen()));
                              },
                              child: Image.asset(
                                ImagePath.exesraech,
                                height: height * 0.030,
                              ),
                            ),
                            SizedBox(
                              width: width * 0.030,
                            ),
                            Expanded(
                              child: TextFormField(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      CupertinoPageRoute(
                                          builder: (context) =>
                                              E_Search_screen()));
                                },
                                readOnly: true,
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(bottom: 6),
                                    border: InputBorder.none,
                                    hintText: AppConstants.happinessExe,
                                    hintStyle: happiness),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                    builder: (context) => E_Filter_screen(),
                                  ),
                                );
                              },
                              child: Image.asset(
                                ImagePath.filterimage,
                                height: height * 0.030,
                              ),
                            ),
                            SizedBox(
                              width: width * 0.020,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(left: 16, right: 16),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Container(
                              height: 35,
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: List.generate(
                                  matches.length,
                                  (index) => Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          selectedMatches = index;
                                        });
                                      },
                                      child: Container(
                                        decoration: selectedMatches == index
                                            ? BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                gradient: AppColors.appColor)
                                            : BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                border: Border.all(
                                                    color: AppColors
                                                        .containeborder),
                                              ),
                                        child: Center(
                                          child: Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text(matches[index],
                                                style: selectedMatches == index
                                                    ? containertext.copyWith(
                                                        color: Colors.white)
                                                    : containertext),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 0, right: 0),
                      child: Container(
                        width: width,
                        height: 220,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(
                              ImagePath.coffe,
                            ),
                          ),
                        ),
                        child: Stack(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 35, top: 140),
                              child: GestureDetector(
                                onTap: () {},
                                child: Container(
                                  height: 35,
                                  width: 101,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: AppColors.colorWhite),
                                  child: Center(
                                    child: Text(
                                      AppConstants.join,
                                      style: join,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, right: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            AppConstants.newlyaddedExe,
                            style: addedbyyou,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                      builder: (context) => SeeAllCandidate()));
                            },
                            child: Row(
                              children: [
                                Text(
                                  AppConstants.seeall,
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
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    _allExecutiveCandidates_Model != null &&
                            _allExecutiveCandidates_Model!.data!.isNotEmpty
                        ? Container(
                            height: 200,
                            alignment: Alignment.topLeft,
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: _allExecutiveCandidates_Model!
                                          .data!.length <
                                      4
                                  ? _allExecutiveCandidates_Model!.data!.length
                                  : 4,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      left: 16.0, right: 0),
                                  child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          CupertinoPageRoute(
                                            builder: (context) => HomeScreen1(
                                              // MobileNO : _allExecutiveCandidates_Model.data[index].
                                                imgLength:
                                                    _allExecutiveCandidates_Model!
                                                                .data![index]
                                                                .profileImage!
                                                                .length >
                                                            0
                                                        ? _allExecutiveCandidates_Model!
                                                            .data![index]
                                                            .profileImage!
                                                            .length
                                                        : 0,
                                                candidateId:
                                                    _allExecutiveCandidates_Model!
                                                        .data![index].userId
                                                        .toString(),
                                                name: _allExecutiveCandidates_Model!
                                                        .data![index].firstname
                                                        .toString() +
                                                    /* _allExecutiveCandidates_Model!
                                                        .data![index].middlename
                                                        .toString() + */
                                                    _allExecutiveCandidates_Model!
                                                        .data![index].lastname
                                                        .toString(),
                                                image: _allExecutiveCandidates_Model!
                                                        .data![index]
                                                        .profileImage!
                                                        .isNotEmpty
                                                    ? _allExecutiveCandidates_Model!
                                                        .data![index]
                                                        .profileImage![0]
                                                        .filePath
                                                    : ""),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        height: 200,
                                        width: width * 0.40,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(18),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              height: 200,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Color(0xffFB5A57),
                                                    width: 5),
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                /* border: Border.all(
                                                    width: 3,
                                                    color: Color(0xffFB5A57)),
                                                borderRadius:
                                                    BorderRadius.circular(13) */
                                                image: (_allExecutiveCandidates_Model != null &&
                                                        _allExecutiveCandidates_Model!
                                                                .data !=
                                                            null &&
                                                        _allExecutiveCandidates_Model!
                                                            .data![index]
                                                            .profileImage!
                                                            .isNotEmpty &&
                                                        _allExecutiveCandidates_Model!
                                                                .data![index]
                                                                .profileImage!
                                                                .length >
                                                            0)
                                                    ? DecorationImage(
                                                        image: NetworkImage(
                                                            _allExecutiveCandidates_Model!
                                                                .data![index]
                                                                .profileImage![
                                                                    0]
                                                                .filePath
                                                                .toString()),
                                                        fit: BoxFit.cover)
                                                    : DecorationImage(
                                                        image: CachedNetworkImageProvider(
                                                            "https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/1024px-No_image_available.svg.png"),
                                                      ),
                                              ),
                                              child: Column(
                                                children: [
                                                  Spacer(),
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      color: Color(0xffffffff)
                                                          .withOpacity(0.9),
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        bottomRight:
                                                            Radius.circular(15),
                                                        bottomLeft:
                                                            Radius.circular(15),
                                                      ),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              bottom: 0,
                                                              left: 0,
                                                              right: 5,
                                                              top: 5),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 5),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Flexible(
                                                                  child: Text(
                                                                    _allExecutiveCandidates_Model !=
                                                                                null &&
                                                                            _allExecutiveCandidates_Model!.data !=
                                                                                null
                                                                        ? _allExecutiveCandidates_Model!.data![index].firstname.toString() +
                                                                            " "
                                                                        : "",
                                                                    maxLines: 1,
                                                                    style: fontStyle.copyWith(
                                                                        overflow:
                                                                            TextOverflow
                                                                                .ellipsis,
                                                                        color: Colors
                                                                            .black,
                                                                        fontSize:
                                                                            15,
                                                                        fontWeight:
                                                                            FontWeight.w600),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width: 5,
                                                                ),
                                                                Image.asset(
                                                                  ImagePath
                                                                      .dualprofile,
                                                                  height: 16,
                                                                  width: 16,
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 5.0),
                                                            child: Text(
                                                              AppConstants
                                                                  .josephWindText,
                                                              maxLines: 1,
                                                              style: matchscroll.copyWith(
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  color: Colors
                                                                      .black),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 5,
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 5,
                                                                    right: 0,
                                                                    bottom: 5),
                                                            child:
                                                                GestureDetector(
                                                              onTap: () {
                                                                Navigator.push(
                                                                  context,
                                                                  CupertinoPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            E_Message_screen(),
                                                                  ),
                                                                );
                                                              },
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
                                                                        BorderRadius.circular(
                                                                            9)),
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                child: Text(
                                                                  'Message',
                                                                  style: appBtnStyle.copyWith(
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
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      )

                                      /*      Container(
                                      // height: 110,
                                      width: width * 0.38,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(19),
                                        border: Border.all(
                                          width: 3,
                                          color: Color(0xffFB5A57),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all(0.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            _allExecutiveCandidates_Model !=
                                                        null &&
                                                    _allExecutiveCandidates_Model!
                                                            .data !=
                                                        null
                                                ? Container(
                                                    height: 110,
                                                    width: width * 0.40,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                      image: DecorationImage(
                                                        fit: BoxFit.cover,
                                                        image: NetworkImage(
                                                          _allExecutiveCandidates_Model!
                                                                          .data![
                                                                              index]
                                                                          .profileImage!
                                                                          .length >
                                                                      0 &&
                                                                  _allExecutiveCandidates_Model!
                                                                      .data![
                                                                          index]
                                                                      .profileImage!
                                                                      .isNotEmpty
                                                              ? _allExecutiveCandidates_Model!
                                                                  .data![index]
                                                                  .profileImage![
                                                                      0]
                                                                  .filePath
                                                                  .toString()
                                                              : "https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/1024px-No_image_available.svg.png",
                                                        ),
                                                      ),
                                                    ),
                                                    alignment:
                                                        Alignment.topRight,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 12,
                                                              right: 12),
                                                      child: Container(
                                                        height: 18,
                                                        width: 54,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Color(
                                                                  0xff000000)
                                                              .withOpacity(.30),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                            10,
                                                          ),
                                                        ),
                                                        child: Center(
                                                          child: Text(
                                                            AppConstants
                                                                .milesText,
                                                            style: TextStyle(
                                                                color: AppColors
                                                                    .colorWhite,
                                                                fontSize: 10,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                : Container(
                                                    height: 100,
                                                    width: width * 0.40,
                                                    decoration: BoxDecoration(
                                                        color: Color(0xff000000)
                                                            .withOpacity(.30),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        image: DecorationImage(
                                                            image: AssetImage(
                                                              ImagePath.newAdd1,
                                                            ),
                                                            fit: BoxFit
                                                                .fitWidth)),
                                                  ),
                                            SizedBox(height: 5),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(right: 8.0),
                                              child: Container(
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    SizedBox(width: 13),
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            _allExecutiveCandidates_Model !=
                                                                        null &&
                                                                    _allExecutiveCandidates_Model
                                                                            ?.data !=
                                                                        null
                                                                ? _allExecutiveCandidates_Model!
                                                                    .data![
                                                                        index]
                                                                    .firstname
                                                                    .toString()
                                                                : '',
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
                                                          SizedBox(height: 5),
                                                          Text(
                                                            AppConstants
                                                                .josephWindText,
                                                            style: TextStyle(
                                                                color: AppColors
                                                                    .eGreyColor,
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(width: 5),
                                                    Container(
                                                      child: Image.asset(
                                                          ImagePath.messg,
                                                          height: 25,
                                                          width: 25),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  */
                                      ),
                                );
                              },
                            ),
                          )
                        : Text("No Newly Added By You"),
                    SizedBox(height: 20),
                    Padding(
                      padding: EdgeInsets.only(left: 16.0, right: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            AppConstants.byCastText,
                            style: addedbyyou,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                      builder: (context) =>
                                          SeeAll_ByCasteScreen()));
                            },
                            child: Row(
                              children: [
                                Text(
                                  AppConstants.seeall,
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
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 15),
                    _getByCastModel != null && _getByCastModel!.data!.isNotEmpty
                        ? Padding(
                            padding: const EdgeInsets.only(left: 16, right: 16),
                            child: GridView.builder(
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
                              itemCount: _getByCastModel!.data!.length > 4
                                  ? 4
                                  : _getByCastModel!.data!.length,
                              // byCastList.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        CupertinoPageRoute(
                                            builder: (context) =>
                                                MatchingProfile_Screen(
                                                  name: _getByCastModel!
                                                      .data![index].firstname
                                                      .toString(),
                                                  candidateId: _getByCastModel!
                                                      .data![index].userId,
                                                  img: _getByCastModel!
                                                              .data![index]
                                                              .profileImage!
                                                              .length >
                                                          0
                                                      ? _getByCastModel!
                                                          .data![index]
                                                          .profileImage![0]
                                                          .filePath
                                                          .toString()
                                                      : "https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/1024px-No_image_available.svg.png",
                                                )));
                                  },
                                  child: Container(
                                    height: 210,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(18),

                                      // gradient: AppColors.appColor,
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.all(1),
                                      child: Container(
                                        height: 210,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Color(0xffFB5A57),
                                              width: 5),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          image: (_getByCastModel != null &&
                                                  _getByCastModel!.data !=
                                                      null &&
                                                  _getByCastModel!
                                                      .data![index]
                                                      .profileImage!
                                                      .isNotEmpty &&
                                                  _getByCastModel!
                                                          .data![index]
                                                          .profileImage!
                                                          .length >
                                                      0)
                                              ? DecorationImage(
                                                  image: NetworkImage(
                                                      _getByCastModel!
                                                          .data![index]
                                                          .profileImage![0]
                                                          .filePath
                                                          .toString()
                                                      // byCastList[index][IMAGE]
                                                      ),
                                                  fit: BoxFit.cover)
                                              : DecorationImage(
                                                  image: CachedNetworkImageProvider(
                                                      "https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/1024px-No_image_available.svg.png"),
                                                ),
                                        ),
                                        child: Column(
                                          children: [
                                            Spacer(),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 0),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: Color(0xffffffff)
                                                      .withOpacity(0.9),
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    bottomRight:
                                                        Radius.circular(15),
                                                    bottomLeft:
                                                        Radius.circular(15),
                                                  ),
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 0,
                                                          right: 5,
                                                          top: 5),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(left: 5),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Flexible(
                                                              child: Text(
                                                                _getByCastModel !=
                                                                            null &&
                                                                        _getByCastModel!.data !=
                                                                            null
                                                                    ? _getByCastModel!.data![index].firstname.toString() +
                                                                        " " +
                                                                        _getByCastModel!
                                                                            .data![
                                                                                index]
                                                                            .lastname
                                                                            .toString() +
                                                                        ", " +
                                                                        _getByCastModel!
                                                                            .data![index]
                                                                            .age
                                                                            .toString()
                                                                    : "",
                                                                maxLines: 1,
                                                                // AppConstants.joseph,
                                                                style: fontStyle.copyWith(
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        15,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 5,
                                                            ),
                                                            Image.asset(
                                                              ImagePath
                                                                  .dualprofile,
                                                              height: 16,
                                                              width: 16,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 5.0),
                                                        child: Text(
                                                          _getByCastModel !=
                                                                      null &&
                                                                  _getByCastModel!
                                                                          .data !=
                                                                      null
                                                              ? "Patel" +
                                                                  " | " +
                                                                  _getByCastModel!
                                                                      .data![
                                                                          index]
                                                                      .height
                                                                      .toString()
                                                              : "",
                                                          maxLines: 1,
                                                          // AppConstants.castText,
                                                          style: matchscroll
                                                              .copyWith(
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  color: Colors
                                                                      .black),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 5,
                                                                right: 0,
                                                                bottom: 5),
                                                        child: GestureDetector(
                                                          onTap: () {
                                                            Navigator.push(
                                                              context,
                                                              CupertinoPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        E_Message_screen(),
                                                              ),
                                                            );
                                                          },
                                                          child: Container(
                                                            width:
                                                                MediaQuery.of(
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
                                                            alignment: Alignment
                                                                .center,
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
                            ),
                          )
                        : Text("No data in ByCast"),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, right: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "By Gotra",
                            // AppConstants.byCastText,
                            style: addedbyyou,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                      builder: (context) => SeeAllByGotra()));
                            },
                            child: Row(
                              children: [
                                Text(
                                  AppConstants.seeall,
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
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 15),
                    _getByGotraModel != null &&
                            _getByGotraModel!.data!.isNotEmpty
                        ? Padding(
                            padding: const EdgeInsets.only(left: 16, right: 16),
                            child: GridView.builder(
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
                              itemCount: _getByGotraModel!.data!.length > 4
                                  ? 4
                                  : _getByGotraModel!.data!.length,
                              // byCastList.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        CupertinoPageRoute(
                                            builder: (context) =>
                                                MatchingProfile_Screen(
                                                  name: _getByGotraModel!
                                                      .data![index].firstname
                                                      .toString(),
                                                  candidateId: _getByGotraModel!
                                                      .data![index].userId,
                                                  img: _getByGotraModel!
                                                              .data![index]
                                                              .profileImage!
                                                              .length >
                                                          0
                                                      ? _getByGotraModel!
                                                          .data![index]
                                                          .profileImage![0]
                                                          .filePath
                                                          .toString()
                                                      : "https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/1024px-No_image_available.svg.png",
                                                )));
                                  },
                                  child: Container(
                                    height: 210,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(18),

                                      // gradient: AppColors.appColor,
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.all(1),
                                      child: Container(
                                        height: 210,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Color(0xffFB5A57),
                                              width: 5),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          image: (_getByGotraModel != null &&
                                                  _getByGotraModel!.data !=
                                                      null &&
                                                  _getByGotraModel!
                                                      .data![index]
                                                      .profileImage!
                                                      .isNotEmpty &&
                                                  _getByGotraModel!
                                                          .data![index]
                                                          .profileImage!
                                                          .length >
                                                      0)
                                              ? DecorationImage(
                                                  image: NetworkImage(
                                                      _getByGotraModel!
                                                          .data![index]
                                                          .profileImage![0]
                                                          .filePath
                                                          .toString()
                                                      // byCastList[index][IMAGE]
                                                      ),
                                                  fit: BoxFit.cover)
                                              : DecorationImage(
                                                  image: CachedNetworkImageProvider(
                                                      "https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/1024px-No_image_available.svg.png"),
                                                ),
                                        ),
                                        child: Column(
                                          children: [
                                            Spacer(),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 0),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: Color(0xffffffff)
                                                      .withOpacity(0.9),
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    bottomRight:
                                                        Radius.circular(15),
                                                    bottomLeft:
                                                        Radius.circular(15),
                                                  ),
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 0,
                                                      right: 5,
                                                      top: 5),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(left: 5),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Flexible(
                                                              child: Text(
                                                                _getByGotraModel !=
                                                                            null &&
                                                                        _getByGotraModel!.data !=
                                                                            null
                                                                    ? _getByGotraModel!.data![index].firstname.toString() +
                                                                        " " +
                                                                        _getByGotraModel!
                                                                            .data![
                                                                                index]
                                                                            .lastname
                                                                            .toString() +
                                                                        ", " +
                                                                        _getByGotraModel!
                                                                            .data![index]
                                                                            .age
                                                                            .toString()
                                                                    : "",
                                                                maxLines: 1,
                                                                // AppConstants.joseph,
                                                                style: fontStyle.copyWith(
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        15,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 5,
                                                            ),
                                                            Image.asset(
                                                              ImagePath
                                                                  .dualprofile,
                                                              height: 16,
                                                              width: 16,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 5.0),
                                                        child: Text(
                                                          _getByGotraModel !=
                                                                      null &&
                                                                  _getByGotraModel!
                                                                          .data !=
                                                                      null
                                                              ? "Patel" +
                                                                  " | " +
                                                                  _getByGotraModel!
                                                                      .data![
                                                                          index]
                                                                      .height
                                                                      .toString()
                                                              : "",
                                                          maxLines: 1,
                                                          // AppConstants.castText,
                                                          style: matchscroll
                                                              .copyWith(
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  color: Colors
                                                                      .black),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 5,
                                                                right: 0,
                                                                bottom: 5),
                                                        child: GestureDetector(
                                                          onTap: () {
                                                            Navigator.push(
                                                              context,
                                                              CupertinoPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        E_Message_screen(),
                                                              ),
                                                            );
                                                          },
                                                          child: Container(
                                                            width:
                                                                MediaQuery.of(
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
                                                            alignment: Alignment
                                                                .center,
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
                            ),
                          )
                        : Text("No data in ByGotra"),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
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
                z.toggle!();
              },
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: AppColors.pink),
                child: Center(
                  child: Image.asset(
                    ImagePath.drawer,
                    width: 24,
                    height: 24,
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
          onTap: () {
            Navigator.push(
                context,
                CupertinoPageRoute(
                    builder: (context) => E_Notification_Screen()));
          },
          child: Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: AppColors.pink),
                  child: Center(
                    child: Image.asset(
                      ImagePath.notify,
                      width: 24,
                      height: 24,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  checkConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      getAllExeCandidate();
      getExeProfileAPI();
      getByCasteAPI();
      getAllCountEXEAPI();
      getByGotraAPI();
    } else if (connectivityResult == ConnectivityResult.wifi) {
      getAllExeCandidate();
      getExeProfileAPI();
      getByCasteAPI();
      getAllCountEXEAPI();
      getByGotraAPI();
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

  getAllCountEXEAPI() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var exeToken = pref.getString(EXE_TOKEN);
    final queryParameters = {
      "token": exeToken.toString(),
    };
    String queryString = Uri(queryParameters: queryParameters).query;
    var response = await dio.get(GET_ALL_COUNT_EXE_URL + "?" + queryString);
    if (response.statusCode == 200) {
      var data = response.data;
      if (data['status'] == 'Token is Expired') {
        pref.setString(EXE_TOKEN, "");
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (dialogcontext) => ExeLogin()),
            (route) => false);
      } else {
        setState(() {
          _allCountUsersModel = AllCountUsersModel.fromJson(response.data);
        });
      }

      matches = [
        AppConstants.castExe,
        AppConstants.gotraExe,
        AppConstants.matchesExe +
            "(" +
            _allCountUsersModel!.data!.getMyMatchCount.toString() +
            ")",
        AppConstants.jionExe,
      ];
    }
  }

  getByCasteAPI() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var exeToken = pref.getString(EXE_TOKEN);
    final queryParameters = {
      "token": exeToken.toString(),
    };
    String queryString = Uri(queryParameters: queryParameters).query;
    var response = await dio.get(GET_BY_CASTE_URL + "?" + queryString);
    if (response.statusCode == 200) {
      var data = response.data;
      if (data['status'] == 'Token is Expired') {
        pref.setString(EXE_TOKEN, "");
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (dialogcontext) => ExeLogin()),
            (route) => false);
      } else {
        setState(() {
          _getByCastModel = GetByCastModel.fromJson(data);
        });
      }
    }
  }

  getByGotraAPI() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var exeToken = pref.getString(EXE_TOKEN);
    final queryParameters = {
      "token": exeToken.toString(),
    };
    String queryString = Uri(queryParameters: queryParameters).query;
    log("gotra Url ::: ${GET_BY_GOTRA_URL + "?" + queryString}");
    var response = await dio.get(GET_BY_GOTRA_URL + "?" + queryString);
    if (response.statusCode == 200) {
      var data = response.data;
      if (data['status'] == 'Token is Expired') {
        pref.setString(EXE_TOKEN, "");
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (dialogcontext) => ExeLogin()),
            (route) => false);
      } else {
        setState(() {
          _getByGotraModel = GetByGotraModel.fromJson(data);
        });
      }
    }
  }

  getExeProfileAPI() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var exeToken = pref.getString(EXE_TOKEN);
    log("Exe Token :::: $exeToken");
    final queryParameters = {
      "token": exeToken.toString(),
    };
    String queryString = Uri(queryParameters: queryParameters).query;
    var response = await dio.get(GET_EXE_PROFILE_URL + "?" + queryString);
    if (response.statusCode == 200) {
      var result = response.data;
      if (result['status'] == 'Token is Expired') {
        pref.setString(EXE_TOKEN, "");
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (dialogcontext) => ExeLogin()),
            (route) => false);
      } else {
        if (result['success'] == true) {
          setState(() {
            _getExeProfileModel = GetExeProfileModel.fromJson(result);
          });
        }
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

  Future<bool> _onBackPressed() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(
          msg: 'Please click BACK again to exit',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM);
      return Future.value(false);
    }
    exit(0);
  }
}
