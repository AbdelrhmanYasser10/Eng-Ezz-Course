import 'package:animate_do/animate_do.dart';
import 'package:e_commerce_app_session_it_sharks/core/network/local/secure_storage_helper.dart';
import 'package:e_commerce_app_session_it_sharks/core/network/local/shared_preferences_helper.dart';
import 'package:e_commerce_app_session_it_sharks/features/authentication/presentation/pages/login_page.dart';
import 'package:e_commerce_app_session_it_sharks/features/home/presentation/pages/home_page.dart';
import 'package:e_commerce_app_session_it_sharks/features/splash/presentation/pages/onboarding_page.dart';
import 'package:flutter/material.dart';

import '../../../../core/widgets/basic_layout.dart';


class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();

     Future.delayed(
        Duration(seconds: 4),
        () async{

          if(mounted) {
            String? accessToken = await SecureStorageHelper.getData(key: "accessToken");
            bool? isPassedOnBoarding = SharedPreferencesHelper.getDataFromCache(key: 'OnBoarding');
            if(isPassedOnBoarding == true){
              if(accessToken == null) {
                Navigator.pushAndRemoveUntil(
                  context, MaterialPageRoute(builder: (_) => LoginPage()), (
                    route) => false,);
              }
              else{
                Navigator.pushAndRemoveUntil(
                  context, MaterialPageRoute(builder: (_) => BasicLayout()), (
                    route) => false,);
              }
            }
            else {
              Navigator.pushAndRemoveUntil(
                  context, MaterialPageRoute(builder: (_) => OnBoardingPage()),(route) => false,);
            }
          }
        },
    ).then((value){
     });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FadeIn(
          delay: Duration(seconds: 1),
          duration: Duration(seconds: 2),
          controller: (value) {
            controller = value;
            if(controller.isCompleted){
              controller.repeat();
            }
          },
          child: Image.asset(
            "assets/logo/logoipsum-255 1.png"
          ),
      ),
      ),
    );
  }
}
