import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const backgroundBlue = Color(0XFF121212);
const headerBlue = Color(0XFF2E2B33);
const textWhite = Color(0xFFFAFAFA);
const textGrey = Color(0XFF929BC3);
const buttonBlue = Color(0xFF006D5B);
const correctGreen = Color(0xFF5FC521);
const incorrectRed = Color(0XFFE51937);

TextStyle headingTextStyle = GoogleFonts.poppins(
  color: textWhite,
  fontSize: 16.0,
  fontWeight: FontWeight.w700,
);

TextStyle buttonTextStyle = GoogleFonts.poppins(
  color: textWhite,
  fontSize: 15.0,
  fontWeight: FontWeight.w500,
);

TextStyle bodyTextStyle = GoogleFonts.poppins(
  color: textWhite,
  fontSize: 13.0,
  fontWeight: FontWeight.normal,
);

TextStyle questionHeadingTextStyle = GoogleFonts.poppins(
  color: textGrey,
  fontSize: 15,
  fontWeight: FontWeight.bold,
);

enum TileStatus { UNSELECTED, CORRECT, INCORRECT }

String returnFormattedTime(int milli) {
  String seconds = ((milli ~/ 1000) % 60)
      .toString()
      .padLeft(2, "0"); // this is for the second
  String minutes = ((milli ~/ 1000) ~/ 60)
      .toString()
      .padLeft(2, "0"); // this is for the minute

  return "$minutes:$seconds";
}
