
import 'package:flutter/material.dart';
import 'package:matrimonial_app/Utils/app_constants.dart';
import 'package:matrimonial_app/Utils/color_constants.dart';
import 'package:matrimonial_app/Utils/image_path_constants.dart';
import 'package:matrimonial_app/Utils/text_styles.dart';
import 'package:matrimonial_app/Utils/value_constant.dart';
import 'package:matrimonial_app/widget/Executive%20Side/eCommonButton.dart';
import 'package:matrimonial_app/widget/commonappbar_search.dart';

class E_Payment_screen extends StatefulWidget {
  const E_Payment_screen({Key? key}) : super(key: key);

  @override
  State<E_Payment_screen> createState() => _E_Payment_screenState();
}

class _E_Payment_screenState extends State<E_Payment_screen> {
  bool isSelectedCash = true;
  bool isSelectedOnline = false;
  int _selectedIndex = 0;
  List<Map<String, dynamic>> payment = [
    {
      IMAGE: ImagePath.paytmlogo,
      NAME: AppConstants.paytm,
    },
    {
      IMAGE: ImagePath.gpaylogo,
      NAME: AppConstants.googlepay,
    },
    {
      IMAGE: ImagePath.paypallogo,
      NAME: AppConstants.paypal,
    },
    {
      IMAGE: ImagePath.visalogo,
      NAME: AppConstants.visa,
    },
    {
      IMAGE: ImagePath.walletlogo,
      NAME: AppConstants.wallet,
    }
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            CommonAppbar1(
              name: AppConstants.paymentOptions,
            ),
            Column(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: payment.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _onItemTapped(index);
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: Color(
                                  0xffF2F2F2,
                                ),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(11)),
                          height: height * 0.1,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 21, right: 15, top: 18, bottom: 17),
                            child: Row(
                              children: [
                                Image.asset(
                                  payment[index][IMAGE],
                                  width: 35,
                                  height: 30,
                                ),
                                SizedBox(
                                  width: 16,
                                ),
                                Text(payment[index][NAME],
                                    style:
                                    _selectedIndex == index ? gpay : paytm),
                                Spacer(),
                                _selectedIndex == index
                                    ? Image.asset(
                                  ImagePath.payselect,
                                  width: 18,
                                  height: 18,
                                )
                                    : Image.asset(
                                  ImagePath.paynotselect,
                                  width: 18,
                                  height: 18,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16, top: 50),
                  child: ECommonButton(
                      btnName: 'Pay',
                      btnOnTap: () {
                        setState(() {
                          _payMentMethodDialog();

                        });
                      }),
                )
              ],
            )
          ],
        ));
  }

  _payMentMethodDialog() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (BuildContext context,
                void Function(void Function()) setState) {
              return AlertDialog(
                insetPadding: EdgeInsets.symmetric(horizontal: 25),
                contentPadding: EdgeInsets.only(left: 8, right: 8),
                backgroundColor: Colors.transparent,
                content: Container(
                  height: 248,
                  width: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      Column(
                        children: [
                          SizedBox(height: 2),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Image.asset(ImagePath.greyCross,
                                    height: 28, width: 28),
                              ),
                              SizedBox(width: 8),
                            ],
                          ),
                          Padding(
                            padding:
                            EdgeInsets.only(left: 10, right: 10, top: 8),
                            child: Container(
                              child: Text(
                                AppConstants.paymentMethod,
                                style: headingStyle.copyWith(
                                  color: Color(0xff333F52),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 13),
                          Padding(
                            padding: const EdgeInsets.only(left: 16, right: 16),
                            child: Text(
                              AppConstants.paymentMethodText,
                              maxLines: 2,
                              textAlign: TextAlign.center,
                              style: headingStyle.copyWith(
                                color: Color(0xffBABABA),
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          SizedBox(height: 15),
                          Padding(
                            padding: EdgeInsets.only(left: 23, right: 23),
                            child: Row(
                              children: [
                                Flexible(
                                  flex: 2,
                                  fit: FlexFit.tight,
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isSelectedCash = true;
                                        isSelectedOnline = false;
                                      });
                                    },
                                    child: Container(
                                      width: 150,
                                      height: 41,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: isSelectedCash == true
                                                ? Colors.transparent
                                                : Color(0xffB7B7B7)),
                                        borderRadius: BorderRadius.circular(10),
                                        gradient: isSelectedCash == true
                                            ? AppColors.appColor
                                            : AppColors.whiteGradient,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: [
                                          isSelectedCash == true
                                              ? Image.asset(ImagePath.cashWhite,
                                              height: 20, width: 20)
                                              : Image.asset(ImagePath.cashGrey,
                                              height: 20, width: 20),
                                          SizedBox(width: 10),
                                          isSelectedCash == true
                                              ? Text(
                                            AppConstants.cash,
                                            style: headingStyle.copyWith(
                                                color: Color(0xffFFFFFF),
                                                fontSize: 16,
                                                fontWeight:
                                                FontWeight.w500),
                                          )
                                              : Text(
                                            AppConstants.cash,
                                            style: headingStyle.copyWith(
                                                color: Color(0xff989FB5),
                                                fontSize: 16,
                                                fontWeight:
                                                FontWeight.w500),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 12,
                                ), 
                                Flexible(
                                    flex: 2,
                                    fit: FlexFit.tight,
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          isSelectedOnline = true;
                                          isSelectedCash = false;
                                        });
                                      },
                                      child: Container(
                                        width: 150,
                                        height: 41,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: isSelectedOnline == true
                                                  ? Colors.transparent
                                                  : Color(0xffB7B7B7)),
                                          borderRadius:
                                          BorderRadius.circular(10),
                                          gradient: isSelectedOnline == true
                                              ? AppColors.appColor
                                              : AppColors.whiteGradient,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          children: [
                                            isSelectedCash == true
                                                ? Image.asset(ImagePath.onlineGrey,
                                                height: 20, width: 20)
                                                : Image.asset(ImagePath.onlineWhite,
                                                height: 20, width: 20),
                                            SizedBox(width: 10),
                                            isSelectedCash == true
                                                ?Text(
                                              AppConstants.online,
                                              style: headingStyle.copyWith(
                                                  color: Color(0xff989FB5),
                                                  fontSize: 16,
                                                  fontWeight:
                                                  FontWeight.w500),
                                            )
                                                : Text(
                                              AppConstants.online,
                                              style: headingStyle.copyWith(
                                                  color: Color(0xffFFFFFF),
                                                  fontSize: 16,
                                                  fontWeight:
                                                  FontWeight.w500),
                                            )
                                          ],
                                        ),
                                      ),
                                    ))
                              ],
                              mainAxisAlignment: MainAxisAlignment.center,
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      Padding(
                          padding: EdgeInsets.only(left: 23, right: 23),
                          child: GestureDetector(
                            onTap: (){
                              Navigator.pop(context);
                            },
                            child: Container(
                              height: 45,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                gradient: AppColors.appColor,
                                borderRadius: BorderRadius.circular(9),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                AppConstants.submit,
                                style: appBtnStyle,
                              ),
                            ),
                          )),
                      SizedBox(height: 12),
                    ],
                  ),
                ),
              );
            },
          );
        });
  }
}

class Payment_PopUp extends StatelessWidget {
  const Payment_PopUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: 250,
      decoration: BoxDecoration(
          color: Colors.red, borderRadius: BorderRadius.circular(20)),
    );
  }
}
