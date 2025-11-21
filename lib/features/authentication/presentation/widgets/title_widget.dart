import 'package:flutter/material.dart';

import '../../../../core/styles/app_text_style.dart';

class TitleWidget extends StatelessWidget {
  final String titleText;
  const TitleWidget({
    super.key,
    required this.titleText,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      titleText,
      style: AppTextStyle.titleTextStyle(),
    );
  }
}
