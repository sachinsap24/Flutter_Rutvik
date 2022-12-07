import 'dart:convert';
import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:matrimonial_app/Core/Constant/CommonUtils.dart';
import 'package:matrimonial_app/Core/Constant/url_constant.dart';
import 'package:matrimonial_app/Core/Constant/value_constants.dart';
import 'package:matrimonial_app/ModelClass/Executive_ModelClass/Add_Looking_For_Model.dart';
import 'package:matrimonial_app/ModelClass/Executive_ModelClass/Get_Looking_For_Model.dart';
import 'package:matrimonial_app/ModelClass/Executive_ModelClass/Update_Exe_Looking_for_Model.dart';
import 'package:matrimonial_app/ModelClass/UserPanel_ModelClass/DropDown_Datas/age_model.dart';
import 'package:matrimonial_app/ModelClass/UserPanel_ModelClass/DropDown_Datas/annualincome_model.dart';
import 'package:matrimonial_app/ModelClass/UserPanel_ModelClass/DropDown_Datas/diet_model.dart';
import 'package:matrimonial_app/ModelClass/UserPanel_ModelClass/DropDown_Datas/gotra_model.dart';
import 'package:matrimonial_app/ModelClass/UserPanel_ModelClass/DropDown_Datas/height_model.dart';
import 'package:matrimonial_app/ModelClass/UserPanel_ModelClass/DropDown_Datas/worktype_model.dart';
import 'package:matrimonial_app/Utils/app_constants.dart';
import 'package:matrimonial_app/Utils/color_constants.dart';
import 'package:matrimonial_app/Utils/image_path_constants.dart';
import 'package:matrimonial_app/Utils/text_styles.dart';
import 'package:matrimonial_app/widget/Executive%20Side/eCommonButton.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:matrimonial_app/ModelClass/UserPanel_ModelClass/DropDown_Datas/cast_model.dart'
    as castData;
import 'package:http/http.dart' as http;

class LookingFor extends StatefulWidget {
  String? isUpdate;
  final Function? onBack;
  var candidateId;
  LookingFor({Key? key, this.onBack, this.isUpdate, this.candidateId})
      : super(key: key);

  @override
  State<LookingFor> createState() => _LookingForState();
}

class _LookingForState extends State<LookingFor> {
  List<String> heShould = ['5’3” to 6’11”', '5’4” to 6’12”'];
  String? dropdownheShould;
  bool isHeight = false;
  bool isHeighTo = false;
  bool isAge = false;
  bool isAgeTo = false;
  List<String> ageRange = ['25 to 31 years', '28 to 30 years'];
  String? dropdownageRange;
  HeightModel? _heightModel;
  HeightModel? _heightModelTo;
  HeightData? _heightDataTo;
  HeightData? _heightDataFrom;
  AgeModel? _ageModel;
  AgeModel? _ageModelTo;
  AgeData? _ageDataFrom;
  AgeData? _ageDataTo;
  workTypeModel? _worktypeModel;
  WorktypeData? _worktypeData;
  AnnualincomeModel? _annualincomeModel;
  AnnualData? _annualincomedata;
  DietModel? _dietModel;
  DietData? _dietData;
  castData.castModel? _castModel;
  castData.castData? _data;
  gotraModel? _gotraModel;
  GotraData? _gotraData;
  Dio dio = Dio();
  @override
  void initState() {
    super.initState();

    checkConnection();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.only(
          left: width * 0.03, right: width * 0.03, top: height * 0.01),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppConstants.addProfileDetails,
              textAlign: TextAlign.center,
              style: fontStyle.copyWith(
                height: 1.3,
                color: AppColors.titleColor,
                fontSize: 15,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: height * 0.02, left: width * 0.02),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppConstants.heShouldBe,
                    style: TextStyle(
                      color: Color(0xff4D4D4D),
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 0),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(top: 5.0),
                                  child: Container(
                                    width: width,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(13),
                                      border: Border.all(
                                        color: Color(0xffD1D1D1),
                                        width: 1.5,
                                      ),
                                    ),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton2<HeightData>(
                                        focusColor: Colors.white,
                                        buttonHeight: 43,
                                        dropdownDecoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(13),
                                        ),
                                        icon: Row(
                                          children: [
                                            isHeight
                                                ? Container(
                                                    child: Text(
                                                      "(Inches)",
                                                      style: TextStyle(
                                                          fontSize: 10,
                                                          color: Colors.black),
                                                    ),
                                                  )
                                                : Container(),
                                            SizedBox(
                                              width: 0,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 8.0),
                                              child: Container(
                                                height: 15,
                                                width: 15,
                                                padding:
                                                    EdgeInsets.only(right: 0),
                                                child: Center(
                                                  child: Image.asset(
                                                    ImagePath.forward,
                                                    height: 24,
                                                    width: 24,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        hint: Padding(
                                          padding: EdgeInsets.only(left: 7),
                                          child: Text(
                                            'Select Height',
                                            style: fontStyle.copyWith(
                                                color: Color(0xff777777),
                                                fontWeight: FontWeight.w500,
                                                fontSize: 12),
                                          ),
                                        ),
                                        dropdownMaxHeight: 200,
                                        itemHeight: 20,
                                        items: addDividersAfterItemsHeight(
                                          (_heightModel != null)
                                              ? _heightModel!.data!
                                              : [],
                                        ),
                                        customItemsIndexes: getDividersIndexes(
                                          (_heightModel != null)
                                              ? _heightModel!.data!
                                              : [],
                                        ),
                                        value: _heightDataFrom,
                                        onChanged: (newValue) {
                                          print(newValue);
                                          setState(() {
                                            _heightDataTo = null;
                                            isHeight = true;
                                            _heightDataFrom = newValue;
                                          });
                                          if (_heightDataFrom != null) {
                                            getHeightTo();
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(AppConstants.to),
                      SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: Container(
                          width: width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(13),
                            border: Border.all(
                              color: Color(0xffD1D1D1),
                              width: 1.5,
                            ),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton2<HeightData>(
                              focusColor: Colors.white,
                              buttonHeight: 43,
                              dropdownDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(13),
                              ),
                              icon: Padding(
                                padding: EdgeInsets.all(0.0),
                                child: Row(
                                  children: [
                                    isHeighTo
                                        ? Text(
                                            '(Inches)',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 12),
                                          )
                                        : Container(),
                                    SizedBox(
                                      width: 0,
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 8.0),
                                      child: Container(
                                        height: 15,
                                        width: 15,
                                        child: Center(
                                          child: Image.asset(
                                            ImagePath.forward,
                                            height: 24,
                                            width: 24,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              hint: Padding(
                                padding: EdgeInsets.only(left: 7),
                                child: Text(
                                  'Select Height',
                                  style: fontStyle.copyWith(
                                      color: Color(0xff777777),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 10),
                                ),
                              ),
                              dropdownMaxHeight: 200,
                              itemHeight: 20,
                              items: addDividersAfterItemsHeight(
                                  (_heightModelTo != null)
                                      ? _heightModelTo!.data!
                                      : []),
                              customItemsIndexes: getDividersIndexes(
                                  (_heightModelTo != null)
                                      ? _heightModelTo!.data!
                                      : []),
                              value: _heightDataTo,
                              onChanged: (newValue) {
                                print(newValue);
                                setState(() {
                                  isHeighTo = true;
                                  _heightDataTo = newValue;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Age Range',
                          style: TextStyle(
                            color: Color(0xff4D4D4D),
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 0),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(top: 5.0),
                                      child: Container(
                                        width: width,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                            color: Color(0xffD1D1D1),
                                            width: 1.5,
                                          ),
                                        ),
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton2<AgeData>(
                                            focusColor: Colors.white,
                                            buttonHeight: 43,
                                            dropdownDecoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            icon: Padding(
                                              padding: EdgeInsets.all(0.0),
                                              child: Row(
                                                children: [
                                                  isAge
                                                      ? Text(
                                                          '(Year)',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 12),
                                                        )
                                                      : Container(),
                                                  SizedBox(
                                                    width: 2,
                                                  ),
                                                  Container(
                                                    height: 17,
                                                    width: 17,
                                                    padding: EdgeInsets.only(
                                                        right: 10),
                                                    child: Center(
                                                      child: Image.asset(
                                                        ImagePath.forward,
                                                        height: 24,
                                                        width: 24,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            hint: Padding(
                                              padding: EdgeInsets.only(left: 8),
                                              child: Text(
                                                'Select Age',
                                                style: fontStyle.copyWith(
                                                    color: Color(0xff777777),
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 14),
                                              ),
                                            ),
                                            dropdownMaxHeight: 200,
                                            itemHeight: 20,
                                            items: addDividersAfterItemsAge(
                                                (_ageModel != null)
                                                    ? _ageModel!.data!
                                                    : []),
                                            customItemsIndexes:
                                                getDividersIndexes(
                                                    (_ageModel != null)
                                                        ? _ageModel!.data!
                                                        : []),
                                            value: _ageDataFrom,
                                            onChanged: (newValue) {
                                              print(newValue);
                                              setState(() {
                                                _ageDataTo = null;
                                                isAge = true;
                                                _ageDataFrom = newValue;
                                              });
                                              if (_ageDataFrom != null) {
                                                getAgeTo();
                                              }
                                            },
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(AppConstants.to),
                          SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: Container(
                              width: width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(13),
                                border: Border.all(
                                  color: Color(0xffD1D1D1),
                                  width: 1.5,
                                ),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton2<AgeData>(
                                  focusColor: Colors.white,
                                  buttonHeight: 43,
                                  dropdownDecoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(13),
                                  ),
                                  icon: Padding(
                                    padding: EdgeInsets.all(0.0),
                                    child: Row(
                                      children: [
                                        isAgeTo
                                            ? Text(
                                                '(Year)',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 12),
                                              )
                                            : Container(),
                                        SizedBox(
                                          width: 2,
                                        ),
                                        Container(
                                          height: 17,
                                          width: 17,
                                          padding: EdgeInsets.only(right: 10),
                                          child: Center(
                                            child: Image.asset(
                                              ImagePath.forward,
                                              height: 24,
                                              width: 24,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  hint: Padding(
                                    padding: EdgeInsets.only(left: 10),
                                    child: Text(
                                      'Select Age',
                                      style: fontStyle.copyWith(
                                          color: Color(0xff777777),
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14),
                                    ),
                                  ),
                                  dropdownMaxHeight: 200,
                                  itemHeight: 20,
                                  items: addDividersAfterItemsAge(
                                      (_ageModelTo != null)
                                          ? _ageModelTo!.data!
                                          : []),
                                  customItemsIndexes: getDividersIndexes(
                                      (_ageModelTo != null)
                                          ? _ageModelTo!.data!
                                          : []),
                                  value: _ageDataTo,
                                  onChanged: (newValue) {
                                    print(newValue);
                                    setState(() {
                                      isAgeTo = true;
                                      _ageDataTo = newValue;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Work Type",
                    style: TextStyle(
                      color: Color(0xff4D4D4D),
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    width: width,
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(13),
                      border: Border.all(
                        color: Color(0xffD1D1D1),
                        width: 1.5,
                      ),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton2<WorktypeData>(
                        focusColor: Colors.white,
                        buttonHeight: 43,
                        dropdownDecoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(13),
                        ),
                        icon: Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Container(
                            height: 15,
                            width: 15,
                            child: Center(
                              child: Image.asset(
                                ImagePath.forward,
                                height: 24,
                                width: 24,
                              ),
                            ),
                          ),
                        ),
                        hint: Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            'Select WorkType',
                            style: fontStyle.copyWith(
                                color: Color(0xff777777),
                                fontWeight: FontWeight.w500,
                                fontSize: 14),
                          ),
                        ),
                        dropdownMaxHeight: 200,
                        itemHeight: 20,
                        items: addDividersAfterItemsWorkType(
                            (_worktypeModel != null)
                                ? _worktypeModel!.data!
                                : []),
                        customItemsIndexes: getDividersIndexes(
                            (_worktypeModel != null)
                                ? _worktypeModel!.data!
                                : []),
                        value: _worktypeData,
                        onChanged: (newValue) {
                          print(newValue);
                          setState(() {
                            _worktypeData = newValue;
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Text(
                    "Annual Income",
                    style: headerstyle.copyWith(
                        color: Color(0xff4D4D4D),
                        fontWeight: FontWeight.w500,
                        fontSize: 15),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(13),
                      border: Border.all(
                        color: Color(0xffD1D1D1),
                        width: 1.5,
                      ),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton2<AnnualData>(
                        focusColor: Colors.white,
                        buttonHeight: 40,
                        dropdownDecoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(13),
                        ),
                        icon: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Container(
                            height: 12,
                            width: 12,
                            child: Center(
                              child: Image.asset(
                                ImagePath.forward,
                                height: 24,
                                width: 24,
                              ),
                            ),
                          ),
                        ),
                        hint: Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            'Select Annual Income',
                            style: fontStyle.copyWith(
                                fontSize: 14,
                                color: Color(0xff777777),
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        dropdownMaxHeight: 200,
                        itemHeight: 20,
                        items: addDividersAfterItemsAnnualIncome(
                            (_annualincomeModel != null)
                                ? _annualincomeModel!.data!
                                : []),
                        customItemsIndexes: getDividersIndexes(
                            (_annualincomeModel != null)
                                ? _annualincomeModel!.data!
                                : []),
                        value: _annualincomedata,
                        onChanged: (newValue) {
                          print(newValue);
                          setState(() {
                            _annualincomedata = newValue;
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Diet type",
                    style: TextStyle(
                      color: Color(0xff4D4D4D),
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    height: 45,
                    width: width,
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(13),
                      border: Border.all(
                        color: Color(0xffD1D1D1),
                        width: 1.5,
                      ),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton2<DietData>(
                        focusColor: Colors.white,
                        buttonHeight: 43,
                        dropdownDecoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(13),
                        ),
                        icon: Padding(
                          padding: EdgeInsets.all(13.0),
                          child: Container(
                            height: 15,
                            width: 15,
                            child: Center(
                              child: Image.asset(
                                ImagePath.forward,
                                height: 24,
                                width: 24,
                              ),
                            ),
                          ),
                        ),
                        hint: Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            'Select Diet',
                            style: fontStyle.copyWith(
                                color: Color(0xff777777),
                                fontWeight: FontWeight.w500,
                                fontSize: 14),
                          ),
                        ),
                        dropdownMaxHeight: 200,
                        itemHeight: 20,
                        items: addDividersAfterItemsDiet(
                            (_dietModel != null) ? _dietModel!.data! : []),
                        customItemsIndexes: getDividersIndexes(
                            (_dietModel != null) ? _dietModel!.data! : []),
                        value: _dietData,
                        onChanged: (newValue) {
                          print(newValue);
                          setState(() {
                            _dietData = newValue;
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Cast",
                    style: headerstyle.copyWith(
                        color: Color(0xff4D4D4D),
                        fontWeight: FontWeight.w500,
                        fontSize: 15),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    width: width,
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(13),
                      border: Border.all(
                        color: Color(0xffD1D1D1),
                        width: 1.5,
                      ),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton2<castData.castData>(
                        focusColor: Colors.white,
                        buttonHeight: 43,
                        dropdownDecoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(13),
                        ),
                        icon: Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Container(
                            height: 15,
                            width: 15,
                            child: Center(
                              child: Image.asset(
                                ImagePath.forward,
                                height: 24,
                                width: 24,
                              ),
                            ),
                          ),
                        ),
                        hint: Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            'Select Cast',
                            style: fontStyle.copyWith(
                                color: Color(0xff777777),
                                fontWeight: FontWeight.w500,
                                fontSize: 14),
                          ),
                        ),
                        dropdownMaxHeight: 200,
                        itemHeight: 20,
                        items: addDividersAfterItems(
                            (_castModel != null) ? _castModel!.data! : []),
                        customItemsIndexes: getDividersIndexes(
                            (_castModel != null) ? _castModel!.data! : []),
                        value: _data,
                        onChanged: (newValue) {
                          print(newValue);
                          setState(() {
                            _data = newValue;
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Gotra",
                    style: headerstyle.copyWith(
                        color: Color(0xff4D4D4D),
                        fontWeight: FontWeight.w500,
                        fontSize: 15),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    width: width,
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(13),
                      border: Border.all(
                        color: Color(0xffD1D1D1),
                        width: 1.5,
                      ),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton2<GotraData>(
                        isExpanded: true,
                        focusColor: Colors.white,
                        buttonHeight: 43,
                        dropdownDecoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(13),
                        ),
                        icon: Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Container(
                            height: 15,
                            width: 15,
                            child: Center(
                              child: Image.asset(
                                ImagePath.forward,
                                height: 24,
                                width: 24,
                              ),
                            ),
                          ),
                        ),
                        hint: Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            'Select Gotra',
                            style: fontStyle.copyWith(
                                color: Color(0xff777777),
                                fontWeight: FontWeight.w500,
                                fontSize: 14),
                          ),
                        ),
                        dropdownMaxHeight: 200,
                        itemHeight: 20,
                        items: addDividersAfterItemsGotra(
                            (_gotraModel != null) ? _gotraModel!.data! : []),
                        customItemsIndexes: getDividersIndexes(
                            (_gotraModel != null) ? _gotraModel!.data! : []),
                        value: _gotraData,
                        onChanged: (newValue) {
                          print(newValue);
                          setState(() {
                            _gotraData = newValue;
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 40),
                  ECommonButton(
                    btnName: (widget.isUpdate == "isUpdate")
                        ? "Update"
                        : AppConstants.next,
                    btnOnTap: () {
                      if (_gotraData == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Please Select Gotra")));
                      } else if (_data == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Please Select Cast")));
                      } else if (_dietData == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Please Select Diet Type")));
                      } else if (_annualincomedata == null) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Please Select Annual Income")));
                      } else if (_worktypeData == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Please Select Work Type")));
                      } else if (_ageDataFrom == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Please Select Age")));
                      } else if (_ageDataTo == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Please Select Age")));
                      } else if (_heightDataFrom == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Please Select Height")));
                      } else if (_heightDataTo == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Please Select Height")));
                      } else {
                        if (widget.isUpdate == "isUpdate") {
                          updateLookingFor();
                        } else {
                          addLookingForAPI();
                        }
                      }
                    },
                    /* btnOnTap: () {
                      if (_gotraData == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Please Select Gotra")));
                      } else if (_data == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Please Select Cast")));
                      } else {
                        if (widget.isUpdate == "isUpdate") {
                          updateLookingFor();
                        } else {
                          addLookingForAPI();
                        }
                      }
                    }, */
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void checkConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      if (widget.isUpdate == "isUpdate") {
        getHeight();
        getAge();
        getCast();
        getDiet();
        getGotra();
        getWorktype();
        getAnnualincome();
        getLookingFor();
      } else {
        getHeight();
        getAge();
        getCast();
        getDiet();
        getGotra();
        getWorktype();
        getAnnualincome();
      }
    } else if (connectivityResult == ConnectivityResult.wifi) {
      if (widget.isUpdate == "isUpdate") {
        getHeight();
        getAge();
        getCast();
        getDiet();
        getGotra();
        getWorktype();
        getAnnualincome();
        getLookingFor();
      } else {
        getHeight();
        getAge();
        getCast();
        getDiet();
        getGotra();
        getWorktype();
        getAnnualincome();
      }
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

  getAnnualincome() async {
    var response = await http.get(
      Uri.parse(GET_ANNUALINCOME_URL),
    );

    if (response.statusCode == 200) {
      if (mounted) {
        setState(() {
          _annualincomeModel =
              AnnualincomeModel.fromJson(jsonDecode(response.body));
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

  getDiet() async {
    var response = await http.get(
      Uri.parse(GET_DIET_URL),
    );

    if (response.statusCode == 200) {
      if (mounted) {
        setState(() {
          _dietModel = DietModel.fromJson(jsonDecode(response.body));
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

  getWorktype() async {
    var response = await http.get(
      Uri.parse(GET_WORKTYPE_URL),
    );

    if (response.statusCode == 200) {
      if (mounted) {
        setState(() {
          _worktypeModel = workTypeModel.fromJson(jsonDecode(response.body));
          log("work type:::: ${response.body}");
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

  getAge() async {
    var response = await http.get(
      Uri.parse(GET_AGE_URL),
    );

    if (response.statusCode == 200) {
      if (mounted) {
        setState(() {
          _ageModel = AgeModel.fromJson(jsonDecode(response.body));
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

  Future getAgeTo() async {
    var response = await http.get(
      Uri.parse(GET_AGE_URL +
          "?select_age=${(_ageDataFrom != null) ? _ageDataFrom!.id : ""}"),
    );

    if (response.statusCode == 200) {
      if (mounted) {
        setState(() {
          _ageModelTo = AgeModel.fromJson(jsonDecode(response.body));
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

  getGotra() async {
    var response = await http.get(
      Uri.parse(GET_GOTRA_URL),
    );

    if (response.statusCode == 200) {
      if (mounted) {
        setState(() {
          _gotraModel = gotraModel.fromJson(jsonDecode(response.body));
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

  getCast() async {
    var response = await http.get(
      Uri.parse(GET_CAST_URL),
    );

    if (response.statusCode == 200) {
      if (mounted) {
        setState(() {
          _castModel = castData.castModel.fromJson(jsonDecode(response.body));
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

  getHeight() async {
    CommonUtils.showProgressLoading(context);

    var response = await http.get(
      Uri.parse(GET_HEIGHT_URL),
    );

    if (response.statusCode == 200) {
      CommonUtils.hideProgressLoading();
      if (mounted) {
        setState(() {
          _heightModel = HeightModel.fromJson(jsonDecode(response.body));
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

  Future getHeightTo() async {
    var response = await http.get(Uri.parse(GET_HEIGHT_URL +
        "?select_height=${(_heightDataFrom != null) ? _heightDataFrom!.id : ""}"));

    if (response.statusCode == 200) {
      if (mounted) {
        setState(() {
          _heightModelTo = HeightModel.fromJson(jsonDecode(response.body));
        });
        log("Height Data::::${response.body}");
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

  getLookingFor() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString(EXE_TOKEN);
    final queryParameters = {
      "token": token.toString(),
    };

    String queryString = Uri(queryParameters: queryParameters).query;
    var response = await dio.get(GET_LOOKINGFOR_DETAIL_URL +
        "?" +
        'user_id=${widget.candidateId}' +
        '&' +
        queryString);
    if (response.statusCode == 200) {
      GetLookingforModel _getLookingforModel =
          GetLookingforModel.fromJson(response.data);
      print(response.data);
      setState(() {
        if (_heightModel != null && _heightModel!.data != null) {
          for (var i = 0; i < _heightModel!.data!.length; i++) {
            if (_getLookingforModel.data != null) {
              if (_getLookingforModel.data!.heightFrom == null) {
              } else {
                if (int.parse(
                        _getLookingforModel.data!.heightFrom.toString()) ==
                    _heightModel!.data![i].id) {
                  _heightDataFrom = _heightModel!.data![i];
                  getHeightTo().then((value) {
                    if (_heightModelTo != null &&
                        _heightModelTo!.data != null &&
                        _heightModel != null) {
                      for (var i = 0; i < _heightModelTo!.data!.length; i++) {
                        if (int.parse(_getLookingforModel.data!.heightTo
                                .toString()) ==
                            _heightModelTo!.data![i].id) {
                          setState(() {
                            _heightDataTo = _heightModelTo!.data![i];
                            isHeighTo = true;
                            log("height data as  ::: $_heightDataTo");
                          });
                        }
                      }
                    }
                  });
                }
              }
            }
          }
        }
        if (_heightModel != null && _heightModel!.data != null) {
          for (var i = 0; i < _heightModel!.data!.length; i++) {
            if (_getLookingforModel.data != null) {
              if (_getLookingforModel.data!.heightTo == null) {
              } else {
                if (int.parse(_getLookingforModel.data!.heightTo.toString()) ==
                    _heightModel!.data![i].id) {
                  _heightDataTo = _heightModel!.data![i];
                }
              }
            } else {}
          }
        }
        if (_ageModel != null && _ageModel!.data != null) {
          for (var i = 0; i < _ageModel!.data!.length; i++) {
            if (_getLookingforModel.data != null) {
              if (_getLookingforModel.data!.ageFrom == null) {
              } else {
                if (int.parse(_getLookingforModel.data!.ageFrom.toString()) ==
                    _ageModel!.data![i].id) {
                  _ageDataFrom = _ageModel!.data![i];
                  getAgeTo().then((value) {
                    if (_ageModelTo != null && _ageModelTo!.data != null) {
                      for (var i = 0; i < _ageModelTo!.data!.length; i++) {
                        if (_getLookingforModel.data!.ageTo == null) {
                          print("object");
                        } else {
                          if (int.parse(
                                  _getLookingforModel.data!.ageTo.toString()) ==
                              _ageModelTo!.data![i].id) {
                            setState(() {
                              _ageDataTo = _ageModelTo!.data![i];
                              isAgeTo = true;
                              log("age data as :::: $_ageDataTo");
                            });
                          }
                        }
                      }
                    }
                  });
                }
              }
            } else {}
          }
        }
        if (_ageModel != null && _ageModel!.data != null) {
          for (var i = 0; i < _ageModel!.data!.length; i++) {
            if (_getLookingforModel.data != null) {
              if (_getLookingforModel.data!.ageTo == null) {
              } else {
                if (int.parse(_getLookingforModel.data!.ageTo.toString()) ==
                    _ageModel!.data![i].id) {
                  _ageDataTo = _ageModel!.data![i];
                }
              }
            } else {}
          }
        }
        if (_worktypeModel != null && _worktypeModel!.data != null) {
          for (var i = 0; i < _worktypeModel!.data!.length; i++) {
            if (_getLookingforModel.data != null) {
              if (_getLookingforModel.data!.ageTo == null) {
              } else {
                if (int.parse(_getLookingforModel.data!.ageTo.toString()) ==
                    _worktypeModel!.data![i].id) {
                  _worktypeData = _worktypeModel!.data![i];
                }
              }
            } else {}
          }
        }
        if (_annualincomeModel != null && _annualincomeModel!.data != null) {
          for (var i = 0; i < _annualincomeModel!.data!.length; i++) {
            if (_getLookingforModel.data != null) {
              if (_getLookingforModel.data!.annualIncome == null) {
              } else {
                print("annual income");
                if (_getLookingforModel.data!.annualIncome ==
                    _annualincomeModel!.data![i].id) {
                  _annualincomedata = _annualincomeModel!.data![i];
                }
              }
            } else {}
          }
        }
        if (_dietModel != null && _dietModel!.data != null) {
          for (var i = 0; i < _dietModel!.data!.length; i++) {
            if (_getLookingforModel.data != null) {
              if (_getLookingforModel.data!.diet == null) {
              } else {
                if (_getLookingforModel.data!.diet == _dietModel!.data![i].id) {
                  _dietData = _dietModel!.data![i];
                }
              }
            } else {}
          }
        }
        if (_gotraModel != null && _gotraModel!.data != null) {
          for (var i = 0; i < _gotraModel!.data!.length; i++) {
            if (_getLookingforModel.data != null) {
              if (_getLookingforModel.data!.gotra == null) {
              } else {
                if (_getLookingforModel.data!.gotra ==
                    _gotraModel!.data![i].id) {
                  _gotraData = _gotraModel!.data![i];
                }
              }
            } else {}
          }
        }
        if (_castModel != null && _castModel!.data != null) {
          for (var i = 0; i < _castModel!.data!.length; i++) {
            if (_getLookingforModel.data != null) {
              if (_getLookingforModel.data!.caste == null) {
              } else {
                if (_getLookingforModel.data!.caste ==
                    _castModel!.data![i].id) {
                  _data = _castModel!.data![i];
                }
              }
            } else {}
          }
        }
      });
      print("get looking exe ------- ${response.data}");
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

  updateLookingFor() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var exeToken = pref.getString(EXE_TOKEN);

    final queryParameters = {
      "token": exeToken.toString(),
    };
    String queryString = Uri(queryParameters: queryParameters).query;
    var params = {
      "height_from": (_heightDataFrom != null) ? _heightDataFrom!.id : "",
      "height_to": (_heightDataTo != null) ? _heightDataTo!.id : "",
      "age_from": (_ageDataFrom != null) ? _ageDataFrom!.id : "",
      "age_to": (_ageDataTo != null) ? _ageDataTo!.id : "",
      "annual_income": (_annualincomedata != null) ? _annualincomedata!.id : "",
      "diet": (_dietData != null) ? _dietData!.id : "",
      "work_type": (_worktypeData != null) ? _worktypeData!.id : "",
      "caste": (_data != null) ? _data!.id : "",
      "gotra": (_gotraData != null) ? _gotraData!.id : "",
      "user_id": widget.candidateId
    };
    var response = await dio
        .post(UPDATE_EXE_LOOKING_FOR_URL + "?" + queryString, data: params);
    if (response.statusCode == 200) {
      UpdateExeLookingForModel _updateExeLookingForModel =
          UpdateExeLookingForModel.fromJson(response.data);
      widget.onBack!(1);
      print("object ++++++++++ ${response.data}");
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

  addLookingForAPI() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var exeToken = pref.getString(EXE_TOKEN);
    var exeUserID = pref.getString(EXE_USER_ID);
    log("userId :::::::::: " + exeUserID.toString());

    final queryParameters = {
      "token": exeToken.toString(),
    };
    String queryString = Uri(queryParameters: queryParameters).query;
    var params = {
      "height_from": (_heightDataFrom != null) ? _heightDataFrom!.id : "",
      "height_to": (_heightDataTo != null) ? _heightDataTo!.id : "",
      "age_from": (_ageDataFrom != null) ? _ageDataFrom!.id : "",
      "age_to": (_ageDataTo != null) ? _ageDataTo!.id : "",
      "annual_income": (_annualincomedata != null) ? _annualincomedata!.id : "",
      "diet": (_dietData != null) ? _dietData!.id : "",
      "work_type": (_worktypeData != null) ? _worktypeData!.id : "",
      "caste": _data!.id,
      "gotra": _gotraData!.id,
      "user_id": exeUserID
    };
    log("add looking for $params");
    log("add looking for $queryString");
    var response = await dio.post(ADD_EXE_LOOKING_FOR_URL + "?" + queryString,
        data: params);
    if (response.statusCode == 200) {
      AddLookingForModel _addLookingForModel =
          AddLookingForModel.fromJson(response.data);
      widget.onBack!(1);
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

  List<DropdownMenuItem<HeightData>> addDividersAfterItemsHeight(
      List<HeightData> items) {
    List<DropdownMenuItem<HeightData>> _menuItems = [];
    for (var item in items) {
      _menuItems.addAll(
        [
          DropdownMenuItem<HeightData>(
            value: item,
            child: Padding(
              padding: EdgeInsets.only(top: 2.0, left: 10),
              child: Text(
                item.height.toString(),
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
          ),
          if (item != items.last)
            const DropdownMenuItem<HeightData>(
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

  List<DropdownMenuItem<AgeData>> addDividersAfterItemsAge(
      List<AgeData> items) {
    List<DropdownMenuItem<AgeData>> _menuItems = [];
    for (var item in items) {
      _menuItems.addAll(
        [
          DropdownMenuItem<AgeData>(
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
            const DropdownMenuItem<AgeData>(
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

  List<DropdownMenuItem<WorktypeData>> addDividersAfterItemsWorkType(
      List<WorktypeData> items) {
    List<DropdownMenuItem<WorktypeData>> _menuItems = [];
    for (var item in items) {
      _menuItems.addAll(
        [
          DropdownMenuItem<WorktypeData>(
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
            const DropdownMenuItem<WorktypeData>(
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

  List<DropdownMenuItem<AnnualData>> addDividersAfterItemsAnnualIncome(
      List<AnnualData> items) {
    List<DropdownMenuItem<AnnualData>> _menuItems = [];
    for (var item in items) {
      _menuItems.addAll(
        [
          DropdownMenuItem<AnnualData>(
            value: item,
            child: Padding(
              padding: EdgeInsets.only(top: 2.0, left: 10),
              child: Text(
                item.incomes.toString(),
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
          ),
          if (item != items.last)
            const DropdownMenuItem<AnnualData>(
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

  List<DropdownMenuItem<DietData>> addDividersAfterItemsDiet(
      List<DietData> items) {
    List<DropdownMenuItem<DietData>> _menuItems = [];
    for (var item in items) {
      _menuItems.addAll(
        [
          DropdownMenuItem<DietData>(
            value: item,
            child: Padding(
              padding: EdgeInsets.only(top: 2.0, left: 10),
              child: Text(
                item.diet.toString(),
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
          ),
          if (item != items.last)
            const DropdownMenuItem<DietData>(
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

  List<DropdownMenuItem<castData.castData>> addDividersAfterItems(
      List<castData.castData> items) {
    List<DropdownMenuItem<castData.castData>> _menuItems = [];
    for (var item in items) {
      _menuItems.addAll(
        [
          DropdownMenuItem<castData.castData>(
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
            const DropdownMenuItem<castData.castData>(
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

  List<DropdownMenuItem<GotraData>> addDividersAfterItemsGotra(
      List<GotraData> items) {
    List<DropdownMenuItem<GotraData>> _menuItems = [];
    for (var item in items) {
      _menuItems.addAll(
        [
          DropdownMenuItem<GotraData>(
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
            const DropdownMenuItem<GotraData>(
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
}
