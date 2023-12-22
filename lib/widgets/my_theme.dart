
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';


class MyTheme {
  static final dark = ThemeData(
    useMaterial3: false,
    brightness: Brightness.dark,
    fontFamily: GoogleFonts.outfit().fontFamily,
    primaryColor: const Color(0xff0D0140),
    scaffoldBackgroundColor:Colors.black,
    appBarTheme: const AppBarTheme(
        backgroundColor:Colors.black,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          // <-- SEE HERE
          statusBarIconBrightness: Brightness.dark,
          //<-- For Android SEE HERE (dark icons)
          statusBarBrightness:
          Brightness.dark, //<-- For iOS SEE HERE (dark icons)
        ),
        iconTheme: IconThemeData(color: AppColors.black),
        actionsIconTheme: IconThemeData(color: AppColors.black),
        titleTextStyle: TextStyle(color: Colors.black,fontSize: 22,fontWeight: FontWeight.w500),
        elevation: 0),
    textTheme: TextTheme(
      headlineLarge: GoogleFonts.dmSans(
        fontSize: 26,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
      displayLarge: GoogleFonts.dmSans(
          fontSize: 24, color: Color(0xffFFFFFF), fontWeight: FontWeight.w700),
      displayMedium: GoogleFonts.dmSans(
          fontSize: 22, color: Colors.black, fontWeight: FontWeight.w700),
      displaySmall: GoogleFonts.dmSans(
          fontSize: 22, color: Color(0xffFFFFFF), fontWeight: FontWeight.w700),
      headlineMedium: GoogleFonts.dmSans(
          fontSize: 20, color: Colors.black, fontWeight: FontWeight.w500),
      headlineSmall: GoogleFonts.dmSans(
          fontSize: 20, color: Color(0xffFFFFFF), fontWeight: FontWeight.w500),
      titleLarge: GoogleFonts.dmSans(
          fontSize: 18, color: Colors.black, fontWeight: FontWeight.w700),
      labelMedium: GoogleFonts.dmSans(
          fontSize: 18, color: Color(0xffFFFFFF), fontWeight: FontWeight.w700),
      titleMedium: GoogleFonts.dmSans(fontSize: 16, color: Colors.black),
      titleSmall: GoogleFonts.dmSans(
          fontSize: 16, color: Color(0xffFFFFFF), fontWeight: FontWeight.w700),
      bodyLarge: GoogleFonts.dmSans(
          fontSize: 14, color: Colors.black, fontWeight: FontWeight.w400),
      bodyMedium: GoogleFonts.dmSans(
          fontSize: 14, color: Color(0xffFFFFFF), fontWeight: FontWeight.w500),
      bodySmall: GoogleFonts.dmSans(
          fontSize: 12, color: Colors.black, fontWeight: FontWeight.normal),
      labelLarge: GoogleFonts.dmSans(fontSize: 12, color: Color(0xffFFFFFF)),
      labelSmall: GoogleFonts.dmSans(fontSize: 10, color: Colors.black),
    ),
  );
}