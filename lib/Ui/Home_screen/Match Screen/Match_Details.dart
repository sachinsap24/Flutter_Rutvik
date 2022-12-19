import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:matrimonial_app/Executive%20Ui/widget/submit_button.dart';
import 'package:matrimonial_app/Utils/image_path_constants.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class MatchDetails extends StatefulWidget {
  String? image1;
  String? image2;
  MatchDetails({Key? key, this.image1, this.image2}) : super(key: key);

  @override
  State<MatchDetails> createState() => _MatchDetailsState();
}

class _MatchDetailsState extends State<MatchDetails> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("image get :::: ${widget.image2}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _matchappbar(),
          Container(
            decoration: BoxDecoration(
                image:
                    DecorationImage(image: AssetImage(ImagePath.MatchImgBg))),
            height: 138,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    image: (widget.image1!.isNotEmpty)
                        ? DecorationImage(
                            image: NetworkImage(widget.image1.toString()),
                            fit: BoxFit.cover)
                        : DecorationImage(
                            image: AssetImage(ImagePath.femaleProfileUser),
                            // "https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/1024px-No_image_available.svg.png"),
                          ),
                    shape: BoxShape.circle,
                  ),
                  height: 130,
                  width: 100,
                ),
                SizedBox(
                  width: 35,
                ),
                Container(
                  decoration: BoxDecoration(
                    image: (widget.image2!.isNotEmpty)
                        ? DecorationImage(
                            image: CachedNetworkImageProvider(
                                widget.image2.toString()),
                            fit: BoxFit.cover)
                        : DecorationImage(
                            image: AssetImage(ImagePath.femaleProfileUser),
                            // "https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/1024px-No_image_available.svg.png"),
                          ),
                    shape: BoxShape.circle,
                  ),
                  height: 130,
                  width: 100,
                )
              ],
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                ImagePath.note,
                color: Colors.black,
                height: 20,
              ),
              SizedBox(
                width: 8,
              ),
              Text(
                "Kundli - 35%🔥",
                style: TextStyle(
                    fontSize: 16,
                    color: Color(0xff333333),
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Text(
                    "Varna - 5%",
                    style: TextStyle(
                        fontSize: 14,
                        color: Color(0xff333333),
                        fontWeight: FontWeight.w400),
                  ),
                  Text(
                    "Vasya - 12%",
                    style: TextStyle(
                        fontSize: 14,
                        color: Color(0xff333333),
                        fontWeight: FontWeight.w400),
                  ),
                  Text(
                    "Tara - 8%",
                    style: TextStyle(
                        fontSize: 14,
                        color: Color(0xff333333),
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
              Container(
                  height: 50,
                  child: VerticalDivider(
                    color: Color(0xff333333).withOpacity(0.15),
                    thickness: 1,
                  )),
              Column(
                children: [
                  Text(
                    "Varna - 5%",
                    style: TextStyle(
                        fontSize: 14,
                        color: Color(0xff333333),
                        fontWeight: FontWeight.w400),
                  ),
                  Text(
                    "Vasya - 8%",
                    style: TextStyle(
                        fontSize: 14,
                        color: Color(0xff333333),
                        fontWeight: FontWeight.w400),
                  ),
                  Text(
                    "Tara - 4%",
                    style: TextStyle(
                        fontSize: 14,
                        color: Color(0xff333333),
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Divider(
            color: Color(0xff333333).withOpacity(0.15),
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                ImagePath.foodHobies,
                color: Colors.black,
                height: 23,
              ),
              SizedBox(
                width: 8,
              ),
              Text(
                "Food Habits - 30%🔥",
                style: TextStyle(
                    fontSize: 16,
                    color: Color(0xff333333),
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Text("Varna - 5%"),
                  Text("Vasya - 12%"),
                  Text("Tara - 8%"),
                ],
              ),
              Container(
                  height: 50,
                  child: VerticalDivider(
                    color: Color(0xff333333).withOpacity(0.15),
                    thickness: 1,
                  )),
              Column(
                children: [
                  Text("Varna - 5%"),
                  Text("Vasya - 8%"),
                  Text("Tara - 4%"),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Divider(
            color: Color(0xff333333).withOpacity(0.15),
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                ImagePath.bag,
                color: Colors.black,
                height: 20,
              ),
              SizedBox(
                width: 8,
              ),
              Text(
                "Occupation - 25%🔥",
                style: TextStyle(
                    fontSize: 16,
                    color: Color(0xff333333),
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "IT Field - 15%",
                style: TextStyle(
                    fontSize: 14,
                    color: Color(0xff333333),
                    fontWeight: FontWeight.w400),
              ),
              Container(
                  height: 20,
                  child: VerticalDivider(
                    color: Color(0xff333333).withOpacity(0.15),
                    thickness: 1,
                  )),
              Text(
                "Engineer - 10%",
                style: TextStyle(
                    fontSize: 14,
                    color: Color(0xff333333),
                    fontWeight: FontWeight.w400),
              ),
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Divider(
            color: Color(0xff333333).withOpacity(0.15),
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                ImagePath.people,
                color: Colors.black,
                height: 20,
              ),
              SizedBox(
                width: 8,
              ),
              Text(
                "Cast - 25%🔥",
                style: TextStyle(
                    fontSize: 16,
                    color: Color(0xff333333),
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Brahmin - 13%",
                style: TextStyle(
                    fontSize: 14,
                    color: Color(0xff333333),
                    fontWeight: FontWeight.w400),
              ),
              Container(
                  height: 20,
                  child: VerticalDivider(
                    color: Color(0xff333333).withOpacity(0.15),
                    thickness: 1,
                  )),
              Text(
                "Brahmin - 12%",
                style: TextStyle(
                    fontSize: 14,
                    color: Color(0xff333333),
                    fontWeight: FontWeight.w400),
              ),
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Divider(
            color: Color(0xff333333).withOpacity(0.15),
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                ImagePath.people,
                color: Colors.black,
                height: 20,
              ),
              SizedBox(
                width: 8,
              ),
              Text(
                "Gotra - 30%🔥",
                style: TextStyle(
                    fontSize: 16,
                    color: Color(0xff333333),
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Angad - 20%",
                style: TextStyle(
                    fontSize: 14,
                    color: Color(0xff333333),
                    fontWeight: FontWeight.w400),
              ),
              Container(
                  height: 20,
                  child: VerticalDivider(
                    color: Color(0xff333333).withOpacity(0.15),
                    thickness: 1,
                  )),
              Text(
                "Angirasa - 10%",
                style: TextStyle(
                    fontSize: 14,
                    color: Color(0xff333333),
                    fontWeight: FontWeight.w400),
              ),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child:
                CommonButton(btnName: "Move to In Progress", btnOnTap: () {}),
          ),
        ],
      ),
    );
  }

  _matchappbar() {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      height: 70,
      child: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: InkWell(
              onTap: () async {
                if (Platform.isAndroid) {
                  var url = widget.image2.toString();
                  var response = await get(Uri.parse(url));
                  final documentDirectory =
                      (await getExternalStorageDirectory())!.path;
                  File imgFile = new File('$documentDirectory/flutter.png');
                  imgFile.writeAsBytesSync(response.bodyBytes);

                  Share.shareFiles(
                    [('$documentDirectory/flutter.png')],
                    subject: 'URL conversion + Share',
                  );
                } else {}
              },
              child: Image.asset(
                ImagePath.shareframe,
                color: Colors.black,
                height: height * 0.020,
                width: width * 0.070,
              ),
            ),
          )
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Align(
          alignment: Alignment.center,
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Image.asset(
              ImagePath.backArrow,
              color: Colors.black,
              width: width * 0.070,
              height: height * 0.05,
            ),
          ),
        ),
      ),
    );
  }
}
