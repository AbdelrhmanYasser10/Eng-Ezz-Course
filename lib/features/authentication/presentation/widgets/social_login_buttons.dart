import 'package:flutter/material.dart';

import '../../../../core/components/space_widget.dart';
import 'social_button.dart';

class SocialLoginButtons extends StatelessWidget {
  const SocialLoginButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SocialButton(
          imageLink:"assets/images/google 1.png" ,
        ),
        HorizontalSpace(space: 10),
        SocialButton(
          imageLink:"assets/images/apple 1.png" ,
        ),
        HorizontalSpace(space: 10),
        SocialButton(
          imageLink:"assets/images/facebook-app-symbol 1.png" ,
        ),
      ],
    );
  }
}
