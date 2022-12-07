import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:matrimonial_app/Core/Constant/value_constants.dart';
import 'package:matrimonial_app/Executive%20Ui/Home%20screen/home_screen.dart';
import 'package:matrimonial_app/Executive%20Ui/Personal_detailsScreen/profiledetails_screen.dart';
import 'package:matrimonial_app/Executive%20Ui/widget/submit_button.dart';
import 'package:matrimonial_app/Utils/app_constants.dart';
import 'package:matrimonial_app/Utils/image_path_constants.dart';
import 'package:matrimonial_app/Utils/text_styles.dart';
import 'package:matrimonial_app/widget/Executive%20Side/eCommonButton.dart';
import 'package:pinput/pinput.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OTPScreen extends StatefulWidget {
  String text, mobile, email, fromValue;
  OTPScreen(
      {Key? key,
      required this.text,
      required this.mobile,
      required this.email,
      required this.fromValue,
      uid,
      String? countryCode})
      : super(key: key);

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  FToast? fToast;
  int _start = 030;
  Timer? _timer;
  bool otperror = false;
  bool isOtpShow = false;
  final pinController = TextEditingController();

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 00) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 1), () {
      isOtpShow = true;
    });
    fToast = FToast();
    fToast!.init(context);

    startTimer();
    Future.delayed(Duration(seconds: 1), () {
      otpShow();
    });
  }

  @override
  void dispose() {
    _timer!.cancel();
    super.dispose();
  }

  void otpShow() {
    Future.delayed(Duration(seconds: 1), () {
      isOtpShow = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffE5E5E5),
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Image.asset(ImagePath.backArrow),
          ),
        ),
        title: Text(
          AppConstants.verification,
          style: fontStyle.copyWith(color: Colors.black),
        ),
      ),
      body: Container(
        color: Color(0xffE5E5E5),
        height: height,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  RichText(
                    text: TextSpan(
                        text: "We have sent an OTP to ",
                        style: fontStyle.copyWith(color: Color(0xff838994)),
                        children: [
                          TextSpan(
                              text: '+91 XXXXX ',
                              style: fontStyle.copyWith(
                                  fontWeight: FontWeight.w600)),
                          TextSpan(
                              text: widget.mobile
                                  .substring(widget.mobile.length - 5),
                              style: fontStyle.copyWith(
                                  fontWeight: FontWeight.w600))
                        ]),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Pinput(
                    length: 6,
                    controller: pinController,
                    cursor: Container(
                        height: 21.87,
                        width: 2,
                        color: Color(0xff57606F).withOpacity(0.1)),
                    showCursor: true,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    submittedPinTheme: PinTheme(
                      width: 52,
                      height: 52,
                      textStyle: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w400),
                      decoration: BoxDecoration(
                        color: Color(0xffFB5A57),
                        borderRadius: BorderRadius.circular(11),
                      ),
                    ),
                    focusedPinTheme: PinTheme(
                      width: 52,
                      height: 52,
                      textStyle: TextStyle(color: Colors.white),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 19,
                              color: Color(0xff051B28).withOpacity(.09),
                              offset: Offset(5.0, 5.0))
                        ],
                        color: Colors.white,
                        border: Border.all(
                          color: Color(0xff79244D).withOpacity(0.23),
                        ),
                        borderRadius: BorderRadius.circular(11),
                      ),
                    ),
                    defaultPinTheme: PinTheme(
                      width: 52,
                      height: 52,
                      textStyle: TextStyle(color: Colors.white),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: Color(0xff79244D).withOpacity(0.2),
                        ),
                        borderRadius: BorderRadius.circular(11),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5, right: 0),
                    child: otperror == true
                        ? Center(
                            child: Text(
                              'Otp is invalid',
                              style: TextStyle(color: Colors.red),
                            ),
                          )
                        : otperror == false && isOtpShow == false
                            ? Text("")
                            : Center(
                                child: Text('OTP Sent Successfully',
                                    style: TextStyle(color: Colors.red)),
                              ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Center(
                    child: Text(
                      "00:$_start",
                      style: fontStyle,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Center(
                    child: RichText(
                      text: TextSpan(
                          text: "Didn’t Receive The code?",
                          style: fontStyle,
                          children: [
                            TextSpan(
                                text: " Resend Now",
                                style: fontStyle.copyWith(
                                    color: Color(0xffFB5A57)))
                          ]),
                    ),
                  ),
                  isOtpShow == true
                      ? Padding(
                          padding: const EdgeInsets.all(16),
                          child: CommonButton(
                              btnName: 'Verify Now', btnOnTap: () {}),
                        )
                      : Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: ECommonButton(
                            btnName: 'Verify Now',
                            btnOnTap: () async {
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              if (widget.text == pinController.text) {
                                if (widget.fromValue == "Login") {
                                  prefs.setBool(EXESHOWOTP, true);
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Zoom()),
                                      (route) => false);
                                } else if (widget.fromValue ==
                                    "isVerifyProfile") {
                                  Navigator.pop(context,'verifyProfile');
                                } else {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            Personaldetails_screen(
                                                mobileNo: widget.mobile),
                                      ));
                                }
                              } else {
                                otperror = true;
                              }
                            },
                          ),
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
