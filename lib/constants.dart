import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const backgroundBlue = Color(0XFF252C4B);
const headerBlue = Color(0XFF36416F);
const textWhite = Color(0xFFEAEAEA);
const textGreen = Color(0XFF48ACA2);
const textGrey = Color(0XFF929BC3);
const buttonBlue = Color(0xFFEAF4FE);
const correctGreen = Color(0xFF5FC521);
const incorrectRed = Color(0XFFE51937);

TextStyle headingTextStyle = GoogleFonts.poppins(
  color: textWhite,
  fontSize: 18.0,
  fontWeight: FontWeight.bold,
);

TextStyle buttonTextStyle = GoogleFonts.poppins(
  color: textGreen,
  fontSize: 16.0,
  fontWeight: FontWeight.w700,
);

TextStyle bodyTextStyle = GoogleFonts.poppins(
  color: textWhite,
  fontSize: 15.0,
  fontWeight: FontWeight.normal,
);

TextStyle questionHeadingTextStyle = GoogleFonts.poppins(
  color: textWhite,
  fontSize: 20,
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

var gradient = const LinearGradient(
  colors: [Color(0xFF44ABA7), Color(0XFF66DCA0)],
  begin: Alignment.bottomLeft,
  end: Alignment.topRight,
);
