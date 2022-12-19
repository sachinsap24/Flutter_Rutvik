import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:matrimonial_app/Core/Constant/CommonUtils.dart';
import 'package:matrimonial_app/Core/Constant/url_constant.dart';
import 'package:matrimonial_app/Core/Constant/value_constants.dart';
import 'package:matrimonial_app/Executive%20Ui/SignupScreen/adharcardfront_screen.dart';
import 'package:matrimonial_app/ModelClass/Executive_ModelClass/Upload_Proifle_Img_Model.dart';
import 'package:matrimonial_app/Ui/Drawer/AccountSettingScreen/account_screen.dart';
import 'package:matrimonial_app/Ui/Login/login_screen.dart';
import 'package:matrimonial_app/Utils/app_constants.dart';
import 'package:matrimonial_app/Utils/app_helper.dart';
import 'package:matrimonial_app/Utils/color_constants.dart';
import 'package:matrimonial_app/Utils/image_path_constants.dart';
import 'package:matrimonial_app/Utils/text_styles.dart';
import 'package:matrimonial_app/widget/Executive%20Side/eCommonButton.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum ImageSourceType { gallery, camera }

class ExeUploadImage extends StatefulWidget {
  ExeUploadImage({
    Key? key,
  }) : super(key: key);

  @override
  State<ExeUploadImage> createState() => _ExeUploadImageState();
}

class _ExeUploadImageState extends State<ExeUploadImage> {
  File? userSelectedCoverImages;
  File? userSelectedProfileImages;
  PickedFile? imageFile;
  PickedFile? imageFile1;
  final _picker = ImagePicker();
  //PickedFile? imageFile;
  File? fileImage;
  PickedFile? coverImage;

  Dio dio = Dio();
  PickedFile? profileImage;
  // PickedFile? coverImage;
  List<PickedFile> coverImgList = [];
  _getImageFrom(
      {required ImageSource source,
      required bool isCover,
      required int isCoverSequence}) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? _pickedImage = await _picker.pickImage(source: source);
    CommonUtils.showProgressLoading(context);
    if (_pickedImage != null) {
      CommonUtils.hideProgressLoading();
      var image = File(_pickedImage.path.toString());
      final _sizeInKbBefore = image.lengthSync() / 1024;
      print('Before Compress $_sizeInKbBefore kb');
      var _compressedImage = await AppHelper.compress(image: image);
      final _sizeInKbAfter = _compressedImage.lengthSync() / 1024;
      print('After Compress $_sizeInKbAfter kb');
      var _croppedImage = await AppHelper.cropImage(_compressedImage,isCover);
      if (_croppedImage == null) {
        return;
      }
      setState(() {
        if (isCover == true) {
          userSelectedCoverImages = _croppedImage;
        } else {
          userSelectedProfileImages = _croppedImage;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Image.asset(ImagePath.backArrow),
          ),
        ),
        title: Text(
          AppConstants.upload,
          style: fontStyle.copyWith(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 12,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      width: width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          DottedBorder(
                            color: userSelectedProfileImages == null
                                ? Colors.black
                                : Colors.transparent,
                            dashPattern: [8, 4],
                            strokeWidth: 1,
                            strokeCap: StrokeCap.round,
                            borderType: BorderType.RRect,
                            radius: Radius.circular(5),
                            child: Column(
                              children: [
                                Container(
                                  height: height * 0.26,
                                  width: width / 2.4,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          showDialog<String>(
                                            context: context,
                                            builder: (BuildContext context) =>
                                                AlertDialog(
                                              title: Center(
                                                  child:
                                                      const Text('Pick Image')),
                                              actions: <Widget>[
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    TextButton(
                                                      onPressed: () async {
                                                        Navigator.of(context)
                                                            .pop();
                                                        await _getImageFrom(
                                                            source: ImageSource
                                                                .gallery,
                                                            isCover: false,
                                                            isCoverSequence: 0);

                                                        setCoverImage(
                                                            "1",
                                                            PickedFile(
                                                                userSelectedProfileImages!
                                                                    .path));
                                                      },
                                                      child:
                                                          const Text('Gallery'),
                                                    ),
                                                    TextButton(
                                                      onPressed: () async {
                                                        Navigator.of(context)
                                                            .pop();
                                                        await _getImageFrom(
                                                            source: ImageSource
                                                                .camera,
                                                            isCover: false,
                                                            isCoverSequence: 0);

                                                        setCoverImage(
                                                            "1",
                                                            PickedFile(
                                                                userSelectedProfileImages!
                                                                    .path));
                                                      },
                                                      child: Text('Camera'),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                        child: (userSelectedProfileImages ==
                                                null)
                                            ? Image.asset(
                                                ImagePath.imagepicker,
                                                width: 40,
                                                height: 40,
                                                fit: BoxFit.fill,
                                              )
                                            : ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                child: Container(
                                                  height: height * 0.26,
                                                  width: width / 2.5,
                                                  child: Image.file(
                                                    File(
                                                        userSelectedProfileImages!
                                                            .path),
                                                    fit: BoxFit.fill,
                                                  ),
                                                ),
                                              ),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text('Profile Picture',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                SizedBox(height: 5)
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 17,
                          ),
                          DottedBorder(
                            color: userSelectedCoverImages == null
                                ? Colors.black
                                : Colors.transparent,
                            dashPattern: [8, 4],
                            strokeWidth: 1,
                            strokeCap: StrokeCap.round,
                            borderType: BorderType.RRect,
                            radius: Radius.circular(5),
                            child: Column(
                              children: [
                                Container(
                                  height: height * 0.26,
                                  width: width / 2.4,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          showDialog<String>(
                                            context: context,
                                            builder: (BuildContext context) =>
                                                AlertDialog(
                                              title: Center(
                                                  child:
                                                      const Text('Pick Image')),
                                              actions: <Widget>[
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    TextButton(
                                                      onPressed: () async {
                                                        Navigator.of(context)
                                                            .pop();
                                                        await _getImageFrom(
                                                            source: ImageSource
                                                                .gallery,
                                                            isCover: true,
                                                            isCoverSequence: 1);

                                                        setCoverImage(
                                                            "2",
                                                            PickedFile(
                                                                userSelectedCoverImages!
                                                                    .path));
                                                      },
                                                      child:
                                                          const Text('Gallery'),
                                                    ),
                                                    TextButton(
                                                      onPressed: () async {
                                                        Navigator.of(context)
                                                            .pop();
                                                        await _getImageFrom(
                                                            source: ImageSource
                                                                .camera,
                                                            isCover: true,
                                                            isCoverSequence: 1);

                                                        setCoverImage(
                                                            "2",
                                                            PickedFile(
                                                                userSelectedCoverImages!
                                                                    .path));
                                                      },
                                                      child: Text('Camera'),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                        child: (userSelectedCoverImages == null)
                                            ? Image.asset(
                                                ImagePath.imagepicker,
                                                width: 40,
                                                height: 40,
                                                fit: BoxFit.fill,
                                              )
                                            : ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                child: Container(
                                                  height: height * 0.26,
                                                  width: width / 2.5,
                                                  child: Image.file(
                                                    File(
                                                        userSelectedCoverImages!
                                                            .path),
                                                    fit: BoxFit.fill,
                                                  ),
                                                ),
                                              ),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text('Cover Picture',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                SizedBox(height: 5)
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 200,
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: width,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Note:",
                            style: fontStyle.copyWith(
                                fontWeight: FontWeight.w600, fontSize: 16),
                          ),
                          RichText(
                            textAlign: TextAlign.start,
                            text: TextSpan(
                              text: " Add At least",
                              style: fontStyle.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: Color(
                                    0xff838994,
                                  ),
                                  fontSize: 15),
                              children: [
                                TextSpan(text: " two ", style: fontStyle),
                                TextSpan(
                                  text: "photos for continue \nwith us",
                                  style: fontStyle.copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: Color(
                                        0xff838994,
                                      ),
                                      fontSize: 15),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Align(
                        alignment: Alignment.bottomCenter,
                        child: ECommonButton(
                            btnName: "Done",
                            btnOnTap: () {
                              Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                      builder: (context) =>
                                          AdharcardFront_screen()));
                            })),
                    SizedBox(height: 25),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  DottedBorder imagepicker(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return DottedBorder(
      dashPattern: [8, 4],
      strokeWidth: 1,
      strokeCap: StrokeCap.round,
      borderType: BorderType.RRect,
      radius: Radius.circular(5),
      child: Container(
        height: height * 0.25,
        width: width / 2.4,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: Center(child: const Text('Pick Image')),
                    actions: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextButton(
                            onPressed: () {
                              _openGallery(context);
                            },
                            child: const Text('Gallery'),
                          ),
                          TextButton(
                            onPressed: () {
                              _openCamera(context);
                            },
                            child: Text('Camera'),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
              child: (imageFile == null)
                  ? Image.asset(
                      ImagePath.imagepicker,
                      width: 40,
                      height: 40,
                      fit: BoxFit.fill,
                    )
                  : Container(
                      height: height * 0.25,
                      width: width / 2.5,
                      child: Image.file(
                        File(imageFile!.path),
                        fit: BoxFit.fill,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Future<List<PickedFile>> _openGallery(BuildContext context) async {
    final pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
    );
    setState(() {
      imageFile = pickedFile;
      coverImgList.add(imageFile!);
    });

    Navigator.pop(context);
    return coverImgList;
  }

  Future<List<PickedFile>> _openCamera(BuildContext context) async {
    final pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
    );
    setState(() {
      imageFile = pickedFile;
      coverImgList.add(imageFile!);
    });

    Navigator.pop(context);
    return coverImgList;
  }

  Future<List<PickedFile>> _openGallery1(BuildContext context) async {
    final pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
    );
    setState(() {
      imageFile1 = pickedFile;
      coverImgList.add(imageFile1!);
    });

    Navigator.pop(context);
    return coverImgList;
  }

  Future<List<PickedFile>> _openCamera1(BuildContext context) async {
    final pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
    );
    setState(() {
      imageFile1 = pickedFile;
      coverImgList.add(imageFile1!);
    });
    Navigator.pop(context);
    return coverImgList;
  }

  void setCoverImage(String imageType, PickedFile? image) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var exeToken = prefs.getString(EXE_TOKEN);
    CommonUtils.showProgressLoading(context);
    log("image uplode start  ========= >>>> ");
    List<MultipartFile> uploadListTest = [];
    for (var i = 0; i < coverImgList.length; i++) {
      uploadListTest.add(await getImageTest(
          coverImgList[i].path, coverImgList[i].path.split('/').last));
    }
    FormData formData = FormData.fromMap({
      "image_type_id": imageType,
      "token": exeToken,
      "image": image != null
          ? await MultipartFile.fromFile(image.path,
              filename: image.path.split('/').last)
          : null,
    });
    print(formData);

    var response = await dio.post(UPLOAD_PROFILE_IMG_URL, data: formData);
    log(response.data.toString());
    print(response.data);
    if (response.statusCode == 200) {
      UploadProfileImgModel _uploadProfileImgModel =
          UploadProfileImgModel.fromJson(response.data);
      if (mounted) {
        Fluttertoast.showToast(
          msg: "File updated successfully",
          backgroundColor: currentColor,
          toastLength: Toast.LENGTH_SHORT,
        );
        log(response.data.toString());
      }
      CommonUtils.hideProgressLoading();
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
    } else {
      CommonUtils.hideProgressLoading();
    }
  }

  Future<MultipartFile> getImageTest(String filePath, String fileName) async {
    return await MultipartFile.fromFile(filePath, filename: fileName);
  }

  Future _openGalleryselect(BuildContext context) async {
    final pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
    );
    setState(() {
      imageFile = pickedFile!;
    });

    Navigator.pop(context);
    return imageFile;
  }

  Future _openCameraselect(BuildContext context) async {
    final pickedFile1 = await ImagePicker().getImage(
      source: ImageSource.camera,
    );
    setState(() {
      imageFile = pickedFile1!;
    });
    Navigator.pop(context);
    return imageFile;
  }
}

class DialogBox extends StatefulWidget {
  const DialogBox({Key? key}) : super(key: key);

  @override
  State<DialogBox> createState() => _DialogBoxState();
}

class _DialogBoxState extends State<DialogBox> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Align(
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              height: 140,
              width: MediaQuery.of(context).size.width * 0.8,
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.only(left: 20.0, right: 20, top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Alert",
                      style: nextBtnStyle,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Your Profile has been Created. \nKindly login again ",
                      style: headingStyle.copyWith(
                          fontSize: 14, fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {});

                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Login(),
                            ),
                            (route) => false);
                      },
                      child: Center(
                        child: Container(
                          width: MediaQuery.of(context).size.width / 1.7,
                          height: 40,
                          decoration: BoxDecoration(
                              gradient: AppColors.appColor,
                              borderRadius: BorderRadius.circular(9)),
                          alignment: Alignment.center,
                          child: Text(
                            "Ok",
                            style: appBtnStyle,
                          ),
                        ),
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
}
