import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

AppFonts appFonts = AppFonts();

class AppFonts {
  final TextStyle logoTextLight = GoogleFonts.nunito(
      color: Colors.black, fontSize: 3.h, fontWeight: FontWeight.w500);

  final TextStyle logoTextDark = GoogleFonts.nunito(
      color: Colors.white, fontSize: 3.h, fontWeight: FontWeight.w500);

  final TextStyle homeGreetLight = GoogleFonts.nunito(
      color: Colors.black, fontSize: 3.5.h, fontWeight: FontWeight.bold);

  final TextStyle homeGreetDark = GoogleFonts.nunito(
      color: Colors.white, fontSize: 3.5.h, fontWeight: FontWeight.bold);

  final TextStyle containerTitleLight = GoogleFonts.nunito(
      color: Colors.black, fontSize: 2.8.h, fontWeight: FontWeight.bold);

  final TextStyle containerTitleDark = GoogleFonts.nunito(
      color: Colors.white, fontSize: 2.8.h, fontWeight: FontWeight.bold);

  final TextStyle containerDataLight = GoogleFonts.nunito(
      color: Colors.black, fontSize: 2.8.h, fontWeight: FontWeight.w400);

  final TextStyle containerDataDark = GoogleFonts.nunito(
      color: Colors.white, fontSize: 2.8.h, fontWeight: FontWeight.w400);

  final TextStyle smallInfoLight = GoogleFonts.nunito(
      color: Colors.black, fontSize: 2.h, fontWeight: FontWeight.w400);

  final TextStyle smallInfoDark = GoogleFonts.nunito(
      color: Colors.white, fontSize: 2.h, fontWeight: FontWeight.w400);
}
