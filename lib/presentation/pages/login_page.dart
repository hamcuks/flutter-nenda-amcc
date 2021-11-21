import 'package:flutter/material.dart';
import 'package:nenda_invfest/constant.dart';
import 'package:nenda_invfest/presentation/widgets/app_button_widget.dart';
import 'package:nenda_invfest/presentation/widgets/app_input_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: size.height * 0.4,
              decoration: BoxDecoration(
                color: kOrange,
                image: DecorationImage(
                  image: AssetImage('assets/images/nenda-logo-white.webp'),
                  scale: 4,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(35),
                  bottomRight: Radius.circular(35),
                ),
              ),
            ),
            SizedBox(
              height: 32,
            ),
            Text(
              "Masuk",
              style: NendaStyles.fontBold.copyWith(color: kOrange),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppInput(
                    label: 'Email',
                    hintText: 'Email Kamu',
                    icon: Icons.alternate_email_outlined,
                    controller: _emailController,
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  AppInput(
                    label: 'Kata Sandi',
                    hintText: 'Kata Sandi Kamu',
                    icon: Icons.lock_outline,
                    controller: _passwordController,
                  ),
                  SizedBox(
                    height: 54,
                  ),
                  AppButton(
                    width: double.infinity,
                    height: 52,
                    text: 'Masuk',
                  ),
                  Center(
                    child: TextButton(
                      onPressed: () =>
                          Navigator.pushNamed(context, '/register'),
                      child: Text(
                        'Klik disini untuk Daftar',
                        style: NendaStyles.fontParagraph,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
