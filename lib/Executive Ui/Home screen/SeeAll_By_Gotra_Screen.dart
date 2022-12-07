// ignore_for_file: unused_import

import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:matrimonial_app/Core/Constant/url_constant.dart';
import 'package:matrimonial_app/Core/Constant/value_constants.dart';
import 'package:matrimonial_app/Executive%20Ui/Home%20screen/MessageScreen/message_screen.dart';
import 'package:matrimonial_app/Executive%20Ui/Login/login_screen.dart';
import 'package:matrimonial_app/MatchingProfile/matching_profilescreen.dart';
import 'package:matrimonial_app/ModelClass/Executive_ModelClass/Get_By_Gotra_Model.dart';
import 'package:matrimonial_app/Utils/image_path_constants.dart';
import 'package:matrimonial_app/Utils/text_styles.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SeeAllByGotra extends StatefulWidget {
  const SeeAllByGotra({Key? key}) : super(key: key);

  @override
  State<SeeAllByGotra> createState() => _SeeAllByGotraState();
}

class _SeeAllByGotraState extends State<SeeAllByGotra> {
  Dio _dio = Dio();
  GetByGotraModel? _getByGotraModel;

  @override
  void initState() {
    super.initState();
    checkConnection();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          "By Gotra",
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
        child: GridView.builder(
          // physics: NeverScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 17.0,
            mainAxisSpacing: 10.0,
            mainAxisExtent: 220,
          ),
          itemCount: _getByGotraModel != null && _getByGotraModel!.data != null
              ? _getByGotraModel!.data!.length
              : 0,
          // byCastList.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (context) => MatchingProfile_Screen(
                              name: _getByGotraModel!.data![index].firstname
                                  .toString(),
                              candidateId:
                                  _getByGotraModel!.data![index].userId,
                              img: _getByGotraModel!
                                          .data![index].profileImage!.length >
                                      0
                                  ? _getByGotraModel!
                                      .data![index].profileImage![0].filePath
                                      .toString()
                                  : "https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/1024px-No_image_available.svg.png",
                            )));
              },
              child: Container(
                height: 210,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),

                  // gradient: AppColors.appColor,
                ),
                child: Padding(
                  padding: EdgeInsets.all(4),
                  child: Container(
                    height: 210,
                    decoration: BoxDecoration(
                      border: Border.all(
                                              color: Color(0xffFB5A57),width: 5),
                                          borderRadius:
                                              BorderRadius.circular(20),
                      image: (_getByGotraModel != null &&
                              _getByGotraModel!.data != null &&
                              _getByGotraModel!
                                  .data![index].profileImage!.isNotEmpty &&
                              _getByGotraModel!
                                      .data![index].profileImage!.length >
                                  0)
                          ? DecorationImage(
                              image: NetworkImage(_getByGotraModel!
                                      .data![index].profileImage![0].filePath
                                      .toString()
                                  // byCastList[index][IMAGE]
                                  ),
                              fit: BoxFit.cover)
                          : DecorationImage(
                              image: CachedNetworkImageProvider(
                                  "https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/1024px-No_image_available.svg.png"),
                            ),
                    ),
                    child: Column(
                      children: [
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color(0xffffffff).withOpacity(0.9),
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(15),
                                bottomLeft: Radius.circular(15),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 0, right: 5, top: 5),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 5),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        
                                        Flexible(
                                          child: Text(
                                            _getByGotraModel != null &&
                                                    _getByGotraModel!.data !=
                                                        null
                                                ? _getByGotraModel!
                                                        .data![index].firstname
                                                        .toString() +
                                                    " " +
                                                    _getByGotraModel!
                                                        .data![index].lastname
                                                        .toString() +
                                                    "," +
                                                    _getByGotraModel!
                                                        .data![index].age
                                                        .toString()
                                                : "",
                                            maxLines: 1,
                                            // AppConstants.joseph,
                                            style: fontStyle.copyWith(
                                                overflow: TextOverflow.ellipsis,
                                                color: Colors.black,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Image.asset(
                                          ImagePath.dualprofile,
                                          height: 16,
                                          width: 16,
                                        ),
                                        
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 5),
                                    child: Row(
                                      children: [
                                        Text(
                                          _getByGotraModel != null &&
                                                  _getByGotraModel!.data != null
                                              ? "Patel" +
                                                  " | " +
                                                  _getByGotraModel!
                                                      .data![index].height
                                                      .toString()
                                              : "",
                                          maxLines: 1,
                                          // AppConstants.castText,
                                          style: matchscroll.copyWith(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 5, right: 0, bottom: 5),
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          CupertinoPageRoute(
                                            builder: (context) =>
                                                E_Message_screen(),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: 25,
                                        decoration: BoxDecoration(
                                            color: Color(0xffFB5A57),
                                            borderRadius:
                                                BorderRadius.circular(9)),
                                        alignment: Alignment.center,
                                        child: Text(
                                          'Message',
                                          style: appBtnStyle.copyWith(
                                              fontSize: 12,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  checkConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      getByGotraAPI();
    } else if (connectivityResult == ConnectivityResult.wifi) {
      getByGotraAPI();
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

  getByGotraAPI() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var exeToken = pref.getString(EXE_TOKEN);
    final queryParameters = {
      "token": exeToken.toString(),
    };
    String queryString = Uri(queryParameters: queryParameters).query;
    // log("gotra Url ::: ${GET_BY_GOTRA_URL + "?" + queryString}");
    var response = await _dio.get(GET_BY_GOTRA_URL + "?" + queryString);
    if (response.statusCode == 200) {
      var data = response.data;
      if (data['status'] == 'Token is Expired') {
        pref.setString(EXE_TOKEN, "");
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (dialogcontext) => ExeLogin()),
            (route) => false);
      } else {
        setState(() {
          _getByGotraModel = GetByGotraModel.fromJson(data);
        });
      }
    }
  }
}
