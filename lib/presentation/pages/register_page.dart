import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nenda_invfest/cubit/auth/auth_cubit.dart';
import 'package:nenda_invfest/presentation/widgets/app_button_widget.dart';
import 'package:nenda_invfest/presentation/widgets/app_input_widget.dart';

import '../../constant.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController _namaLengkapContoller = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _passwordConfirmationController =
      TextEditingController();

  bool _isLoading = false;

  @override
  void dispose() {
    _namaLengkapContoller.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _passwordConfirmationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 32,
              ),
              Text(
                "Daftar Akun",
                style: NendaStyles.fontBold.copyWith(color: kOrange),
              ),
              SizedBox(
                height: 72,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppInput(
                      label: 'Nama Lengkap',
                      hintText: 'Nama Lengkap Kamu',
                      icon: Icons.person_outline,
                      controller: _namaLengkapContoller,
                    ),
                    SizedBox(
                      height: 32,
                    ),
                    AppInput(
                      label: 'Username',
                      hintText: 'Nama Lengkap Kamu',
                      icon: Icons.person_outline,
                      controller: _usernameController,
                    ),
                    SizedBox(
                      height: 32,
                    ),
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
                      isPassword: true,
                      icon: Icons.lock_outline,
                      controller: _passwordController,
                    ),
                    SizedBox(
                      height: 32,
                    ),
                    AppInput(
                      label: 'Konfirmasi Kata Sandi',
                      hintText: 'Konfirmasi Kata Sandi',
                      isPassword: true,
                      icon: Icons.lock_outline,
                      controller: _passwordConfirmationController,
                    ),
                    SizedBox(
                      height: 54,
                    ),
                    BlocConsumer<AuthCubit, AuthState>(
                      listener: (context, state) {
                        if (state is AuthSuccess) {
                          _isLoading = false;
                          Navigator.pushNamedAndRemoveUntil(
                              context, '/main', (route) => false);
                        } else if (state is AuthError) {
                          _isLoading = false;
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(state.errorMessage.toString()),
                            backgroundColor: Colors.black,
                          ));
                        } else if (state is AuthLoading) {
                          _isLoading = true;
                        }
                      },
                      builder: (context, state) {
                        return AppButton(
                          isLoading: _isLoading,
                          width: double.infinity,
                          height: 52,
                          text: 'Daftar',
                          onPressed: () {
                            if (_passwordController.text ==
                                _passwordConfirmationController.text) {
                              context.read<AuthCubit>().signup(
                                    email: _emailController.text,
                                    username: _usernameController.text,
                                    password: _passwordController.text,
                                    namaLengkap: _namaLengkapContoller.text,
                                  );
                            }
                          },
                        );
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
