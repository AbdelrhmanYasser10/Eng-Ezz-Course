import 'package:e_commerce_app_session_it_sharks/core/network/local/shared_preferences_helper.dart';
import 'package:flutter/material.dart';

import 'features/splash/presentation/pages/splash_page.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesHelper.initialize();
  runApp(ECommerceApp());
}

class ECommerceApp extends StatelessWidget {
  const ECommerceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashPage(),
    );
  }
}

