import 'dart:developer';
import 'dart:io';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:matrimonial_app/Utils/app_constants.dart';
import 'package:matrimonial_app/Utils/color_constants.dart';
import 'package:matrimonial_app/Utils/image_path_constants.dart';
import 'package:matrimonial_app/Utils/text_styles.dart';
import 'package:matrimonial_app/Utils/value_constant.dart';
import '../../../widget/dropdown_const.dart';

class NewPost_screen extends StatefulWidget {
  const NewPost_screen({Key? key}) : super(key: key);
  @override
  State<NewPost_screen> createState() => _NewPost_screenState();
}

class _NewPost_screenState extends State<NewPost_screen> {
  File? profileImage;
  String? _fileName;
  String? pdfPath;
  String? fileName;
  String? selectedValue;
  PickedFile? imageFile;
  List<String> items = [
    'Item1',
    'Item2',
    'Item3',
    'Item4',
  ];
  List<Map<String, dynamic>> newPost = [
    {
      IMAGE: ImagePath.imageGrey,
      NAME: AppConstants.imageText,
    },
    {
      IMAGE: ImagePath.videoGrey,
      NAME: AppConstants.videoText,
    },
    {
      IMAGE: ImagePath.celebrateGrey,
      NAME: AppConstants.celebrateText,
    },
    {
      IMAGE: ImagePath.eventGrey,
      NAME: AppConstants.eventText,
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.colorWhite,
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Column(
            children: [
              _appBar(),
              SizedBox(height: 10),
              Container(
                height: 2,
                width: MediaQuery.of(context).size.width,
                color: Color(0xffF1F2F6),
              ),
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.only(left: 16, right: 16),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 69,
                            width: 69,
                            decoration: BoxDecoration(shape: BoxShape.circle),
                            child: Image.asset(
                              ImagePath.newPostProfile,
                              height: 69,
                              width: 69,
                            ),
                          ),
                          SizedBox(width: 8),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(AppConstants.elonMusk),
                                SizedBox(height: 5),
                                Container(
                                  height: 25,
                                  width: 90,
                                  padding: EdgeInsets.only(left: 5),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(18),
                                    border: Border.all(
                                      color: Color(0xffD1D1D1),
                                      width: 1.5,
                                    ),
                                  ),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton2(
                                      hint: Text(
                                        AppConstants.anyone,
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Theme.of(context).hintColor,
                                        ),
                                      ),
                                      dropdownMaxHeight: 200,
                                      items: getDropdown()
                                          .addDividersAfterItems(items),
                                      customItemsIndexes: getDropdown()
                                          .getDividersIndexes(items),
                                      value: selectedValue,
                                      onChanged: (value) {
                                        setState(() {
                                          selectedValue = value as String;
                                        });
                                      },
                                      buttonHeight: 40,
                                      buttonWidth: 140,
                                      itemHeight: 40,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 25),
                    Padding(
                      padding: EdgeInsets.only(left: 16, right: 16),
                      child: TextFormField(
                        maxLines: 5,
                        decoration: InputDecoration(
                            hintText: AppConstants.newPostAbout,
                            hintStyle: headingStyle.copyWith(
                                color: Color(0xff7E7E7E),
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none)),
                      ),
                    ),
                  ],
                ),
              ),
              Spacer(),
              Container(
                height: 192,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xff000000).withOpacity(.11),
                      offset: Offset(
                        0,
                        -5,
                      ),
                      blurRadius: 5,
                      spreadRadius: 0,
                    ),
                  ],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Container(
                        height: 4,
                        width: 49,
                        decoration: BoxDecoration(
                            color: Color(0xff676767),
                            borderRadius: BorderRadius.circular(3)),
                      ),
                    ),
                    SizedBox(height: 10),
                    ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.only(left: 16),
                        itemCount: newPost.length,
                        itemBuilder: ((context, index) {
                          return Material(
                            type: MaterialType.transparency,
                            elevation: 10,
                            animationDuration: Duration(seconds: 1),
                            child: InkWell(
                              splashColor: Colors.grey.withOpacity(0.5),
                              splashFactory: InkRipple.splashFactory,
                              onTap: () {
                                setState(() {
                                  if (index == 0) {
                                    addPhotoDialog();
                                  } else if (index == 1) {
                                    _openFileExplorer();
                                    log("index 1");
                                  } else if (index == 2) {
                                  } else if (index == 3) {}
                                });
                              },
                              child: Container(
                                color: Colors.transparent,
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 16),
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        newPost[index][IMAGE],
                                        height: 23,
                                        width: 23,
                                      ),
                                      SizedBox(width: 16),
                                      Text(
                                        newPost[index][NAME],
                                        style: headingStyle.copyWith(
                                            color: Color(0xff646464),
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }))
                  ],
                ),
              ),
            ],
          ),
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
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Image.asset(
                ImagePath.leftArrow,
                height: 28,
                width: 28,
                color: Color(0xff2C3E50),
              ),
            ),
          ),
          Spacer(),
          Text(
            AppConstants.newPost,
            style: headingStyle.copyWith(
                color: Color(0xff440312),
                fontSize: 21,
                fontWeight: FontWeight.w600),
          ),
          Spacer(),
          Text(
            AppConstants.done,
            style: headingStyle.copyWith(
                color: Color(0xff8B8B8B),
                fontSize: 14,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(width: 8)
        ],
      ),
    );
  }

  _openFileExplorer() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ['mp4']);
    if (result != null) {
      PlatformFile file = result.files.first;
      setState(() {
        _fileName = file.name;
        pdfPath = file.path;
        print("doc ::::::::::::::::::::::::${_fileName}");
        print("Pdf =>>>>>>>>>>>>>>>>>>>${pdfPath}");
      });
    } else {
    }
  }

  addPhotoDialog() {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Center(child: const Text('Add a photo')),
        actions: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                onPressed: () {
                  setState(() {
                    _openGallery(context);
                  });
                },
                child: const Text('Gallery'),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    _openCamera(context);
                  });
                },
                child: Text('Camera'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  _openGallery(BuildContext context) async {
    final pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
    );
    setState(() {
      imageFile = pickedFile;
    });
    Navigator.pop(context);
  }

  _openCamera(BuildContext context) async {
    final pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
    );
    setState(() {
      imageFile = pickedFile;
    });
    Navigator.pop(context);
  }


}
