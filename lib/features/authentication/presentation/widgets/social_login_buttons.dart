import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../../core/components/space_widget.dart';
import '../../../../core/utils/app_toaster.dart';
import '../../../../core/widgets/basic_layout.dart';
import 'social_button.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class SocialLoginButtons extends StatelessWidget {
  const SocialLoginButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () async {
            try {
              // Trigger the authentication flow
             await GoogleSignIn.instance.initialize(
                clientId: "103272714650624970996",
                serverClientId: "52216104618-c9hna9eitkkv93vh3tgbosv956ir32u0.apps.googleusercontent.com",
              );
              final GoogleSignInAccount googleUser = await GoogleSignIn.instance.authenticate();

              // Obtain the auth details from the request
              final GoogleSignInAuthentication googleAuth = googleUser.authentication;

              // Create a new credential
              final credential = GoogleAuthProvider.credential(
                  idToken: googleAuth.idToken);


              // Once signed in, return the UserCredential
              await FirebaseAuth.instance.signInWithCredential(credential);

              Navigator.pushAndRemoveUntil(
                context, MaterialPageRoute(builder: (_) => BasicLayout()),(route) => false,);
            }catch(err){
              log(err.toString());
              showToast(
              title:"Failed to login" ,
              description: "Failed to login with your google account",
              context: context,
              isError: true
              );
            }
          },
          child: SocialButton(
            imageLink:"assets/images/google 1.png" ,
          ),
        ),
        HorizontalSpace(space: 10),
        SocialButton(
          imageLink:"assets/images/apple 1.png" ,
        ),
        HorizontalSpace(space: 10),
        GestureDetector(
          onTap:()async{
            try {
              // Trigger the sign-in flow
              final LoginResult loginResult = await FacebookAuth.instance
                  .login();

              // Create a credential from the access token
              final OAuthCredential facebookAuthCredential = FacebookAuthProvider
                  .credential(loginResult.accessToken!.tokenString);


              await FirebaseAuth.instance.signInWithCredential(
                  facebookAuthCredential);
              Navigator.pushAndRemoveUntil(
                context, MaterialPageRoute(builder: (_) => BasicLayout()),(route) => false,);
            }catch(err){
              log(err.toString());
              showToast(
                  title:"Failed to login" ,
                  description: "Failed to login with your facebook account",
                  context: context,
                  isError: true
              );
            }
          },
          child:SocialButton(
            imageLink:"assets/images/facebook-app-symbol 1.png" ,
          ),
        ),
      ],
    );
  }
}
