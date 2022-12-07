import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:matrimonial_app/Core/Constant/CommonUtils.dart';
import 'package:matrimonial_app/Core/Constant/url_constant.dart';
import 'package:matrimonial_app/Core/Constant/value_constants.dart';
import 'package:matrimonial_app/ModelClass/Executive_ModelClass/Add_Management_Model.dart';
import 'package:matrimonial_app/ModelClass/Executive_ModelClass/Get_Management_Model.dart';
import 'package:matrimonial_app/ModelClass/UserPanel_ModelClass/DropDown_Datas/annualincome_model.dart';
import 'package:matrimonial_app/Utils/app_constants.dart';
import 'package:matrimonial_app/Utils/color_constants.dart';
import 'package:matrimonial_app/Utils/image_path_constants.dart';
import 'package:matrimonial_app/Utils/text_styles.dart';
import 'package:matrimonial_app/src/DatePicker/date_picker.dart';
import 'package:matrimonial_app/src/DatePicker/i18n/date_picker_i18n.dart';
import 'package:matrimonial_app/widget/Executive%20Side/eCommonButton.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../widget/dropdown_const.dart';

class Management extends StatefulWidget {
  Management({Key? key, this.onBack, this.isUpdate, this.candidateId})
      : super(key: key);
  final String? isUpdate;
  final Function? onBack;
  var candidateId;
  @override
  State<Management> createState() => _ManagementState();
}

class _ManagementState extends State<Management> {
  Dio dio = Dio();
  List<String> budgetList = ["Rs. 10 lakh", "Rs. 20 Lakh"];

  String? dropdownBudget;
  bool isDateSelected = true;
  PickedFile? image;
  PickedFile? imageFile;
  PickedFile? imageFile1;
  PickedFile? imageFile2;
  DateTime Date = DateTime.now();
  bool isSelectBudget = false;
  TextEditingController _detailController = TextEditingController();
  TextEditingController _date = TextEditingController();
  TextEditingController _visitController = TextEditingController();
  TextEditingController _specialNoteController = TextEditingController();
  AnnualincomeModel? _annualincomeModel;
  AnnualData? _annualData;
  GetManagementModel? _getManagementModel;
  final _formKey = GlobalKey<FormState>();

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
              margin: EdgeInsets.only(
                left: width * 0.02,
                top: height * 0.015,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          AppConstants.budget,
                          style: TextStyle(
                            color: Color(0xff838994),
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          ' *',
                          style: TextStyle(color: Colors.red),
                        )
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.only(top: height * 0.01),
                      height: 30,
                      width: width,
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton2(
                          buttonPadding: EdgeInsets.zero,
                          dropdownDecoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(13),
                          ),
                          icon: Container(
                            height: 24,
                            width: 24,
                            child: Image.asset(
                              ImagePath.downArrow,
                              height: 24,
                              width: 24,
                            ),
                          ),
                          hint: Text(
                            'Select Budget',
                            style: TextStyle(fontSize: 14.5),
                          ),
                          itemHeight: 20,
                          dropdownMaxHeight: 200,
                          items: addDividersAfterItemsAnnualIncome(
                              (_annualincomeModel != null)
                                  ? _annualincomeModel!.data!
                                  : []),
                          customItemsIndexes:
                              getDropdown().getDividersIndexes(budgetList),
                          value: _annualData,
                          onChanged: (value) {
                            setState(() {
                              _annualData = value as AnnualData?;
                            });
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                isSelectBudget = false;
                              });
                            }
                            ;
                          },
                        ),
                      ),
                    ),
                    Divider(
                      height: 5,
                      thickness: height * 0.002,
                      color: AppColors.dividerColor,
                    ),
                    (isSelectBudget)
                        ? Text(
                            "Please Select Budget",
                            style: TextStyle(color: Colors.red, fontSize: 14),
                          )
                        : Container(),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        margin: EdgeInsets.only(top: height * 0.01),
                        child: Row(
                          children: [
                            Text(
                              AppConstants.details,
                              textAlign: TextAlign.start,
                              style: fontStyle.copyWith(
                                color: AppColors.addNameColor,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              ' *',
                              style: TextStyle(color: Colors.red),
                            )
                          ],
                        ),
                      ),
                    ),
                    TextFormField(
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          RegExp("[a-zA-Z , . + |\s]"),
                        )
                      ],
                      textCapitalization: TextCapitalization.sentences,
                      controller: _detailController,
                      style: TextStyle(
                          color: Color(
                            0xff333F52,
                          ),
                          fontWeight: FontWeight.w500,
                          fontSize: 17),
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColors.textFieldColor, width: 2),
                        ),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColors.textFieldColor, width: 2),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColors.textFieldColor, width: 2),
                        ),
                        disabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColors.textFieldColor, width: 2),
                        ),
                        hintText: "Enter Details",
                        hintStyle: TextStyle(
                            color: Color(
                              0xff333F52,
                            ),
                            fontWeight: FontWeight.w500,
                            fontSize: 15),
                        labelStyle: TextStyle(
                          color: Color(0xff838994),
                          fontWeight: FontWeight.w400,
                          fontSize: 17,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20, top: 10),
                      child: Container(
                        child: TextFormField(
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(3),
                            FilteringTextInputFormatter.allow(
                              RegExp("[0-9]"),
                            )
                          ],
                          keyboardType: TextInputType.number,
                          controller: _visitController,
                          style: TextStyle(
                              color: Color(
                                0xff333F52,
                              ),
                              fontWeight: FontWeight.w500,
                              fontSize: 17),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 5),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: AppColors.textFieldColor, width: 2),
                            ),
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: AppColors.textFieldColor, width: 2),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: AppColors.textFieldColor, width: 2),
                            ),
                            disabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: AppColors.textFieldColor, width: 2),
                            ),
                            hintText: 'Enter Number of Visit',
                            hintStyle: TextStyle(
                                color: Color(
                                  0xff333F52,
                                ),
                                fontWeight: FontWeight.w500,
                                fontSize: 15),
                            label: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Number of visit ',
                                    style: TextStyle(
                                      color: Color(0xff838994),
                                      fontWeight: FontWeight.w400,
                                      fontSize: 15,
                                    ),
                                  ),
                                  TextSpan(
                                    text: '*',
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 15,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            labelStyle: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                                fontSize: 15),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    Row(
                      children: [
                        Text(
                          AppConstants.specialnote,
                          style: TextStyle(
                            color: Color(0xff838994),
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          ' *',
                          style: TextStyle(color: Colors.red),
                        )
                      ],
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    TextFormField(
                      textCapitalization: TextCapitalization.sentences,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp("[a-zA-Z , . + |\s]"))
                      ],
                      controller: _specialNoteController,
                      style: TextStyle(
                          color: Color(
                            0xff333F52,
                          ),
                          fontWeight: FontWeight.w500,
                          fontSize: 17),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 8),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColors.textFieldColor, width: 2),
                        ),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColors.textFieldColor, width: 2),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColors.textFieldColor, width: 2),
                        ),
                        disabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColors.textFieldColor, width: 2),
                        ),
                        hintText: "Enter Special Notes",
                        hintStyle: TextStyle(
                            color: Color(
                              0xff333F52,
                            ),
                            fontWeight: FontWeight.w500,
                            fontSize: 15),
                        labelStyle: TextStyle(
                          color: Color(0xff838994),
                          fontWeight: FontWeight.w400,
                          fontSize: 15,
                        ),
                      ),
                      onChanged: (value) {
                        if (_formKey.currentState!.validate()) ;
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter special notes";
                        }
                      },
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    Text(
                      AppConstants.followupdate,
                      style: TextStyle(
                        color: Color(0xff838994),
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    GestureDetector(
                      onTap: () async {
                        DateTime? date = DateTime.now();
                        FocusManager.instance.primaryFocus?.unfocus();
                        final datePick = await DatePicker.showSimpleDatePicker(
                          context,
                          initialDate: DateTime(2000),
                          firstDate: DateTime(date.year),
                          // DateTime(1972),
                          lastDate:
                              DateTime(date.year + 1, date.month, date.day),
                          dateFormat: "dd-MMMM-yyyy",
                          locale: DateTimePickerLocale.en_us,
                          looping: false,
                        );
                        if (datePick != null && datePick != Date) {
                          setState(() {
                            Date = datePick;
                            isDateSelected = true;

                            _date.text =
                                "${Date.month}-${Date.day}-${Date.year}";
                            print('${_date.text.toString()}');
                          });
                        }
                      },
                      child: TextFormField(
                        controller: _date,
                        enabled: false,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 8),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: AppColors.textFieldColor, width: 2),
                          ),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: AppColors.textFieldColor, width: 2),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: AppColors.textFieldColor, width: 2),
                          ),
                          disabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: AppColors.textFieldColor, width: 2),
                          ),
                          hintText: "Select Date",
                          hintStyle: TextStyle(
                              color: Color(
                                0xff333F52,
                              ),
                              fontWeight: FontWeight.w500,
                              fontSize: 15),
                          labelStyle: TextStyle(
                            color: Color(0xff838994),
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: height * 0.04,
            ),
            ECommonButton(
              btnName: (widget.isUpdate == "isUpdate")
                  ? "Update"
                  : AppConstants.next,
              btnOnTap: () {
                if (_formKey.currentState!.validate()) {
                  if (widget.isUpdate == "isUpdate") {
                    updateManagementAPI();
                  } else {
                    if (_annualData == null) {
                      setState(() {
                        isSelectBudget = true;
                      });
                    } else {
                      addManagementAPI();
                    }
                  }
                }
              },
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  void checkConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      if (widget.isUpdate == "isUpdate") {
        getAnnualincome();
        getmanagementAPI();
      } else {
        getAnnualincome();
      }
    } else if (connectivityResult == ConnectivityResult.wifi) {
      if (widget.isUpdate == "isUpdate") {
        getAnnualincome();
        getmanagementAPI();
      } else {
        getAnnualincome();
      }
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

  getAnnualincome() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var authToken = prefs.getString(USER_TOKEN);

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

  addManagementAPI() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var exeToken = pref.getString(EXE_TOKEN);
    var exeUserId = pref.getString(EXE_USER_ID);
    log("Exe id :: $exeUserId");
    final queryParameters = {
      "token": exeToken.toString(),
    };
    String queryString = Uri(queryParameters: queryParameters).query;
    var params = {
      "user_id": exeUserId,
      "budget": _annualData!.id,
      "details": _detailController.text,
      "visit_count": _visitController.text,
      "spacial_notes": _specialNoteController.text,
      "followup_date": _date.text
    };
    var response =
        await dio.post(ADD_MANAGEMENT_URL + "?" + queryString, data: params);
    if (response.statusCode == 200) {
      AddManagementModel _addManagementModel =
          AddManagementModel.fromJson(response.data);
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

  getmanagementAPI() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var authToken = prefs.getString(EXE_TOKEN);
    final queryParameters = {
      "user_id": widget.candidateId.toString(),
      "token": authToken.toString(),
    };
    String queryString = Uri(queryParameters: queryParameters).query;
    var response = await http.get(
      Uri.parse(GET_MANAGEMENT_URL + "?" + queryString),
    );
    print("managment response::: ${response.body}");
    if (response.statusCode == 200) {
      CommonUtils.hideProgressLoading();
      if (mounted) {
        setState(() {
          _getManagementModel =
              GetManagementModel.fromJson(jsonDecode(response.body));
          _detailController.text =
              (_getManagementModel != null && _getManagementModel!.data != null)
                  ? _getManagementModel!.data!.details.toString()
                  : "";
          _visitController.text =
              (_getManagementModel != null && _getManagementModel!.data != null)
                  ? _getManagementModel!.data!.budget.toString()
                  : "";
          _specialNoteController.text =
              (_getManagementModel != null && _getManagementModel!.data != null)
                  ? _getManagementModel!.data!.spacialNotes.toString()
                  : "";
          _date.text =
              (_getManagementModel != null && _getManagementModel!.data != null)
                  ? _getManagementModel!.data!.followupDate.toString()
                  : "";
          if (_annualincomeModel != null && _annualincomeModel!.data != null) {
            for (var i = 0; i < _annualincomeModel!.data!.length; i++) {
              if (_getManagementModel != null &&
                  _getManagementModel!.data != null) {
                if (_annualincomeModel!.data![i].id ==
                    _getManagementModel!.data!.budget) {
                  _annualData = _annualincomeModel!.data![i];
                }
              }
            }
          }
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

  updateManagementAPI() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var exeToken = pref.getString(EXE_TOKEN);
    final queryParameters = {
      "token": exeToken.toString(),
    };
    String queryString = Uri(queryParameters: queryParameters).query;
    var params = {
      "user_id": widget.candidateId,
      "visit_count": _visitController.text,
      "budget": (_annualData != null) ? _annualData!.id : "",
      "details": _detailController.text,
      "spacial_notes": _specialNoteController.text,
      "followup_date": _date.text
    };
    var response =
        await dio.post(UPDATE_MANAGEMENT_URL + "?" + queryString, data: params);
    if (response.statusCode == 200) {
      AddManagementModel _addManagementModel =
          AddManagementModel.fromJson(response.data);
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
/* 
  Future _openGallery(BuildContext context) async {
    final pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
    );
    final f = File(pickedFile!.path);
    int sizeInBytes = f.lengthSync();
    double sizeInMb = sizeInBytes / (1024 * 1024);
    if (sizeInMb < 5) {
      setState(() {
        image = pickedFile;
      });
      Navigator.pop(context);
      return image;
    } else {
      Fluttertoast.showToast(
        msg: "max size 5 mb",
        toastLength: Toast.LENGTH_SHORT,
      );
      Navigator.pop(context);
      return null;
    }
  }

  Future _openCamera(BuildContext context) async {
    final pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
    );
    final f = File(pickedFile!.path);
    int sizeInBytes = f.lengthSync();
    double sizeInMb = sizeInBytes / (1024 * 1024);
    if (sizeInMb < 5) {
      setState(() {
        image = pickedFile;
      });
      Navigator.pop(context);
      return image;
    } else {
      Fluttertoast.showToast(
        msg: "max size 5 mb",
        toastLength: Toast.LENGTH_SHORT,
      );
      Navigator.pop(context);
      return null;
    }
  }
 */
}
