
// ignore_for_file: unnecessary_import, unused_import, unused_field, unused_local_variable


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:matrimonial_app/Ui/Drawer/AccountSettingScreen/account_screen.dart';
import 'package:matrimonial_app/Utils/app_constants.dart';
import 'package:matrimonial_app/Utils/color_constants.dart';
import 'package:matrimonial_app/Utils/image_path_constants.dart';
import 'package:matrimonial_app/Utils/text_styles.dart';
import 'package:matrimonial_app/widget/Executive%20Side/eCommonButton.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class E_Filter_screen extends StatefulWidget {
  const E_Filter_screen({Key? key}) : super(key: key);

  @override
  State<E_Filter_screen> createState() => _E_Filter_screenState();
}

class _E_Filter_screenState extends State<E_Filter_screen> {
  int val = -1;

  int _selectedIndex = 0;
  String? _ratingController;
  bool onlineOffline = false;
  bool online = false;
  bool offline = false;
  String dropdownValue = 'English';
  SfRangeValues _values = SfRangeValues(5.0, 10.0);
  double _value = 0.5;
  int? gender;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Column(
      children: [
        _filterbar(),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Text(
                    AppConstants.gender,
                    style: name.copyWith(fontSize: 18),
                  ),
                ),
                Row(
                  children: [
                    Container(
                      child: Row(
                        children: [
                          Radio<int>(
                            activeColor: currentColor,
                            value: 1,
                            groupValue: gender,
                            onChanged: (int? value) {
                              setState(() {
                                gender = value;
                              });
                            },
                          ),
                          Text(
                            AppConstants.male,
                            style: TextStyle(
                              color: gender == 1
                                  ? currentColor
                                  : Color(0xff7E7E7E),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: Row(
                        children: [
                          Radio<int>(
                              activeColor: currentColor,
                              value: 2,
                              groupValue: gender,
                              onChanged: (int? value) {
                                setState(() {
                                  gender = value;
                                });
                              }),
                          Text(
                            AppConstants.female,
                            style: TextStyle(
                              color: gender == 2
                                  ? currentColor
                                  : Color(0xff7E7E7E),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                Divider(),
                Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: Text(
                            AppConstants.agerange,
                            style: name.copyWith(fontSize: 18),
                          ),
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: Container(
                              width: width * 0.11,
                              child: Text(
                                '23-33',
                                style: TextStyle(color: AppColors.female),
                              )),
                        )
                      ],
                    ),
                    Container(
                      width: width,
                      child: SfRangeSliderTheme(
                        data: SfRangeSelectorThemeData(
                          activeTrackColor: currentColor,
                          inactiveTrackColor:
                              Color(0xff7E7E7E).withOpacity(0.1),
                          thumbColor: Colors.white,
                        ),
                        child: SfRangeSlider(
                          max: 100,
                          onChanged: (SfRangeValues newvalue) {
                            setState(() {
                              _values = newvalue;
                              print('${_values.start}');
                            });
                          },
                          values: _values,
                        ),
                      ),
                    ),
                  ],
                ),
                Divider(),
                Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: Text(
                            AppConstants.maximumdistance,
                            style: name.copyWith(fontSize: 18),
                          ),
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: Text(
                            '50 Km',
                            style: TextStyle(color: AppColors.female),
                          ),
                        )
                      ],
                    ),
                    SfSliderTheme(
                      data: SfSliderThemeData(
                        thumbColor: Colors.white,

                        activeTrackColor: currentColor,
                        inactiveTrackColor: Color(0xff7E7E7E).withOpacity(0.1),
                      ),
                      child: SfSlider(
                        value: _value,
                        onChanged: (newValue) {
                          setState(() {
                            _value = newValue;
                          });
                        },
                      ),
                    )
                  ],
                ),
                Divider(),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 16, right: 16, top: 10, bottom: 10),
                      child: Row(
                        children: [
                          Text(
                            AppConstants.otherStates,
                            style: name.copyWith(
                              fontSize: 18,
                            ),
                          ),
                          Spacer(),
                          FlutterSwitch(
                            width: 39.0,
                            height: 25.0,
                            toggleSize: 16.0,
                            value: onlineOffline,
                            borderRadius: 30.0,
                            activeColor: currentColor,
                            onToggle: (val) {
                              setState(() {
                                onlineOffline = val;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height * 0.020,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16, right: 25),
                      child: Container(
                        child:
                            Text(AppConstants.otherStatessub, style: subtitle),
                      ),
                    )
                  ],
                ),
                Divider(),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 10, left: 16, right: 16, bottom: 10),
                  child: Row(
                    children: [
                      Text(
                        AppConstants.withprofile,
                        style: name.copyWith(fontSize: 18),
                      ),
                      Spacer(),
                      FlutterSwitch(
                        width: 39.0,
                        height: 25.0,
                        toggleSize: 16.0,
                        value: online,
                        borderRadius: 30.0,

                        activeColor: currentColor,
                        onToggle: (val) {
                          setState(() {
                            online = val;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                Divider(),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 16, right: 16, top: 10, bottom: 10),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            width: width * 0.5,
                            child: Text(
                              AppConstants.profilepicture,
                              style: name.copyWith(fontSize: 18),
                            ),
                          ),
                          Spacer(),
                          FlutterSwitch(
                            width: 39.0,
                            height: 25.0,
                            toggleSize: 16.0,
                            value: offline,
                            borderRadius: 30.0,

                            activeColor: currentColor,
                            onToggle: (val) {
                              setState(() {
                                offline = val;
                              });
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      Container(
                          width: width * 0.9,
                          child: Text(AppConstants.profilepicturesub,
                              style: subtitle))
                    ],
                  ),
                ),
                Divider(),
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Text(
                    AppConstants.filterlanguage,
                    style: name.copyWith(fontSize: 18),
                  ),
                ),
                SizedBox(
                  height: height * 0.03,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Color(0xffC8CACD)),
                        borderRadius: BorderRadius.circular(13)),
                    child: DropdownButtonFormField<String>(
                      decoration: InputDecoration(border: InputBorder.none),
                      icon: Padding(
                        padding: const EdgeInsets.only(right: 13),
                        child: Container(
                          height: 24,
                          width: 24,
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Image.asset(
                              ImagePath.forward,
                              height: 24,
                              width: 24,
                            ),
                          ),
                        ),
                      ),
                      value: _ratingController,
                      items: [
                        AppConstants.hindi,
                        AppConstants.english,
                        AppConstants.gujarati
                      ]
                          .map(
                            (label) => DropdownMenuItem(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 13),
                                child: Text(label.toString()),
                              ),
                              value: label,
                            ),
                          )
                          .toList(),
                      hint: Padding(
                        padding: const EdgeInsets.only(left: 13),
                        child: Text(
                          AppConstants.hindi,
                          style: name.copyWith(color: Color(0xff333F52)),
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          _ratingController = value!;
                          print(_ratingController);
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.03,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: ECommonButton(btnName: 'Search Now', btnOnTap: () {}),
                ),
                SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        )
      ],
    ));
  }

  _filterbar() {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Align(
          alignment: Alignment.center,
          child: Image.asset(
            ImagePath.backArrow,
            color: Colors.black,
            height: height * 0.050,
          ),
        ),
      ),
      centerTitle: true,
      title: Text(
        AppConstants.filter,
        style: message,
      ),
    );
  }


}
