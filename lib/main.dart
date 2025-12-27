import 'package:e_commerce_app_session_it_sharks/features/authentication/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:e_commerce_app_session_it_sharks/features/home/presentation/manager/product_cubit/product_cubit.dart';
import 'package:e_commerce_app_session_it_sharks/features/splash/presentation/manager/splash_cubit/splash_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/splash/presentation/pages/splash_page.dart';
import 'injection_container.dart' as di;

void main() async {
  // To ensure the native code generated
  WidgetsFlutterBinding.ensureInitialized();

  await di.initialize();



  runApp(ECommerceApp());
}

class ECommerceApp extends StatelessWidget {
  const ECommerceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => di.sl<AuthCubit>(),
        ),
        BlocProvider(
          create: (context) => di.sl<SplashCubit>()..isPassedOnBoarding(),
        ),
        BlocProvider(
          create: (context) => ProductCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashPage(),
      ),
    );
  }
}

