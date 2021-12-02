import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nenda_invfest/constant.dart';
import 'package:nenda_invfest/cubit/article/article_cubit.dart';
import 'package:nenda_invfest/cubit/auth/auth_cubit.dart';
import 'package:nenda_invfest/cubit/forecast/forecast_cubit.dart';
import 'package:nenda_invfest/cubit/navigation/navigation_cubit.dart';
import 'package:nenda_invfest/cubit/pendakian/pendakian_cubit.dart';
import 'package:nenda_invfest/cubit/ticket/ticket_cubit.dart';
import 'package:nenda_invfest/cubit/user/user_cubit.dart';
import 'package:nenda_invfest/presentation/pages/artikel/daftar_artikel_page.dart';
import 'package:nenda_invfest/presentation/pages/pendakian/daftar_pendakian_page.dart';
import 'package:nenda_invfest/presentation/pages/tiket/daftar_ticket_page.dart';
import 'package:nenda_invfest/presentation/pages/fasilitas_page.dart';
import 'package:nenda_invfest/presentation/pages/main_page.dart';
import 'package:nenda_invfest/presentation/pages/login_page.dart';
import 'package:nenda_invfest/presentation/pages/onboarding_page.dart';
import 'package:nenda_invfest/presentation/pages/register_page.dart';
import 'package:nenda_invfest/presentation/pages/splash_page.dart';

void main() async {
  // SdkContext.init(IsolateOrigin.main);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => NavigationCubit()),
        BlocProvider(create: (context) => AuthCubit()),
        BlocProvider(create: (context) => PendakianCubit()),
        BlocProvider(create: (context) => ArticleCubit()),
        BlocProvider(create: (context) => TicketCubit()),
        BlocProvider(create: (context) => UserCubit()),
        BlocProvider(create: (context) => ForecastCubit()),
      ],
      child: MaterialApp(
        title: 'Nenda, Solusi Muncak Tanpa Ribet!',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: kWhite,
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => SplashPage(),
          '/main': (context) => MainPage(),
          '/onboarding': (context) => OnboardingPage(),
          '/login': (context) => LoginPage(),
          '/register': (context) => RegisterPage(),
          '/fasilitas': (context) => FasilitasPage(),
          '/daftar-pendakian': (context) => DaftarPendakianPage(),
          '/daftar-artikel': (context) => DaftarArtikelPage(),
          '/daftar-ticket': (context) => DaftarTicketPage(),
        },
      ),
    );
  }
}
