import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:matrimonial_app/Core/Constant/CommonUtils.dart';
import 'package:matrimonial_app/Core/Constant/url_constant.dart';
import 'package:matrimonial_app/Core/Constant/value_constants.dart';
import 'package:matrimonial_app/Executive%20Ui/Home%20screen/SettingScreen/contact_us_screen.dart';
import 'package:matrimonial_app/Executive%20Ui/Home%20screen/SettingScreen/privacy_screen.dart';
import 'package:matrimonial_app/Executive%20Ui/ProfileScreen/profile_screen.dart';
import 'package:matrimonial_app/Executive%20Ui/WalletScreen/PaymentScreen/payment_screen.dart';
import 'package:matrimonial_app/ModelClass/Executive_ModelClass/Get_Profile_Model.dart';
import 'package:matrimonial_app/Ui/Drawer/ProfileScreen/profile_screenn.dart';
import 'package:matrimonial_app/Ui/Home_screen/Notification/notification.dart';
import 'package:matrimonial_app/Utils/app_constants.dart';
import 'package:matrimonial_app/Utils/color_constants.dart';
import 'package:matrimonial_app/Utils/image_path_constants.dart';
import 'package:matrimonial_app/Utils/text_styles.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Account_Setting extends StatefulWidget {
  const Account_Setting({Key? key}) : super(key: key);

  @override
  State<Account_Setting> createState() => _Account_SettingState();
}

Color currentColor = Color.fromRGBO(230, 36, 87, 1.0);

class _Account_SettingState extends State<Account_Setting> {
  Dio dio = Dio();
  Color pickerColor = Color.fromRGBO(250, 36, 87, 1.0);
  void changeColor(Color color) => setState(() => pickerColor = color);
  bool blurImage = false;
  bool requestContact = true;
  bool onlineOffline = true;
  GetExeProfileModel? _getExeProfileModel;

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
                    InkWell(
                      splashColor: Colors.grey.withOpacity(0.5),
                      splashFactory: InkRipple.splashFactory,
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
                          InkWell(
                            splashColor: Colors.grey.withOpacity(0.5),
                            splashFactory: InkRipple.splashFactory,
                            onTap: () {
                              Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                      builder: (context) =>
                                          E_Executive_Profile()));
                            },
                            child: Container(
                              color: Colors.transparent,
                              child: Row(
                                children: [
                                  SizedBox(width: 10),
                                  onlineOffline == true
                                      ? Stack(
                                          children: [
                                            _getExeProfileModel != null &&
                                                    _getExeProfileModel!.data !=
                                                        null &&
                                                    _getExeProfileModel!
                                                        .data!
                                                        .profileImage!
                                                        .isNotEmpty
                                                ? Container(
                                                    height: 67,
                                                    width: 67,
                                                    decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        image: DecorationImage(
                                                            image: NetworkImage(
                                                              _getExeProfileModel!
                                                                  .data!
                                                                  .profileImage![
                                                                      0]
                                                                  .filePath
                                                                  .toString(),
                                                            ),
                                                            fit: BoxFit.fill)),
                                                  )
                                                : Container(
                                                    decoration: BoxDecoration(
                                                        border: Border.all(),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50)),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50),
                                                      child: (_getExeProfileModel != null &&
                                                              _getExeProfileModel!
                                                                      .data !=
                                                                  null &&
                                                              _getExeProfileModel!
                                                                      .data!
                                                                      .gender ==
                                                                  "Male")
                                                          ? Image.asset(
                                                              ImagePath
                                                                  .maleProfile,
                                                              height: 67,
                                                              width: 67,
                                                            )
                                                          : Image.asset(
                                                              ImagePath
                                                                  .femaleProfile,
                                                              height: 67,
                                                              width: 67,
                                                            ),
                                                    ),
                                                  )
                                          ],
                                        )
                                      : Stack(
                                          children: [
                                            Image.asset(
                                              ImagePath.eProfileImage,
                                              height: 67,
                                              width: 67,
                                            ),
                                          ],
                                        ),
                                  SizedBox(width: 15),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 10),
                                      Text(
                                        _getExeProfileModel != null &&
                                                _getExeProfileModel!.data !=
                                                    null
                                            ? _getExeProfileModel!
                                                    .data!.firstname
                                                    .toString() +
                                                " " +
                                                _getExeProfileModel!
                                                    .data!.lastname
                                                    .toString()
                                            : AppConstants.elonMusk,
                                        style: headingStyle.copyWith(
                                            color: Color(0xff333F52),
                                            fontSize: 19,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        _getExeProfileModel != null &&
                                                _getExeProfileModel!.data !=
                                                    null
                                            ? _getExeProfileModel!.data!.mobile
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
                                      Text(
                                        _getExeProfileModel != null &&
                                                _getExeProfileModel!.data !=
                                                    null
                                            ? _getExeProfileModel!.data!.email
                                                .toString()
                                            : AppConstants.elonMuskUserName,
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
                                    height: 27,
                                    child: Row(
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
                                                E_About_Screen()));
                                  },
                                  child: Container(
                                    height: 27,
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
                                                E_Contact_Us()));
                                  },
                                  child: Container(
                                    height: 27,
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
                              ),
                              /*   Padding(
                                padding:
                                    const EdgeInsets.only(left: 6, right: 6),
                                child: Divider(),
                              ), */
/* 
                              InkWell(
                                splashColor: Colors.grey.withOpacity(0.5),
                                splashFactory: InkRipple.splashFactory,
                                onTap: () {},
                                child: Container(
                                  height: 27,
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
                              */
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
                                  onTap: () {},
                                  child: Container(
                                    color: Colors.transparent,
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
                                                E_Payment_screen()));
                                  },
                                  child: Container(
                                    color: Colors.transparent,
                                    child: Row(
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
                                  ),
                                ),
                              ),
                              SizedBox(height: 5)
                            ],
                          ),
                        ),
                        SizedBox(height: 17),
                        GestureDetector(
                          onTap: () {
                            _disableDialogBox();
                          },
                          child: Container(
                            height: 41,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(13),
                                color: currentColor.withOpacity(0.3)),
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
                    height: 110,
                    width: 110,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(ImagePath.disableImage),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10, right: 10, top: 8),
                    child: Container(
                      child: Text(
                        AppConstants.sureText,
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
                      AppConstants.suresubtext,
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
                          gradient: AppColors.appColor,
                          borderRadius: BorderRadius.circular(9),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          "Disable",
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
}
