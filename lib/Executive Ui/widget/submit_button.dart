import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class CommonButton extends StatelessWidget {
  String btnName;
  VoidCallback btnOnTap;
  CommonButton({Key? key, required this.btnName, required this.btnOnTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: btnOnTap,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 54,
        decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xffFC7358),
                Color(0xffFA2457),
              ],
            ),
            borderRadius: BorderRadius.circular(9)),
        alignment: Alignment.center,
        child: Text(
          btnName,
          style: TextStyle(
              color: Color(0xffFFFFFF),
              fontSize: 19,
              fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
