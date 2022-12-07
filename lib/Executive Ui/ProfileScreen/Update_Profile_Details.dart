import 'package:country_code_picker/country_code_picker.dart';
import 'package:dio/dio.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:matrimonial_app/Core/Constant/CommonUtils.dart';
import 'package:matrimonial_app/Core/Constant/url_constant.dart';
import 'package:matrimonial_app/Core/Constant/value_constants.dart';
import 'package:matrimonial_app/ModelClass/Executive_ModelClass/Get_Profile_Model.dart';
import 'package:matrimonial_app/Ui/Drawer/ProfileScreen/profile_screenn.dart';
import 'package:matrimonial_app/Utils/DropDownList.dart';
import 'package:matrimonial_app/Utils/app_constants.dart';
import 'package:matrimonial_app/Utils/color_constants.dart';
import 'package:matrimonial_app/Utils/image_path_constants.dart';
import 'package:matrimonial_app/Utils/text_styles.dart';
import 'package:matrimonial_app/widget/Executive%20Side/eCommonButton.dart';
import 'package:matrimonial_app/widget/dropdown_const.dart';
import 'package:matrimonial_app/ModelClass/UserPanel_ModelClass/DropDown_Datas/state_model.dart'
    as stateModel;
import 'package:shared_preferences/shared_preferences.dart';

class UpdateProfileDetails extends StatefulWidget {
  const UpdateProfileDetails({Key? key}) : super(key: key);

  @override
  State<UpdateProfileDetails> createState() => _UpdateProfileDetailsState();
}

class _UpdateProfileDetailsState extends State<UpdateProfileDetails> {
  GetExeProfileModel? _getExeProfileModel;
  TextEditingController _textFieldController = TextEditingController();
  Dio dio = Dio();
  stateModel.StateModel? _stateModel;
  stateModel.Data? _data;
  String? dropdownlanguage;
  List<String> droplanguage = [AppConstants.hindi, AppConstants.english];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xffFAFAFA),
        elevation: 0,
        leading: GestureDetector(
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
        ),
        title: Text(
          "Edit Profile",
          textAlign: TextAlign.center,
          style: headingStyle.copyWith(color: AppColors.blackColor),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 16, right: 16),
        child: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                scrollPhysics: NeverScrollableScrollPhysics(),
                controller: _textFieldController,
                readOnly: true,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: _getExeProfileModel != null &&
                          _getExeProfileModel!.data != null
                      ? _getExeProfileModel!.data!.firstname.toString() +
                          " " +
                          _getExeProfileModel!.data!.lastname.toString()
                      : "Sara Williamson",
                  hintStyle: TextStyle(
                      color: Color(
                        0xff333F52,
                      ),
                      fontWeight: FontWeight.w500,
                      fontSize: 17),
                  labelText: 'Full Name',
                  labelStyle: TextStyle(
                    color: Color(0xff838994),
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
                ),
              ),
              Container(
                height: 2,
                color: Color(0xffE4E7F1),
              ),
              SizedBox(
                height: 10,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Mobile Number',
                    style: TextStyle(
                      color: Color(0xff838994),
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                          color: Color(0xffE4E7F1),
                        ))),
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: CountryCodePicker(
                            padding: EdgeInsets.zero,
                            onChanged: print,
                            initialSelection: 'IN',
                            showCountryOnly: false,
                            showOnlyCountryWhenClosed: false,
                            alignLeft: false,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: Container(
                            child: TextField(
                              // controller: _mobileNo,
                              keyboardType: TextInputType.number,
                              // readOnly: true,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(10)
                              ],
                              decoration: InputDecoration(
                                hintText: _getExeProfileModel != null &&
                                        _getExeProfileModel!.data != null
                                    ? _getExeProfileModel!.data!.mobile
                                    : '',
                                hintStyle: TextStyle(
                                    color: Color(
                                      0xff333F52,
                                    ),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
              TextField(
                readOnly: true,
                keyboardType: TextInputType.number,
                inputFormatters: [LengthLimitingTextInputFormatter(6)],
                decoration: InputDecoration(
                  hintText: _getExeProfileModel != null &&
                          _getExeProfileModel!.data != null
                      ? _getExeProfileModel!.data!.email
                      : '',
                  hintStyle: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                      fontSize: 17),
                  labelText: 'Email Address',
                  labelStyle: TextStyle(
                    color: Color(0xff838994),
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
                ),
              ),
              TextField(
                readOnly: true,
                decoration: InputDecoration(
                  hintText: 'Manhattan Lower, NY, 13655',
                  hintStyle: TextStyle(
                    color: Color(
                      0xff333F52,
                    ),
                    fontWeight: FontWeight.w500,
                    fontSize: 17,
                  ),
                  labelText: 'Address',
                  labelStyle: TextStyle(
                    color: Color(0xff838994),
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 163,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'District',
                          style: TextStyle(
                            color: Color(0xff838994),
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          width: 164,
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton2<String>(
                              dropdownDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(13),
                              ),
                              icon: Container(
                                height: 24,
                                width: 19,
                                child: Image.asset(
                                  ImagePath.downarrow,
                                  height: 24,
                                  width: 19,
                                ),
                              ),
                              hint: Text('Select District'),
                              dropdownMaxHeight: 200,
                              itemHeight: 20,
                              customItemsHeight: 20,
                              items: _addDividersAfterItems(districtList),
                              customItemsIndexes: _getDividersIndexes(),
                              value: district,
                              onChanged: (newValue) {
                                print(newValue);
                                setState(() {
                                  district = newValue;
                                });
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Container(
                    width: 160,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'State',
                          style: TextStyle(
                            color: Color(0xff838994),
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          width: 163,
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton2<stateModel.Data>(
                              dropdownDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(13),
                              ),
                              icon: Container(
                                height: 24,
                                width: 19,
                                child: Image.asset(
                                  ImagePath.downarrow,
                                  height: 24,
                                  width: 19,
                                ),
                              ),
                              hint: Text('Pune'),
                              dropdownMaxHeight: 200,
                              itemHeight: 20,
                              items: addDividersAfterItemsStateModel(
                                  (_stateModel != null)
                                      ? _stateModel!.data!
                                      : []),
                              customItemsIndexes: getDividersIndexes(
                                  (_stateModel != null)
                                      ? _stateModel!.data!
                                      : []),
                              value: _data,
                              onChanged: (newValue) {
                                print(newValue);
                                setState(() {
                                  _data = newValue;
                                });
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    height: 2,
                    width: 160,
                    color: Color(0xffE4E7F1),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Container(
                    height: 2,
                    width: 160,
                    color: Color(0xffE4E7F1),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 163,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Religion',
                          style: TextStyle(
                            color: Color(0xff838994),
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          ),
                        ),
                        Container(
                          width: 163,
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton2(
                              dropdownDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(13),
                              ),
                              icon: Container(
                                height: 24,
                                width: 19,
                                child: Image.asset(
                                  ImagePath.downarrow,
                                  height: 24,
                                  width: 19,
                                ),
                              ),
                              hint: Text('Hindi'),
                              dropdownMaxHeight: 200,
                              itemHeight: 20,
                              items: getDropdown()
                                  .addDividersAfterItems(droplanguage),
                              customItemsIndexes: getDropdown()
                                  .getDividersIndexes(droplanguage),
                              value: dropdownlanguage,
                              onChanged: (value) {
                                setState(() {
                                  dropdownlanguage = value as String;
                                });
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    child: Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 16),
                            child: Text(
                              'Age',
                              style: TextStyle(
                                color: Color(0xff838994),
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 16),
                            child: TextField(
                              keyboardType: TextInputType.number,
                              readOnly: true,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(2)
                              ],
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: '25',
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Container(
                    height: 2,
                    width: 163,
                    color: Color(0xffE4E7F1),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Container(
                    height: 2,
                    width: 148,
                    color: Color(0xffE4E7F1),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 163,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Are you Looking for?',
                          style: TextStyle(
                            color: Color(0xff838994),
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          ),
                        ),
                        Container(
                          width: 163,
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton2(
                              dropdownDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(13),
                              ),
                              icon: Container(
                                height: 24,
                                width: 19,
                                child: Image.asset(
                                  ImagePath.downarrow,
                                  height: 24,
                                  width: 19,
                                ),
                              ),
                              hint: Text('Male'),
                              dropdownMaxHeight: 200,
                              itemHeight: 20,
                              items: getDropdown()
                                  .addDividersAfterItems(genderdropdown),
                              customItemsIndexes: getDropdown()
                                  .getDividersIndexes(genderdropdown),
                              value: dropdowngender,
                              onChanged: (value) {
                                setState(() {
                                  dropdowngender = value as String;
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                      child: Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: Text(
                            'PIN Code',
                            style: TextStyle(
                              color: Color(0xff838994),
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: TextField(
                            readOnly: true,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(6)
                            ],
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'NYCB055G8',
                              hintStyle: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                  fontSize: 17),
                            ),
                          ),
                        )
                      ],
                    ),
                  ))
                ],
              ),
              Row(
                children: [
                  Container(
                    height: 2,
                    width: 163,
                    color: Color(0xffE4E7F1),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Container(
                    height: 2,
                    width: 148,
                    color: Color(0xffE4E7F1),
                  ),
                ],
              ),
              SizedBox(
                height : 20,
              ),
              ECommonButton(
                btnName: "Update",
                btnOnTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }

  getProfileAPI() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var exeToken = pref.getString(EXE_TOKEN);
    CommonUtils.showProgressLoading(context);
    final queryParameters = {
      "token": exeToken.toString(),
    };
    String queryString = Uri(queryParameters: queryParameters).query;
    var response = await dio.get(GET_EXE_PROFILE_URL + "?" + queryString);
    if (response.statusCode == 200) {
      CommonUtils.hideProgressLoading();
      var result = response.data;
      if (result['success'] == true) {
        setState(() {
          _getExeProfileModel = GetExeProfileModel.fromJson(result);
        });
      }

      print(response.data);
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

  String? district;
  List<DropdownMenuItem<String>> _addDividersAfterItems(
      List<Map<String, dynamic>> district) {
    List<DropdownMenuItem<String>> _menuItems = [];
    for (var item in districtList) {
      _menuItems.addAll(
        [
          DropdownMenuItem<String>(
            value: item['name'],
            child: Padding(
              padding: EdgeInsets.only(top: 2.0, left: 0),
              child: Text(
                item['name'],
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
          ),
          //If it's last item, we will not add Divider after it.
          if (item != districtList.last)
            const DropdownMenuItem<String>(
              enabled: false,
              child: Divider(
                height: 0,
              ),
            ),
        ],
      );
    }
    return _menuItems;
  }

  List<int> _getDividersIndexes() {
    List<int> _dividersIndexes = [];
    for (var i = 0; i < (districtList.length * 2) - 1; i++) {
      //Dividers indexes will be the odd indexes
      if (i.isOdd) {
        _dividersIndexes.add(i);
      }
    }
    return _dividersIndexes;
  }

  List<DropdownMenuItem<stateModel.Data>> addDividersAfterItemsStateModel(
      List<stateModel.Data> items) {
    List<DropdownMenuItem<stateModel.Data>> _menuItems = [];
    for (var item in items) {
      _menuItems.addAll(
        [
          DropdownMenuItem<stateModel.Data>(
            value: item,
            child: Padding(
              padding: EdgeInsets.only(top: 2.0, left: 10),
              child: Text(
                item.name.toString(),
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
          ),
          if (item != items.last)
            const DropdownMenuItem<stateModel.Data>(
              enabled: false,
              child: Divider(
                height: 0,
              ),
            ),
        ],
      );
    }
    return _menuItems;
  }

  getDividersIndexes(items) {
    List<int> _getDividersIndexes() {
      List<int> _dividersIndexes = [];
      for (var i = 0; i < (items.length * 2) - 1; i++) {
        if (i.isOdd) {
          _dividersIndexes.add(i);
        }
      }
      return _dividersIndexes;
    }
  }
}
