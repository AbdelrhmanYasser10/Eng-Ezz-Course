import 'package:e_commerce_app_session_it_sharks/features/splash/presentation/manager/splash_cubit/splash_cubit.dart';
import 'package:e_commerce_app_session_it_sharks/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_style.dart';
import '../../../authentication/presentation/pages/login_page.dart';


class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {

  final PageController _pageController = PageController();
  int currentIndex = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    titles = [
      S.of(context).chooseProducts,
      S.of(context).makePayment,
      S.of(context).getYourOrder
    ];
    description = [
      S.of(context).onboardingDesc,
      S.of(context).onboardingDesc,
      S.of(context).onboardingDesc,
    ];
  }

  List<String> titles = [];
  List<String> description = [];
  List<String> images= [
    "assets/images/fashion shop-rafiki 1.png",
    "assets/images/Sales consulting-pana 1.png",
    "assets/images/Shopping bag-rafiki 1.png"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20.0.r),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text.rich(
                  TextSpan(
                    text: (currentIndex + 1 ).toString(),
                    children: [
                      TextSpan(
                        text: "/3",

                          style: AppTextStyle.textStyleFont18GreyNormal (),
                      ),

                    ],
                    style: AppTextStyle.textStyleFont18BlackBold(),
                  ),
                ),

                TextButton(
                    onPressed: (){
                      context.read<SplashCubit>().saveOnBoardingValue(true);
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=>LoginPage()), (route)=>false);
                    },

                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.all(0),
                      textStyle: AppTextStyle.textStyleFont18BlackBold(),
                      surfaceTintColor: Colors.white,
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,

                    ),
                    child: Text(S.of(context).skip,style: AppTextStyle.textStyleFont18BlackBold(),),
                )
              ],
            ),
            Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (value) {
                    setState(() {
                      currentIndex = value;
                    });
                  },
                  itemBuilder: (context,index){
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(images[index]),
                        SizedBox(
                          height: 5.0.h,
                        ),
                        Text(
                          titles[index],
                          style: AppTextStyle.textStyleFont24BlackBold(),
                          maxLines: 1,
                        ),
                        SizedBox(
                          height: 5.0.h,
                        ),
                        Text(
                          description[index],
                          maxLines: 3,
                          style: AppTextStyle.textStyleFont14GreyNormal(),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    );
                  },
                  itemCount: 3,
                ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if(currentIndex > 0)
                TextButton(
                  onPressed: (){

                      _pageController.previousPage(duration: Duration(milliseconds: 300), curve: Curves.easeIn);

                    },
                  style: TextButton.styleFrom(
                      padding: const EdgeInsets.all(0),
                      foregroundColor: AppColors.kInactiveTextColor1
                  ),
                  child: Text(
                    S.of(context).prev,
                    style: AppTextStyle.textStyleFont18GreyBold(),
                  ),
                )
                else
                  SizedBox(),

                SmoothPageIndicator(
                    controller: _pageController,  // PageController
                    count:  3,
                    effect:  ExpandingDotsEffect(
                      radius: 14.0.r,
                      dotWidth: 10.w,
                      dotHeight: 10.h,
                      activeDotColor: Colors.black,
                      spacing: 9.0.w,
                      dotColor: Colors.grey[300]!,

                    ),  // your preferred effect
                    onDotClicked: (index){
                    }
                ),

                TextButton(
                    onPressed: (){
                        if(currentIndex != 2) {
                          _pageController.nextPage(
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeIn);
                        }
                        else {
                          context.read<SplashCubit>().saveOnBoardingValue(true);
                          Navigator.pushAndRemoveUntil(context,
                              MaterialPageRoute(builder: (_) => LoginPage()), (
                                  route) => false);
                        }

                    },
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.all(0),
                    foregroundColor: AppColors.kPrimaryColor
                  ),
                    child: Text(
                        currentIndex == 2 ? S.of(context).getStarted:S.of(context).next,
                      style: AppTextStyle.textStyleFont18PrimaryBold(),
                    ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
