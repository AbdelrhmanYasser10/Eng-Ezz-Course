import 'dart:async';

import 'package:e_commerce_app_session_it_sharks/core/network/remote/message_config.dart';
import 'package:e_commerce_app_session_it_sharks/features/home/presentation/manager/fav_cubit/fav_cubit.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:e_commerce_app_session_it_sharks/features/authentication/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:e_commerce_app_session_it_sharks/features/chats/presentation/manager/chats_cubit/chats_cubit.dart';
import 'package:e_commerce_app_session_it_sharks/features/home/presentation/manager/home_cubit/home_cubit.dart';
import 'package:e_commerce_app_session_it_sharks/features/home/presentation/manager/product_cubit/product_cubit.dart';
import 'package:e_commerce_app_session_it_sharks/features/home/presentation/manager/search_cubit/search_cubit.dart';
import 'package:e_commerce_app_session_it_sharks/features/settings/presentation/manager/settings_cubit/settings_cubit.dart';
import 'package:e_commerce_app_session_it_sharks/features/splash/presentation/manager/splash_cubit/splash_cubit.dart';
import 'package:e_commerce_app_session_it_sharks/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

import 'core/styles/app_themes.dart';
import 'features/splash/presentation/pages/splash_page.dart';
import 'injection_container.dart' as di;
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:shorebird_code_push/shorebird_code_push.dart';



void main() async {
  // To ensure the native code generated
  WidgetsFlutterBinding.ensureInitialized();

  await di.initialize();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await MessagingConfig.config();
  FirebaseMessaging.onBackgroundMessage(
    MessagingConfig.firebaseMessagningBackgroundHandler,
  );

  final updater = ShorebirdUpdater();
  // Check whether a new update is available.
  final status = await updater.checkForUpdate();

  if (status == UpdateStatus.outdated) {
    try {
      // Perform the update
      await updater.update();
    } on UpdateException catch (error) {
      // Handle any errors that occur while updating.
    }
  }

  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

  runZonedGuarded(() {
    runApp(ECommerceApp());
  }, (error, stackTrace) {
    FirebaseCrashlytics.instance.recordError(error, stackTrace);
  });
}

class ECommerceApp extends StatelessWidget {
  const ECommerceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => di.sl<AuthCubit>()),
        BlocProvider(
          create: (context) => di.sl<SplashCubit>()..isPassedOnBoarding(),
        ),
        BlocProvider(create: (context) => di.sl<ProductCubit>()),
        BlocProvider(create: (context) => di.sl<SearchCubit>()),
        BlocProvider(create: (context) => di.sl<HomeCubit>()),
        BlocProvider(create: (context) => di.sl<ChatsCubit>()),
        BlocProvider(create: (context) => di.sl<FavCubit>()..getFavProducts()),
        BlocProvider(
          create:
              (context) =>
                  di.sl<SettingsCubit>()
                    ..getCurrentAppTheme()
                    ..getAppCurrentLocale(),
        ),
      ],
      child: BlocConsumer<SettingsCubit, SettingsState>(
        listener: (context, state) {},
        builder: (context, state) {
          return ScreenUtilInit(
            designSize: const Size(375, 812),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (_, child) {
              return MaterialApp(
                localizationsDelegates: [
                  S.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: [Locale('en'), Locale('ar')],
                locale: Locale(context.read<SettingsCubit>().languageCode),
                theme: AppThemes.lightTheme,
                darkTheme: AppThemes.darkTheme,
                themeMode:
                    context.read<SettingsCubit>().isDark
                        ? ThemeMode.dark
                        : ThemeMode.light,
                debugShowCheckedModeBanner: false,
                home: SplashPage(),
              );
            },
          );
        },
      ),
    );
  }
}
