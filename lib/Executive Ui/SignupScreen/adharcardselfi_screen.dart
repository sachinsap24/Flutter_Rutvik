// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:matrimonial_app/Core/Constant/CommonUtils.dart';
import 'package:matrimonial_app/Executive%20Ui/ReviewScreen/review_screen.dart';
import 'package:matrimonial_app/Utils/app_constants.dart';
import 'package:matrimonial_app/Utils/app_helper.dart';
import 'package:matrimonial_app/Utils/image_path_constants.dart';
import 'package:matrimonial_app/Utils/text_styles.dart';
import 'package:matrimonial_app/widget/Executive%20Side/eCommonButton.dart';

class Adharcardselfi_screen extends StatefulWidget {
  const Adharcardselfi_screen({Key? key}) : super(key: key);

  @override
  State<Adharcardselfi_screen> createState() => _Adharcardselfi_screenState();
}

class _Adharcardselfi_screenState extends State<Adharcardselfi_screen> {
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
              child: Image.asset(ImagePath.uploaddocument3),
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
                      AppConstants.aadharcardselfi,
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
                              AppConstants.selfiphoto,
                              style: uploadcontent1,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(25.0),
                              child: Image.asset(
                                ImagePath.selfiePhoto,
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
                btnName: 'Done',
                btnOnTap: () {
                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) => Review_screen()));
                }),
          ],
        ),
      ),
    );
  }

  void _openCamera(BuildContext context) async {
    final pickedFile = await ImagePicker().getImage(
        source: ImageSource.camera,
        imageQuality: 100,
        preferredCameraDevice: CameraDevice.rear);
    setState(() {
      imageFile = pickedFile!;
    });
    Navigator.pop(context);
  }
}
