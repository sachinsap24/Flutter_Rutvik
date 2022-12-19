import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:matrimonial_app/Core/Constant/CommonUtils.dart';
import 'package:matrimonial_app/Core/Constant/url_constant.dart';
import 'package:matrimonial_app/Core/Constant/value_constants.dart';
import 'package:matrimonial_app/Ui/Login/login_screen.dart';
import 'package:matrimonial_app/Utils/app_helper.dart';
import 'package:matrimonial_app/Utils/color_constants.dart';
import 'package:matrimonial_app/Utils/image_path_constants.dart';
import 'package:matrimonial_app/Utils/text_styles.dart';
import 'package:matrimonial_app/widget/Executive%20Side/eCommonButton.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum ImageSourceType { gallery, camera }

class ExAttchHomePicture extends StatefulWidget {
  final String? isUpdate;
  final Function? onBack;
  var candidateId;

  ExAttchHomePicture({Key? key, this.isUpdate, this.onBack, this.candidateId})
      : super(key: key);

  @override
  State<ExAttchHomePicture> createState() => _ExAttchHomePictureState();
}

class _ExAttchHomePictureState extends State<ExAttchHomePicture> {
  // PickedFile? imageFile;
  PickedFile? imageFile1;
  PickedFile? imageFile2;
  PickedFile? imageFile3;
  Dio dio = Dio();
  PickedFile? profileImage;
  //PickedFile? coverImage;
  List<PickedFile> coverImgList = [];
  List<String> coverImgPathList = [];
  File? userSelectedCoverImages;
  File? userSelectedProfileImages;
  File? userSelectedCoverImages1;
  File? userSelectedProfileImages1;
  File? userSelectedCoverImages2;
  File? userSelectedProfileImages2;
  File? userSelectedCoverImages3;
  File? userSelectedProfileImages3;
  PickedFile? imageFile;
  File? fileImage;
  PickedFile? coverImage;
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
          if (isCoverSequence == 1) {
            userSelectedCoverImages1 = _croppedImage;
          } else if (isCoverSequence == 2) {
            userSelectedCoverImages2 = _croppedImage;
          } else if (isCoverSequence == 3) {
            userSelectedCoverImages3 = _croppedImage;
          }
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
                                /* Text('Profile Picture',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                SizedBox(height: 5) */
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 17,
                          ),
                          DottedBorder(
                            color: userSelectedCoverImages1 == null
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
                                                      /*  onPressed: () async {
                                                        coverImgList =
                                                            await _openGallery1(
                                                                context);
                                                        setCoverImage(
                                                            "2", coverImage);
                                                      }, */
                                                      onPressed: () async {
                                                        /* coverImage =
                                                      await _openGallery(
                                                          context); */
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
                                                                userSelectedCoverImages1!
                                                                    .path));
                                                      },
                                                      child:
                                                          const Text('Gallery'),
                                                    ),
                                                    TextButton(
                                                      /*  onPressed: () async {
                                                        coverImgList =
                                                            await _openCamera1(
                                                                context);
                                                        setCoverImage(
                                                            "2", coverImage);
                                                      }, */
                                                      onPressed: () async {
                                                        /* profileImage =
                                                            await _openGallery(
                                                                context); */
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
                                                                userSelectedCoverImages1!
                                                                    .path));
                                                        /*   setProfileUpdateAPI(
                                                            "1", profileImage); */
                                                      },
                                                      child: Text('Camera'),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                        child: (userSelectedCoverImages1 ==
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
                                                        userSelectedCoverImages1!
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
                                /* Text('Cover Picture',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                SizedBox(height: 5) */
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 17,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        DottedBorder(
                          color: userSelectedCoverImages2 == null
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
                                                    /* onPressed: () async {
                                                      coverImgList =
                                                          await _openGallery2(
                                                              context);
                                                      setCoverImage(
                                                          "2", coverImage);
                                                    }, */
                                                    onPressed: () async {
                                                      /* coverImage =
                                                      await _openGallery(
                                                          context); */
                                                      Navigator.of(context)
                                                          .pop();
                                                      await _getImageFrom(
                                                          source: ImageSource
                                                              .gallery,
                                                          isCover: true,
                                                          isCoverSequence: 2);

                                                      setCoverImage(
                                                          "2",
                                                          PickedFile(
                                                              userSelectedCoverImages2!
                                                                  .path));
                                                    },
                                                    child:
                                                        const Text('Gallery'),
                                                  ),
                                                  TextButton(
                                                    /* onPressed: () async {
                                                      coverImgList =
                                                          await _openCamera2(
                                                              context);
                                                      setCoverImage(
                                                          "2", coverImage);
                                                    }, */
                                                    onPressed: () async {
                                                      /* profileImage =
                                                            await _openGallery(
                                                                context); */
                                                      Navigator.of(context)
                                                          .pop();
                                                      await _getImageFrom(
                                                          source: ImageSource
                                                              .camera,
                                                          isCover: true,
                                                          isCoverSequence: 2);

                                                      setCoverImage(
                                                          "2",
                                                          PickedFile(
                                                              userSelectedCoverImages2!
                                                                  .path));
                                                      /*   setProfileUpdateAPI(
                                                            "1", profileImage); */
                                                    },
                                                    child: Text('Camera'),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                      child: (userSelectedCoverImages2 == null)
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
                                                  File(userSelectedCoverImages2!
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
                              /* Text('Cover Picture',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              SizedBox(height: 5) */
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 17,
                        ),
                        DottedBorder(
                          color: userSelectedCoverImages3 == null
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
                                                    /*  onPressed: () async {
                                                      coverImgList =
                                                          await _openGallery3(
                                                              context);
                                                      setCoverImage(
                                                          "2", coverImage);
                                                    }, */
                                                    onPressed: () async {
                                                      /* coverImage =
                                                      await _openGallery(
                                                          context); */
                                                      Navigator.of(context)
                                                          .pop();
                                                      await _getImageFrom(
                                                          source: ImageSource
                                                              .gallery,
                                                          isCover: true,
                                                          isCoverSequence: 3);

                                                      setCoverImage(
                                                          "2",
                                                          PickedFile(
                                                              userSelectedCoverImages3!
                                                                  .path));
                                                    },
                                                    child:
                                                        const Text('Gallery'),
                                                  ),
                                                  TextButton(
                                                    /* onPressed: () async {
                                                      coverImgList =
                                                          await _openCamera3(
                                                              context);
                                                      setCoverImage(
                                                          "2", coverImage);
                                                    }, */
                                                    onPressed: () async {
                                                      /* profileImage =
                                                            await _openGallery(
                                                                context); */
                                                      Navigator.of(context)
                                                          .pop();
                                                      await _getImageFrom(
                                                          source: ImageSource
                                                              .camera,
                                                          isCover: true,
                                                          isCoverSequence: 3);

                                                      setCoverImage(
                                                          "2",
                                                          PickedFile(
                                                              userSelectedCoverImages3!
                                                                  .path));
                                                      /*   setProfileUpdateAPI(
                                                            "1", profileImage); */
                                                    },
                                                    child: Text('Camera'),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                      child: (userSelectedCoverImages3 == null)
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
                                                  File(userSelectedCoverImages3!
                                                      .path),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(height: 5),
                              /* Text(
                                'Cover Picture',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 5) */
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
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
                          Text("You can add those image later")
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Align(
                        alignment: Alignment.bottomCenter,
                        child: ECommonButton(
                            btnName: "Next",
                            btnOnTap: () {
                              widget.onBack!(1);
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
      coverImgPathList.add(imageFile1!.path);
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
      coverImgPathList.add(imageFile1!.path);
    });
    Navigator.pop(context);
    return coverImgList;
  }

  Future<List<PickedFile>> _openGallery2(BuildContext context) async {
    final pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
    );
    setState(() {
      imageFile2 = pickedFile;
      coverImgList.add(imageFile2!);
      coverImgPathList.add(imageFile2!.path);
    });

    Navigator.pop(context);
    return coverImgList;
  }

  Future<List<PickedFile>> _openCamera2(BuildContext context) async {
    final pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
    );
    setState(() {
      imageFile2 = pickedFile;
      coverImgList.add(imageFile2!);
      coverImgPathList.add(imageFile2!.path);
    });
    Navigator.pop(context);
    return coverImgList;
  }

  Future<List<PickedFile>> _openGallery3(BuildContext context) async {
    final pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
    );
    setState(() {
      imageFile3 = pickedFile;
      coverImgList.add(imageFile3!);
    });

    Navigator.pop(context);
    return coverImgList;
  }

  Future<List<PickedFile>> _openCamera3(BuildContext context) async {
    final pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
    );
    setState(() {
      imageFile3 = pickedFile!;
      coverImgList.add(imageFile3!);
    });
    Navigator.pop(context);
    return coverImgList;
  }

  void setCoverImage(String imageType, PickedFile? image) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var authToken = prefs.getString(EXE_TOKEN);
    var exeUserId = prefs.getString(EXE_USER_ID);
    CommonUtils.showProgressLoading(context);

    log("image uplode start  ========= >>>> $authToken");

    FormData formData = FormData.fromMap({
      "user_id": exeUserId,
      "image": image != null
          ? await MultipartFile.fromFile(image.path,
              filename: image.path.split('/').last)
          : null,
    });
    log("user id executive  ::: ${exeUserId}");

    print(formData);
    final queryParameters = {
      "token": authToken.toString(),
    };
    String queryString = Uri(queryParameters: queryParameters).query;
    print("upload image params :: $formData");
    try {
      print("upload image params ::: ${formData.files}");
      log("Url ${UPLOAD_CANDIDATE_HOME_IMG + "?" + queryString}");
      var response = await dio
          .post(UPLOAD_CANDIDATE_HOME_IMG + "?" + queryString, data: formData);
      log(response.data.toString());
      print(response.data);
      if (response.statusCode == 200) {
        // prefs.setString(EXE_ID, data['user_id']);
        if (mounted) {
          Fluttertoast.showToast(
            msg: "File updated successfully",
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
    } catch (e) {
      print("object:: $e");
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
