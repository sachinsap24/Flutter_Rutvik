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
import 'package:matrimonial_app/Executive%20Ui/SignupScreen/adharcardselfi_screen.dart';
import 'package:matrimonial_app/ModelClass/Executive_ModelClass/uploadPancard_model.dart';
import 'package:matrimonial_app/Utils/app_constants.dart';
import 'package:matrimonial_app/Utils/app_helper.dart';
import 'package:matrimonial_app/Utils/image_path_constants.dart';
import 'package:matrimonial_app/Utils/text_styles.dart';
import 'package:matrimonial_app/widget/Executive%20Side/eCommonButton.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Pancard_screen extends StatefulWidget {
  const Pancard_screen({Key? key}) : super(key: key);

  @override
  State<Pancard_screen> createState() => _Pancard_screenState();
}

class _Pancard_screenState extends State<Pancard_screen> {
  File? userSelectedProfileImages;
  PickedFile? imageFile;
  _getImageFrom({
    required ImageSource source,
  }) async {
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
      var _croppedImage = await AppHelper.cropImage(_compressedImage);
      if (_croppedImage == null) {
        return;
      }
      setState(() {
        userSelectedProfileImages = _croppedImage;
      });
    }
  }

  UploadPanCardModel? uploadPanCardModel;
  Dio dio = Dio();
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color(0xffFAFAFA),
      appBar: AppBar(
        backgroundColor: Color(0xffFAFAFA),
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop(context);
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
          AppConstants.personal,
          style: fontStyle.copyWith(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: Column(
          children: [
            Divider(),
            SizedBox(
              height: 20,
            ),
            Container(
              height: height * 0.1,
              width: width,
              child: Image.asset(ImagePath.uploaddocument2),
            ),
            SizedBox(
              height: 20,
            ),
            Divider(),
            SizedBox(
              height: 30,
            ),
            Container(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      AppConstants.pancardphoto,
                      style: upload,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Text(
                    AppConstants.clearphotocontaine,
                    textAlign: TextAlign.center,
                    style: uploadcontent,
                  )
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            DottedBorder(
              dashPattern: [8, 4],
              strokeCap: StrokeCap.round,
              borderType: BorderType.RRect,
              radius: Radius.circular(15),
              child: GestureDetector(
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
                              onPressed: () async {
                                await _getImageFrom(
                                  source: ImageSource.gallery,
                                );
                                Navigator.of(context).pop();
                              },
                              child: const Text('Gallery'),
                            ),
                            TextButton(
                              onPressed: () async {
                                await _getImageFrom(
                                  source: ImageSource.camera,
                                );
                                Navigator.of(context).pop();
                              },
                              child: Text('Camera'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
                child: (userSelectedProfileImages == null)
                    ? Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white,
                        ),
                        height: height * 0.31,
                        width: width,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              AppConstants.uploadpancard,
                              style: uploadcontent1,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(25.0),
                              child: Image.asset(
                                ImagePath.adhaarcard,
                                width: 142,
                                height: 101,
                              ),
                            )
                          ],
                        ))
                    : Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15)),
                        height: height * 0.31,
                        width: width,
                        child: Image.file(
                          File(userSelectedProfileImages!.path),
                          fit: BoxFit.fill,
                        ),
                      ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ECommonButton(
                btnName: 'NEXT',
                btnOnTap: () {
                  uploadPancardImage(
                      "4", PickedFile(userSelectedProfileImages!.path));
                })
          ],
        ),
      ),
    );
  }

  uploadPancardImage(String imageType, PickedFile? image) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var exeToken = prefs.getString(EXE_TOKEN);
    CommonUtils.showProgressLoading(context);
    log("image uplode start  ========= >>>> ");

    FormData formData = FormData.fromMap({
      "image_type_id": imageType,
      "token": exeToken,
      "image": image != null
          ? await MultipartFile.fromFile(image.path,
              filename: image.path.split('/').last)
          : null,
    });
    print(formData);

    var response = await dio.post(
        GET_EXE_PANCARDIMAGE /* + "?token=" + "$userToken" */,
        data: formData);
    print(response.data);
    if (response.statusCode == 200) {
      CommonUtils.hideProgressLoading();
      Fluttertoast.showToast(
        msg: "File updated successfully",
        toastLength: Toast.LENGTH_SHORT,
      );
      Navigator.push(context,
          CupertinoPageRoute(builder: (context) => Adharcardselfi_screen()));
      log(response.data.toString());
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

  void _openGallery(BuildContext context) async {
    final pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
    );
    setState(() {
      imageFile = pickedFile!;
    });

    Navigator.pop(context);
  }

  void _openCamera(BuildContext context) async {
    final pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
    );
    setState(() {
      imageFile = pickedFile!;
    });
    Navigator.pop(context);
  }
}
