
import 'package:flutter/material.dart';
import 'package:matrimonial_app/Utils/app_constants.dart';
import 'package:matrimonial_app/Utils/color_constants.dart';
import 'package:matrimonial_app/Utils/image_path_constants.dart';
import 'package:matrimonial_app/Utils/text_styles.dart';

class FinalProposal_Screen extends StatefulWidget {
  const FinalProposal_Screen({Key? key}) : super(key: key);

  @override
  State<FinalProposal_Screen> createState() => _FinalProposal_ScreenState();
}

class _FinalProposal_ScreenState extends State<FinalProposal_Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _appBar(),
            SizedBox(height: 10),
            Container(
              height: 2,
              width: MediaQuery.of(context).size.width,
              color: Color(0xffF1F2F6),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 16, right: 16),
                      child: Column(
                        children: [
                          Container(
                            height: 265,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  offset: Offset(
                                    0,
                                    0,
                                  ),
                                  color: Color(0xff000000).withOpacity(.10),
                                  blurRadius: 20,
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                SizedBox(height: 10),
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8),
                                      child: Row(
                                        children: [
                                          SizedBox(width: 8),
                                          Column(
                                            children: [
                                              Container(
                                                height: 115,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    2.4,
                                                decoration: BoxDecoration(
                                                  color: Colors.red,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: Image.asset(
                                                    ImagePath.finalProposalImage1,
                                                    fit: BoxFit.fill),
                                              ),
                                              SizedBox(height: 8),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Image.asset(
                                                    ImagePath.dualprofile,
                                                    height: 18,
                                                    width: 18,
                                                  ),
                                                  SizedBox(width: 8),
                                                  Text(
                                                    AppConstants.joseph,
                                                    style: fontStyle.copyWith(
                                                        fontSize: 15,
                                                        fontWeight: FontWeight.w600,
                                                        color: Color(0xff161616)),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 4),
                                              Text(
                                                AppConstants.josephWindText,
                                                style: TextStyle(
                                                    color: AppColors.eGreyColor,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w500),
                                              )
                                            ],
                                          ),
                                          Spacer(),
                                          Column(
                                            children: [
                                              Container(
                                                height: 115,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    2.4,
                                                decoration: BoxDecoration(
                                                  color: Colors.blue,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: Image.asset(
                                                    ImagePath.finalProposalImage2,
                                                    fit: BoxFit.fill),
                                              ),
                                              SizedBox(height: 8),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Image.asset(
                                                    ImagePath.dualprofile,
                                                    height: 18,
                                                    width: 18,
                                                  ),
                                                  SizedBox(width: 8),
                                                  Text(
                                                    AppConstants.joseph,
                                                    style: fontStyle.copyWith(
                                                        fontSize: 15,
                                                        fontWeight: FontWeight.w600,
                                                        color: Color(0xff161616)),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 4),
                                              Text(
                                                AppConstants.josephWindText,
                                                style: TextStyle(
                                                    color: AppColors.eGreyColor,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w500),
                                              )
                                            ],
                                          ),
                                          SizedBox(width: 8),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 45),
                                      child: Container(
                                        height: 50,
                                        width: 50,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white,
                                        ),
                                        child: Image.asset(
                                          ImagePath.finalProposalImage,
                                          height: 50,
                                          width: 50,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10, top: 10),
                                  child: Container(
                                    height: 42,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(7),
                                      color: Color(0xffFB5A57),
                                    ),
                                    child: Center(
                                      child: Text(
                                        AppConstants.completeProposal,
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 10, right: 10),
                                  child: Text(
                                    AppConstants.withDrawn,
                                    style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xffFB5A57)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.only(left: 16, right: 16),
                      child: Column(
                        children: [
                          Container(
                            height: 265,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  offset: Offset(
                                    0,
                                    0,
                                  ),
                                  color: Color(0xff000000).withOpacity(.10),
                                  blurRadius: 20,
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                SizedBox(height: 10),
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8),
                                      child: Row(
                                        children: [
                                          SizedBox(width: 8),
                                          Column(
                                            children: [
                                              Container(
                                                height: 115,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    2.4,
                                                decoration: BoxDecoration(
                                                  color: Colors.red,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: Image.asset(
                                                    ImagePath.finalProposalImage1,
                                                    fit: BoxFit.fill),
                                              ),
                                              SizedBox(height: 8),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Image.asset(
                                                    ImagePath.dualprofile,
                                                    height: 18,
                                                    width: 18,
                                                  ),
                                                  SizedBox(width: 8),
                                                  Text(
                                                    AppConstants.joseph,
                                                    style: fontStyle.copyWith(
                                                        fontSize: 15,
                                                        fontWeight: FontWeight.w600,
                                                        color: Color(0xff161616)),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 4),
                                              Text(
                                                AppConstants.josephWindText,
                                                style: TextStyle(
                                                    color: AppColors.eGreyColor,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w500),
                                              )
                                            ],
                                          ),
                                          Spacer(),
                                          Column(
                                            children: [
                                              Container(
                                                height: 115,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    2.4,
                                                decoration: BoxDecoration(
                                                  color: Colors.blue,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: Image.asset(
                                                    ImagePath.finalProposalImage2,
                                                    fit: BoxFit.fill),
                                              ),
                                              SizedBox(height: 8),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Image.asset(
                                                    ImagePath.dualprofile,
                                                    height: 18,
                                                    width: 18,
                                                  ),
                                                  SizedBox(width: 8),
                                                  Text(
                                                    AppConstants.joseph,
                                                    style: fontStyle.copyWith(
                                                        fontSize: 15,
                                                        fontWeight: FontWeight.w600,
                                                        color: Color(0xff161616)),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 4),
                                              Text(
                                                AppConstants.josephWindText,
                                                style: TextStyle(
                                                    color: AppColors.eGreyColor,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w500),
                                              )
                                            ],
                                          ),
                                          SizedBox(width: 8),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 45),
                                      child: Container(
                                        height: 50,
                                        width: 50,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white,
                                        ),
                                        child: Image.asset(
                                          ImagePath.finalProposalImage,
                                          height: 50,
                                          width: 50,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10, top: 10),
                                  child: Container(
                                    height: 42,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(7),
                                      color: Color(0xffFB5A57),
                                    ),
                                    child: Center(
                                      child: Text(
                                        AppConstants.completeProposal,
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 10, right: 10),
                                  child: Text(
                                    AppConstants.withDrawn,
                                    style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xffFB5A57)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.only(left: 16, right: 16),
                      child: Column(
                        children: [
                          Container(
                            height: 265,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  offset: Offset(
                                    0,
                                    0,
                                  ),
                                  color: Color(0xff000000).withOpacity(.10),
                                  blurRadius: 20,
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                SizedBox(height: 10),
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8),
                                      child: Row(
                                        children: [
                                          SizedBox(width: 8),
                                          Column(
                                            children: [
                                              Container(
                                                height: 115,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    2.4,
                                                decoration: BoxDecoration(
                                                  color: Colors.red,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: Image.asset(
                                                    ImagePath.finalProposalImage1,
                                                    fit: BoxFit.fill),
                                              ),
                                              SizedBox(height: 8),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Image.asset(
                                                    ImagePath.dualprofile,
                                                    height: 18,
                                                    width: 18,
                                                  ),
                                                  SizedBox(width: 8),
                                                  Text(
                                                    AppConstants.joseph,
                                                    style: fontStyle.copyWith(
                                                        fontSize: 15,
                                                        fontWeight: FontWeight.w600,
                                                        color: Color(0xff161616)),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 4),
                                              Text(
                                                AppConstants.josephWindText,
                                                style: TextStyle(
                                                    color: AppColors.eGreyColor,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w500),
                                              )
                                            ],
                                          ),
                                          Spacer(),
                                          Column(
                                            children: [
                                              Container(
                                                height: 115,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    2.4,
                                                decoration: BoxDecoration(
                                                  color: Colors.blue,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: Image.asset(
                                                    ImagePath.finalProposalImage2,
                                                    fit: BoxFit.fill),
                                              ),
                                              SizedBox(height: 8),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Image.asset(
                                                    ImagePath.dualprofile,
                                                    height: 18,
                                                    width: 18,
                                                  ),
                                                  SizedBox(width: 8),
                                                  Text(
                                                    AppConstants.joseph,
                                                    style: fontStyle.copyWith(
                                                        fontSize: 15,
                                                        fontWeight: FontWeight.w600,
                                                        color: Color(0xff161616)),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 4),
                                              Text(
                                                AppConstants.josephWindText,
                                                style: TextStyle(
                                                    color: AppColors.eGreyColor,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w500),
                                              )
                                            ],
                                          ),
                                          SizedBox(width: 8),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 45),
                                      child: Container(
                                        height: 50,
                                        width: 50,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white,
                                        ),
                                        child: Image.asset(
                                          ImagePath.finalProposalImage,
                                          height: 50,
                                          width: 50,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10, top: 10),
                                  child: Container(
                                    height: 42,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(7),
                                      color: Color(0xffFB5A57),
                                    ),
                                    child: Center(
                                      child: Text(
                                        AppConstants.completeProposal,
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 10, right: 10),
                                  child: Text(
                                    AppConstants.withDrawn,
                                    style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xffFB5A57)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _appBar() {
    return Container(
      height: 45,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(width: 8),
          Container(height: 28, width: 28),
          
       
          Spacer(),
          Text(
            AppConstants.finalProposal,
            style: headingStyle.copyWith(
                color: Color(0xff440312),
                fontSize: 21,
                fontWeight: FontWeight.w600),
          ),
          Spacer(),
          
          SizedBox(width: 25)
        ],
      ),
    );
  }
}
