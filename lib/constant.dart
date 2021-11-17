import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

Color kOrange = Color(0xFFF86443);
Color kBlack = Color(0xFF061D2E);
Color kBlueDarken = Color(0xFF043E69);
Color kWhite = Color(0xFFFEFEFE);

class NendaStyles {
  static TextStyle fontDisplay = GoogleFonts.raleway(
    fontSize: 50,
    color: kBlack,
    fontWeight: FontWeight.w900,
  );

  static TextStyle fontBold = GoogleFonts.raleway(
    fontSize: 24,
    color: kBlack,
    fontWeight: FontWeight.bold,
  );

  static TextStyle fontMedium = GoogleFonts.raleway(
    fontSize: 18,
    color: kBlack,
    fontWeight: FontWeight.bold,
  );

  static TextStyle fontParagraph = GoogleFonts.raleway(
    fontSize: 14,
    color: kBlack,
    fontWeight: FontWeight.bold,
  );
}
