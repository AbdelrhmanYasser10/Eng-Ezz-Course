import 'package:e_commerce_app_session_it_sharks/core/components/space_widget.dart';
import 'package:e_commerce_app_session_it_sharks/core/styles/app_text_style.dart';
import 'package:flutter/material.dart';

import '../../../../core/components/app_button.dart';
import '../../../../core/components/input_field.dart';
import '../widgets/form_footer.dart';
import '../widgets/social_login_buttons.dart';
import '../widgets/title_widget.dart';


class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding:  EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TitleWidget(
              titleText: "Welcome\nBack!",
            ),
            const VerticalSpace(
              space: 30.0,
            ),
            InputField(
              controller: TextEditingController(),
              prefixIcon: Icons.person,
              hintText:"Username or Email",
            ),
            const VerticalSpace(
              space: 10.0,
            ),
            InputField(
              controller: TextEditingController(),
              prefixIcon: Icons.lock,
              hintText:"Password",
              isPassword: true,
            ),
            const VerticalSpace(
              space: 50.0,
            ),
            AppButton(
              onPressed: (){},
              text: "Login",
            ),
            const VerticalSpace(
              space: 50.0,
            ),
            Center(
              child: Text(
                "- OR Continue with -",
                style: AppTextStyle.textStyleFont14GreyNormal(),
              ),
            ),

            const VerticalSpace(space: 20),
            SocialLoginButtons(),
            const VerticalSpace(space: 20),
            FormFooter(
              hintText: "Don't have account? ",
              linkText: "Register",
              replacedScreen: Scaffold(),
            ),
          ],
        ),
      ),
    );
  }
}





