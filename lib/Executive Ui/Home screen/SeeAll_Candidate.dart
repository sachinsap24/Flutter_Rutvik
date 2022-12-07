import 'dart:convert';
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:matrimonial_app/Core/Constant/CommonUtils.dart';
import 'package:matrimonial_app/Core/Constant/url_constant.dart';
import 'package:matrimonial_app/Core/Constant/value_constants.dart';
import 'package:matrimonial_app/Executive%20Ui/Home%20screen/MessageScreen/message_screen.dart';
import 'package:matrimonial_app/Executive%20Ui/Home%20screen/homescreen2.dart';
import 'package:matrimonial_app/ModelClass/Executive_ModelClass/All_Executive_Candidate_Model.dart';
import 'package:matrimonial_app/Utils/app_constants.dart';
import 'package:matrimonial_app/Utils/color_constants.dart';
import 'package:matrimonial_app/Utils/image_path_constants.dart';
import 'package:matrimonial_app/Utils/text_styles.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class SeeAllCandidate extends StatefulWidget {
  int? imgLength;
  SeeAllCandidate({Key? key, this.imgLength}) : super(key: key);

  @override
  State<SeeAllCandidate> createState() => _SeeAllCandidateState();
}

class _SeeAllCandidateState extends State<SeeAllCandidate> {
  AllExecutiveCandidates_Model? _allExecutiveCandidates_Model;
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
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          "Newly Added By You",
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
        padding: const EdgeInsets.only(bottom: 10),
        child: GridView.builder(
          itemCount: (_allExecutiveCandidates_Model != null &&
                  _allExecutiveCandidates_Model!.data != null)
              ? _allExecutiveCandidates_Model!.data!.length
              : 0,
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 5.0,
            mainAxisExtent: 210,
          ),
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => HomeScreen1(
                                imgLength: _allExecutiveCandidates_Model!
                                            .data![index].profileImage!.length >
                                        0
                                    ? _allExecutiveCandidates_Model!
                                        .data![index].profileImage!.length
                                    : 0,
                                candidateId: _allExecutiveCandidates_Model!
                                    .data![index].userId,
                                name: _allExecutiveCandidates_Model!
                                    .data![index].firstname
                                    .toString(),
                                image: (_allExecutiveCandidates_Model!
                                        .data![index].profileImage!.isNotEmpty)
                                    ? _allExecutiveCandidates_Model!
                                        .data![index].profileImage![0].filePath
                                    : "")));
                                    log(_allExecutiveCandidates_Model!
                                        .data![index].profileImage!.length.toString());
                  },
                  child: Container(
                    height: 260,
                    width: width * 0.40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Column(
                      children: [
                        Container(
                          height: 200,
                          decoration: BoxDecoration(
                            border: Border.all(
                                                color: Color(0xffFB5A57),width: 5),
                                            borderRadius:
                                                BorderRadius.circular(20),
                            image: (_allExecutiveCandidates_Model != null &&
                                    _allExecutiveCandidates_Model!.data !=
                                        null &&
                                    _allExecutiveCandidates_Model!.data![index]
                                        .profileImage!.isNotEmpty &&
                                    _allExecutiveCandidates_Model!
                                            .data![index].profileImage!.length >
                                        0)
                                ? DecorationImage(
                                    image: NetworkImage(
                                        _allExecutiveCandidates_Model!
                                            .data![index]
                                            .profileImage![0]
                                            .filePath
                                            .toString()),
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
                                    color: Color(0xffffffff).withOpacity(0.5),
                                    borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(15),
                                      bottomLeft: Radius.circular(15),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 0, right: 5, top: 5),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 5),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              
                                              Flexible(
                                                child: Text(
                                                  _allExecutiveCandidates_Model !=
                                                              null &&
                                                          _allExecutiveCandidates_Model!
                                                                  .data !=
                                                              null
                                                      ? _allExecutiveCandidates_Model!
                                                              .data![index]
                                                              .firstname
                                                              .toString() +
                                                          " "
                                                      : "",
                                                  maxLines: 1,
                                                  style: fontStyle.copyWith(
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      color: Colors.black,
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w600),
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
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 5.0),
                                          child: Text(
                                            AppConstants.josephWindText,
                                            maxLines: 1,
                                            style: matchscroll.copyWith(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black),
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
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
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
                      ],
                    ),
                  )

                  /*     Container(
                  width: width * 0.5,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(23),
                      color: Colors.white,
                      border: Border.all(width: 3, color: Color(0xffFB5A57))),
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _allExecutiveCandidates_Model != null &&
                                _allExecutiveCandidates_Model!.data != null
                            ? 
                            Container(
                                height: 130,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(13),
                                  image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: (_allExecutiveCandidates_Model!
                                              .data![index]
                                              .profileImage!
                                              .isNotEmpty)
                                          ? CachedNetworkImageProvider(
                                              _allExecutiveCandidates_Model!
                                                  .data![index]
                                                  .profileImage![0]
                                                  .filePath
                                                  .toString(),
                                            )
                                          : CachedNetworkImageProvider(
                                              "https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/1024px-No_image_available.svg.png",
                                            )
                                     
                                      ),
                                ),
                                alignment: Alignment.topRight,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(top: 12, right: 12),
                                  child: Container(
                                    height: 18,
                                    width: 54,
                                    decoration: BoxDecoration(
                                        color: Color(0xff000000).withOpacity(.30),
                                        borderRadius: BorderRadius.circular(10)),
                                    child: Center(
                                      child: Text(
                                        AppConstants.milesText,
                                        style: TextStyle(
                                            color: AppColors.colorWhite,
                                            fontSize: 10,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : Container(
                                height: 130,
                                width: 240,
                                decoration: BoxDecoration(
                                    color: Color(0xff000000).withOpacity(.30),
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                        image: AssetImage(
                                          ImagePath.newAdd1,
                                        ),
                                        fit: BoxFit.fitWidth)),
                              ),
                        SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _allExecutiveCandidates_Model != null &&
                                          _allExecutiveCandidates_Model?.data !=
                                              null
                                      ? _allExecutiveCandidates_Model!
                                          .data![index].firstname
                                          .toString()
                                      : '',
                                  style: TextStyle(
                                      color: AppColors.blackColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  AppConstants.josephWindText,
                                  style: TextStyle(
                                      color: AppColors.eGreyColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                            Image.asset(ImagePath.messg, height: 33, width: 33),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              */
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
      getAllExeCandidate();
    } else if (connectivityResult == ConnectivityResult.wifi) {
      getAllExeCandidate();
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

  getAllExeCandidate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var authToken = prefs.getString(EXE_TOKEN);
    CommonUtils.showProgressLoading(context);
    final queryParameters = {"token": authToken};
    String queryString = Uri(queryParameters: queryParameters).query;

    var response = await http.get(
      Uri.parse(GET_EXE_ALLCANDIDATES_URL + "?" + queryString),
    );

    if (response.statusCode == 200) {
      CommonUtils.hideProgressLoading();
      if (mounted) {
        setState(() {
          _allExecutiveCandidates_Model =
              AllExecutiveCandidates_Model.fromJson(jsonDecode(response.body));
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
}
