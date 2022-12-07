import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:matrimonial_app/Core/Constant/CommonUtils.dart';
import 'package:matrimonial_app/Core/Constant/url_constant.dart';
import 'package:matrimonial_app/Core/Constant/value_constants.dart';
import 'package:matrimonial_app/Executive%20Ui/Home%20screen/SettingScreen/privacy_screen.dart';
import 'package:matrimonial_app/Executive%20Ui/Login/LoginModel/LoginModel.dart';
import 'package:matrimonial_app/Executive%20Ui/Login/otp_screen.dart';
import 'package:matrimonial_app/Executive%20Ui/Register_Screens/Mobile_no_screen.dart';
import 'package:matrimonial_app/Ui/AboutScreen/about_screen.dart';
import 'package:matrimonial_app/Utils/app_constants.dart';
import 'package:matrimonial_app/Utils/color_constants.dart';
import 'package:matrimonial_app/Utils/image_path_constants.dart';
import 'package:matrimonial_app/Utils/text_styles.dart';
import 'package:matrimonial_app/widget/Executive%20Side/eCommonButton.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:matrimonial_app/Ui/Login/login_screen.dart';

import 'package:http/http.dart' as http;

class ExeLogin extends StatefulWidget {
  const ExeLogin({Key? key}) : super(key: key);

  @override
  State<ExeLogin> createState() => _ExeLoginState();
}

class _ExeLoginState extends State<ExeLogin> {
  FToast? fToast;
  bool ftoast = true;
  String? countryCodeShow = '(+91)';
  var name;
  var email;
  TextEditingController _mobile = TextEditingController();
  TextEditingController _email = TextEditingController();

  String selectedCountry = "";
  bool ismobileEmptyChek = false;
  bool ismobileValidChek = false;
  bool isCheckValue = false;
  bool loginerror = false;
  bool check = false;
  String isNotAuthorize = "";
  bool isAuthorize = false;
  bool dontcheck = false;

  final _formKey = GlobalKey<FormState>();
  E_LoginModel? _e_loginModel;
  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast!.init(context);
  }

  Widget build(BuildContext context) {
    Timer(Duration(seconds: 2000), () {
      setState(() {
        ftoast = true;
      });
    });
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    fToast = FToast();
    fToast!.init(context);
    return Scaffold(
        backgroundColor: Color(0xffE5E5E5),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(top: 0, right: 16, left: 16),
              child: Container(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        height: 75,
                        child: Image.asset(ImagePath.appLogo),
                      ),
                      SizedBox(
                        height: 21,
                      ),
                      Container(
                        height: 50,
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            AppConstants.welcome,
                            style: GoogleFonts.montserrat(
                                fontSize: 22, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Text(
                            "You can now continue with your mobile number to find your Good Partner.",
                            textAlign: TextAlign.center,
                            style: fontStyle.copyWith(
                                color: Color(0xff8186A1),
                                fontWeight: FontWeight.w400)),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 55,
                        decoration: BoxDecoration(
                          border: Border.all(
                              width: 1.0,
                              color: Color(0xff7572E7).withOpacity(0.23)),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(11),
                          boxShadow: [
                            BoxShadow(
                              spreadRadius: 0.9,
                              blurRadius: 4,
                              offset: Offset(
                                .0,
                                3,
                              ),
                              color: Color(0xff000000).withOpacity(.25),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            CountryCodePicker(
                              padding: EdgeInsets.only(
                                  left: 8, right: 0, top: 8, bottom: 10),
                              onChanged: (CountryCode countryCode) {
                                setState(() {
                                  countryCodeShow = countryCode.toString();
                                });
                              },
                              initialSelection: "IN",
                              favorite: ['(+91)', 'IN'],
                              showCountryOnly: false,
                              showFlag: true,
                              showFlagDialog: true,
                              textStyle: TextStyle(
                                  fontSize: 15,
                                  color: Color(0xff646B7B),
                                  fontWeight: FontWeight.bold),
                            ),
                            Expanded(
                              child: TextFormField(
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(10),
                                  FilteringTextInputFormatter.allow(
                            RegExp("[0-9]")),
                                ],
                                keyboardType: TextInputType.number,
                                controller: _mobile,
                                onChanged: (value) {
                                  
                                },
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: AppConstants.enteryournumber,
                                    hintStyle: TextStyle(
                                        color: Color(0xff677294),
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400)),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 5,
                        ),
                        child: Text(
                          loginerror == true
                              ? "Phone Number Should be of 10 Digit"
                              : ismobileEmptyChek
                                  ? "Enter a Phone Number!"
                                  : ismobileValidChek
                                      ? 'Please enter valid phone number'
                                      : isAuthorize
                                          ? isNotAuthorize
                                          : "",
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 1,
                            width: 130,
                            color: Color.fromARGB(255, 194, 191, 191),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "OR",
                            style: TextStyle(color: AppColors.grey),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            height: 1,
                            width: 130,
                            color: Color.fromARGB(255, 194, 191, 191),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        height: 55,
                        decoration: BoxDecoration(
                          border: Border.all(
                              width: 1.0,
                              color: Color(0xff7572E7).withOpacity(0.23)),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(11),
                          boxShadow: [
                            BoxShadow(
                              spreadRadius: 0.2,
                              blurRadius: 10,
                              offset: Offset(
                                4,
                                6,
                              ),
                              color: Color(0xff000000).withOpacity(.1),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Enter Your Email",
                                hintStyle: TextStyle(
                                    color: Color(0xff677294).withOpacity(0.5),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400)),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                check = !check;
                                dontcheck = false;
                                print(check);
                              });
                            },
                            child: check == false
                                ? Container(
                                    width: 20,
                                    height: 20,
                                    color: Colors.transparent,
                                    child: Container(
                                      width: 16,
                                      height: 16,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(2),
                                          border: Border.all(
                                            color: Color.fromARGB(
                                                255, 194, 191, 191),
                                          )),
                                    ),
                                  )
                                : Image.asset(
                                    ImagePath.logincheck,
                                    width: 20,
                                    height: 20,
                                  ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  check = !check;
                                  dontcheck = false;
                                  print(check);
                                });
                              },
                              child: Container(
                                child: RichText(
                                    textAlign: TextAlign.start,
                                    maxLines: 3,
                                    text: TextSpan(
                                        text: "I have read and accept the",
                                        style: fontStyle.copyWith(
                                            color: Color(0xff8186A1),
                                            fontSize: 11.5),
                                        children: [
                                          TextSpan(
                                              recognizer: TapGestureRecognizer()
                                                ..onTap = () {
                                                  Navigator.push(
                                                      context,
                                                      CupertinoPageRoute(
                                                          builder: (context) =>
                                                              E_About_Screen()));
                                                },
                                              text: " Privacy Policy ",
                                              style: fontStyle.copyWith(
                                                  color: Color(0xffFB5A57),
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500)),
                                          TextSpan(
                                              text:
                                                  'and agree \nthat my personal data will be processed by you')
                                        ])),
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      (isCheckValue == true)
                          ? Container(
                              height: 40,
                              width: 280,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  20,
                                ),
                                color: Colors.black,
                              ),
                              child: Center(
                                  child: Text(
                                'Please accept privacy policy for login',
                                style: TextStyle(
                                    fontSize: 14, color: Colors.white),
                              )),
                            )
                          : SizedBox(
                              height: 40,
                            ),
                      Text(
                        'Forgot Your Mobile Number?',
                        style: TextStyle(decoration: TextDecoration.underline),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      RichText(
                        text: TextSpan(
                            text: "Don't have an Account? ",
                            style: fontStyle.copyWith(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: Color(0xff8186A1)),
                            children: [
                              TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => MobileNoScreen(),
                                      ),
                                    );
                                  },
                                text: 'Register Now ',
                                style: fontStyle.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xffE16284),
                                ),
                              )
                            ]),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ECommonButton(
                        btnName: "Login Now",
                        btnOnTap: () {
                          if (_formKey.currentState!.validate()) {
                            if (_mobile.text.isEmpty) {
                              if (_mobile.text.isEmpty &&
                                  _email.text.isNotEmpty) {
                                if (check == false) {
                                  /*    setState(() {
                                    ismobileEmptyChek = false;
                                  }); */
                                  print("not check privacy");
                                  setState(() {});
                                  privacyPolicyToast();
                                } else {
                                  checkConnection();
                                }
                              } else {
                                setState(() {
                                  loginerror = false;
                                  ismobileEmptyChek = true;
                                  // loginerror = false;
                                  // isNotAuthorize = "";
                                });
                              }

                              print("Please enter mobile number");
                            } else if (_mobile.text.length < 10 ||
                                _email.text.length < 0) {
                              setState(() {
                                ismobileEmptyChek = false;
                                loginerror = true;
                                // ismobileValidChek = true;
                              });
                            } else {
                              setState(() {
                                ismobileEmptyChek = false;
                                ismobileEmptyChek = false;
                                loginerror = false;
                                isNotAuthorize = "";
                              });
                              if (check == false) {
                                setState(() {
                                  isCheckValue = true;
                                  Future.delayed(Duration(seconds: 2), () {
                                    setState(() {
                                      isCheckValue = false;
                                    });
                                  });
                                  ismobileEmptyChek = false;
                                });
                                print("not check privacy");
                                // privacyPolicyToast();
                              } else {
                                checkConnection();
                              }
                            }
                          }
                          /*   if (_formKey.currentState!.validate()) {
                            if (_mobile.text.isEmpty) {
                              setState(() {
                                ismobileEmptyChek = true;
                                ismobileEmptyChek = false;
                                loginerror = false;
                                isNotAuthorize = "";
                              });
                              print("Please enter mobile number");
                            } else if (_mobile.text.length < 10) {
                              setState(() {
                                ismobileEmptyChek = false;
                                loginerror = true;
                                // ismobileValidChek = true;
                              });
                            } else {
                              setState(() {
                                ismobileEmptyChek = false;
                                ismobileEmptyChek = false;
                                loginerror = false;
                                isNotAuthorize = "";
                              });
                              if (check == false) {
                                setState(() {
                                  ismobileEmptyChek = false;
                                });
                                print("not check privacy");
                                privacyPolicyToast();
                              } else {
                                checkConnection();
                              }
                            }
                          } */
                          /* if (_formKey.currentState!.validate() &&
                              check == true) {
                            log("This is my debug state done and all clear");

                            setState(() {
                              ismobileEmptyChek = false;
                              ismobileValidChek = false;
                            });

                            checkConnection();
                          } else if (check == false) {
                            log("This is my debug check policy");
                            if (_mobile.text.trim().isNotEmpty &&
                                _mobile.text.trim().length <= 10) {
                              log("This is my debug mobile length");
                              setState(() {
                                ismobileEmptyChek = false;
                                ismobileValidChek = true;
                              });
                            } else {
                              setState(() {
                                log("This is my debug mobile empty");
                                ismobileEmptyChek = true;
                              });
                            }
                            privacyPolicyToast();
                          }*/
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 1,
                            width: 90,
                            color: Color.fromARGB(255, 194, 191, 191),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Or sign in with",
                            style: TextStyle(
                              color: Color(
                                0xff777777,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            height: 1,
                            width: 90,
                            color: Color.fromARGB(255, 194, 191, 191),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(13),
                                color: Color(0xff475993).withOpacity(0.1)),
                            height: 54,
                            width: width * 0.45,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  ImagePath.fblogo,
                                  height: 24,
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  'FACEBOOK',
                                  style: fontStyle.copyWith(
                                      color: Color(0xff475993),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 17),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color(0xffEB4132).withOpacity(0.1)),
                            height: 54,
                            width: width * 0.45,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  ImagePath.googlelogo,
                                  height: 24,
                                  width: 24,
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  'GOOGLE',
                                  style: fontStyle.copyWith(
                                      color: Color(0xffEB4132),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 17),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      RichText(
                        text: TextSpan(
                            text: 'Interested In Marrige? ',
                            style: fontStyle.copyWith(
                                fontWeight: FontWeight.w600, fontSize: 14),
                            children: [
                              TextSpan(
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Login()),
                                      );
                                    },
                                  text: 'Become User ',
                                  style: fontStyle.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xffE16284)))
                            ]),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }

  privacyPolicyToast() async {
    fToast!.showToast(
      fadeDuration: 500,
      toastDuration: Duration(seconds: 2),
      gravity: ToastGravity.CENTER,
      positionedToastBuilder: ((context, child) {
        return Positioned(
          child: child,
          left: 0,
          right: 0,
          bottom: 220,
        );
      }),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 40,
            width: 280,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                20,
              ),
              color: Colors.black,
            ),
            child: Center(
                child: Text(
              'Please accept privacy policy for login',
              style: TextStyle(fontSize: 14, color: Colors.white),
            )),
          ),
        ],
      ),
    );
  }

  void checkConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      loginApi();
    } else if (connectivityResult == ConnectivityResult.wifi) {
      loginApi();
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Alert"),
              content: Text("Check Your Internet Connection"),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Ok")),
              ],
            );
          });
    }
  }

  loginApi() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    CommonUtils.showProgressLoading(context);
    final msg = {
      "email": _email.text,
      "mobile": _mobile.text.toString(),
      "otp": "123456",
      "type": "2"
    };
    var response = await http.post(
      Uri.parse(LOGIN_URl),
      body: msg,
    );
    print(response.body);
    if (response.statusCode == 200) {
      CommonUtils.hideProgressLoading();
      E_LoginModel e_loginModel =
          E_LoginModel.fromJson(jsonDecode(response.body));

      prefs.setBool(EXESHOWLOGIN, true);
      prefs.setString(EXE_MOBILE, _mobile.text);
      prefs.setString(EXE_TOKEN, e_loginModel.token.toString());

      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => OTPScreen(
                  uid: e_loginModel,
                  mobile: _mobile.text,
                  email: _email.text,
                  countryCode: countryCodeShow,
                  text: '123456',
                  fromValue: 'Login',
                )),
      );
    } else if (response.statusCode == 400) {
      CommonUtils.hideProgressLoading();
      setState(() {
        loginerror = true;
      });
    } else if (response.statusCode == 500) {
      var res = jsonDecode(response.body);
      setState(() {
        isAuthorize = true;
      });

      CommonUtils.hideProgressLoading();
      isNotAuthorize = res['message'];
      /* Fluttertoast.showToast(
          msg: res['message'],
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Color(0xffE16284),
          textColor: Colors.white,
          fontSize: 16.0); */
    } else {
      CommonUtils.hideProgressLoading();
    }
  }
}

class E_ErrorResponse {
  String? timestamp;
  int? status;
  String? error;
  String? message;
  String? path;

  E_ErrorResponse(
      {this.timestamp, this.status, this.error, this.message, this.path});

  E_ErrorResponse.fromJson(Map<String, dynamic> json) {
    timestamp = json['timestamp'];
    status = json['status'];
    error = json['error'];
    message = json['message'];
    path = json['path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['timestamp'] = timestamp;
    data['status'] = status;
    data['error'] = error;
    data['message'] = message;
    data['path'] = path;
    return data;
  }
}
