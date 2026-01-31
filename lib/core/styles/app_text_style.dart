import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_colors.dart';

abstract class AppTextStyle{


  static TextStyle textStyleFont18BlackBold ()=> GoogleFonts.montserrat(
    textStyle: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 18.sp,
    ),

  );

  static TextStyle textStyleFont20BlackBold ()=> GoogleFonts.montserrat(
    textStyle: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 20.sp,
    ),

  );
  static TextStyle textStyleFont16BlackBold ()=> GoogleFonts.montserrat(
    textStyle: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16.sp,
    ),

  );
  static TextStyle textStyleFont14BlackRegular ()=> GoogleFonts.montserrat(
    textStyle: TextStyle(
      fontSize: 14.sp,
    ),

  );
  static TextStyle textStyleFont12BlackRegular ()=> GoogleFonts.montserrat(
    textStyle: TextStyle(
      fontSize: 12.sp,
    ),

  );
  static TextStyle textStyleFont8BlackRegular ()=> GoogleFonts.montserrat(
    textStyle: TextStyle(
      fontSize: 8.sp,
    ),

  );
  static TextStyle textStyleFont18WhiteBold ()=> GoogleFonts.montserrat(
    textStyle: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 18.sp,
      color: Colors.white
    ),

  );
  static TextStyle textStyleFont24BlackBold ()=> GoogleFonts.montserrat(
    textStyle: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 24.sp,
    ),

  );
  static TextStyle titleTextStyle ()=> GoogleFonts.montserrat(
    textStyle: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 36.sp,
    ),

  );
  static TextStyle textStyleFont18PrimaryBold ()=> GoogleFonts.montserrat(
    textStyle: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 18.sp,
      color: AppColors.kPrimaryColor,
    ),

  );


  static TextStyle textStyleFont18GreyBold ()=> GoogleFonts.montserrat(
    textStyle: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 18.sp,
      color: AppColors.kInactiveTextColor1,
    ),

  );

  static TextStyle textStyleFont18GreyNormal ()=> GoogleFonts.montserrat(
    textStyle: TextStyle(
      fontSize: 18.sp,
      color: AppColors.kInactiveTextColor1
    ),

  );



  static TextStyle textStyleFont14GreyNormal ()=> GoogleFonts.montserrat(
    textStyle: TextStyle(
        fontSize: 14.sp,
        color: AppColors.kInactiveTextColor1
    ),

  );

  static TextStyle inputFieldHintStyle ()=> GoogleFonts.montserrat(
    textStyle: TextStyle(
        fontSize: 12.sp,
        color: AppColors.kInactiveTextColor1
    ),

  );
}