import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

abstract class AppTextStyle{


  static TextStyle textStyleFont18BlackBold ()=> GoogleFonts.montserrat(
    textStyle: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 18.0,
    ),

  );

  static TextStyle textStyleFont20BlackBold ()=> GoogleFonts.montserrat(
    textStyle: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 20.0,
    ),

  );
  static TextStyle textStyleFont16BlackBold ()=> GoogleFonts.montserrat(
    textStyle: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16.0,
    ),

  );
  static TextStyle textStyleFont14BlackRegular ()=> GoogleFonts.montserrat(
    textStyle: TextStyle(
      fontSize: 14.0,
    ),

  );
  static TextStyle textStyleFont12BlackRegular ()=> GoogleFonts.montserrat(
    textStyle: TextStyle(
      fontSize: 12.0,
      color: Colors.black,
    ),

  );
  static TextStyle textStyleFont18WhiteBold ()=> GoogleFonts.montserrat(
    textStyle: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 18.0,
      color: Colors.white
    ),

  );
  static TextStyle textStyleFont24BlackBold ()=> GoogleFonts.montserrat(
    textStyle: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 24.0,
    ),

  );
  static TextStyle titleTextStyle ()=> GoogleFonts.montserrat(
    textStyle: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 36.0,
    ),

  );
  static TextStyle textStyleFont18PrimaryBold ()=> GoogleFonts.montserrat(
    textStyle: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 18.0,
      color: AppColors.kPrimaryColor,
    ),

  );


  static TextStyle textStyleFont18GreyBold ()=> GoogleFonts.montserrat(
    textStyle: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 18.0,
      color: AppColors.kInactiveTextColor1,
    ),

  );

  static TextStyle textStyleFont18GreyNormal ()=> GoogleFonts.montserrat(
    textStyle: TextStyle(
      fontSize: 18.0,
      color: AppColors.kInactiveTextColor1
    ),

  );



  static TextStyle textStyleFont14GreyNormal ()=> GoogleFonts.montserrat(
    textStyle: TextStyle(
        fontSize: 14.0,
        color: AppColors.kInactiveTextColor1
    ),

  );

  static TextStyle inputFieldHintStyle ()=> GoogleFonts.montserrat(
    textStyle: TextStyle(
        fontSize: 12.0,
        color: AppColors.kInactiveTextColor1
    ),

  );
}