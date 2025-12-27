import 'package:animate_do/animate_do.dart';
import 'package:e_commerce_app_session_it_sharks/features/authentication/presentation/pages/login_page.dart';
import 'package:e_commerce_app_session_it_sharks/features/splash/presentation/manager/splash_cubit/splash_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/basic_layout.dart';
import 'onboarding_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late AnimationController controller;


  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashCubit, SplashState>(
      listener: (context, state) {
        if(state is PassOnBoardingSuccessFully){
          context.read<SplashCubit>().getAccessToken();
        }
        else if(state is PassOnBoardingError){
          Navigator.pushAndRemoveUntil(
            context, MaterialPageRoute(builder: (_) => OnBoardingPage()),(route) => false,);
        }

        if(state is GetAccessTokenSuccessfully){
          Navigator.pushAndRemoveUntil(
            context, MaterialPageRoute(builder: (_) => BasicLayout()),(route) => false,);
        }
        else if(state is GetAccessTokenError){
          Navigator.pushAndRemoveUntil(
            context, MaterialPageRoute(builder: (_) => LoginPage()),(route) => false,);
        }

      },
      child: Scaffold(
        body: Center(
          child: FadeIn(
            delay: Duration(seconds: 1),
            duration: Duration(seconds: 2),
            controller: (value) {
              controller = value;
              if (controller.isCompleted) {
                controller.repeat();
              }
            },
            child: Image.asset("assets/logo/logoipsum-255 1.png"),
          ),
        ),
      ),
    );
  }
}
