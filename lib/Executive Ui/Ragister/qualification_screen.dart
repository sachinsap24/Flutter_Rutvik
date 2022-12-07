import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:matrimonial_app/Core/Constant/CommonUtils.dart';
import 'package:matrimonial_app/Core/Constant/url_constant.dart';
import 'package:matrimonial_app/Core/Constant/value_constants.dart';
import 'package:matrimonial_app/Executive%20Ui/Home%20screen/home_screen.dart';
import 'package:matrimonial_app/ModelClass/Executive_ModelClass/Add_Qualification_Model.dart';
import 'package:matrimonial_app/ModelClass/Executive_ModelClass/Get_Qualification_Model.dart';
import 'package:matrimonial_app/ModelClass/Executive_ModelClass/Get_Work_As_Model.dart';
import 'package:matrimonial_app/ModelClass/Executive_ModelClass/Get_Work_Type_Model.dart';
import 'package:matrimonial_app/ModelClass/Executive_ModelClass/Update_Qualification_Model.dart';
import 'package:matrimonial_app/ModelClass/UserPanel_ModelClass/DropDown_Datas/annualincome_model.dart';
import 'package:matrimonial_app/ModelClass/UserPanel_ModelClass/DropDown_Datas/qualification_model.dart'
    as qualification;
import 'package:matrimonial_app/Utils/app_constants.dart';
import 'package:matrimonial_app/Utils/image_path_constants.dart';
import 'package:matrimonial_app/widget/Executive%20Side/eCommonButton.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Qualification_screen extends StatefulWidget {
   Qualification_screen(
      {Key? key, this.isUpdate, this.onBack, this.candidateId})
      : super(key: key);
  final String? isUpdate;
  final Function? onBack;
  var candidateId;
  @override
  State<Qualification_screen> createState() => _Qualification_screenState();
}

class _Qualification_screenState extends State<Qualification_screen> {
  Dio dio = Dio();
  AnnualincomeModel? _annualincomeModel;
  qualification.QualificationModel? _qualificationModel;
  AnnualData? _annualincomedata;
  qualification.Data? _qualificationData;
  getWorkTypeModel? _workTypeModel;
  DataWorkType? _dataWorkType;
  getWorkAsModel? _workAsModel;
  DataWorkAs? _dataWorkAs;
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
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: SingleChildScrollView(
          child: Column(
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
              Text(
                AppConstants.highestqualification,
                style: TextStyle(
                    color: Color(0xff838994),
                    fontSize: 12,
                    fontWeight: FontWeight.w400),
              ),
              SizedBox(height: 8),
              Container(
                padding: EdgeInsets.only(top: 0),
                height: 30,
                width: MediaQuery.of(context).size.width,
                child: DropdownButtonHideUnderline(
                  child: DropdownButton2<qualification.Data>(
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
                      AppConstants.bcom,
                      style: TextStyle(fontSize: 14),
                    ),
                    dropdownMaxHeight: 200,
                    itemHeight: 20,
                    items: addDividersAfterItemsQualificationModel(
                        (_qualificationModel != null)
                            ? _qualificationModel!.data!
                            : []),
                    customItemsIndexes: getDividersIndexes(
                        (_qualificationModel != null)
                            ? _qualificationModel!.data!
                            : []),
                    value: _qualificationData,
                    onChanged: (value) {
                      setState(() {
                        _qualificationData = value;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(height: 5),
              Divider(
                height: 5,
                thickness: MediaQuery.of(context).size.width * 0.002,
                color: Color(0xffE4E7F1),
              ),
              SizedBox(height: 20),
              Text(
                AppConstants.workwith,
                style: TextStyle(
                    color: Color(0xff838994),
                    fontSize: 12,
                    fontWeight: FontWeight.w400),
              ),
              SizedBox(height: 8),
              Container(
                padding: EdgeInsets.only(top: 0),
                height: 30,
                width: MediaQuery.of(context).size.width,
                child: DropdownButtonHideUnderline(
                  child: DropdownButton2<DataWorkType>(
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
                      AppConstants.privatecompany,
                      style: TextStyle(fontSize: 14),
                    ),
                    dropdownMaxHeight: 200,
                    itemHeight: 20,
                    items: addDividersAfterItemsWorkTypeModel(
                        (_workTypeModel != null) ? _workTypeModel!.data! : []),
                    customItemsIndexes: getDividersIndexes(
                        (_workTypeModel != null) ? _workTypeModel!.data! : []),
                    value: _dataWorkType,
                    onChanged: (value) {
                      setState(() {
                        _dataWorkType = value as DataWorkType;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(height: 5),
              Divider(
                height: 5,
                thickness: MediaQuery.of(context).size.width * 0.002,
                color: Color(0xffE4E7F1),
              ),
              SizedBox(height: 20),
              Text(
                AppConstants.as,
                style: TextStyle(
                    color: Color(0xff838994),
                    fontSize: 12,
                    fontWeight: FontWeight.w400),
              ),
              SizedBox(height: 8),
              Container(
                padding: EdgeInsets.only(top: 0),
                height: 30,
                width: MediaQuery.of(context).size.width,
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
                      AppConstants.senior,
                      style: TextStyle(fontSize: 14),
                    ),
                    itemHeight: 20,
                    dropdownMaxHeight: 200,
                    items: addDividersAfterItemsWorkAsModel(
                        (_workAsModel != null) ? _workAsModel!.data! : []),
                    customItemsIndexes: getDividersIndexes(
                        (_workAsModel != null) ? _workAsModel!.data! : []),
                    value: _dataWorkAs,
                    onChanged: (value) {
                      setState(() {
                        _dataWorkAs = value as DataWorkAs;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(height: 5),
              Divider(
                height: 5,
                thickness: MediaQuery.of(context).size.width * 0.002,
                color: Color(0xffE4E7F1),
              ),
              SizedBox(height: 20),
              Text(
                AppConstants.yourannual,
                style: TextStyle(
                    color: Color(0xff838994),
                    fontSize: 12,
                    fontWeight: FontWeight.w400),
              ),
              SizedBox(height: 8),
              Container(
                padding: EdgeInsets.only(top: 0),
                height: 30,
                width: MediaQuery.of(context).size.width,
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
                      AppConstants.lakhs,
                      style: TextStyle(fontSize: 14),
                    ),
                    itemHeight: 20,
                    dropdownMaxHeight: 200,
                    items: addDividersAfterItemsIncome(
                        (_annualincomeModel != null)
                            ? _annualincomeModel!.data!
                            : []),
                    customItemsIndexes: getDividersIndexes(
                        (_annualincomeModel != null)
                            ? _annualincomeModel!.data!
                            : []),
                    value: _annualincomedata,
                    onChanged: (value) {
                      setState(() {
                        _annualincomedata = value as AnnualData;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(height: 5),
              Divider(
                height: 5,
                thickness: MediaQuery.of(context).size.width * 0.002,
                color: Color(0xffE4E7F1),
              ),
              SizedBox(height: 20),
              SizedBox(
                height: 0.04,
              ),
              ECommonButton(
                btnName: AppConstants.done,
                btnOnTap: () {
                  if (_qualificationData == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Please Select Qualification")));
                  } else if (_annualincomedata == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Please Select AnnualIncome")));
                  } else {
                    if (widget.isUpdate == "isUpdate") {
                      updateQualificationAPI();
                    } else {
                      addQualification();
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
      ),
    );
  }

  void checkConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      if (widget.isUpdate == "isUpdate") {
        getQualificationAPI();
        getAnnualincome();
        getQualification();
        getWorkingType();
        getWorkAs();
      } else {
        getAnnualincome();
        getQualification();
        getWorkingType();
        getWorkAs();
      }
    } else if (connectivityResult == ConnectivityResult.wifi) {
      if (widget.isUpdate == "isUpdate") {
        getQualificationAPI();
        getAnnualincome();
        getQualification();
        getWorkingType();
        getWorkAs();
      } else {
        getAnnualincome();
        getQualification();
        getWorkingType();
        getWorkAs();
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
    CommonUtils.showProgressLoading(context);

    var response = await http.get(
      Uri.parse(GET_ANNUALINCOME_URL),
    );

    if (response.statusCode == 200) {
      CommonUtils.hideProgressLoading();
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
    } else {
      CommonUtils.hideProgressLoading();
    }
  }

  getQualification() async {
    var response = await http.get(
      Uri.parse(GET_QUALIFICATION_URL),
    );

    if (response.statusCode == 200) {
      if (mounted) {
        setState(() {
          _qualificationModel = qualification.QualificationModel.fromJson(
              jsonDecode(response.body));
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

  getWorkingType() async {
    var response = await http.get(
      Uri.parse(GET_EXE_WORKTYPE_URL),
    );

    if (response.statusCode == 200) {
      if (mounted) {
        setState(() {
          _workTypeModel = getWorkTypeModel.fromJson(jsonDecode(response.body));
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

  getWorkAs() async {
    var response = await http.get(
      Uri.parse(GET_EXE_WORKAS_URL),
    );

    if (response.statusCode == 200) {
      if (mounted) {
        setState(() {
          _workAsModel = getWorkAsModel.fromJson(jsonDecode(response.body));
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

  addQualification() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var exeToken = pref.getString(EXE_TOKEN);
    var exeUserId = pref.getString(EXE_USER_ID);
    final queryParameters = {
      "token": exeToken.toString(),
    };
    String queryString = Uri(queryParameters: queryParameters).query;
    var params = {
      "qualification": _qualificationData!.id,
      "work_type": (_dataWorkType != null) ? _dataWorkType!.id : "",
      "work_post": (_dataWorkAs != null) ? _dataWorkAs!.id : "",
      "annual_income": _annualincomedata!.id,
      "user_id": exeUserId
    };
    var response =
        await dio.post(ADD_QUALIFICATION_URL + "?" + queryString, data: params);
    if (response.statusCode == 200) {
      print("response :: ${response.data}");
      AddQualificationModel _addQualificationModel =
          AddQualificationModel.fromJson(response.data);
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) => Zoom()), ((route) => false));
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

  getQualificationAPI() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var exeToken = pref.getString(EXE_TOKEN);
    final queryParameters = {
      "user_id": widget.candidateId.toString(),
      "token": exeToken.toString(),
    };
    String queryString = Uri(queryParameters: queryParameters).query;
    var response = await dio.get(GET_EXE_QUALIFICATION_URL + "?" + queryString);
    if (response.statusCode == 200) {
      GetExeQualificationModel _getExeQualificationModel =
          GetExeQualificationModel.fromJson(response.data);

      if (_qualificationModel != null && _qualificationModel!.data != null) {
        for (var i = 0; i < _qualificationModel!.data!.length; i++) {
          if (_qualificationModel!.data![i].id ==
              _getExeQualificationModel.data!.qualification) {
            setState(() {
              _qualificationData = _qualificationModel!.data![i];
            });
          }
        }
      }

      for (var i = 0; i < _workTypeModel!.data!.length; i++) {
        if (_workTypeModel!.data![i].id ==
            int.parse(_getExeQualificationModel.data!.workType.toString())) {
          setState(() {
            _dataWorkType = _workTypeModel!.data![i];
          });
        }
      }
      for (var i = 0; i < _workAsModel!.data!.length; i++) {
        if (_workAsModel!.data![i].id ==
            int.parse(_getExeQualificationModel.data!.workPost.toString())) {
          setState(() {
            _dataWorkAs = _workAsModel!.data![i];
          });
        }
      }
      for (var i = 0; i < _annualincomeModel!.data!.length; i++) {
        if (_annualincomeModel!.data![i].id ==
            _getExeQualificationModel.data!.annualIncome) {
          setState(() {
            _annualincomedata = _annualincomeModel!.data![i];
          });
        }
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

  updateQualificationAPI() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var exeToken = pref.getString(EXE_TOKEN);
    final queryParameters = {
      "token": exeToken.toString(),
    };
    String queryString = Uri(queryParameters: queryParameters).query;
    var params = {
      "qualification":
          (_qualificationData != null) ? _qualificationData!.id : "",
      "work_type": (_dataWorkType != null) ? _dataWorkType!.id : "",
      "work_post": (_dataWorkAs != null) ? _dataWorkAs!.id : "",
      "annual_income": (_annualincomedata != null) ? _annualincomedata!.id : "",
      "user_id": widget.candidateId
    };
    var response = await dio
        .post(UPDATE_EXE_QUALIFICATION_URL + "?" + queryString, data: params);
    if (response.statusCode == 200) {
      UpdateExeQualificationModel _updateExeQualificationModel =
          UpdateExeQualificationModel.fromJson(response.data);
      Navigator.pop(context);
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

  List<DropdownMenuItem<AnnualData>> addDividersAfterItemsIncome(
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

  List<DropdownMenuItem<qualification.Data>>
      addDividersAfterItemsQualificationModel(List<qualification.Data> items) {
    List<DropdownMenuItem<qualification.Data>> _menuItems = [];
    for (var item in items) {
      _menuItems.addAll(
        [
          DropdownMenuItem<qualification.Data>(
            value: item,
            child: Padding(
              padding: EdgeInsets.only(top: 2.0, left: 10),
              child: Text(
                item.qualification.toString(),
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
          ),
          if (item != items.last)
            const DropdownMenuItem<qualification.Data>(
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

  List<DropdownMenuItem<DataWorkType>> addDividersAfterItemsWorkTypeModel(
      List<DataWorkType> items) {
    List<DropdownMenuItem<DataWorkType>> _menuItems = [];
    for (var item in items) {
      _menuItems.addAll(
        [
          DropdownMenuItem<DataWorkType>(
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
            const DropdownMenuItem<DataWorkType>(
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

  List<DropdownMenuItem<DataWorkAs>> addDividersAfterItemsWorkAsModel(
      List<DataWorkAs> items) {
    List<DropdownMenuItem<DataWorkAs>> _menuItems = [];
    for (var item in items) {
      _menuItems.addAll(
        [
          DropdownMenuItem<DataWorkAs>(
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
            const DropdownMenuItem<DataWorkAs>(
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
