import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:matrimonial_app/Core/Constant/CommonUtils.dart';
import 'package:matrimonial_app/Core/Constant/url_constant.dart';
import 'package:matrimonial_app/Core/Constant/value_constants.dart';
import 'package:matrimonial_app/ModelClass/UserPanel_ModelClass/GetProfile_Details/Get_Hobbies_Model.dart';
import 'package:matrimonial_app/ModelClass/UserPanel_ModelClass/Update_Profile_Details/Update_Hobbies_Model.dart';
import 'package:matrimonial_app/Ui/Drawer/ProfileScreen/profile_screenn.dart';
import 'package:matrimonial_app/Ui/Home_screen/Home/Drawer_Screen.dart';
import 'package:matrimonial_app/Ui/RegisterScreen/basic_detail.dart';
import 'package:matrimonial_app/Utils/app_constants.dart';
import 'package:matrimonial_app/Utils/image_path_constants.dart';
import 'package:matrimonial_app/Utils/text_styles.dart';
import 'package:matrimonial_app/widget/commonappbar_search.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../widget/submit_button.dart';

class Hobbies_Detail extends StatefulWidget {
  String? fromValue;
  Hobbies_Detail({Key? key, this.fromValue}) : super(key: key);
  @override
  HobbiesDetailScreen createState() => HobbiesDetailScreen();
}

class HobbiesDetailScreen extends State<Hobbies_Detail> {
  Dio dio = Dio();
  bool isSelect = false;

  List dataList = [];
  void selectItem(int i) {
    setState(() {
      imaglist[i].isSelected = !imaglist[i].isSelected;

      if (imaglist[i].isSelected == true) {
        print("selected items --------> $dataList");
        dataList.add(imaglist[i].label);
        print("new selection items +++++++ $dataList");
      } else {
        if (imaglist[i].isSelected == false) {
          log("tap id ${imaglist[i].label}");

          print("data list length ::: ${dataList.length}");
          for (var k = 0; k < dataList.length; k++) {
            if (imaglist[i].label == dataList[k]) {
              log(dataList[k]);
              dataList.removeAt(k);
            }
            print("object items ======== $dataList");
          }
        }
      }
    });
  }

  List<Tech> imaglist = [
    Tech(AppConstants.catan, false),
    Tech(/* "ludo".tr */ AppConstants.ludo, false),
    Tech(/* "rave ".tr */ AppConstants.rave, false),
    Tech(/* "outdoors".tr */ AppConstants.outdoors, false),
    Tech(/* "cricket".tr */ AppConstants.cricket, false),
    Tech(/* "sushi".tr */ AppConstants.sushi, false),
    Tech(/* "mountians".tr */ AppConstants.mountians, false),
    Tech(/* "broadway".tr */ AppConstants.broadway, false),
    Tech(/* "pilates".tr */ AppConstants.pilates, false),
    Tech(/* "art".tr */ AppConstants.art, false),
    Tech(/* "movie".tr */ AppConstants.movie, false),
    Tech(/* "90s Kid".tr */ AppConstants.d, false),
    Tech(/* "kID".tr */ AppConstants.kid, false),
    Tech(/* "tikTok".tr */ AppConstants.tiktok, false),
    Tech(/* "baseBall".tr */ AppConstants.baseball, false),
    Tech(/* "bloging".tr */ AppConstants.bloging, false),
    Tech(/* "cooking".tr */ AppConstants.cooking, false),
    Tech(/* "dancing".tr */ AppConstants.dancing, false),
    Tech(/* "yoga".tr */ AppConstants.yoga, false),
    Tech(/* "working out".tr */ AppConstants.workingout, false),
    Tech(/* "vinyasa".tr */ AppConstants.vinyasa, false),
    Tech(/* "astrology".tr */ AppConstants.astrology, false),
  ];
  List<Tech> foundimaglist = [];
  bool selected = false;

  @override
  void initState() {
    foundimaglist = imaglist;
    super.initState();
    checkConnection();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
            child: Column(
              children: [
                ProfileDataGetAppbar(name: "hobbies".tr),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Text(
                          "continuewithus".tr,
                          style: headingStyle.copyWith(
                              color: Color(0xff838994),
                              fontSize: 14,
                              fontWeight: FontWeight.w400),
                        ),
                        (widget.fromValue == "Edit")
                            ? Container()
                            : SizedBox(height: 15),
                        (widget.fromValue == "Edit")
                            ? Container()
                            : Image.asset(ImagePath.loaction, height: 19),
                        Padding(
                          padding: EdgeInsets.only(top: 20.0, bottom: 10),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color: Color(0xff000000).withOpacity(0.1),
                                    offset: Offset(0.5, 0.5),
                                    blurRadius: 10)
                              ],
                              border: Border.all(
                                  color: Color(0xffC5D0DE), width: 0.5),
                              borderRadius: BorderRadius.circular(13),
                            ),
                            child: TextField(
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
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
                                    borderRadius: BorderRadius.circular(13),
                                    borderSide: BorderSide(
                                        color:
                                            Color.fromARGB(255, 187, 187, 187),
                                        width: 1.5),
                                  ),
                                  hintText: AppConstants.search,
                                  hintStyle: TextStyle(
                                      color: Color(0xff757885),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14),
                                  label: Text(
                                    "what are looking for".tr,
                                    style: headerstyle.copyWith(
                                        color: Color(0xff4D4D4D),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14),
                                  ),
                                  prefixIcon: Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: Image.asset(
                                      ImagePath.search,
                                      width: 20,
                                      height: 20,
                                      color: Color(0xff576170),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                )),
                          ),
                        ),
                        Column(
                          children: techChips(),
                        ),
                        SizedBox(height: 30),
                        CommonButton(
                          btnName: AppConstants.done,
                          btnOnTap: () {
                            updateHobbiesAPI();
                          },
                        ),
                        SizedBox(height: 30),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void checkConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      getHobbiesAPI();
    } else if (connectivityResult == ConnectivityResult.wifi) {
      getHobbiesAPI();
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

  updateHobbiesAPI() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString(USER_TOKEN);
    final queryParameters = {
      "token": token.toString(),
    };
    String queryString = Uri(queryParameters: queryParameters).query;
    var params = {"hobbies": dataList};
    var response =
        await dio.post(UPDATE_HOBBIES_URL + "?" + queryString, data: params);
    if (response.statusCode == 200) {
      print(response.data);
      var data = response.data;
      if (data['success'] == true) {
        UpdateHobbiesModel updateHobbiesModel =
            UpdateHobbiesModel.fromJson(data);
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => Zoom(
                      selectedIndex: 4,
                    )),
            (route) => false);
      } else {
        Navigator.push(
            context, CupertinoPageRoute(builder: (context) => Profile()));
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

  getHobbiesAPI() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString(USER_TOKEN);
    final queryParameters = {
      "token": token.toString(),
    };
    String queryString = Uri(queryParameters: queryParameters).query;
    var response = await dio.get(GET_HOBBIES_URL + "?" + queryString);
    if (response.statusCode == 200) {
      print(response.data);
      var data = response.data;
      if (data['success'] == true) {
        GetHobbiesModel _getHobbiesModel =
            GetHobbiesModel.fromJson(response.data);
        setState(() {
          log("Get Hobbiles Length :: ${_getHobbiesModel.data!.userHobbies!.hobbies!.length}");
          for (var i = 0;
              i < _getHobbiesModel.data!.userHobbies!.hobbies!.length;
              i++) {
            log("Get ImageList Length :: ${imaglist.length}");
            for (var j = 0; j < imaglist.length; j++) {
              if (_getHobbiesModel.data!.userHobbies!.hobbies![i] ==
                  imaglist[j].label) {
                imaglist[j].isSelected = true;
                dataList.add(_getHobbiesModel.data!.userHobbies!.hobbies![i]);
                log("Selected Hobbies  : : ${dataList}");
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
    } else {
      CommonUtils.hideProgressLoading();
    }
  }

  List<Widget> techChips() {
    List<Widget> chips = [];

    Widget items = Wrap(
      runSpacing: 10,
      spacing: 10,
      alignment: WrapAlignment.start,
      crossAxisAlignment: WrapCrossAlignment.start,
      children: List.generate(
          imaglist.length,
          (index) => InkWell(
                onTap: () {
                  if (dataList.length < 5) {
                    selectItem(index);
                  } /* else if (dataList.length == 5) {
                    Fluttertoast.showToast(msg: "Maximum 5 hobbies selected");
                  } */
                  else {
                    if (imaglist[index].isSelected == true) {
                      for (var k = 0; k < dataList.length; k++) {
                        print("data list length ::: ${dataList.length}");
                        if (imaglist[index].label == dataList[k]) {
                          log(dataList[k]);
                          dataList.removeAt(k);
                        }
                        print("object items ======== $dataList");
                      }
                    }
                  }
                },
                child: Container(
                  height: 40,
                  // width:
                  // MediaQuery.of(context).size.width / 4,
                  // imaglist[index].label.characters.length.toDouble() /
                  //     0.056,
                  // padding: EdgeInsets.only(left: 10, right: 10),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: imaglist[index].isSelected
                              ? Color(0xffFB5257)
                              : Colors.black38),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 15, right: 15, top: 8, bottom: 10),
                    child: Text(
                      imaglist[index].label,
                      textAlign: TextAlign.center,
                      style: homestyle.copyWith(
                          fontSize: 17,
                          color: imaglist[index].isSelected
                              ? Color(0xffFB5257)
                              : Color(0xff8B8B8B)),
                    ),
                  ),
                ),
              )),
    );
    chips.add(items);

    return chips;
  }
}

class Tech {
  String label;
  bool isSelected;
  Tech(this.label, this.isSelected);
}
