import 'package:dio/dio.dart';
import 'package:e_commerce_app_session_it_sharks/core/network/local/secure_storage_helper.dart';
import 'package:e_commerce_app_session_it_sharks/core/network/local/shared_preferences_helper.dart';
import 'package:e_commerce_app_session_it_sharks/core/network/remote/dio_helper.dart';
import 'package:e_commerce_app_session_it_sharks/features/authentication/data/data_sources/auth_remote_data_source.dart';
import 'package:e_commerce_app_session_it_sharks/features/authentication/data/repositories/authentication_repository_implementer.dart';
import 'package:e_commerce_app_session_it_sharks/features/authentication/domain/use_cases/login_with_email_and_password.dart';
import 'package:e_commerce_app_session_it_sharks/features/authentication/domain/use_cases/register_user_data.dart';
import 'package:e_commerce_app_session_it_sharks/features/authentication/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:e_commerce_app_session_it_sharks/features/home/presentation/manager/product_cubit/product_cubit.dart';
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
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthCubit(
            loginUseCase:LoginWithEmailAndPassword(
                repository: AuthenticationRepositoryImplementer(
                    authRemoteDataSource: AuthRemoteDataSourceWithDio(
                      dio: Dio(),
                    ),
                ),
            ) ,
            registerUseCase: RegisterUserData(
                repository: AuthenticationRepositoryImplementer(authRemoteDataSource: AuthRemoteDataSourceWithDio(dio: Dio()))),
          ),
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

