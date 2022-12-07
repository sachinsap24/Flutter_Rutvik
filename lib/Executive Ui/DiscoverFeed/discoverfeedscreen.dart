
// ignore_for_file: unused_local_variable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:matrimonial_app/Executive%20Ui/DiscoverFeed/ModelBottomSheet/bottomsheet.dart';
import 'package:matrimonial_app/Executive%20Ui/DiscoverFeed/NewPostScreen/newpost_screen.dart';
import 'package:matrimonial_app/Utils/value_constant.dart';

import '../../Utils/app_constants.dart';
import '../../Utils/image_path_constants.dart';
import '../../Utils/text_styles.dart';
import '../../widget/commonappbar.dart';

class Discover_Screen extends StatefulWidget {
  Discover_Screen({Key? key}) : super(key: key);

  @override
  State<Discover_Screen> createState() => _Discover_ScreenState();
}

class _Discover_ScreenState extends State<Discover_Screen> {
  List multipleImages = [
    ImagePath.steaveimage,
    ImagePath.profile,
    ImagePath.steaveimage
  ];

  List<Map<String, dynamic>> imageList = [
    {
      IMAGE1: ImagePath.profile1,
      IMAGE: ImagePath.imge1,
    },
    {
      IMAGE1: ImagePath.profile2,
      IMAGE: ImagePath.imge2,
    },
    {
      IMAGE1: ImagePath.profile1,
      IMAGE: ImagePath.imge1,
    },
  ];

  List<Map<String, dynamic>> matualMatchesList = [
    {
      IMAGE: ImagePath.profile2,
      NAME: AppConstants.jacksonPatil,
      SUBTITLE: AppConstants.jacksonPatilAdd,
    },
    {
      IMAGE: ImagePath.profile1,
      NAME: AppConstants.anirudhApte,
      SUBTITLE: AppConstants.anirudhApteAdd,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final avatars = <Widget>[];
    final avatarWidth = 40;
    final overlayWidth = 10;
    return Container(
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            children: [
              CommonAppbar(name: AppConstants.discoverText),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) => NewPost_screen()));
                          },
                          child: Row(
                            children: [
                              Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  color: Color(0xffF6F6F6),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Image.asset(
                                    ImagePath.plusIcon,
                                    height: 20,
                                    width: 20,
                                  ),
                                ),
                              ),
                              SizedBox(width: 6),
                              Text(
                                AppConstants.postLabel,
                                style: headingStyle.copyWith(
                                    color: Color(0xff333F52),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600),
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Flexible(
                              flex: 2,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      CupertinoPageRoute(
                                          builder: (context) =>
                                              NewPost_screen()));
                                },
                                child: Container(
                                  height: 40,
                                  width: 95,
                                  decoration: BoxDecoration(
                                      color: Color(0xffF6F6F6),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Image.asset(ImagePath.photoIcon,
                                          height: 22, width: 22),
                                      SizedBox(width: 5),
                                      Text(
                                        AppConstants.photoText,
                                        style: headingStyle.copyWith(
                                            color: Color(0xff2E2E2E),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Flexible(
                              flex: 2,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      CupertinoPageRoute(
                                          builder: (context) =>
                                              NewPost_screen()));
                                },
                                child: Container(
                                  height: 40,
                                  width: 95,
                                  decoration: BoxDecoration(
                                      color: Color(0xffF6F6F6),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Image.asset(ImagePath.videoIcon,
                                          height: 22, width: 22),
                                      SizedBox(width: 5),
                                      Text(AppConstants.videoText,
                                          style: headingStyle.copyWith(
                                              color: Color(0xff2E2E2E),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500)),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Flexible(
                              flex: 2,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      CupertinoPageRoute(
                                          builder: (context) =>
                                              NewPost_screen()));
                                },
                                child: Container(
                                  height: 40,
                                  width: 95,
                                  decoration: BoxDecoration(
                                      color: Color(0xffF6F6F6),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Image.asset(ImagePath.postIcon,
                                          height: 22, width: 22),
                                      SizedBox(width: 5),
                                      Text(AppConstants.postText,
                                          style: headingStyle.copyWith(
                                              color: Color(0xff2E2E2E),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500)),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 15),
                        ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: imageList.length,
                            itemBuilder: ((context, index) {
                              return Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 15),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                              color: Color(0xff000000)
                                                  .withOpacity(.15)),
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, right: 10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(height: 8),
                                            Row(
                                              children: [
                                                Container(
                                                  height: 46,
                                                  width: 46,
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: Colors.red),
                                                  child: Image.asset(
                                                    imageList[index][IMAGE1],
                                                    height: 46,
                                                    width: 46,
                                                  ),
                                                ),
                                                SizedBox(width: 10),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      AppConstants
                                                          .josephWindName,
                                                      style: TextStyle(
                                                          color:
                                                              Color(0xff440312),
                                                          fontSize: 17,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                    Text(
                                                      AppConstants
                                                          .joesphAddress,
                                                      style: TextStyle(
                                                          color:
                                                              Color(0xffB1B1B1),
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ],
                                                ),
                                                Spacer(),
                                                GestureDetector(
                                                  onTap: () {
                                                    showModalBottomSheet<void>(
                                                      context: context,
                                                      backgroundColor:
                                                          Colors.transparent,
                                                      builder: (BuildContext
                                                          context) {
                                                        return FeedBottomSheet();
                                                      },
                                                    );
                                                  },
                                                  child: Container(
                                                    height: 22,
                                                    width: 22,
                                                    color: Colors.transparent,
                                                    child: Image.asset(
                                                        ImagePath.popupmenu,
                                                        height: 22,
                                                        width: 22),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 8),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 0, right: 0),
                                              child: Container(
                                                height: 1,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                color: Colors.grey,
                                              ),
                                            ),
                                            SizedBox(height: 10),
                                            Text(
                                              AppConstants.quickChest,
                                              style: TextStyle(
                                                  color: Color(0xff3E3E3E),
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            SizedBox(height: 5),
                                            Text(
                                              AppConstants.includeChest,
                                              style: TextStyle(
                                                  color: Color(0xff3E3E3E),
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            SizedBox(height: 5),
                                            Text(
                                              AppConstants.flatBench,
                                              style: TextStyle(
                                                  color: Color(0xff3E3E3E),
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            SizedBox(height: 5),
                                            Text(
                                              AppConstants.chestFlys,
                                              style: TextStyle(
                                                  color: Color(0xff3E3E3E),
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            SizedBox(height: 5),
                                            Text(
                                              AppConstants.skullCrusher,
                                              style: TextStyle(
                                                  color: Color(0xff3E3E3E),
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            SizedBox(height: 14),
                                            index == 2
                                                ? Container(
                                                    height: 194,
                                                    width: 323,
                                                    decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                      image: AssetImage(
                                                          ImagePath.imge3),
                                                      fit: BoxFit.fill,
                                                    )))
                                                : Image.asset(
                                                    imageList[index][IMAGE],
                                                    height: 194,
                                                    width: 323,
                                                    fit: BoxFit.fill,
                                                  ),
                                            SizedBox(height: 11),
                                            Row(
                                              children: [
                                                Row(
                                                  children: [
                                                    Stack(
                                                      children: List.generate(
                                                        multipleImages.length,
                                                        (index) => Padding(
                                                          padding: EdgeInsets.only(
                                                              left: index
                                                                      .toDouble() *
                                                                  12),
                                                          child: Image.asset(
                                                            multipleImages[
                                                                index],
                                                            height: 20,
                                                            width: 20,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 4,
                                                    ),
                                                    Text(
                                                      "253",
                                                      style: discovercontenttype
                                                          .copyWith(
                                                              color: Color(
                                                                  0xff979797)),
                                                    ),
                                                  ],
                                                ),
                                                Spacer(),
                                                Row(
                                                  children: [
                                                    Text(
                                                      AppConstants.cmntNumber,
                                                      style: discovercontenttype
                                                          .copyWith(
                                                              color: Color(
                                                                  0xff979797)),
                                                    ),
                                                    SizedBox(
                                                      width: 3,
                                                    ),
                                                    Text(
                                                      AppConstants.comment,
                                                      style: discovercontenttype
                                                          .copyWith(
                                                              color: Color(
                                                                  0xff979797)),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  width: 16,
                                                )
                                              ],
                                            ),
                                            SizedBox(height: 10),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 0, right: 0),
                                              child: Container(
                                                height: 1,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                color: Colors.grey,
                                              ),
                                            ),
                                            SizedBox(height: 11),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Column(children: [
                                                  Image.asset(
                                                    ImagePath.dlike,
                                                    width: 25,
                                                    height: 25,
                                                  ),
                                                  SizedBox(
                                                    width: 4,
                                                  ),
                                                  Text(
                                                    AppConstants.like,
                                                    style: discovercontenttype,
                                                  )
                                                ]),
                                                Column(children: [
                                                  Image.asset(
                                                    ImagePath.dcomment,
                                                    width: 25,
                                                    height: 25,
                                                  ),
                                                  SizedBox(
                                                    width: 4,
                                                  ),
                                                  Text(
                                                    AppConstants.comment,
                                                    style: discovercontenttype,
                                                  )
                                                ]),
                                                Column(children: [
                                                  Image.asset(
                                                    ImagePath.dshare,
                                                    width: 25,
                                                    height: 25,
                                                  ),
                                                  SizedBox(
                                                    width: 4,
                                                  ),
                                                  Text(
                                                    AppConstants.share,
                                                    style: discovercontenttype,
                                                  )
                                                ]),
                                              ],
                                            ),
                                            SizedBox(height: 10)
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  index == 1
                                      ? Column(
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  AppConstants.matualMatches,
                                                  style: headerstyle.copyWith(
                                                      color: Color(0xff101620),
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                Spacer(),
                                                Text(
                                                  AppConstants.seeAllExe,
                                                  style: headerstyle.copyWith(
                                                      color: Color(0xffE16284),
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                SizedBox(width: 8),
                                                Image.asset(
                                                  ImagePath.pinkforward,
                                                  height: 14,
                                                  width: 10,
                                                )
                                              ],
                                            ),
                                            SizedBox(height: 10),
                                            Container(
                                              height: 198,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: ScrollConfiguration(
                                                behavior: CustomScroll(),
                                                child: ListView.builder(
                                                    padding: EdgeInsets.zero,
                                                    shrinkWrap: true,
                                                    itemCount: matualMatchesList
                                                        .length,
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    itemBuilder:
                                                        ((context, index) {
                                                      return Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                right: 16),
                                                        child: Container(
                                                          height: 198,
                                                          width: 163,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15),
                                                            border: Border.all(
                                                                width: 1,
                                                                color: Color(
                                                                        0xff000000)
                                                                    .withOpacity(
                                                                        .15)),
                                                          ),
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceEvenly,
                                                            children: [
                                                              SizedBox(
                                                                  height: 5),
                                                              Container(
                                                                height: 72,
                                                                width: 72,
                                                                decoration: BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle,
                                                                    color: Colors
                                                                        .white),
                                                                child: Image.asset(
                                                                    matualMatchesList[
                                                                            index]
                                                                        [
                                                                        IMAGE]),
                                                              ),
                                                              SizedBox(
                                                                  height: 5),
                                                              Text(
                                                                matualMatchesList[
                                                                        index]
                                                                    [NAME],
                                                                style: TextStyle(
                                                                    color: Color(
                                                                        0xff3E3E3E),
                                                                    fontSize:
                                                                        15,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600),
                                                              ),
                                                              Text(
                                                                matualMatchesList[
                                                                        index]
                                                                    [SUBTITLE],
                                                                style: TextStyle(
                                                                    color: Color(
                                                                        0xffB1B1B1),
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                              ),
                                                              SizedBox(
                                                                  height: 5),
                                                              Container(
                                                                height: 34,
                                                                width: 143,
                                                                decoration:
                                                                    BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                10),
                                                                        gradient:
                                                                            LinearGradient(
                                                                          begin:
                                                                              Alignment.topLeft,
                                                                          end: Alignment
                                                                              .bottomRight,
                                                                          colors: [
                                                                            Color(0xffC23A66),
                                                                            Color(0xffFA829D),
                                                                          ],
                                                                        )),
                                                                child: Center(
                                                                    child: Text(
                                                                  AppConstants
                                                                      .viewProfile,
                                                                  style: TextStyle(
                                                                      color: Color(
                                                                          0xffFFFFFF),
                                                                      fontSize:
                                                                          13,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500),
                                                                )),
                                                              ),
                                                              SizedBox(
                                                                  height: 5),
                                                            ],
                                                          ),
                                                        ),
                                                      );
                                                    })),
                                              ),
                                            ),
                                            SizedBox(height: 10)
                                          ],
                                        )
                                      : Text('')
                                ],
                              );
                            })),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomScroll extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
