import 'package:e_commerce_app_session_it_sharks/core/network/local/secure_storage_helper.dart';
import 'package:e_commerce_app_session_it_sharks/core/network/local/shared_preferences_helper.dart';
import 'package:e_commerce_app_session_it_sharks/core/network/remote/dio_helper.dart';
import 'package:e_commerce_app_session_it_sharks/features/authentication/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/splash/presentation/pages/splash_page.dart';


void main() async {
  // To ensure the native code generated
  WidgetsFlutterBinding.ensureInitialized();

  // to initialize cache database
  await SharedPreferencesHelper.initialize();

  // to initialize secure storage cache mem
  SecureStorageHelper.initializeSecureStorage();

  // to initialize API Client
  DioHelper.initialize();


  runApp(ECommerceApp());
}

class ECommerceApp extends StatelessWidget {
  const ECommerceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashPage(),
      ),
    );
  }
}

