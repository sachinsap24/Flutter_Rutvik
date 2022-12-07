
import 'dart:async';

import 'package:custom_timer/custom_timer.dart';
import 'package:flutter/material.dart';
import 'package:matrimonial_app/Executive%20Ui/Home%20screen/home_screen.dart';

import '../../Utils/app_constants.dart';
import '../../Utils/image_path_constants.dart';
import '../../Utils/text_styles.dart';

class Review_screen extends StatefulWidget {
  const Review_screen({Key? key}) : super(key: key);

  @override
  State<Review_screen> createState() => _Review_screenState();
}

class _Review_screenState extends State<Review_screen> {
  CustomTimerController _controller = CustomTimerController();
  @override
  void initState() {
    super.initState();
    _controller.start();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Image.asset(
                  ImagePath.executive_reviewing,
                  height: 370,
                  width: 370,
                  fit: BoxFit.fill,
                ),
              ),
              Center(
                child: Text(
                  AppConstants.reviewname,
                  style: reviewStyle,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8),
                child: Text(
                  AppConstants.reviewdes,
                  textAlign: TextAlign.center,
                  style: reviewStyle.copyWith(
                      color: Color(0xff838994),
                      fontSize: 15,
                      fontWeight: FontWeight.w400),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  AppConstants.reviewtry,
                  textAlign: TextAlign.center,
                  style: reviewStyle.copyWith(
                      color: Color(0xff838994),
                      fontSize: 17,
                      fontWeight: FontWeight.w300),
                ),
              ),
              SizedBox(height: 10),
              CustomTimer(
                  controller: _controller,
                  begin: Duration(hours: 2, minutes: 35, seconds: 25),
                  end: Duration(hours: 0,minutes: 00,seconds: 1),
                  builder: (time) {
                    return Text(
                      "${time.hours}h : ${time.minutes}m : ${time.seconds}s",
                      style: reviewStyle,
                    );
                  }),
             
              Spacer(),

            
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Zoom()));
                  },
                  child: Container(
                    height: 48,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      color: Color(0xffEFEFEF),
                    ),
                    child: Center(
                      child: Text(
                        AppConstants.appPending,
                        style: TextStyle(
                            color: Color(0xff7E7E7E),
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15)
            ],
          ),
        ),
      ),
    );
  }
}
