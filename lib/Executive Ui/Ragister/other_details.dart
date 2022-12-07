import 'dart:convert';
import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:matrimonial_app/Core/Constant/CommonUtils.dart';
import 'package:matrimonial_app/Core/Constant/url_constant.dart';
import 'package:matrimonial_app/Core/Constant/value_constants.dart';
import 'package:matrimonial_app/ModelClass/Executive_ModelClass/Get_Other_Detail_Model.dart';
import 'package:matrimonial_app/ModelClass/Executive_ModelClass/add_others_model.dart';
import 'package:matrimonial_app/ModelClass/UserPanel_ModelClass/DropDown_Datas/age_model.dart';
import 'package:matrimonial_app/ModelClass/UserPanel_ModelClass/DropDown_Datas/diet_model.dart';
import 'package:matrimonial_app/ModelClass/UserPanel_ModelClass/DropDown_Datas/height_model.dart';
import 'package:matrimonial_app/Utils/app_constants.dart';
import 'package:matrimonial_app/Utils/image_path_constants.dart';
import 'package:matrimonial_app/Utils/text_styles.dart';
import 'package:http/http.dart' as http;
import 'package:matrimonial_app/widget/Executive%20Side/eCommonButton.dart';
import 'package:matrimonial_app/ModelClass/UserPanel_ModelClass/DropDown_Datas/Get_MaritalStatus_Model.dart'
    as maritalStatus;
import 'package:shared_preferences/shared_preferences.dart';

class Other_DetailsScreen extends StatefulWidget {
   Other_DetailsScreen(
      {Key? key, this.onBack, this.isUpdate, this.candidateId})
      : super(key: key);
  final String? isUpdate;
  final Function? onBack;
  var candidateId;

  @override
  State<Other_DetailsScreen> createState() => _Other_DetailsScreenState();
}

class _Other_DetailsScreenState extends State<Other_DetailsScreen> {
  Dio dio = Dio();
  maritalStatus.GetmaritalStatusModel? _getmaritalStatusModel;
  maritalStatus.Data? _maritalData;
  bool isWeight = false;
  bool isHeight = false;
  DietModel? _dietModel;
  DietData? _dietData;
  String? dropdownBudget;
  String? dropdownBudget1;
  AgeModel? _ageModel;
  AgeData? _ageData;
  HeightData? _heightData;
  HeightModel? _heightModel;
  List<String> maritalList = ["Married", "UnMarried"];
  List<String> dietList = ["Veg", "Non-Veg"];
  TextEditingController _heightController = TextEditingController();
  TextEditingController _weightController = TextEditingController();
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
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 8),
                  Text(
                    AppConstants.otherDetailheading,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Color(0xff4D5767),
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(top: 15, bottom: 7),
                    child: Text(
                      "Marital Status",
                      style: TextStyle(
                        color: Color(0xff4D4D4D),
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(13),
                      border: Border.all(
                        color: Color(0xffD1D1D1),
                        width: 1.5,
                      ),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton2<maritalStatus.Data>(
                        focusColor: Colors.white,
                        buttonHeight: 43,
                        dropdownDecoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(13),
                        ),
                        icon: Padding(
                          padding: EdgeInsets.all(10.0),
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
                            'Select Marital Status',
                            style: fontStyle.copyWith(
                                color: Color(0xff777777),
                                fontWeight: FontWeight.w500,
                                fontSize: 15),
                          ),
                        ),
                        dropdownMaxHeight: 200,
                        itemHeight: 20,
                        items: addDividersAfterItemsMaritalStatus(
                            (_getmaritalStatusModel != null)
                                ? _getmaritalStatusModel!.data!
                                : []),
                        customItemsIndexes: getDividersIndexes(
                            (_getmaritalStatusModel != null)
                                ? _getmaritalStatusModel!.data!
                                : []),
                        value: _maritalData,
                        onChanged: (newValue) {
                          print(newValue);
                          log("this is drop down value for marital status ${newValue!.name}");
                          log("this is drop down value for marital status ${newValue.id}");

                          setState(() {
                            _maritalData = newValue;
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Diet type",
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
                          padding: EdgeInsets.all(10.0),
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
                                fontSize: 15),
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

                          log("this is drop down value for marital status ${newValue!.diet}");
                          log("this is drop down value for marital status ${newValue.id}");
                          setState(() {
                            _dietData = newValue;
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              "",
                              style: TextStyle(
                                color: Color(0xff4D4D4D),
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            TextFormField(
                              onChanged: (String t) {},
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(3),
                                FilteringTextInputFormatter.allow(
                                    RegExp("[0-9]"))
                              ],
                              textInputAction: TextInputAction.done,
                              keyboardType: TextInputType.number,
                              controller: _weightController,
                              onTap: () {
                                setState(() {
                                  isWeight = true;
                                });
                              },
                              decoration: InputDecoration(
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(13),
                                  borderSide: BorderSide(
                                      color: Color(0xffD1D1D1), width: 1.5),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(13),
                                  borderSide: BorderSide(
                                      color: Color(0xffD1D1D1), width: 1.5),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 4, horizontal: 15),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                hintText: AppConstants.kg,
                                suffixText: isWeight ? "(Kg's)" : '',
                                suffixStyle: TextStyle(color: Colors.black),
                                hintStyle: TextStyle(
                                    color: Color(0xff757885),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14),
                                label: Text(
                                  AppConstants.weight,
                                  style: headerstyle.copyWith(
                                      color: Color(0xff4D4D4D),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Flexible(
                        flex: 1,
                        child: Container(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 15, bottom: 7),
                              child: Text(
                                "Height",
                                style: TextStyle(
                                  color: Color(0xff4D4D4D),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(13),
                                border: Border.all(
                                  color: Color(0xffD1D1D1),
                                  width: 1.5,
                                ),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton2<HeightData>(
                                  buttonHeight: 43,
                                  dropdownDecoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(13),
                                  ),
                                  icon: Padding(
                                    padding: EdgeInsets.all(0.0),
                                    child: Row(
                                      children: [
                                        isHeight
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
                                        Container(
                                          height: 18,
                                          width: 18,
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
                                      'Select height',
                                      style: fontStyle.copyWith(
                                          color: Color(0xff777777),
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14),
                                    ),
                                  ),
                                  dropdownMaxHeight: 200,
                                  itemHeight: 20,
                                  items: addDividersAfterItemsHeight(
                                      (_heightModel != null)
                                          ? _heightModel!.data!
                                          : []),
                                  customItemsIndexes: getDividersIndexes(
                                      (_heightModel != null)
                                          ? _heightModel!.data!
                                          : []),
                                  value: _heightData,
                                  onChanged: (newValue) {
                                    print(newValue);
                                    log("this is drop down value for marital status ${newValue!.height}");
                                    log("this is drop down value for marital status ${newValue.id}");
                                    setState(() {
                                      isHeight = true;
                                      _heightData = newValue;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ],
                        )),
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(height: 50),
              ECommonButton(
                  btnName: (widget.isUpdate == "isUpdate")
                      ? "Update"
                      : AppConstants.next,
                  btnOnTap: () async {
                    if (_maritalData == null) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Please Select Marital Status")));
                    } else {
                      if (widget.isUpdate == "isUpdate") {
                        updateOtherDetailAPI();
                      } else {
                        addOtherDetailAPI();
                      }
                    }
                  }),
              SizedBox(height: 10)
            ],
          ),
        ),
      ),
    );
  }

  void checkConnection() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var exeId = prefs.getString(EXE_ID);
    log("this is my data for user id $exeId");
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      if (widget.isUpdate == "isUpdate") {
        getMaritalStatus();
        getAge();
        getDiet();
        getHeight();
        getOtherDetailAPI();
      } else {
        getMaritalStatus();
        getAge();
        getDiet();
        getHeight();
      }
    } else if (connectivityResult == ConnectivityResult.wifi) {
      if (widget.isUpdate == "isUpdate") {
        getMaritalStatus();
        getAge();
        getDiet();
        getHeight();
        getOtherDetailAPI();
      } else {
        getMaritalStatus();
        getAge();
        getDiet();
        getHeight();
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

  addOtherDetailAPI() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var exeToken = prefs.getString(EXE_TOKEN);
    var exeUserId = prefs.getString(EXE_USER_ID);
    final queryParameters = {
      "token": exeToken.toString(),
    };
    String queryString = Uri(queryParameters: queryParameters).query;
    var params = {
      "height": (_heightData != null) ? _heightData!.id : "",
      "weight": _weightController.text,
      "diet": (_dietData != null) ? _dietData!.id : "",
      "marital_status": _maritalData!.id,
      "user_id": exeUserId
    };
    var response = await dio.post(POST_OTHERE_DETAILS_URL + "?" + queryString,
        data: params);
    if (response.statusCode == 200) {
      AddOthersModel _addOthersModel = AddOthersModel.fromJson(response.data);
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

  getOtherDetailAPI() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var exeToken = pref.getString(EXE_TOKEN);
    final queryParameters = {
      "user_id": widget.candidateId.toString(),
      "token": exeToken.toString()
    };
    String queryString = Uri(queryParameters: queryParameters).query;
    var response = await dio.get(GET_OTHER_DETAIL_URL + "?" + queryString);
    if (response.statusCode == 200) {
      print("other detail :::::: ${response.data}");
      GetOtherDetailModel _getOtherDetailModel =
          GetOtherDetailModel.fromJson(response.data);

      setState(() {
        _weightController.text = _getOtherDetailModel.data!.weight.toString();
        // if (_getmaritalStatusModel != null) {
        for (var i = 0; i < _getmaritalStatusModel!.data!.length; i++) {
          if (_getmaritalStatusModel!.data![i].id ==
              _getOtherDetailModel.data!.maritalStatus) {
            _maritalData = _getmaritalStatusModel!.data![i];
          }
        }
        // }
        if (_dietModel != null) {
          for (var i = 0; i < _dietModel!.data!.length; i++) {
            if (_dietModel!.data![i].id == _getOtherDetailModel.data!.diet) {
              _dietData = _dietModel!.data![i];
            }
          }
        }
        if (_heightModel != null) {
          for (var i = 0; i < _heightModel!.data!.length; i++) {
            if (_heightModel!.data![i].id ==
                _getOtherDetailModel.data!.height) {
              _heightData = _heightModel!.data![i];
            }
          }
        }
      });
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

  updateOtherDetailAPI() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var exeToken = prefs.getString(EXE_TOKEN);
    final queryParameters = {
      "token": exeToken.toString(),
    };
    String queryString = Uri(queryParameters: queryParameters).query;
    var params = {
      "height": (_heightData != null) ? _heightData!.id : "",
      "weight": _weightController.text,
      "diet": (_dietData != null) ? _dietData!.id : "",
      "marital_status": (_maritalData != null) ? _maritalData!.id : "",
      "user_id": widget.candidateId
    };
    var response = await dio.post(UPDATE_OTHER_DETAIL_URL + "?" + queryString,
        data: params);
    if (response.statusCode == 200) {
      AddOthersModel _addOthersModel = AddOthersModel.fromJson(response.data);
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

  getAge() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var authToken = prefs.getString(USER_TOKEN);

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

  getDiet() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var authToken = prefs.getString(USER_TOKEN);

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

  getMaritalStatus() async {
    var response = await http.get(Uri.parse(GET_MARITAL_STATUS_URL));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      if (data['success'] == true) {
        setState(() {
          _getmaritalStatusModel =
              maritalStatus.GetmaritalStatusModel.fromJson(data);
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
  }

  List<DropdownMenuItem<maritalStatus.Data>> addDividersAfterItemsMaritalStatus(
      List<maritalStatus.Data> items) {
    List<DropdownMenuItem<maritalStatus.Data>> _menuItems = [];
    for (var item in items) {
      _menuItems.addAll(
        [
          DropdownMenuItem<maritalStatus.Data>(
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
            const DropdownMenuItem<maritalStatus.Data>(
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
