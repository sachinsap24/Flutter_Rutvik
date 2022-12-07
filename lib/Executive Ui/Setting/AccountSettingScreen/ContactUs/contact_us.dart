
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:matrimonial_app/widget/Executive%20Side/eCommonButton.dart';

import '../../../../Utils/app_constants.dart';
import '../../../../Utils/image_path_constants.dart';
import '../../../../Utils/text_styles.dart';
import '../../../../widget/commonappbar.dart';
import '../../../../widget/submit_button.dart';

class Contact_Us extends StatefulWidget {
  const Contact_Us({Key? key}) : super(key: key);

  @override
  State<Contact_Us> createState() => _Contact_UsState();
}

class _Contact_UsState extends State<Contact_Us> {
  final maxLines = 5;
  PickedFile? imageFile;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _numberController = TextEditingController();
  TextEditingController _msgController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonAppbar(name: AppConstants.contactUs),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppConstants.contactUsText,
                          style: headerstyle.copyWith(
                            color: Color(0xff67707D),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: 30),
                        Text(
                          AppConstants.name,
                          style: headerstyle.copyWith(
                            color: Color(0xff67707D),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: 2),
                        _textFormField(39, _nameController),
                        SizedBox(height: 25),
                        Text(
                          AppConstants.emailAdd,
                          style: headerstyle.copyWith(
                            color: Color(0xff67707D),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: 2),
                        _textFormField(39, _emailController),
                        SizedBox(height: 25),
                        Text(
                          AppConstants.mobileNumber,
                          style: headerstyle.copyWith(
                            color: Color(0xff67707D),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: 2),
                        _textFormField(39, _numberController),
                        SizedBox(height: 25),
                        Text(
                          AppConstants.message,
                          style: headerstyle.copyWith(
                            color: Color(0xff67707D),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: 2),
                        Container(
                          height: 110,
                          width: MediaQuery.of(context).size.width,
                          child: TextFormField(
                            controller: _msgController,
                            maxLines: maxLines,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(13),
                                borderSide: BorderSide(
                                    color: Color(0xffD1D1D1), width: 1.5),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(13),
                                borderSide: BorderSide(
                                    color: Color(0xffD1D1D1), width: 1.5),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 4, horizontal: 15),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4)),
                            ),
                          ),
                        ),
                        SizedBox(height: 25),
                        Text(
                          AppConstants.attachment,
                          style: headerstyle.copyWith(
                            color: Color(0xff67707D),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: 6),
                        Wrap(
                          children: <Widget>[
                            DottedBorder(
                              dashPattern: [8, 4],
                              strokeWidth: 1,
                              strokeCap: StrokeCap.round,
                              borderType: BorderType.RRect,
                              radius: Radius.circular(7),
                              color: Color(0xffD9DADE),
                              child: Container(
                                height: 90,
                                width: 90,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    GestureDetector(
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
                                                    onPressed: () {
                                                      _openGallery(context);
                                                    },
                                                    child:
                                                        const Text('Gallery'),
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
                                          ? Container(
                                              child: Image.asset(
                                                  ImagePath.uploadImage,
                                                  height: 15,
                                                  width: 15),
                                            )
                                          : Container(
                                              height: 90,
                                              width: 90,
                                              color: Colors.red,
                                              child: Image.file(
                                                File(imageFile!.path),
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(width: 6),
                            DottedBorder(
                              dashPattern: [8, 4],
                              strokeWidth: 1,
                              strokeCap: StrokeCap.round,
                              borderType: BorderType.RRect,
                              radius: Radius.circular(7),
                              color: Color(0xffD9DADE),
                              child: Container(
                                height: 90,
                                width: 90,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    GestureDetector(
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
                                                    onPressed: () {
                                                      _openGallery(context);
                                                    },
                                                    child:
                                                        const Text('Gallery'),
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
                                          ? Container(
                                              child: Image.asset(
                                                  ImagePath.uploadImage,
                                                  height: 15,
                                                  width: 15),
                                            )
                                          : Container(
                                              height: 90,
                                              width: 90,
                                              color: Colors.red,
                                              child: Image.file(
                                                File(imageFile!.path),
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(width: 6),
                            DottedBorder(
                              dashPattern: [8, 4],
                              strokeWidth: 1,
                              strokeCap: StrokeCap.round,
                              borderType: BorderType.RRect,
                              radius: Radius.circular(7),
                              color: Color(0xffD9DADE),
                              child: Container(
                                height: 90,
                                width: 90,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    GestureDetector(
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
                                                    onPressed: () {
                                                      _openGallery(context);
                                                    },
                                                    child:
                                                        const Text('Gallery'),
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
                                          ? Container(
                                              child: Image.asset(
                                                  ImagePath.uploadImage,
                                                  height: 15,
                                                  width: 15),
                                            )
                                          : Container(
                                              height: 90,
                                              width: 90,
                                              color: Colors.red,
                                              child: Image.file(
                                                File(imageFile!.path),
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(width: 6),
                            DottedBorder(
                              dashPattern: [8, 4],
                              strokeWidth: 1,
                              strokeCap: StrokeCap.round,
                              borderType: BorderType.RRect,
                              radius: Radius.circular(7),
                              color: Color(0xffD9DADE),
                              child: Container(
                                height: 90,
                                width: 90,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    GestureDetector(
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
                                                    onPressed: () {
                                                      _openGallery(context);
                                                    },
                                                    child:
                                                        const Text('Gallery'),
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
                                          ? Container(
                                              child: Image.asset(
                                                  ImagePath.uploadImage,
                                                  height: 15,
                                                  width: 15),
                                            )
                                          : Container(
                                              height: 90,
                                              width: 90,
                                              color: Colors.red,
                                              child: Image.file(
                                                File(imageFile!.path),
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(width: 6),
                          ],
                        ),
                        SizedBox(height: 16),
                        ECommonButton(
                          btnName: AppConstants.sendUs,
                          btnOnTap: () {
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _textFormField(
    double height,
    TextEditingController _controller,
  ) {
    return Container(
      height: height,
      child: TextFormField(
        controller: _controller,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(13),
            borderSide: BorderSide(color: Color(0xffD1D1D1), width: 1.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(13),
            borderSide: BorderSide(color: Color(0xffD1D1D1), width: 1.5),
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 4, horizontal: 15),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(4)),
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
      radius: Radius.circular(7),
      color: Color(0xffD9DADE),
      child: Container(
        height: 90,
        width: 90,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
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
                  ? Container(
                      child: Image.asset(ImagePath.uploadImage,
                          height: 15, width: 15),
                    )
                  : Container(
                      height: 90,
                      width: 90,
                      color: Colors.red,
                      child: Image.file(
                        File(imageFile!.path),
                        fit: BoxFit.fill,
                      ),
                    ),
            )
          ],
        ),
      ),
    );
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
