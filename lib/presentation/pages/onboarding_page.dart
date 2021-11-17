import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:nenda_invfest/constant.dart';
import 'package:nenda_invfest/presentation/pages/home_page.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: double.infinity,
                height: 650,
                child: Image.asset(
                  'assets/images/background-onboarding.webp',
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 3,
                sigmaY: 3,
                tileMode: TileMode.decal,
              ),
              child: Container(
                width: double.infinity,
                height: double.infinity,
                color: kWhite.withOpacity(0.5),
              ),
            ),
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [kWhite, kWhite.withOpacity(0.1)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    SizedBox(
                      height: 100,
                    ),
                    Text(
                      'Solusi muncak, tanpa ribet!',
                      style: NendaStyles.fontBold.copyWith(
                        fontSize: 42,
                      ),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    Text(
                      'Mt. Merbabu is a dormant stratovolcano in Central Java province on the Indonesian island of Java.',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        height: 1.4,
                        color: kBlack.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Image.asset('assets/images/dot-decoration.webp'),
            Positioned(
              top: 100,
              right: 0,
              child: Image.asset('assets/images/dot-decoration.webp'),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Image.asset(
                'assets/images/man-onboarding.webp',
                alignment: Alignment.center,
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.transparent, kBlack.withOpacity(0.5)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.only(bottom: 35),
                width: 145,
                height: 52,
                decoration: BoxDecoration(
                  color: kOrange,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: TextButton(
                  child: Text(
                    'Ayo Muncak!',
                    style: NendaStyles.fontParagraph.copyWith(color: kWhite),
                  ),
                  onPressed: () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage(),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
