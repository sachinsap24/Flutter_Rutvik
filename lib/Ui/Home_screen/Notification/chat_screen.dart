import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:matrimonial_app/Ui/Drawer/AccountSettingScreen/account_screen.dart';
import 'package:matrimonial_app/Utils/image_path_constants.dart';
import 'package:matrimonial_app/Utils/text_styles.dart';

class Chat_screen extends StatefulWidget {
  String? name;
  String? image;
  Chat_screen({Key? key, this.name, this.image}) : super(key: key);

  @override
  State<Chat_screen> createState() => _Chat_screenState();
}

class _Chat_screenState extends State<Chat_screen> {
  int? changeIndex;
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
  void initState() {
    super.initState();
    print("image ===> ${widget.image}");
  }

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
                                : Border.all(color: currentColor),
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
                                : currentColor),
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
                          Container(
                            width: 25,
                            height: 25,
                            child: Image.asset(ImagePath.sharefile),
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
                  backgroundImage: (widget.image!.isNotEmpty)
                      ? NetworkImage(widget.image.toString())
                      : NetworkImage(
                          "https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/1024px-No_image_available.svg.png"),
                ),
              ),
            ),
            SizedBox(
              width: 11,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.name.toString(),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: headerstyle.copyWith(
                        fontSize: 18, fontWeight: FontWeight.w400),
                  ),
                  Text(
                    'Online',
                    style: onlinenow,
                  )
                ],
              ),
            )
          ],
        ));
  }
}

class ChatMessage {
  String messageContent;
  String messageType;
  ChatMessage({required this.messageContent, required this.messageType});
}
