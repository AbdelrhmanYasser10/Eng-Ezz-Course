import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_style.dart';

class FormFooter extends StatelessWidget {
  final String hintText;
  final String linkText;
  final Widget replacedScreen;
  const FormFooter({
    super.key,
    required this.hintText,
    required this.replacedScreen,
    required this.linkText,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RichText(
        text: TextSpan(
          text: hintText,
          style: AppTextStyle.textStyleFont14GreyNormal(),
          children: [
            TextSpan(
              text: linkText,
              style: AppTextStyle.textStyleFont14GreyNormal().copyWith(
                color: AppColors.kPrimaryColor,
                fontWeight: FontWeight.bold,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {

                  // Perform an action here
                  Navigator.pushReplacement(context,MaterialPageRoute(builder: (_)=>replacedScreen));
                },
            ),
          ],
        ),
      ),
    );
  }
}
