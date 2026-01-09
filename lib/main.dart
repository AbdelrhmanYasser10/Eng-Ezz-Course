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

import 'core/styles/app_themes.dart';
import 'features/splash/presentation/pages/splash_page.dart';
import 'injection_container.dart' as di;
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  // To ensure the native code generated
  WidgetsFlutterBinding.ensureInitialized();

  await di.initialize();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(ECommerceApp());
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
          return MaterialApp(
            localizationsDelegates: [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: [Locale('en'), Locale('ar')],
            locale: Locale(context.read<SettingsCubit>().languageCode),
            theme:AppThemes.lightTheme,
            darkTheme:AppThemes.darkTheme,
            themeMode:
                context.read<SettingsCubit>().isDark
                    ? ThemeMode.dark
                    : ThemeMode.light,
            debugShowCheckedModeBanner: false,
            home: SplashPage(),
          );
        },
      ),
    );
  }
}
