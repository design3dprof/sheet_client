import 'package:flutter/material.dart';

class MediaSize {
  late MediaQueryData queryData;
  static double? screenHeight;
  static double? screenWidth;

  init(BuildContext context) {
    queryData = MediaQuery.of(context);
    screenHeight = queryData.size.height;
    screenWidth = queryData.size.width;
  }
}

// Colors

Color colorGrey = Colors.grey.shade300;
Color colorGreyLight = Colors.grey.shade200;
Color colorGreyWithOpacity = Colors.grey.withOpacity(0.6);
Color colorGrey50 = Colors.grey.shade50;

Color colorCyanLight = Colors.cyan.shade100;
Color colorIndigo = Colors.indigo.shade900;
Color colorDarkBlue = const Color.fromRGBO(0, 0, 60, 0.9);  //Hex #000646
const Color colorBlue = Color.fromRGBO(0, 6, 70, 1.0);
const Color colorOrange = Colors.deepOrange;
Color colorGreenDark = const Color.fromRGBO(42, 63, 30, 0.9);
Color colorLime = Colors.yellowAccent.shade700;
Color colorGreenLogo = const Color.fromRGBO(120, 196, 105, 1.0);
Color colorBlueGrey = Colors.blueGrey.shade100;


EdgeInsets setPaddingAdd = const EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0);
EdgeInsets marginLogin = const EdgeInsets.only(left: 10.0, right: 10.0);
EdgeInsets marginVertical = const EdgeInsets.only(left: 10.0, right: 30.0);
EdgeInsets marginHorizontal = const EdgeInsets.only(top: 10,bottom: 10);
EdgeInsets paddingRight = const EdgeInsets.only(right: 20.0);
EdgeInsets setPaddingStart = const EdgeInsets.only(left: 15);
EdgeInsets setPaddingBottom = const EdgeInsets.only(bottom: 15);
EdgeInsets setPaddingTop = const EdgeInsets.only(top: 25);
EdgeInsets setMargin = const EdgeInsets.all(20.0);
EdgeInsets setPadding = const EdgeInsets.all(25.0);

//Boxes

BoxDecoration boxGrey = BoxDecoration(
    shape: BoxShape.rectangle,
    color: colorGrey50,
    borderRadius: BorderRadius.circular(15),
    boxShadow: [
      BoxShadow(
        color: colorGreyWithOpacity,
        offset: Offset(10, 10),
        blurRadius: 10,
        //spreadRadius: 5,
      ),
      BoxShadow(
        color: colorGreyLight,
        offset: Offset(-10, -10),
        blurRadius: 10,
        //spreadRadius: 5,
      ),
    ]);

BoxDecoration boxLight = BoxDecoration(
    shape: BoxShape.rectangle,
    color: colorGrey50,
    borderRadius: BorderRadius.circular(15),
    boxShadow: [
      BoxShadow(
        color: colorGreyWithOpacity,
        offset: Offset(10, 10),
        blurRadius: 10,
        //spreadRadius: 5,
      ),
    ]);

//TextStyle

TextStyle textSubTitle(Color color) {
  return TextStyle(
    color: color,
    fontWeight: FontWeight.w500,
  );
}

TextStyle textTitle(Color color) {
  return TextStyle(
    fontSize: 16,
    color: color,
    fontWeight: FontWeight.w500,
  );
}

TextStyle textHead(Color color) {
  return TextStyle(
    fontSize: 20,
    color: color,
    fontWeight: FontWeight.w700,
  );
}