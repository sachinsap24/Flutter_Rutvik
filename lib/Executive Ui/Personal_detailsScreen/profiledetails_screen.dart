import 'dart:convert';
import 'dart:developer';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:matrimonial_app/Core/Constant/CommonUtils.dart';
import 'package:matrimonial_app/Core/Constant/url_constant.dart';
import 'package:matrimonial_app/Core/Constant/value_constants.dart';
import 'package:matrimonial_app/Executive%20Ui/Personal_detailsScreen/uploadimage.dart';
import 'package:matrimonial_app/ModelClass/Executive_ModelClass/Add_Personal_Detail_Model.dart'
    as personalDetail;
import 'package:matrimonial_app/ModelClass/Executive_ModelClass/Get_District_Model.dart';
import 'package:matrimonial_app/ModelClass/Executive_ModelClass/Get_Sub_Profession_Model.dart'
    as subProfession;
import 'package:matrimonial_app/ModelClass/UserPanel_ModelClass/DropDown_Datas/Get_Profession_Model.dart';
import 'package:matrimonial_app/ModelClass/UserPanel_ModelClass/DropDown_Datas/country_model.dart';
import 'package:matrimonial_app/Utils/DropDownList.dart';
import 'package:matrimonial_app/Utils/app_constants.dart';

import 'package:matrimonial_app/ModelClass/UserPanel_ModelClass/DropDown_Datas/state_model.dart'
    as stateModel;
import 'package:matrimonial_app/Utils/image_path_constants.dart';
import 'package:matrimonial_app/Utils/text_styles.dart';
import 'package:matrimonial_app/src/DatePicker/flutter_holo_date_picker.dart';
import 'package:matrimonial_app/widget/Executive%20Side/eCommonButton.dart';
import 'package:matrimonial_app/widget/dropdown_const.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Personaldetails_screen extends StatefulWidget {
  final String? mobileNo;
  const Personaldetails_screen({Key? key, this.mobileNo}) : super(key: key);

  @override
  State<Personaldetails_screen> createState() => _Personaldetails_screenState();
}

class _Personaldetails_screenState extends State<Personaldetails_screen> {
  Dio dio = Dio();
  final _form = GlobalKey<FormState>();
  late String birthDateInString;
  DateTime birthDate = DateTime.now();
  bool isDateSelected = true;
  String? _gender;
  String? _ratingprofile;
  bool nextPressed = false;
  bool ganderSelcted = false;
  String? selectedValue;
  countryModal? _countryModel;
  CountryData? _countryData;
  stateModel.StateModel? _stateModel;
  stateModel.Data? _data;
  List<String> neutre = [
    'Male',
    'Female',
  ];
  GetProfessionModel? _getProfessionModel;
  Data? _professionData;
  subProfession.GetSubProfessionModel? _getSubProfessionModel;
  subProfession.Data? _subProfessionData;
  personalDetail.AddExePersonalDetailModel? _addExePersonalDetailModel;
  getDistrictModel? _districtModel;
  DistrictData? _districtData;

  TextEditingController _name = TextEditingController();
  TextEditingController _middlename = TextEditingController();
  TextEditingController _lastname = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _dob = TextEditingController();
  TextEditingController _mobile = TextEditingController();
  TextEditingController _workWithController = TextEditingController();
  final TextEditingController _pinCodecontroller = TextEditingController();

  FocusNode fname = FocusNode();
  FocusNode mname = FocusNode();
  FocusNode email = FocusNode();
  FocusNode lname = FocusNode();
  FocusNode workWith = FocusNode();
  FocusNode gender = FocusNode();
  FocusNode dob = FocusNode();
  FocusNode mobile = FocusNode();
  FocusNode refer = FocusNode();

  String? dropdownBudget;
  String? dropdownBudget1;
  String? dropdownBudget2;
  String? dropdownBudget3;

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
      backgroundColor: Color(0xffE5E5E5),
      appBar: AppBar(
        backgroundColor: Color(0xffE5E5E5),
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Image.asset(ImagePath.backArrow),
            ),
          ),
        ),
        title: Text(
          AppConstants.personal,
          style: fontStyle.copyWith(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Form(
            key: _form,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: Text(
                    "Hey It seems you were new here, Kindly enter your details to continue with us.",
                    style: fontStyle.copyWith(color: Color(0xff838994)),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Container(
                  width: width,
                  height: 3,
                  color: Color(0xff838994).withOpacity(0.5),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16, right: 16),
                  child: TextFormField(
                    onTap: () {},
                    textCapitalization: TextCapitalization.words,
                    /* onChanged: ((value) {
                      // if (_form.currentState!.validate()) ;
                    }), */
                    validator: (text) {
                      if (text!.isEmpty) {
                        return "Please Enter Your First Name";
                      }
                      return null;
                    },
                    onChanged: (value) {
                      if (_form.currentState!.validate()) ;
                    },
                    controller: _name,
                    keyboardType: TextInputType.text,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                        RegExp("[A-Za-z  |\s]"),
                      ),
                    ],
                    decoration: InputDecoration(
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(13),
                        borderSide:
                            BorderSide(color: Color(0xffd1d1d1), width: 1.5),
                      ),
                      hintStyle: TextStyle(
                        fontSize: 14,
                        color: Color(0xff777777),
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 4, horizontal: 15),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(13),
                        borderSide:
                            BorderSide(color: Color(0xffD1D1D1), width: 1.5),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(13),
                        borderSide:
                            BorderSide(color: Color(0xffd1d1d1), width: 1.5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(13),
                        borderSide:
                            BorderSide(color: Color(0xffD1D1D1), width: 1.5),
                      ),
                      hintText: "Enter your first name here",
                      label: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "First Name",
                              style: TextStyle(
                                color: Color(0xff838994),
                                fontWeight: FontWeight.w400,
                                fontSize: 15,
                              ),
                            ),
                            TextSpan(
                              text: ' *',
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.w400,
                                fontSize: 15,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                /*  _textField(_name, 'Enter your first name here', 'First Name',
                    fname, TextInputType.name), */
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16, right: 16),
                  child: TextFormField(
                    textCapitalization: TextCapitalization.words,
                    controller: _middlename,
                    keyboardType: TextInputType.text,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                        RegExp("[A-Za-z  |\s]"),
                      ),
                    ],
                    decoration: InputDecoration(
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(13),
                        borderSide:
                            BorderSide(color: Color(0xffd1d1d1), width: 1.5),
                      ),
                      hintStyle: TextStyle(
                        fontSize: 14,
                        color: Color(0xff777777),
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 4, horizontal: 15),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(13),
                        borderSide:
                            BorderSide(color: Color(0xffD1D1D1), width: 1.5),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(13),
                        borderSide:
                            BorderSide(color: Color(0xffd1d1d1), width: 1.5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(13),
                        borderSide:
                            BorderSide(color: Color(0xffD1D1D1), width: 1.5),
                      ),
                      hintText: "Enter your middle name here",
                      label: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Middle Name",
                              style: TextStyle(
                                color: Color(0xff838994),
                                fontWeight: FontWeight.w400,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                /*   _textField(_middlename, "Enter your Middle Name", "Middle Name",
                    mname, TextInputType.name), */
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16, right: 16),
                  child: TextFormField(
                    textCapitalization: TextCapitalization.words,
                    validator: (text) {
                      if (text!.isEmpty) {
                        return "Please Enter Your Last Name";
                      }
                      return null;
                    },
                    onChanged: ((value) {
                      if (_form.currentState!.validate()) ;
                    }),
                    controller: _lastname,
                    keyboardType: TextInputType.text,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                        RegExp("[A-Za-z  |\s]"),
                      ),
                    ],
                    decoration: InputDecoration(
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(13),
                        borderSide:
                            BorderSide(color: Color(0xffd1d1d1), width: 1.5),
                      ),
                      hintStyle: TextStyle(
                        fontSize: 14,
                        color: Color(0xff777777),
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 4, horizontal: 15),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(13),
                        borderSide:
                            BorderSide(color: Color(0xffD1D1D1), width: 1.5),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(13),
                        borderSide:
                            BorderSide(color: Color(0xffd1d1d1), width: 1.5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(13),
                        borderSide:
                            BorderSide(color: Color(0xffD1D1D1), width: 1.5),
                      ),
                      hintText: "Enter your last name here",
                      label: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Last Name",
                              style: TextStyle(
                                color: Color(0xff838994),
                                fontWeight: FontWeight.w400,
                                fontSize: 15,
                              ),
                            ),
                            TextSpan(
                              text: ' *',
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.w400,
                                fontSize: 15,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                /*  _textField(_lastname, "Enter your first name here", "Last Name",
                    lname, TextInputType.name), */
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16, right: 16),
                  child: TextFormField(
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                          RegExp("[a-zA-Z0-9@\.]")),
                    ],
                    validator: (value) {
                      if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value!)) {
                        return "Please enter a valid email address";
                      }

                      return null;
                    },
                    onChanged: ((value) {
                      if (_form.currentState!.validate()) ;
                    }),
                    controller: _email,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(13),
                        borderSide:
                            BorderSide(color: Color(0xffd1d1d1), width: 1.5),
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 4, horizontal: 15),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(13),
                        borderSide:
                            BorderSide(color: Color(0xffD1D1D1), width: 1.5),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(13),
                        borderSide:
                            BorderSide(color: Color(0xffd1d1d1), width: 1.5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(13),
                        borderSide:
                            BorderSide(color: Color(0xffD1D1D1), width: 1.5),
                      ),
                      hintStyle:
                          TextStyle(fontSize: 14, color: Color(0xff777777)),
                      hintText: "Enter your Email",
                      label: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Email",
                              style: TextStyle(
                                color: Color(0xff838994),
                                fontWeight: FontWeight.w400,
                                fontSize: 15,
                              ),
                            ),
                            TextSpan(
                              text: ' *',
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.w400,
                                fontSize: 15,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                _textformField(
                  _dob,
                  "Select your date of birth",
                  "DOB (MM-DD-YYYY)",
                  Container(
                    height: 24,
                    width: 24,
                    child: Padding(
                      padding: const EdgeInsets.all(13.0),
                      child: GestureDetector(
                        onTap: () async {},
                        child: Image.asset(
                          ImagePath.calendar,
                          width: 21,
                          height: 24,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButtonFormField2(
                      dropdownMaxHeight: 200,
                      dropdownDecoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(13)),
                      decoration: InputDecoration(
                          focusColor: Colors.white,
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(13),
                            borderSide: BorderSide(
                                color: Color(0xffd1d1d1), width: 1.5),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(13),
                              borderSide: BorderSide(color: Color(0xffD1D1D1))),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xffD1D1D1)),
                            borderRadius: BorderRadius.circular(13),
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(13),
                              borderSide:
                                  BorderSide(color: Color(0xffD1D1D1)))),
                      icon: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Container(
                          height: 10,
                          width: 10,
                          child: Center(
                            child: Image.asset(
                              ImagePath.forward,
                              height: 15,
                              width: 15,
                            ),
                          ),
                        ),
                      ),
                      iconSize: 30,
                      buttonHeight: 45,
                      hint: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Select your gender',
                                style: fontStyle.copyWith(
                                    fontSize: 15,
                                    color: Color(0xff777777),
                                    fontWeight: FontWeight.w500),
                              ),
                              TextSpan(
                                text: ' *',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      itemHeight: 20,
                      items: getDropdown()
                          .addDividersAfterItems(['Male', 'Female']),
                      customItemsIndexes:
                          getDropdown().getDividersIndexes(['Male', 'Female']),
                      value: _gender,
                      validator: (value) {
                        if (value == null) {
                          return '    Please select Gender';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          _gender = value as String?;
                          if (_form.currentState!.validate()) ;
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButtonFormField2<Data>(
                      dropdownMaxHeight: 200,
                      dropdownDecoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(13)),
                      decoration: InputDecoration(
                          focusColor: Colors.white,
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(13),
                              borderSide: BorderSide(color: Color(0xffD1D1D1))),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xffD1D1D1)),
                            borderRadius: BorderRadius.circular(13),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(13),
                            borderSide: BorderSide(
                                color: Color(0xffd1d1d1), width: 1.5),
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(13),
                              borderSide:
                                  BorderSide(color: Color(0xffD1D1D1)))),
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
                        padding: const EdgeInsets.only(left: 8.0),
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Select Profession',
                                style: fontStyle.copyWith(
                                    fontSize: 15,
                                    color: Color(0xff777777),
                                    fontWeight: FontWeight.w500),
                              ),
                              TextSpan(
                                text: ' *',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      buttonHeight: 45,
                      itemHeight: 20,
                      items: addDividersAfterItems((_getProfessionModel != null)
                          ? _getProfessionModel!.data!
                          : []),
                      customItemsIndexes: getDividersIndexes(
                          (_getProfessionModel != null)
                              ? _getProfessionModel!.data!
                              : []),
                      value: _professionData,
                      validator: (value) {
                        if (value == null) {
                          return '    Please select profession';
                        }
                        return null;
                      },
                      onChanged: (newValue) {
                        print(newValue);
                        setState(() {
                          _professionData = newValue;
                          if (_form.currentState!.validate()) ;
                          getSubProfessionAPI();
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButtonFormField2<subProfession.Data>(
                      dropdownMaxHeight: 200,
                      dropdownDecoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(13)),
                      decoration: InputDecoration(
                          focusColor: Colors.white,
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(13),
                            borderSide: BorderSide(
                                color: Color(0xffd1d1d1), width: 1.5),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(13),
                              borderSide: BorderSide(color: Color(0xffD1D1D1))),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xffD1D1D1)),
                            borderRadius: BorderRadius.circular(13),
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(13),
                              borderSide:
                                  BorderSide(color: Color(0xffD1D1D1)))),
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
                        padding: const EdgeInsets.only(left: 8.0),
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Select sub Profession',
                                style: fontStyle.copyWith(
                                    fontSize: 15,
                                    color: Color(0xff777777),
                                    fontWeight: FontWeight.w500),
                              ),
                              TextSpan(
                                text: ' *',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      itemHeight: 20,
                      buttonHeight: 45,
                      validator: (value) {
                        if (value == null) {
                          return '    Please select sub-profession';
                        }
                        return null;
                      },
                      items: addDividersAfterSubProfessionItems(
                          (_getSubProfessionModel != null)
                              ? _getSubProfessionModel!.data!
                              : []),
                      customItemsIndexes: getDividersIndexes(
                          (_getSubProfessionModel != null)
                              ? _getSubProfessionModel!.data!
                              : []),
                      value: _subProfessionData,
                      onChanged: (newValue) {
                        print(newValue);
                        setState(() {
                          _subProfessionData = newValue;
                          if (_form.currentState!.validate()) ;
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: TextFormField(
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(
                        _countryData != null
                            ? _countryData!.id == 1
                                ? 6
                                : 5
                            : 6,
                      ),
                      FilteringTextInputFormatter.allow(
                        RegExp("[0-9]"),
                      ),
                    ],
                    controller: _pinCodecontroller,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(13),
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 232, 15, 15),
                            width: 1.5),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(13),
                        borderSide:
                            BorderSide(color: Color(0xffd1d1d1), width: 1.5),
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 4, horizontal: 15),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(13),
                        borderSide:
                            BorderSide(color: Color(0xffD1D1D1), width: 1.5),
                      ),
                      border: OutlineInputBorder(),
                      label: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Pincode",
                              style: TextStyle(
                                color: Color(0xff838994),
                                fontWeight: FontWeight.w400,
                                fontSize: 15,
                              ),
                            ),
                            TextSpan(
                              text: ' *',
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.w400,
                                fontSize: 15,
                              ),
                            )
                          ],
                        ),
                      ),
                      labelStyle: fontStyle.copyWith(
                          color: Color(0xff777777),
                          fontWeight: FontWeight.w500),
                      hintText: "Enter Pincode",
                    ),
                    onChanged: ((value) {
                      if (_form.currentState!.validate()) ;
                    }),
                    validator: (text) {
                      if (text!.length < 6) {
                        return "Please Enter 6 digit pincode";
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButtonFormField2<stateModel.Data>(
                      buttonHeight: 45,
                      dropdownMaxHeight: 200,
                      dropdownDecoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(13)),
                      decoration: InputDecoration(
                          focusColor: Colors.white,
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(13),
                            borderSide: BorderSide(
                                color: Color(0xffd1d1d1), width: 1.5),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(13),
                              borderSide: BorderSide(color: Color(0xffD1D1D1))),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xffD1D1D1)),
                            borderRadius: BorderRadius.circular(13),
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(13),
                              borderSide:
                                  BorderSide(color: Color(0xffD1D1D1)))),
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
                        padding: const EdgeInsets.only(left: 8.0),
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Select State',
                                style: fontStyle.copyWith(
                                    fontSize: 15,
                                    color: Color(0xff777777),
                                    fontWeight: FontWeight.w500),
                              ),
                              TextSpan(
                                text: ' *',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      itemHeight: 20,
                      items: addDividersAfterItemsStateModel(
                          (_stateModel != null) ? _stateModel!.data! : []),
                      customItemsIndexes: getDividersIndexes(
                          (_stateModel != null) ? _stateModel!.data! : []),
                      value: _data,
                      validator: (value) {
                        if (value == null) {
                          return '    Please select State';
                        }
                        return null;
                      },
                      onChanged: (newValue) {
                        print(newValue);
                        setState(() {
                          _data = newValue;
                          if (_form.currentState!.validate()) ;
                          getDistrictAPI();
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButtonFormField2<DistrictData>(
                      buttonHeight: 45,
                      dropdownMaxHeight: 200,
                      dropdownDecoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(13)),
                      decoration: InputDecoration(
                          focusColor: Colors.white,
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(13),
                              borderSide: BorderSide(color: Color(0xffD1D1D1))),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xffD1D1D1)),
                            borderRadius: BorderRadius.circular(13),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(13),
                            borderSide: BorderSide(
                                color: Color(0xffd1d1d1), width: 1.5),
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(13),
                              borderSide:
                                  BorderSide(color: Color(0xffD1D1D1)))),
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
                        padding: const EdgeInsets.only(left: 8.0),
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Select District',
                                style: fontStyle.copyWith(
                                    fontSize: 15,
                                    color: Color(0xff777777),
                                    fontWeight: FontWeight.w500),
                              ),
                              TextSpan(
                                text: ' *',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      itemHeight: 20,
                      items: _addDividersAfterItemsdistrict(
                          (_districtModel != null)
                              ? _districtModel!.data!
                              : []),
                      customItemsIndexes: _getDividersIndexesDistrict(),
                      value: _districtData,
                      validator: (value) {
                        if (value == null) {
                          return '    Please select District';
                        }
                      },
                      onChanged: (newValue) {
                        print(newValue);
                        setState(() {
                          _districtData = newValue!;
                          if (_form.currentState!.validate()) ;
                        });
                      },
                    ),
                  ),
                ),

                /*  */
                SizedBox(
                  height: 20,
                ),
                _textField(_workWithController, 'Enter your Work With',
                    'You Will Work With', workWith, TextInputType.text),
                SizedBox(
                  height: 35,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: ECommonButton(
                      btnName: 'Next',
                      btnOnTap: () {
                        if (_form.currentState!.validate()) {
                          addPersonalDetailAPI();
                        }
                      }),
                ),
                SizedBox(
                  height: 15,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _textField(TextEditingController _controller, String hinttext,
      String lableName, FocusNode _focusenode, TextInputType keybordType) {
    return Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: TextFormField(
          textInputAction: TextInputAction.done,
          keyboardType: keybordType,
          /* validator: (value) {
            if (value!.isEmpty) {
              return '* Please Fill Details';
            } else {
              return null;
            }
          }, */
          focusNode: _focusenode,
          controller: _controller,
          decoration: InputDecoration(
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(13),
              borderSide: BorderSide(color: Color(0xffd1d1d1), width: 1.5),
            ),
            hintStyle: TextStyle(
              fontSize: 14,
              color: Color(0xff777777),
            ),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            contentPadding: EdgeInsets.symmetric(vertical: 4, horizontal: 15),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(13),
              borderSide: BorderSide(color: Color(0xffD1D1D1), width: 1.5),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(13),
              borderSide: BorderSide(color: Color(0xffd1d1d1), width: 1.5),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(13),
              borderSide: BorderSide(color: Color(0xffD1D1D1), width: 1.5),
            ),
            hintText: hinttext,
            label: Text(
              lableName,
              style: fontStyle.copyWith(
                  color: Color(0xff777777), fontWeight: FontWeight.w500),
            ),
          ),
        ));
  }

  _textformField(
    TextEditingController _controller,
    String hinttext,
    String lableName,
    Widget image,
  ) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: TextFormField(
              controller: _controller,
              readOnly: true,
              onTap: () async {
                DateTime? date = DateTime.now();
                FocusScope.of(context).requestFocus(new FocusNode());
                date = (await DatePicker.showSimpleDatePicker(context,
                    initialDate: DateTime(2000),
                    firstDate: DateTime(1972),
                    lastDate: DateTime(date.year - 18, date.month, date.day),
                    dateFormat: 'dd-MMM-yyyy',
                    locale: DateTimePickerLocale.en_us,
                    looping: false,
                    itemTextStyle: TextStyle(color: Color(0xff000000)),
                    textColor: Color(0xffFA2457)));

                _dob.text = DateFormat('dd-MMM-yyyy').format(date!);
                log(_dob.text);
              },
              validator: (value) {
                if (value!.isEmpty) {
                  return '* Please Fill Details';
                } else {
                  return null;
                }
              },
              decoration: InputDecoration(
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(13),
                  borderSide: BorderSide(color: Color(0xffd1d1d1), width: 1.5),
                ),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(13),
                  borderSide: BorderSide(color: Color(0xffD1D1D1), width: 1.5),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(13),
                  borderSide: BorderSide(color: Color(0xffD1D1D1), width: 1.5),
                ),
                suffixIcon: image,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 4, horizontal: 15),
                border: InputBorder.none,
                hintText: hinttext,
                hintStyle: TextStyle(fontSize: 14, color: Color(0xff777777)),
                label: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: lableName,
                        style: TextStyle(
                          color: Color(0xff838994),
                          fontWeight: FontWeight.w400,
                          fontSize: 15,
                        ),
                      ),
                      TextSpan(
                        text: ' *',
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.w400,
                          fontSize: 15,
                        ),
                      )
                    ],
                  ),
                ),
                alignLabelWithHint: true,
              ),
            ),
          ),
        ),
      ],
    );
  }

  void checkConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      getProfessionAPI();
      getState();
    } else if (connectivityResult == ConnectivityResult.wifi) {
      getProfessionAPI();
      getState();
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
        },
      );
    }
  }

  getProfessionAPI() async {
    var response = await http.get(Uri.parse(GET_PROFESSION_URL));
    if (response.statusCode == 200) {
      setState(() {
        _getProfessionModel =
            GetProfessionModel.fromJson(jsonDecode(response.body));
        log(response.body);
      });
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

  getState() async {
    var response = await http.get(
      Uri.parse(GET_STATE_URL),
    );

    if (response.statusCode == 200) {
      if (mounted) {
        setState(
          () {
            _stateModel =
                stateModel.StateModel.fromJson(jsonDecode(response.body));
          },
        );
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

  getSubProfessionAPI() async {
    var response = await http.get(Uri.parse(GET_EXE_SUB_PROFESSION_URL +
        "?" +
        "profession=${_professionData!.id}"));
    if (response.statusCode == 200) {
      setState(() {
        _getSubProfessionModel = subProfession.GetSubProfessionModel.fromJson(
            jsonDecode(response.body));
      });
      log(response.body);
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

  getDistrictAPI() async {
    var response = await http
        .get(Uri.parse(GET_DISTRICT_URL + "?" + "state=${_data!.id}"));
    if (response.statusCode == 200) {
      setState(() {
        _districtModel = getDistrictModel.fromJson(jsonDecode(response.body));
      });
      log(response.body);
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

  addPersonalDetailAPI() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    CommonUtils.showProgressLoading(context);
    var params = {
      "mobile": widget.mobileNo,
      "email": _email.text,
      "firstname": _name.text,
      "lastname": _lastname.text,
      "middlename": _middlename.text,
      "dob": _dob.text,
      "gender": _gender,
      "profession": _professionData!.id,
      "subprofession": _subProfessionData!.id,
      "work_with": _workWithController.text
    };
    try {
      var response = await dio.post(ADD_EXE_PERSONAL_DETAIL_URL, data: params);
      print(response.statusCode);
      if (response.statusCode == 200) {
        var result = response.data;
        CommonUtils.hideProgressLoading();
        if (result['success'] == true) {
          setState(() {
            _addExePersonalDetailModel =
                personalDetail.AddExePersonalDetailModel.fromJson(result);
          });
          pref.setString(
              EXE_TOKEN, _addExePersonalDetailModel!.data!.token.toString());
          pref.setString(
              EXE_MOBILE, _addExePersonalDetailModel!.data!.mobile.toString());
          pref.setString(
              EXE_ID, _addExePersonalDetailModel!.data!.userId.toString());

          Navigator.push(context,
              CupertinoPageRoute(builder: (context) => ExeUploadImage()));
        }

        print(response.data);
      }
    } on DioError catch (e) {
      print("error other status code : $e");
      if (e.response!.statusCode == 400) {
        CommonUtils.hideProgressLoading();
        var result = e.response!.data;
        print("email already exist ::::: $result");
        Fluttertoast.showToast(
            msg: result['message'],
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Color(0xffFA2457),
            textColor: Colors.white,
            fontSize: 16.0);
      } else if (e.response!.statusCode == 500) {
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
  }

  List<DropdownMenuItem<Data>> addDividersAfterItems(List<Data> items) {
    List<DropdownMenuItem<Data>> _menuItems = [];
    for (var item in items) {
      _menuItems.addAll(
        [
          DropdownMenuItem<Data>(
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
            const DropdownMenuItem<Data>(
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

  List<DropdownMenuItem<subProfession.Data>> addDividersAfterSubProfessionItems(
      List<subProfession.Data> items) {
    List<DropdownMenuItem<subProfession.Data>> _menuItems = [];
    for (var item in items) {
      _menuItems.addAll(
        [
          DropdownMenuItem<subProfession.Data>(
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
            const DropdownMenuItem<subProfession.Data>(
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

  // Map<String, dynamic> district = {};
  List<DropdownMenuItem<DistrictData>> _addDividersAfterItemsdistrict(
      List<DistrictData> district) {
    List<DropdownMenuItem<DistrictData>> _menuItems = [];
    for (var item in district) {
      _menuItems.addAll(
        [
          DropdownMenuItem<DistrictData>(
            value: item,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                item.name.toString(),
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
          ),
          if (item != districtList.last)
            const DropdownMenuItem<DistrictData>(
              enabled: false,
              child: Divider(),
            ),
        ],
      );
    }
    return _menuItems;
  }

  List<int> _getDividersIndexesDistrict() {
    List<int> _dividersIndexes = [];
    for (var i = 0; i < (districtList.length * 2) - 1; i++) {
      if (i.isOdd) {
        _dividersIndexes.add(i);
      }
    }
    return _dividersIndexes;
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
