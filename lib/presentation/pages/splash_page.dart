import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nenda_invfest/constant.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({ Key? key }) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/onboarding');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBlack,
      body: Center(
        child: Image.asset("assets/images/splash_logo.webp", scale: 4),
      ),
    );
  }
}