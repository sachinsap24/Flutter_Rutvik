
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:matrimonial_app/Executive%20Ui/WalletScreen/PaymentScreen/payment_screen.dart';
import 'package:matrimonial_app/Utils/app_constants.dart';
import 'package:matrimonial_app/Utils/color_constants.dart';
import 'package:matrimonial_app/Utils/image_path_constants.dart';
import 'package:matrimonial_app/Utils/text_styles.dart';
import 'package:matrimonial_app/Utils/value_constant.dart';
import 'package:matrimonial_app/widget/commonappbar_search.dart';

class Wallet_Screen extends StatefulWidget {
  const Wallet_Screen({Key? key}) : super(key: key);

  @override
  State<Wallet_Screen> createState() => _Wallet_ScreenState();
}

class _Wallet_ScreenState extends State<Wallet_Screen> {
  List<Map<String, dynamic>> walletHistory = [
    {
      TEXT: AppConstants.sText,
      NAME: AppConstants.shweniSmith,
      DATE: AppConstants.dateText,
      PRICE: AppConstants.priceText
    },
    {
      TEXT: AppConstants.sText,
      NAME: AppConstants.shweniSmith,
      DATE: AppConstants.dateText,
      PRICE: AppConstants.priceText
    },
    {
      TEXT: AppConstants.iText,
      NAME: AppConstants.shweniSmith,
      DATE: AppConstants.dateText,
      PRICE: AppConstants.priceText
    },
    {
      TEXT: AppConstants.vText,
      NAME: AppConstants.shweniSmith,
      DATE: AppConstants.dateText,
      PRICE: AppConstants.priceText
    },
    {
      TEXT: AppConstants.sText,
      NAME: AppConstants.shweniSmith,
      DATE: AppConstants.dateText,
      PRICE: AppConstants.priceText
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorWhite,
      body: Column(
        children: [
          CommonAppbar1(name: AppConstants.walletText),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 16),
                    child: Container(
                      height: 157,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xff000000).withOpacity(.23),
                            offset: Offset(
                              5.0,
                              5.0,
                            ),
                            blurRadius: 8.0,
                            spreadRadius: 1.0,
                          ),
                        ],
                        gradient: LinearGradient(
                          colors: [
                            Color(0xffFC7358),
                            Color(0xffFA2457),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(width: 10),
                              Container(
                                height: 64,
                                width: 64,
                                decoration: BoxDecoration(
                                  
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Image.asset(ImagePath.walletProfile),
                              ),
                              SizedBox(width: 10),
                              Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      AppConstants.elonMusk,
                                      style: headingStyle.copyWith(
                                          color: Color(0xffFFFFFF),
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Text(
                                      AppConstants.ownerWallet,
                                      style: headingStyle.copyWith(
                                          color: Color(0xffFFFFFF),
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 15),
                              Image.asset(
                                ImagePath.more,
                                height: 25,
                                width: 25,
                              ),
                            
                            ],
                          ),
                          SizedBox(height: 15),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 16.0, right: 16),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                        builder: (context) =>
                                            E_Payment_screen()));
                              },
                              child: Container(
                                height: 45,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  color: Color(0xffF6F6F6).withOpacity(.21),
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(width: 32),
                                    Text(
                                      AppConstants.totalBalance,
                                      style: headingStyle.copyWith(
                                          color: Color(0xffFFFFFF),
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Spacer(),
                                    Text(
                                      AppConstants.totalBalanceText,
                                      style: headingStyle.copyWith(
                                          color: Color(0xffFFFFFF),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(width: 32),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 16),
                    child: Row(
                      children: [
                        Text(
                          AppConstants.transactionHistory,
                          style: headerstyle.copyWith(
                              color: Color(0xff31384A),
                              fontSize: 19,
                              fontWeight: FontWeight.w600),
                        ),
                        Spacer(),
                        Text(
                          AppConstants.viewAll,
                          style: headerstyle.copyWith(
                              color: Color(0xff8692B5),
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                  ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: walletHistory.length,
                      itemBuilder: ((context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(
                              bottom: 25, left: 16, right: 16),
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 57,
                                  width: 57,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(9),
                                    color: Color(0xffF2F1F4),
                                    boxShadow: [
                                      BoxShadow(
                                        color:
                                            Color(0xff000333).withOpacity(.05),
                                        offset: Offset(
                                          5.0,
                                          5.0,
                                        ),
                                        blurRadius: 8.0,
                                        spreadRadius: 1.0,
                                      ),
                                    ],
                                  ),
                                  child: index == 1 || index == 4
                                      ? Image.asset(
                                          ImagePath.walletList,
                                          height: 57,
                                          width: 57,
                                          fit: BoxFit.fill,
                                        )
                                      : Center(
                                          child: Text(
                                            walletHistory[index][TEXT],
                                            style: headerstyle.copyWith(
                                                color: Color(0xff130847),
                                                fontSize: 30,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                ),
                                SizedBox(width: 8),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        walletHistory[index][NAME],
                                        style: headerstyle.copyWith(
                                            color: Color(0xff31384A),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        walletHistory[index][DATE],
                                        style: headerstyle.copyWith(
                                            color: Color(0xff9A94A0),
                                            fontSize: 13,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  ),
                                ),
                                Spacer(),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: Text(
                                    index == 1 || index == 4
                                        ? "- " + walletHistory[index][PRICE]
                                        : "+ " + walletHistory[index][PRICE],
                                    style: headerstyle.copyWith(
                                        color: index == 1 || index == 4
                                            ? Colors.red
                                            : Color(0xff36AF73),
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                SizedBox(width: 8),
                              ],
                            ),
                          ),
                        );
                      }))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
