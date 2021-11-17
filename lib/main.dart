import 'package:flutter/material.dart';
import 'package:nenda_invfest/constant.dart';
import 'package:nenda_invfest/presentation/pages/home_page.dart';
import 'package:nenda_invfest/presentation/pages/onboarding_page.dart';
import 'package:nenda_invfest/presentation/pages/splash_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nenda, Solusi Muncak Tanpa Ribet!',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: kWhite,
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => SplashPage(),
        '/home': (context) => HomePage(),
        '/onboarding': (context) => OnboardingPage(),
      },
    );
  }
}
