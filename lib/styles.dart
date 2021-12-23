import 'package:flutter/material.dart';

class FontWeights {
  FontWeights._();

  static const thin = FontWeight.w100;
  static const extraLight = FontWeight.w200;
  static const light = FontWeight.w300;
  static const normal = FontWeight.normal;
  static const medium = FontWeight.w500;
  static const semiBold = FontWeight.w600;
  static const bold = FontWeight.bold;
  static const extraBold = FontWeight.w800;
  static const black = FontWeight.w900;
}

Color primaryBlue = const Color(0xff2972ff);
Color textBlack = const Color(0xff222222);
Color textGrey = const Color(0xff94959b);
Color textWhiteGrey = const Color(0xfff1f1f5);

const kNoteHeadLine = TextStyle(
  fontWeight: FontWeights.bold,
  color: Colors.black,
  fontSize: 24,
);

const kNoteBodyText2 = TextStyle(
  fontWeight: FontWeights.bold,
  color: Colors.black,
  fontSize: 20,
);

const kNoteBodyText1 = TextStyle(
  fontWeight: FontWeights.normal,
  color: Colors.black,
  fontSize: 18,
);

const kNoteSubTitle = TextStyle(
  fontWeight: FontWeights.normal,
  color: Colors.black,
  fontSize: 14,
);

const kNoteTitle = TextStyle(
  color: Colors.white,
  fontSize: 30,
  fontWeight: FontWeights.bold,
);

TextStyle kNoteHeading6 = const TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.w600,
);

TextStyle kNoteHeading5 = const TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.w600,
);

TextStyle kNoteRegular = const TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.w400,
);
