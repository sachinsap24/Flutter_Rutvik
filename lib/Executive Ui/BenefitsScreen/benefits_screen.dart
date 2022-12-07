// ignore_for_file: unused_local_variable

import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:matrimonial_app/Core/Constant/CommonUtils.dart';
import 'package:matrimonial_app/Core/Constant/url_constant.dart';
import 'package:matrimonial_app/Core/Constant/value_constants.dart';
import 'package:matrimonial_app/Executive%20Ui/Login/login_screen.dart';
import 'package:matrimonial_app/ModelClass/Executive_ModelClass/benefits_exe_model.dart';
import 'package:matrimonial_app/Utils/app_constants.dart';
import 'package:matrimonial_app/Utils/image_path_constants.dart';
import 'package:matrimonial_app/Utils/text_styles.dart';
import 'package:matrimonial_app/widget/Executive%20Side/eCommonButton.dart';
import 'package:matrimonial_app/widget/commonappbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

class Benefits_screen extends StatefulWidget {
  int? selectIndex;
  Benefits_screen({Key? key}) : super(key: key);

  @override
  State<Benefits_screen> createState() => _Benefits_screenState();
}

class _Benefits_screenState extends State<Benefits_screen> {
  List<bool> isOpen = [false];
  int? changeIndex;
  void showHide(int i) {
    setState(() {
      isOpen[i] = !isOpen[i];
    });
  }

  /* void showHide1(int i) {
    setState(() {
      isOpen1 = !isOpen1;
    });
  }

  void showHide2(int i) {
    setState(() {
      isOpen2 = !isOpen2;
    });
  }

  void showHide3(int i) {
    setState(() {
      isOpen3 = !isOpen3;
    });
  }

  void showHide4(int i) {
    setState(() {
      isOpen4 = !isOpen4;
    });
  }

  void showHide5(int i) {
    setState(() {
      isOpen5 = !isOpen5;
    });
  } */

  ExecutiveBenefitModel? _executiveBenefitModel;
  @override
  void initState() {
    changeIndex = widget.selectIndex;
    checkConnection();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color(0xffffffff),
      body: Column(
        children: [
          CommonAppbar(name: AppConstants.benefits),
          Container(
            height: 6,
            color: Color(0xffEDF1F5),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          AppConstants.gomatchmaker,
                          style: matchmaker,
                        ),
                        ListView.builder(
                          itemCount: _executiveBenefitModel != null &&
                                  _executiveBenefitModel!.data != null
                              ? _executiveBenefitModel!
                                  .data![1].commonquestion!.length
                              : 0,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _executiveBenefitModel != null &&
                                          _executiveBenefitModel!.data != null
                                      ? _executiveBenefitModel!.data![1]
                                          .commonquestion![index].question
                                          .toString()
                                      : "",
                                  style: earn,
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      '.',
                                      style: bullet,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 5),
                                      child: Text(
                                        _executiveBenefitModel != null &&
                                                _executiveBenefitModel!.data !=
                                                    null
                                            ? _executiveBenefitModel!.data![1]
                                                .commonquestion![index].answer
                                                .toString()
                                            : "",
                                        textAlign: TextAlign.start,
                                        style: bullet,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            );
                          },
                        ),
                        /* Text(
                          _executiveBenefitModel != null &&
                                  _executiveBenefitModel!.data != null
                              ? _executiveBenefitModel!
                                  .data![1].commonquestion![0].question
                                  .toString()
                              : "",
                          style: earn,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              '.',
                              style: bullet,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: Text(
                                _executiveBenefitModel != null &&
                                        _executiveBenefitModel!.data != null
                                    ? _executiveBenefitModel!
                                        .data![1].commonquestion![0].answer
                                        .toString()
                                    : "",
                                textAlign: TextAlign.start,
                                style: bullet,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          _executiveBenefitModel != null &&
                                  _executiveBenefitModel!.data != null
                              ? _executiveBenefitModel!
                                  .data![1].commonquestion![1].answer
                                  .toString()
                              : "",
                          style: earn,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              '.',
                              style: bullet,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: Text(
                                _executiveBenefitModel != null &&
                                        _executiveBenefitModel!.data != null
                                    ? _executiveBenefitModel!
                                        .data![1].commonquestion![1].answer
                                        .toString()
                                    : "",
                                textAlign: TextAlign.start,
                                style: bullet,
                              ),
                            ),
                          ],
                        ), */
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: width,
                          height: 3,
                          color: Color(0xffEDF1F5),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Text(
                          AppConstants.common,
                          style: matchermake,
                        ),
                        ListView.builder(
                          itemCount: _executiveBenefitModel != null &&
                                  _executiveBenefitModel!.data != null
                              ? _executiveBenefitModel!.data![0].benefit!.length
                              : 0,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    showHide(index);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 0, right: 0, top: 8, bottom: 8),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          _executiveBenefitModel != null &&
                                                  _executiveBenefitModel!
                                                          .data !=
                                                      null
                                              ? _executiveBenefitModel!.data![0]
                                                  .benefit![index].question
                                                  .toString()
                                              : "",
                                          style: earn,
                                        ),
                                        isOpen[index]
                                            ? Icon(Icons.remove)
                                            : Image.asset(
                                                ImagePath.plus,
                                                width: 18,
                                                height: 18,
                                              )
                                      ],
                                    ),
                                  ),
                                ),
                                isOpen[index]
                                    ? Padding(
                                        padding: const EdgeInsets.only(
                                            left: 0, right: 0),
                                        child: Text(
                                          _executiveBenefitModel != null &&
                                                  _executiveBenefitModel!
                                                          .data !=
                                                      null
                                              ? _executiveBenefitModel!.data![0]
                                                  .benefit![index].answer
                                                  .toString()
                                              : "",
                                          textAlign: TextAlign.start,
                                          style: headerstyle.copyWith(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xff67707D),
                                          ),
                                        ),
                                      )
                                    : Container(),
                              ],
                            );
                          },
                        ),
                        /* GestureDetector(
                          onTap: () {
                            showHide(0);
                          },
                          child: isOpen == false
                              ? Padding(
                                  padding: const EdgeInsets.only(
                                      left: 17, right: 17, top: 10, bottom: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        _executiveBenefitModel != null &&
                                                _executiveBenefitModel!.data !=
                                                    null
                                            ? _executiveBenefitModel!
                                                .data![0].benefit![0].question
                                                .toString()
                                            : "",
                                        style: earn,
                                      ),
                                      Image.asset(
                                        ImagePath.plus,
                                        width: 18,
                                        height: 18,
                                      )
                                    ],
                                  ),
                                )
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        SizedBox(width: 16),
                                        Text(
                                          _executiveBenefitModel != null &&
                                                  _executiveBenefitModel!
                                                          .data !=
                                                      null
                                              ? _executiveBenefitModel!
                                                  .data![0].benefit![0].question
                                                  .toString()
                                              : "",
                                          style: headerstyle.copyWith(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Spacer(),
                                        Icon(Icons.remove),
                                        SizedBox(width: 16),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 16, right: 16),
                                      child: Text(
                                        _executiveBenefitModel != null &&
                                                _executiveBenefitModel!.data !=
                                                    null
                                            ? _executiveBenefitModel!
                                                .data![0].benefit![0].answer
                                                .toString()
                                            : "",
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
                        Padding(
                          padding: const EdgeInsets.only(left: 16, right: 16),
                          child: Divider(),
                        ),
                        GestureDetector(
                          onTap: () {
                            showHide1(0);
                          },
                          child: isOpen1 == false
                              ? Padding(
                                  padding: const EdgeInsets.only(
                                      left: 17, right: 17, top: 10, bottom: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        _executiveBenefitModel != null &&
                                                _executiveBenefitModel!.data !=
                                                    null
                                            ? _executiveBenefitModel!
                                                .data![0].benefit![1].question
                                                .toString()
                                            : "",
                                        style: earn,
                                      ),
                                      Image.asset(
                                        ImagePath.plus,
                                        width: 18,
                                        height: 18,
                                      )
                                    ],
                                  ),
                                )
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        SizedBox(width: 16),
                                        Text(
                                          _executiveBenefitModel != null &&
                                                  _executiveBenefitModel!
                                                          .data !=
                                                      null
                                              ? _executiveBenefitModel!
                                                  .data![0].benefit![1].question
                                                  .toString()
                                              : "",
                                          style: headerstyle.copyWith(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Spacer(),
                                        Icon(Icons.remove),
                                        SizedBox(width: 16),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 16, right: 16),
                                      child: Text(
                                        _executiveBenefitModel != null &&
                                                _executiveBenefitModel!.data !=
                                                    null
                                            ? _executiveBenefitModel!
                                                .data![0].benefit![1].answer
                                                .toString()
                                            : "",
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
                        Padding(
                          padding: const EdgeInsets.only(left: 16, right: 16),
                          child: Divider(),
                        ),
                        GestureDetector(
                          onTap: () {
                            showHide2(0);
                          },
                          child: isOpen2 == false
                              ? Padding(
                                  padding: const EdgeInsets.only(
                                      left: 17, right: 17, top: 10, bottom: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        _executiveBenefitModel != null &&
                                                _executiveBenefitModel!.data !=
                                                    null
                                            ? _executiveBenefitModel!
                                                .data![0].benefit![2].question
                                                .toString()
                                            : "",
                                        style: earn,
                                      ),
                                      Image.asset(
                                        ImagePath.plus,
                                        width: 18,
                                        height: 18,
                                      )
                                    ],
                                  ),
                                )
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        SizedBox(width: 16),
                                        Text(
                                          _executiveBenefitModel != null &&
                                                  _executiveBenefitModel!
                                                          .data !=
                                                      null
                                              ? _executiveBenefitModel!
                                                  .data![0].benefit![2].question
                                                  .toString()
                                              : "",
                                          style: headerstyle.copyWith(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Spacer(),
                                        Icon(Icons.remove),
                                        SizedBox(width: 16),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 16, right: 16),
                                      child: Text(
                                        _executiveBenefitModel != null &&
                                                _executiveBenefitModel!.data !=
                                                    null
                                            ? _executiveBenefitModel!
                                                .data![0].benefit![2].answer
                                                .toString()
                                            : "",
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
                        Padding(
                          padding: const EdgeInsets.only(left: 16, right: 16),
                          child: Divider(),
                        ),
                        GestureDetector(
                          onTap: () {
                            showHide3(0);
                          },
                          child: isOpen3 == false
                              ? Padding(
                                  padding: const EdgeInsets.only(
                                      left: 17, right: 17, top: 10, bottom: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        _executiveBenefitModel != null &&
                                                _executiveBenefitModel!.data !=
                                                    null
                                            ? _executiveBenefitModel!
                                                .data![0].benefit![3].question
                                                .toString()
                                            : "",
                                        style: earn,
                                      ),
                                      Image.asset(
                                        ImagePath.plus,
                                        width: 18,
                                        height: 18,
                                      )
                                    ],
                                  ),
                                )
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        SizedBox(width: 16),
                                        Text(
                                          _executiveBenefitModel != null &&
                                                  _executiveBenefitModel!
                                                          .data !=
                                                      null
                                              ? _executiveBenefitModel!
                                                  .data![0].benefit![3].question
                                                  .toString()
                                              : "",
                                          style: headerstyle.copyWith(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Spacer(),
                                        Icon(Icons.remove),
                                        SizedBox(width: 16),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 16, right: 16),
                                      child: Text(
                                        _executiveBenefitModel != null &&
                                                _executiveBenefitModel!.data !=
                                                    null
                                            ? _executiveBenefitModel!
                                                .data![0].benefit![3].answer
                                                .toString()
                                            : "",
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
                        Padding(
                          padding: const EdgeInsets.only(left: 16, right: 16),
                          child: Divider(),
                        ),
                        GestureDetector(
                          onTap: () {
                            showHide4(0);
                          },
                          child: isOpen4 == false
                              ? Padding(
                                  padding: const EdgeInsets.only(
                                      left: 17, right: 17, top: 10, bottom: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        _executiveBenefitModel != null &&
                                                _executiveBenefitModel!.data !=
                                                    null
                                            ? _executiveBenefitModel!
                                                .data![0].benefit![4].question
                                                .toString()
                                            : "",
                                        style: earn,
                                      ),
                                      Image.asset(
                                        ImagePath.plus,
                                        width: 18,
                                        height: 18,
                                      )
                                    ],
                                  ),
                                )
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        SizedBox(width: 16),
                                        Text(
                                          _executiveBenefitModel != null &&
                                                  _executiveBenefitModel!
                                                          .data !=
                                                      null
                                              ? _executiveBenefitModel!
                                                  .data![0].benefit![4].question
                                                  .toString()
                                              : "",
                                          style: headerstyle.copyWith(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Spacer(),
                                        Icon(Icons.remove),
                                        SizedBox(width: 16),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 16, right: 16),
                                      child: Text(
                                        _executiveBenefitModel != null &&
                                                _executiveBenefitModel!.data !=
                                                    null
                                            ? _executiveBenefitModel!
                                                .data![0].benefit![4].answer
                                                .toString()
                                            : "",
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
                        Divider(),
                        GestureDetector(
                          onTap: () {
                            showHide5(0);
                          },
                          child: isOpen5 == false
                              ? Padding(
                                  padding: const EdgeInsets.only(
                                      left: 17, right: 17, top: 10, bottom: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        _executiveBenefitModel != null &&
                                                _executiveBenefitModel!.data !=
                                                    null
                                            ? _executiveBenefitModel!
                                                .data![0].benefit![4].question
                                                .toString()
                                            : "",
                                        style: earn,
                                      ),
                                      Image.asset(
                                        ImagePath.plus,
                                        width: 18,
                                        height: 18,
                                      )
                                    ],
                                  ),
                                )
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        SizedBox(width: 16),
                                        Text(
                                          _executiveBenefitModel != null &&
                                                  _executiveBenefitModel!
                                                          .data !=
                                                      null
                                              ? _executiveBenefitModel!
                                                  .data![0].benefit![4].question
                                                  .toString()
                                              : "",
                                          style: headerstyle.copyWith(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Spacer(),
                                        Icon(Icons.remove),
                                        SizedBox(width: 16),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 16, right: 16),
                                      child: Text(
                                        _executiveBenefitModel != null &&
                                                _executiveBenefitModel!.data !=
                                                    null
                                            ? _executiveBenefitModel!
                                                .data![0].benefit![4].answer
                                                .toString()
                                            : "",
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
                        ), */
                        SizedBox(
                          height: 25,
                        ),
                        Text(
                          AppConstants.executivebenefits,
                          style: matchermake,
                        ),
                        ListView.builder(
                          itemCount: _executiveBenefitModel != null &&
                                  _executiveBenefitModel!.data != null
                              ? _executiveBenefitModel!.data![2].payment!.length
                              : 0,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _executiveBenefitModel != null &&
                                          _executiveBenefitModel!.data != null
                                      ? _executiveBenefitModel!
                                          .data![2].payment![index].type
                                          .toString()
                                      : "",
                                  // AppConstants.executivecreditcard,
                                  style: earn,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      '.',
                                      style: bullet,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 5),
                                      child: Text(
                                        _executiveBenefitModel != null &&
                                                _executiveBenefitModel!.data !=
                                                    null
                                            ? _executiveBenefitModel!.data![2]
                                                .payment![index].content
                                                .toString()
                                            : "",
                                        // AppConstants.groccery,
                                        textAlign: TextAlign.start,
                                        style: bullet,
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            );
                          },
                        ),
                        /* Text(
                          AppConstants.executivecreditcard,
                          style: earn,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              '.',
                              style: bullet,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: Text(
                                AppConstants.groccery,
                                textAlign: TextAlign.start,
                                style: bullet,
                              ),
                            )
                          ],
                        ), */
                        /* SizedBox(
                          height: 15,
                        ),
                        Text(
                          AppConstants.executivedebitcard,
                          style: earn,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              '.',
                              style: bullet,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: Text(
                                AppConstants.groccery,
                                textAlign: TextAlign.start,
                                style: bullet,
                              ),
                            )
                          ],
                        ), */
                        SizedBox(
                          height: 25,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16, right: 16),
                          child: ECommonButton(
                              btnName: 'Login',
                              btnOnTap: () {
                                Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                        builder: (context) => ExeLogin()));
                              }),
                        ),
                        SizedBox(
                          height: 35,
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void checkConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      CommonUtils.showProgressLoading(context);
      getBenefits();
    } else if (connectivityResult == ConnectivityResult.wifi) {
      CommonUtils.hideProgressLoading();
      getBenefits();
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

  getBenefits() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString(EXE_TOKEN);
    final queryParameters = {
      "token": token.toString(),
    };
    String queryString = Uri(queryParameters: queryParameters).query;
    CommonUtils.showProgressLoading(context);
    var response = await http.get(Uri.parse(EXE_BENEFITS_URL));

    if (response.statusCode == 200) {
      CommonUtils.hideProgressLoading();
      if (mounted) {
        setState(() {
          _executiveBenefitModel =
              ExecutiveBenefitModel.fromJson(jsonDecode(response.body));
        });
      }
      for (var i = 0;
          i < _executiveBenefitModel!.data![0].benefit!.length;
          i++) {
        isOpen.add(false);
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
