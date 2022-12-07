import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:matrimonial_app/Executive%20Ui/DashBoardScreen/ReviewScreen/review_screen.dart';
import 'package:matrimonial_app/Executive%20Ui/DiscoverFeed/NewPostScreen/newpost_screen.dart';
import 'package:matrimonial_app/Executive%20Ui/DiscoverFeed/discoverfeedscreen.dart';
import 'package:matrimonial_app/Executive%20Ui/WalletScreen/wallet_screen.dart';
import 'package:matrimonial_app/Utils/app_constants.dart';
import 'package:matrimonial_app/Utils/color_constants.dart';
import 'package:matrimonial_app/Utils/image_path_constants.dart';
import 'package:matrimonial_app/Utils/text_styles.dart';
import 'package:matrimonial_app/Utils/value_constant.dart';
import 'package:matrimonial_app/widget/Executive%20Side/dashboardappbar.dart';
import 'package:matrimonial_app/widget/commonappbar_search.dart';
import 'package:matrimonial_app/widget/commondivider.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({Key? key}) : super(key: key);

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  List<Map<String, dynamic>> reviewdetail = [
    {
      IMAGE: ImagePath.review_1,
      NAME: AppConstants.miaSmith,
      MAIL: AppConstants.reviewEmail,
      RATING: ImagePath.rating_1,
      RAT: AppConstants.rating1,
      DETAIL: AppConstants.reviewDetails,
    },
    {
      IMAGE: ImagePath.review_2,
      NAME: AppConstants.miaSmith,
      MAIL: AppConstants.reviewEmail,
      RATING: ImagePath.rating_2,
      RAT: AppConstants.rating2,
      DETAIL: AppConstants.reviewDetails,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Dashboardappbar(
            name: AppConstants.dashBoard,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      /*  Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => Wallet_Screen())); */
                    },
                    child: Image.asset(
                      ImagePath.dashboardImage,
                      height: MediaQuery.of(context).size.width / 2.6,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  Common_divider(),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Text(
                            AppConstants.communicative,
                            style: TextStyle(
                                color: Color(0xff4D5767),
                                fontSize: 15,
                                fontWeight: FontWeight.w400),
                          ),
                          Row(
                            children: [
                              Image.asset(
                                ImagePath.rating_1,
                                height: 22,
                                width: 22,
                              ),
                              Text(
                                AppConstants.h10,
                                style: TextStyle(
                                    color: AppColors.yellow,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15),
                              )
                            ],
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            AppConstants.responsive,
                            style: TextStyle(
                                color: Color(0xff4D5767),
                                fontSize: 15,
                                fontWeight: FontWeight.w400),
                          ),
                          Row(
                            children: [
                              Image.asset(
                                ImagePath.rating_2,
                                height: 22,
                                width: 22,
                              ),
                              Text(
                                AppConstants.h5,
                                style: TextStyle(
                                    color: AppColors.yellow,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15),
                              )
                            ],
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            AppConstants.honestText,
                            style: TextStyle(
                                color: Color(0xff4D5767),
                                fontSize: 15,
                                fontWeight: FontWeight.w400),
                          ),
                          Row(
                            children: [
                              Image.asset(
                                ImagePath.rating_2,
                                height: 22,
                                width: 22,
                              ),
                              Text(
                                AppConstants.h10,
                                style: TextStyle(
                                    color: AppColors.yellow,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15),
                              )
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 16),
                    child: Row(
                      children: [
                        Text(
                          AppConstants.completeMrg,
                          style: headerstyle.copyWith(
                              color: Color(0xff333F52),
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                        ),
                        Spacer(),
                        Text(
                          AppConstants.seeMore,
                          style: headerstyle.copyWith(
                              color: Color(0xffE16284),
                              fontSize: 13,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(width: 8),
                        Image.asset(
                          ImagePath.pinkforward,
                          height: 14,
                          width: 10,
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 16),
                    child: GestureDetector(
                      onTap: () {
                        /*   Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => NewPost_screen())); */
                      },
                      child: Container(
                        height: 199,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color(0xffFC7358),
                              Color(0xffFA2457),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 16, right: 16, top: 16),
                              child: Text(
                                AppConstants.thisYear,
                                style: headingStyle.copyWith(
                                    color: Color(0xffFFFFFF).withOpacity(.66),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 16, right: 16, top: 5),
                              child: Text(
                                AppConstants.proposals3,
                                style: headingStyle.copyWith(
                                    color: Color(0xffFFFFFF),
                                    fontSize: 24,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 16, right: 16, top: 5),
                              child: Text(
                                AppConstants.inProgress,
                                style: headingStyle.copyWith(
                                    color: Color(0xffFFFFFF),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                            SizedBox(height: 15),
                            Container(
                              height: 1,
                              width: MediaQuery.of(context).size.width,
                              color: Color(0xffFFFFFF),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 16, right: 16, bottom: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        AppConstants.proposals2,
                                        style: headingStyle.copyWith(
                                            color: Color(0xffFFFFFF),
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        AppConstants.finalText,
                                        style: headingStyle.copyWith(
                                            color: Color(0xffFFFFFF),
                                            fontSize: 15,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Container(
                                  height: 93,
                                  width: 1,
                                  color: Color(0xffFFFFFF),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 16.0),
                                        child: Text(
                                          AppConstants.mrg1,
                                          style: headingStyle.copyWith(
                                              color: Color(0xffFFFFFF),
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        AppConstants.complete,
                                        style: headingStyle.copyWith(
                                            color: Color(0xffFFFFFF),
                                            fontSize: 15,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Common_divider(),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 16),
                    child: Row(
                      children: [
                        Text(
                          AppConstants.totalRevenue,
                          style: headerstyle.copyWith(
                              color: Color(0xff333F52),
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                        ),
                        Spacer(),
                        Text(
                          AppConstants.seeMore,
                          style: headerstyle.copyWith(
                              color: Color(0xff12A2AB),
                              fontSize: 13,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(width: 8),
                        Image.asset(
                          ImagePath.blueForward,
                          height: 14,
                          width: 10,
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 16),
                    child: GestureDetector(
                      onTap: () {
                        /*  Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => Discover_Screen())); */
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Color(0xff6C6987),
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(width: 15),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 21),
                                    Text(
                                      AppConstants.monthlyRevenue,
                                      style: headerstyle.copyWith(
                                          color: Color(0xffD1CFE2),
                                          fontSize: 11,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      AppConstants.monthlyRevenueText,
                                      style: headerstyle.copyWith(
                                          color: Color(0xffFFFFFF),
                                          fontSize: 24,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                                Spacer(),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 21),
                                    Text(
                                      AppConstants.yearlyRevenue,
                                      style: headerstyle.copyWith(
                                          color: Color(0xffD1CFE2),
                                          fontSize: 11,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      AppConstants.yearlyRevenueText,
                                      style: headerstyle.copyWith(
                                          color: Color(0xffFFFFFF),
                                          fontSize: 24,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                                SizedBox(width: 25),
                              ],
                            ),
                            SizedBox(height: 18),
                            Container(
                              height: 50,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  color: Color(0xff545471),
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(7),
                                    bottomRight: Radius.circular(7),
                                  )),
                              child: Row(
                                children: [
                                  SizedBox(width: 15),
                                  Container(
                                    height: 26,
                                    width: 46,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    child: Center(
                                        child: Image.asset(
                                      ImagePath.greenThumb,
                                      height: 14,
                                      width: 14,
                                    )),
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    AppConstants.zeroText,
                                    style: headerstyle.copyWith(
                                        color: Color(0xffD1CFE2),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    AppConstants.cancellationsText,
                                    style: headerstyle.copyWith(
                                        color: Color(0xffD1CFE2),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(width: 10),
                                  Container(
                                    height: 26,
                                    width: 52,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    child: Center(
                                        child: Text(AppConstants.lossNumber,
                                            style: headerstyle.copyWith(
                                                color: Color(0xffF9253A),
                                                fontSize: 11,
                                                fontWeight: FontWeight.w400))),
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    AppConstants.lossText,
                                    style: headerstyle.copyWith(
                                        color: AppColors.colorWhite,
                                        fontSize: 11,
                                        fontWeight: FontWeight.w400),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Common_divider(),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 16),
                    child: Row(
                      children: [
                        Text(
                          AppConstants.withdrawProposal,
                          style: headerstyle.copyWith(
                              color: Color(0xff333F52),
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                        ),
                        Spacer(),
                        Text(
                          AppConstants.seeMore,
                          style: headerstyle.copyWith(
                              color: Color(0xff12A2AB),
                              fontSize: 13,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(width: 8),
                        Image.asset(
                          ImagePath.blueForward,
                          height: 14,
                          width: 10,
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 16),
                    child: Text(AppConstants.lossmrg),
                  ),
                  SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 16),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(7),
                          border: Border.all(
                              color: Color(0xff7572E7).withOpacity(.23)),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xff7572E7).withOpacity(.23),
                              offset: Offset(
                                5.0,
                                5.0,
                              ),
                              blurRadius: 8.0,
                              spreadRadius: 1.0,
                            ),
                          ]),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 16, right: 16, top: 16),
                                    child: Text(
                                      AppConstants.thisMonth,
                                      style: headingStyle.copyWith(
                                          color: Color(0xff757885),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 16, right: 16, top: 5),
                                    child: Text(
                                      AppConstants.thisMonthText,
                                      style: headingStyle.copyWith(
                                          color: Color(0xff333F52),
                                          fontSize: 24,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 16, right: 16, top: 5),
                                    child: Text(
                                      AppConstants.thisMonthMrg,
                                      style: headingStyle.copyWith(
                                          color: Color(0xff4D5767),
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                ],
                              ),
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 88, bottom: 35, right: 16),
                                child: Container(
                                  height: 26,
                                  width: 58,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      color: Color(0xff4AC2C6)),
                                  child: Center(
                                      child: Text(
                                    AppConstants.byYou,
                                    style: headerstyle.copyWith(
                                        color: Color(0xffFFFFFF),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500),
                                  )),
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 15),
                          Container(
                            height: 1,
                            width: MediaQuery.of(context).size.width,
                            color: Color(0xffE8E8E8),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 16, right: 16, bottom: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      AppConstants.lastMonth,
                                      style: headingStyle.copyWith(
                                          color: Color(0xff757885),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      AppConstants.lastMonthText,
                                      style: headingStyle.copyWith(
                                          color: Color(0xff333F52),
                                          fontSize: 24,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      AppConstants.lastMonthMrg,
                                      style: headingStyle.copyWith(
                                          color: Color(0xff4D5767),
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 14,
                              ),
                              Container(
                                height: 93,
                                width: 1,
                                color: Color(0xffE8E8E8),
                              ),
                              SizedBox(
                                width: 14,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 16.0),
                                      child: Text(
                                        AppConstants.thisYearDate,
                                        style: headingStyle.copyWith(
                                            color: Color(0xff757885),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      AppConstants.thisYearText,
                                      style: headingStyle.copyWith(
                                          color: Color(0xff333F52),
                                          fontSize: 24,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      AppConstants.thisYearMrg,
                                      style: headingStyle.copyWith(
                                          color: Color(0xff4D5767),
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  SizedBox(height: 10),
                  Padding(
                    padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppConstants.reviews,
                          style: headingStyle.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) => Review_screen()));
                          },
                          child: Text(
                            AppConstants.seeMore,
                            style: headingStyle.copyWith(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: AppColors.green,
                            ),
                          ),
                        ),
                        SizedBox(width: 5),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) => Review_screen()));
                          },
                          child: Image.asset(ImagePath.seemoreimage,
                              height: 8, width: 5),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 15),
                  ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: reviewdetail.length,
                    itemBuilder: ((context, index) {
                      return Padding(
                        padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                        child: Container(
                          height: 200,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Color(0xffE8E8E8),
                            ),
                            borderRadius: BorderRadius.circular(13),
                          ),
                          child: Column(
                            children: [
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  SizedBox(width: 15),
                                  Image.asset(reviewdetail[index][IMAGE],
                                      height: 43, width: 43),
                                  SizedBox(width: 12),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        reviewdetail[index][NAME],
                                        style: headingStyle.copyWith(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        reviewdetail[index][MAIL],
                                        style: headingStyle.copyWith(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Spacer(),
                                  Container(
                                    height: 30,
                                    width: 65,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Color(0xffFDF1E1),
                                    ),
                                    child: Row(
                                      children: [
                                        SizedBox(width: 8),
                                        Image.asset(reviewdetail[index][RATING],
                                            height: 22, width: 22),
                                        SizedBox(width: 4),
                                        Text(
                                          reviewdetail[index][RAT],
                                          style: headingStyle.copyWith(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 15),
                                ],
                              ),
                              SizedBox(height: 14),
                              Padding(
                                padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                                child: Text(
                                  reviewdetail[index]['detail'],
                                  style: headingStyle.copyWith(
                                    height: 1.5,
                                    color: Color(0xff67707D),
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
