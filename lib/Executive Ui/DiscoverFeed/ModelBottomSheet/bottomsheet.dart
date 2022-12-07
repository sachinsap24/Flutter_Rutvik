import 'package:flutter/material.dart';
import 'package:matrimonial_app/Utils/app_constants.dart';
import 'package:matrimonial_app/Utils/image_path_constants.dart';

class FeedBottomSheet extends StatefulWidget {
  const FeedBottomSheet({Key? key}) : super(key: key);

  @override
  State<FeedBottomSheet> createState() => _FeedBottomSheetState();
}

class _FeedBottomSheetState extends State<FeedBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 298,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
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
            SizedBox(height: 15),
            Row(
              children: [
                SizedBox(width: 5),
                Flexible(
                  flex: 3,
                  child: Container(
                    height: 73,
                    width: 104,
                    decoration: BoxDecoration(
                      color: Color(0xffF8F8F8),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Color(0xffECECEC)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(ImagePath.unfollow, height: 24, width: 24),
                        SizedBox(height: 4),
                        Text(
                          AppConstants.unfollow,
                          style: TextStyle(
                              color: Color(0xff3E3E3E),
                              fontSize: 13,
                              fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 5),
                Spacer(),
                Flexible(
                  flex: 3,
                  child: Container(
                    height: 73,
                    width: 104,
                    decoration: BoxDecoration(
                      color: Color(0xffF8F8F8),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Color(0xffECECEC)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(ImagePath.link, height: 24, width: 24),
                        SizedBox(height: 4),
                        Text(
                          AppConstants.link,
                          style: TextStyle(
                              color: Color(0xff3E3E3E),
                              fontSize: 13,
                              fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 5),
                Spacer(),
                Flexible(
                  flex: 3,
                  child: Container(
                    height: 73,
                    width: 104,
                    decoration: BoxDecoration(
                      color: Color(0xffF8F8F8),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Color(0xffECECEC)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(ImagePath.reportImage,
                            height: 24, width: 24),
                        SizedBox(height: 4),
                        Text(
                          AppConstants.reportText,
                          style: TextStyle(
                              color: Color(0xffFF5858),
                              fontSize: 13,
                              fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 5),
              ],
            ),
            SizedBox(height: 15),
            Container(
              height: 87,
              decoration: BoxDecoration(
                color: Color(0xffF8F8F8),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Color(0xffECECEC)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Center(
                      child: Text(
                    AppConstants.seeYourPost,
                    style: TextStyle(
                        color: Color(0xff000000),
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                  )),
                  Container(
                    color: Color(0xffEDEDED),
                    height: 1,
                  ),
                  Center(
                      child: Text(
                    AppConstants.hide,
                    style: TextStyle(
                        color: Color(0xff000000),
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                  )),
                ],
              ),
            ),
            SizedBox(height: 15),
            Container(
              height: 40,
              decoration: BoxDecoration(
                color: Color(0xffF8F8F8),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Color(0xffECECEC)),
              ),
              child: Center(
                  child: Text(
                AppConstants.cancle,
                style: TextStyle(
                    color: Color(0xff000000),
                    fontSize: 15,
                    fontWeight: FontWeight.w500),
              )),
            )
          ],
        ),
      ),
    );
  }
}
