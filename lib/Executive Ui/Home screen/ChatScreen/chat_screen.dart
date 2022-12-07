// ignore_for_file: unused_field, unnecessary_import, unused_local_variable, deprecated_member_use

import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:matrimonial_app/Utils/image_path_constants.dart';
import 'package:matrimonial_app/Utils/text_styles.dart';

class E_Chat_screen extends StatefulWidget {
  const E_Chat_screen({Key? key}) : super(key: key);

  @override
  State<E_Chat_screen> createState() => _E_Chat_screenState();
}

class _E_Chat_screenState extends State<E_Chat_screen> {
  int _selectedIndex = 0;
  File? profileImage;
  String? _fileName;
  String? pdfPath;
  String? fileName;
  String? selectedValue;
  PickedFile? imageFile;

  List<ChatMessage> messages = [
    ChatMessage(
        messageContent:
            "Lorem ipsum dolor sit amet, consete sadipscing elite, sed diam nonumy ",
        messageType: "receiver"),
    ChatMessage(
        messageContent: "Lorem ipsum dolor sit amet, ",
        messageType: "receiver"),
    ChatMessage(
        messageContent: "Lorem ipsum dolor sit amet, ", messageType: "sender"),
    ChatMessage(
        messageContent: "Lorem ipsum dolor sit amet, ",
        messageType: "receiver"),
  ];
  @override
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _chatappbar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: messages.length,
              shrinkWrap: true,
              padding: EdgeInsets.only(top: 10, bottom: 10),
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                          left: 14, right: 14, top: 10, bottom: 10),
                      child: Align(
                        alignment: (messages[index].messageType == "receiver"
                            ? Alignment.topLeft
                            : Alignment.topRight),
                        child: Container(
                          decoration: BoxDecoration(
                            border: messages[index].messageType == "receiver"
                                ? Border.all(color: Color(0xffEBEBEB))
                                : Border.all(color: Color(0xffFC7358)),
                            borderRadius:
                                messages[index].messageType == "receiver"
                                    ? BorderRadius.only(
                                        topLeft: Radius.circular(13),
                                        topRight: Radius.circular(13),
                                        bottomRight: Radius.circular(13))
                                    : BorderRadius.only(
                                        topLeft: Radius.circular(13),
                                        topRight: Radius.circular(13),
                                        bottomLeft: Radius.circular(13),
                                        bottomRight: Radius.circular(13)),
                            color: (messages[index].messageType == "receiver"
                                ? Colors.white
                                : Color.fromARGB(255, 250, 65, 65)),
                          ),
                          padding: EdgeInsets.all(16),
                          child: Text(
                            messages[index].messageContent,
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: messages[index].messageType == "receiver"
                                    ? Colors.black
                                    : Colors.white),
                          ),
                        ),
                      ),
                    ),
                    Align(
                        alignment: messages[index].messageType == "receiver"
                            ? Alignment.bottomLeft
                            : Alignment.bottomRight,
                        child: Padding(
                          padding: messages[index].messageType == "receiver"
                              ? EdgeInsets.only(left: 15)
                              : EdgeInsets.only(right: 15),
                          child: Text(
                            "8:30 am",
                            style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff3A3A3A)),
                          ),
                        ))
                  ],
                );
              },
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Joseph wind is typing...",
                  style: TextStyle(
                      color: Color(
                        0xff3A4167,
                      ),
                      fontSize: 13,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 50,
                  width: double.infinity,
                  padding: EdgeInsets.only(left: 10, right: 5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Color(0xff000000).withOpacity(0.1),
                          offset: Offset(0.5, 0.5),
                          blurRadius: 10)
                    ],
                    border: Border.all(color: Color(0xffE1E1E1), width: 0.5),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Row(
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 25,
                            height: 25,
                            child: Image.asset(ImagePath.smily),
                          ),
                          Padding(
                              padding: const EdgeInsets.only(
                                  top: 10, bottom: 10, left: 10, right: 10),
                              child: Container(
                                height: 60,
                                width: 1,
                                color: Color(0xffBCBCBC),
                              )),
                          InkWell(
                            onTap: () {
                              setState(() {
                                addPhotoDialog();
                              });
                            },
                            child: Container(
                              width: 25,
                              height: 25,
                              color: Colors.transparent,
                              child: Image.asset(ImagePath.sharefile),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 10),
                      Expanded(
                          child: TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Type here....',
                          suffixIcon: Container(
                              padding: EdgeInsets.all(8),
                              width: 15,
                              height: 15,
                              child: Image.asset(ImagePath.shareImage)),
                        ),
                      ))
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  _chatappbar() {
    return AppBar(
        actions: [
          PopupMenuButton(
              icon: Center(
                child: Container(
                    width: 4,
                    height: 24,
                    child: Image.asset(ImagePath.popupmenu)),
              ),
              itemBuilder: (context) => [
                    PopupMenuItem(
                      child: Text("Voice Call"),
                    ),
                    PopupMenuItem(
                      child: Text("Video Call"),
                    ),
                  ])
        ],
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: EdgeInsets.all(12.0),
            child: Image.asset(
              ImagePath.leftArrow,
              height: 15,
              width: 15,
              color: Color(0xff2C3E50),
            ),
          ),
        ),
        centerTitle: true,
        title: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 1),
              child: Container(
                width: 50,
                height: 50,
                child: CircleAvatar(
                  backgroundImage: AssetImage(ImagePath.notify2),
                ),
              ),
            ),
            SizedBox(
              width: 11,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Joseph wind',
                  style: headerstyle.copyWith(
                      fontSize: 18, fontWeight: FontWeight.w400),
                ),
                Text(
                  'Online',
                  style: onlinenow,
                )
              ],
            )
          ],
        ));
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

class ChatMessage {
  String messageContent;
  String messageType;
  ChatMessage({required this.messageContent, required this.messageType});
}
