import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../styles/app_colors.dart';
import '../styles/app_text_style.dart';

class AppButton extends StatelessWidget {
  final String text;
  final double? width;
  final VoidCallback onPressed;

  const AppButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width?.w ?? double.infinity,
        height: 50.0.h,
        decoration: BoxDecoration(
          color: AppColors.kPrimaryColor,
          borderRadius: BorderRadius.circular(2.0.r),
        ),
        child: Center(
          child: Text(
            text,
            style: AppTextStyle.textStyleFont18WhiteBold(),
          ),
        ),
      ),
    );
  }
}
