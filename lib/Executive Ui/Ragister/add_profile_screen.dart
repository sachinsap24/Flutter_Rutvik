import 'package:flutter/material.dart';
import 'package:matrimonial_app/Executive%20Ui/Ragister/about_her.dart';
import 'package:matrimonial_app/Executive%20Ui/Ragister/attachHomePicture.dart';
import 'package:matrimonial_app/Executive%20Ui/Ragister/looking_for.dart';
import 'package:matrimonial_app/Executive%20Ui/Ragister/management.dart';
import 'package:matrimonial_app/Executive%20Ui/Ragister/other_details.dart';
import 'package:matrimonial_app/Executive%20Ui/Ragister/qualification_screen.dart';
import 'package:matrimonial_app/Executive%20Ui/Ragister/uploadPicture.dart';
import 'package:matrimonial_app/Utils/app_constants.dart';
import 'package:matrimonial_app/Utils/color_constants.dart';
import 'package:matrimonial_app/Utils/image_path_constants.dart';
import 'package:matrimonial_app/Utils/text_styles.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

class AddProfileScreen extends StatefulWidget {
  String? isUpdate;
  var candidateId;
  AddProfileScreen({this.isUpdate, this.candidateId});
  @override
  State<AddProfileScreen> createState() => _AddProfileScreenState();
}

class _AddProfileScreenState extends State<AddProfileScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String selectedTab = "";
  String? fromValue;

  @override
  void initState() {
    _tabController = TabController(length: 7, vsync: this, initialIndex: 0);
    _tabController.addListener(() {
      _tabController.index = _tabController.index;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color(0xffFAFAFA),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xffFAFAFA),
        elevation: 0,
        leading: (widget.isUpdate == "isUpdate")
            ? GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Image.asset(ImagePath.backarrowshort),
                  ),
                ),
              )
            : Text(""),
        actions: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  print("object");

                  if (_tabController.index == 0) {
                    print(_tabController.index);
                    setState(() {
                      _tabController.index = 1;
                    });
                  } else if (_tabController.index == 1) {
                    setState(() {
                      _tabController.index = 2;
                    });
                  } else if (_tabController.index == 2) {
                    setState(() {
                      _tabController.index = 3;
                    });
                  } else if (_tabController.index == 3) {
                    setState(() {
                      _tabController.index = 4;
                    });
                  } else if (_tabController.index == 4) {
                    setState(() {
                      _tabController.index = 5;
                    });
                  } else if (_tabController.index == 5) {
                    setState(() {
                      _tabController.index = 6;
                    });
                  }
                },
                child: Container(
                  margin: EdgeInsets.only(right: width * 0.02),
                  child: Text(
                    AppConstants.skip,
                    textAlign: TextAlign.center,
                    style: fontStyle.copyWith(color: AppColors.blackColor),
                  ),
                ),
              ),
            ],
          )
        ],
        title: Text(
          AppConstants.addProfile,
          textAlign: TextAlign.center,
          style: headingStyle.copyWith(color: AppColors.blackColor),
        ),
      ),
      body: Column(
        children: [
          Divider(
            thickness: height * 0.01,
            color: AppColors.dividerColor,
          ),
          SizedBox(
            height: height * 0.002,
          ),
          Container(
            padding: EdgeInsets.zero,
            margin: EdgeInsets.only(
              left: width * 0.025,
            ),
            child: TabBar(
              padding: EdgeInsets.zero,
              physics: BouncingScrollPhysics(),
              onTap: (value) {},
              isScrollable: true,
              controller: _tabController,
              indicator: MaterialIndicator(
                  height: 5,
                  topLeftRadius: 8,
                  topRightRadius: 8,
                  tabPosition: TabPosition.bottom,
                  color: AppColors.tabselected),
              tabs: [
                Tab(
                  child: Text(
                    'About her',
                    style: fontStyle.copyWith(
                      color: _tabController.index == 0
                          ? AppColors.tabselected
                          : AppColors.tabunselecte,
                      fontSize: width * 0.04,
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    'Upload Picture',
                    style: fontStyle.copyWith(
                      color: _tabController.index == 0
                          ? AppColors.tabselected
                          : AppColors.tabunselecte,
                      fontSize: width * 0.04,
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    'Looking For',
                    style: fontStyle.copyWith(
                      color: _tabController.index == 1
                          ? AppColors.tabselected
                          : AppColors.tabunselecte,
                      fontSize: width * 0.04,
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    'Management',
                    style: fontStyle.copyWith(
                      color: _tabController.index == 2
                          ? AppColors.tabselected
                          : AppColors.tabunselecte,
                      fontSize: width * 0.04,
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    'Atttach Home Picture',
                    style: fontStyle.copyWith(
                      color: _tabController.index == 0
                          ? AppColors.tabselected
                          : AppColors.tabunselecte,
                      fontSize: width * 0.04,
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    'Other Details',
                    style: fontStyle.copyWith(
                      color: _tabController.index == 3
                          ? AppColors.tabselected
                          : AppColors.tabunselecte,
                      fontSize: width * 0.04,
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    'Qualification',
                    style: fontStyle.copyWith(
                      color: _tabController.index == 4
                          ? AppColors.tabselected
                          : AppColors.tabunselecte,
                      fontSize: width * 0.04,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(
            height: 2,
            thickness: height * 0.002,
            color: AppColors.dividerColor,
          ),
          Expanded(
            child: TabBarView(controller: _tabController, children: [
              AboutHer(
                  candidateId: widget.candidateId,
                  isUpdate: widget.isUpdate,
                  onBack: (int value) {
                    setState(() {
                      _tabController.index = value;
                    });
                  }),
              ExUploadPicture(
                  candidateId: widget.candidateId,
                  isUpdate: widget.isUpdate,
                  onBack: (int value) {
                    setState(() {
                      _tabController.index = _tabController.index + value;
                    });
                  }),
              LookingFor(
                  candidateId: widget.candidateId,
                  isUpdate: widget.isUpdate,
                  onBack: (int value) {
                    setState(() {
                      _tabController.index = _tabController.index + value;
                    });
                  }),
              Management(
                  candidateId: widget.candidateId,
                  isUpdate: widget.isUpdate,
                  onBack: (int value) {
                    setState(() {
                      _tabController.index = _tabController.index + value;
                    });
                  }),
              ExAttchHomePicture(
                  candidateId: widget.candidateId,
                  isUpdate: widget.isUpdate,
                  onBack: (int value) {
                    setState(() {
                      _tabController.index = _tabController.index + value;
                    });
                  }),
              Other_DetailsScreen(
                  candidateId: widget.candidateId,
                  isUpdate: widget.isUpdate,
                  onBack: (int value) {
                    setState(() {
                      _tabController.index = _tabController.index + value;
                    });
                  }),
              Qualification_screen(
                  candidateId: widget.candidateId,
                  isUpdate: widget.isUpdate,
                  onBack: (value) {}),
            ]),
          )
        ],
      ),
    );
  }
}
