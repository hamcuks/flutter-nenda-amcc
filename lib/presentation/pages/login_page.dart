import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nenda_invfest/constant.dart';
import 'package:nenda_invfest/cubit/auth/auth_cubit.dart';
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

  bool _isLoading = false;

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
                    isPassword: true,
                    label: 'Kata Sandi',
                    hintText: 'Kata Sandi Kamu',
                    icon: Icons.lock_outline,
                    controller: _passwordController,
                  ),
                  SizedBox(
                    height: 54,
                  ),
                  BlocConsumer<AuthCubit, AuthState>(
                    listener: (context, state) {
                      if (state is AuthLoading) {
                        _isLoading = true;
                      } else if (state is AuthSuccess) {
                        _isLoading = false;
                        Navigator.pushNamedAndRemoveUntil(
                            context, '/main', (route) => false);
                      } else if (state is AuthError) {
                        _isLoading = false;
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(state.errorMessage.toString()),
                          backgroundColor: Colors.black,
                        ));
                      }
                    },
                    builder: (context, state) {
                      return AppButton(
                        width: double.infinity,
                        height: 52,
                        isLoading: _isLoading,
                        text: 'Masuk',
                        onPressed: () {
                          if (_emailController.text.isNotEmpty &&
                              _passwordController.text.isNotEmpty) {
                            context.read<AuthCubit>().signIn(
                                email: _emailController.text,
                                password: _passwordController.text);
                          }
                        },
                      );
                    },
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
