import 'dart:io';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:matrimonial_app/Ui/Drawer/AccountSettingScreen/account_screen.dart';
import 'package:matrimonial_app/Utils/image_path_constants.dart';
import 'package:matrimonial_app/Utils/text_styles.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Core/Constant/value_constants.dart';

class Chat_screen extends StatefulWidget {
  String? name;
  String? image;
  String? chatId;
  Function? onBack;

  Chat_screen({Key? key, this.name, this.image, this.chatId, this.onBack})
      : super(key: key);

  @override
  State<Chat_screen> createState() => _Chat_screenState();
}

class _Chat_screenState extends State<Chat_screen> {
  int? changeIndex;
  List chatData = [];
  TextEditingController chatController = TextEditingController();
  File? file;

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
  String userId = "";

  @override
  void initState() {
    // getChatData();
    getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
        .collection('Chats')
        .where("chatId", isEqualTo: widget.chatId)
        .orderBy('time', descending: true)
        .snapshots();
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _chatappbar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: StreamBuilder(
                stream: _usersStream,
                builder: (
                  BuildContext context,
                  AsyncSnapshot snapshot,
                ) {
                  if (snapshot.hasData) {
                    /*   return ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: snapshot.data.length,
                      shrinkWrap: true,
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Container(
                              padding: EdgeInsets.only(
                                  left: 14, right: 14, top: 10, bottom: 10),
                              child: Align(
                                alignment:
                                    (userId == snapshot.data[index]["user"]
                                        ? Alignment.topRight
                                        : Alignment.topLeft),
                                child: snapshot.data[index]["isImage"]
                                    ? Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  color: Colors.grey,
                                                ),
                                                height: 150,
                                                width: 200,
                                                child: Image.network(
                                                  snapshot.data[index]["image"],
                                                  fit: BoxFit.cover,
                                                )),
                                          ),
                                          Text(
                                            DateFormat('kk:mm').format(
                                                (snapshot.data[index]["time"])
                                                    .toDate()),
                                            style: TextStyle(fontSize: 10),
                                          ),
                                        ],
                                      )
                                    : Container(
                                        decoration: BoxDecoration(
                                          border: userId !=
                                                  snapshot.data[index]["user"]
                                              ? Border.all(
                                                  color: Color(0xffEBEBEB))
                                              : Border.all(color: currentColor),
                                          borderRadius: userId !=
                                                  snapshot.data[index]["user"]
                                              ? BorderRadius.only(
                                                  topLeft: Radius.circular(13),
                                                  topRight: Radius.circular(13),
                                                  bottomRight:
                                                      Radius.circular(13))
                                              : BorderRadius.only(
                                                  topLeft: Radius.circular(13),
                                                  topRight: Radius.circular(13),
                                                  bottomLeft:
                                                      Radius.circular(13),
                                                  bottomRight:
                                                      Radius.circular(13)),
                                          color: (userId !=
                                                  snapshot.data[index]["user"]
                                              ? Colors.white
                                              : currentColor),
                                        ),
                                        padding: EdgeInsets.all(16),
                                        child: Text(
                                          snapshot.data[index]["msg"],
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w400,
                                              color: userId !=
                                                      snapshot.data[index]
                                                          ["user"]
                                                  ? Colors.black
                                                  : Colors.white),
                                        ),
                                      ),
                              ),
                            ),
                            Align(
                                alignment:
                                    userId != snapshot.data[index]["user"]
                                        ? Alignment.bottomLeft
                                        : Alignment.bottomRight,
                                child: Padding(
                                  padding:
                                      userId != snapshot.data[index]["user"]
                                          ? EdgeInsets.only(left: 15)
                                          : EdgeInsets.only(right: 15),
                                  child: Text(
                                    DateFormat('kk:mm').format(
                                        (snapshot.data[index]["time"])
                                            .toDate()),
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xff3A3A3A)),
                                  ),
                                ))
                          ],
                        );
                      },
                    );*/
                    return ListView(
                      reverse: true,
                      children: snapshot.data!.docs
                          .map<Widget>((DocumentSnapshot document) {
                        Map<String, dynamic> data =
                            document.data()! as Map<String, dynamic>;
                        return Column(
                          children: [
                            Container(
                              padding: EdgeInsets.only(
                                  left: 14, right: 14, top: 10, bottom: 10),
                              child: Align(
                                alignment: (userId == data["user"]
                                    ? Alignment.topRight
                                    : Alignment.topLeft),
                                child: data["isImage"]
                                    ? Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  color: Colors.grey,
                                                ),
                                                height: 150,
                                                width: 200,
                                                child: Image.network(
                                                  data["image"],
                                                  fit: BoxFit.cover,
                                                )),
                                          ),
                                        ],
                                      )
                                    : Container(
                                        decoration: BoxDecoration(
                                          border: userId != data["user"]
                                              ? Border.all(
                                                  color: Color(0xffEBEBEB))
                                              : Border.all(color: currentColor),
                                          borderRadius: userId != data["user"]
                                              ? BorderRadius.only(
                                                  topLeft: Radius.circular(13),
                                                  topRight: Radius.circular(13),
                                                  bottomRight:
                                                      Radius.circular(13))
                                              : BorderRadius.only(
                                                  topLeft: Radius.circular(13),
                                                  topRight: Radius.circular(13),
                                                  bottomLeft:
                                                      Radius.circular(13),
                                                  bottomRight:
                                                      Radius.circular(13)),
                                          color: (userId != data["user"]
                                              ? Colors.white
                                              : currentColor),
                                        ),
                                        padding: EdgeInsets.all(16),
                                        child: Text(
                                          data["msg"],
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w400,
                                              color: userId != data["user"]
                                                  ? Colors.black
                                                  : Colors.white),
                                        ),
                                      ),
                              ),
                            ),
                            Align(
                                alignment: userId != data["user"]
                                    ? Alignment.bottomLeft
                                    : Alignment.bottomRight,
                                child: Padding(
                                  padding: userId != data["user"]
                                      ? EdgeInsets.only(left: 15)
                                      : EdgeInsets.only(right: 15),
                                  child: Text(
                                    DateFormat('kk:mm')
                                        .format((data["time"]).toDate()),
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xff3A3A3A)),
                                  ),
                                ))
                          ],
                        );
                      }).toList(),
                    );
                  } else {
                    return Center(child: Text("No Data"));
                  }
                }),
          ),
          Container(
            margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /*  Text(
                  "Joseph wind is typing...",
                  style: TextStyle(
                      color: Color(
                        0xff3A4167,
                      ),
                      fontSize: 13,
                      fontWeight: FontWeight.w500),
                ),*/ /*  Text(
                  "Joseph wind is typing...",
                  style: TextStyle(
                      color: Color(
                        0xff3A4167,
                      ),
                      fontSize: 13,
                      fontWeight: FontWeight.w500),
                ),*/
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
                          // Container(
                          //   width: 25,
                          //   height: 25,
                          //   child: Image.asset(ImagePath.smily),
                          // ),
                          // Padding(
                          //     padding: const EdgeInsets.only(
                          //         top: 10, bottom: 10, left: 10, right: 10),
                          //     child: Container(
                          //       height: 60,
                          //       width: 1,
                          //       color: Color(0xffBCBCBC),
                          //     )),
                          GestureDetector(
                            onTap: () {
                              getImageFromGallery();
                            },
                            child: Container(
                              width: 25,
                              height: 25,
                              child: Image.asset(ImagePath.sharefile),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 10),
                      Expanded(
                          child: TextField(
                        controller: chatController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Type here....',
                          suffixIcon: GestureDetector(
                            onTap: () {
                              if (chatController.text.isNotEmpty) {
                                setMsg();
                              }
                            },
                            child: Container(
                                padding: EdgeInsets.all(8),
                                width: 15,
                                height: 15,
                                child: Image.asset(ImagePath.shareImage)),
                          ),
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
                  backgroundImage: NetworkImage(widget.image.toString()),
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
                Container(
                  width: MediaQuery.of(context).size.width * 0.45,
                  child: Text(
                    widget.name.toString(),
                    overflow: TextOverflow.fade,
                    style: headerstyle.copyWith(
                        fontSize: 18, fontWeight: FontWeight.w400),
                  ),
                ),
                /*Text(
                  'Online',
                  style: onlinenow,
                )*/
              ],
            )
          ],
        ));
  }

  void getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    userId = await prefs.getString(USER_ID)!;
  }

  void setMsg() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    firestore.collection("Chats").add({
      "user": userId,
      "msg": chatController.text,
      "chatId": widget.chatId,
      "time": DateTime.now(),
      "image": "",
      "isImage": false,
    });
    setLastMsg(chatController.text);

    chatController.clear();
  }

  void getImageFromGallery() async {
    final storageRef = FirebaseStorage.instance.ref();
    ImagePicker imagePicker = ImagePicker();
    final XFile? image =
        await imagePicker.pickImage(source: ImageSource.gallery);
    file = File(image!.path);
    final imagesRef = storageRef.child("images/");
    final TaskSnapshot snapshot = await imagesRef
        .child(file.toString().split("/").last.toString())
        .putFile(file!);

    final String url = await imagesRef
        .child(file.toString().split("/").last.toString())
        .getDownloadURL();
    print("The download URL is " + url);
    setImage(url);
  }

  void setImage(url) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    firestore.collection("Chats").add({
      "user": userId,
      "msg": chatController.text,
      "image": url,
      "isImage": true,
      "chatId": widget.chatId,
      "time": DateTime.now()
    });
    chatController.clear();
    setLastMsg("");

    // getMsg();
  }

  void setLastMsg(msg) async {
    List data = [];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    String userId = await prefs.getString(USER_ID)!;
    await firestore.collection("Users").doc(userId).get().then((value) {
      setState(() {
        data = value.data()!["chats"];
        data.forEach((element) {
          if (element["chatId"] == widget.chatId) {
            setState(() {
              element["lastMsg"] = msg == "" ? "Image" : msg;
              element["lastMsgTime"] = DateTime.now();
            });
          }
        });
      });
    });

    await firestore.collection("Users").doc(userId).set({
      "chats": data,
    }, SetOptions(merge: true));
    if (widget.onBack != null) {
      widget.onBack!();
    }
    ;
  }

// void getChatData() async {
//   FirebaseFirestore firestore = FirebaseFirestore.instance;
//
//   firestore.collection("Chats").doc(widget.chatId).get().then((value) {
//     firestore
//         .collection("Chats")
//         .where("chatId", isEqualTo: widget.chatId)
//         .orderBy('time', descending: true)
//         .get()
//         .then((value) {
//       value.docs.forEach((element) {
//         if (element.data().isNotEmpty) {
//
//           setState(() {
//             chatData.add(element.data());
//           });
//         }
//
//       });
//     });
//   });
// }
}

class ChatMessage {
  String messageContent;
  String messageType;

  ChatMessage({required this.messageContent, required this.messageType});
}


/* import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:matrimonial_app/Ui/Drawer/AccountSettingScreen/account_screen.dart';
import 'package:matrimonial_app/Utils/image_path_constants.dart';
import 'package:matrimonial_app/Utils/text_styles.dart';

class Chat_screen extends StatefulWidget {
  String? name;
  String? image;
  String? chatId;
  Function? onBack;
  Chat_screen({Key? key, this.name, this.image, this.chatId, this.onBack}) : super(key: key);

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
                  backgroundImage: (widget.image != null &&
                          widget.image!.isNotEmpty)
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
 */