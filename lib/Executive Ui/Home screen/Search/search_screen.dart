
// ignore_for_file: unused_import, unused_element, unused_local_variable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:matrimonial_app/Ui/Search/filter_screen.dart';
import 'package:matrimonial_app/Utils/app_constants.dart';
import 'package:matrimonial_app/Utils/color_constants.dart';
import 'package:matrimonial_app/Utils/image_path_constants.dart';
import 'package:matrimonial_app/Utils/text_styles.dart';
import 'package:matrimonial_app/Utils/value_constant.dart';
import 'package:matrimonial_app/widget/commonappbar.dart';
import 'package:matrimonial_app/widget/commonappbar_search.dart';

class E_Search_screen extends StatefulWidget {
  const E_Search_screen({Key? key}) : super(key: key);

  @override
  State<E_Search_screen> createState() => _E_Search_screenState();
}

class _E_Search_screenState extends State<E_Search_screen> {
  List<Map<String, dynamic>> searchfilter = [
    {
      IMAGE: ImagePath.searchimage,
      NAME: AppConstants.joseph1,
      SUBNAME: AppConstants.ahmadabad,
    },
    {
      IMAGE: ImagePath.searchimage1,
      NAME: AppConstants.sara,
      SUBNAME: AppConstants.surat,
    },
    {
      IMAGE: ImagePath.searchimage2,
      NAME: AppConstants.faye,
      SUBNAME: AppConstants.chennai,
    },
    {
      IMAGE: ImagePath.searchimage3,
      NAME: AppConstants.faye,
      SUBNAME: AppConstants.mumbai,
    },
    {
      IMAGE: ImagePath.searchimage2,
      NAME: AppConstants.faye,
      SUBNAME: AppConstants.chennai,
    },
    {
      IMAGE: ImagePath.searchimage3,
      NAME: AppConstants.faye,
      SUBNAME: AppConstants.mumbai,
    },
  ];
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Column(
      children: [
        CommonAppbar1(
          name: 'Search',
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(13),
                      color: AppColors.messagesearch,
                    ),
                    height: height * 0.069,
                    child: Row(
                      children: [
                        SizedBox(
                          width: width * 0.020,
                        ),
                        Image.asset(
                          ImagePath.search,
                          height: height * 0.030,
                        ),
                        SizedBox(
                          width: width * 0.010,
                        ),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: AppConstants.profileid,
                                hintStyle: happiness),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              CupertinoPageRoute(
                                builder: (context) => Filter_screen(),
                              ),
                            );
                          },
                          child: Image.asset(
                            ImagePath.filterimage,
                            height: height * 0.030,
                          ),
                        ),
                        SizedBox(
                          width: width * 0.020,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: searchfilter.length,
                    itemBuilder: (context, index) {
                      return Container(
                        child: Row(
                          children: [
                            Container(
                              height: 53,
                              width: 53,
                              child: CircleAvatar(
                                backgroundImage:
                                    AssetImage(searchfilter[index][IMAGE]),
                              ),
                            ),
                            SizedBox(
                              width: 13,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  searchfilter[index][NAME],
                                  style: name,
                                ),
                                Text(
                                  searchfilter[index][SUBNAME],
                                  style: subname,
                                )
                              ],
                            ),
                            Spacer(),
                            GestureDetector(
                              onTap: () {
                                searchfilter.removeAt(0);
                                setState(() {});
                              },
                              child: Image.asset(
                                ImagePath.crossimage,
                                height: height * 0.030,
                              ),
                            )
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return Divider();
                    },
                  ),
                )
              ],
            ),
          ),
        )
      ],
    ));
  }

  _searchbar() {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,

      centerTitle: true,
      title: Text(
        AppConstants.search,
        style: message,
      ),
    );
  }
}
