import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nenda_invfest/cubit/navigation/navigation_cubit.dart';
import 'package:nenda_invfest/presentation/pages/home_page.dart';
import 'package:nenda_invfest/presentation/pages/tiket/daftar_ticket_page.dart';
import 'package:nenda_invfest/presentation/pages/profile/user_settings_page.dart';
import 'package:nenda_invfest/presentation/widgets/custom_bottom_navigation_item.dart';

class MainPage extends StatefulWidget {
  MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationCubit, Navigation>(
        builder: (context, currentNavigation) {
      return Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              _mainContent(currentNavigation),
              customBottomNavigation(),
            ],
          ),
        ),
      );
    });
  }

  Widget _mainContent(Navigation currentNavigation) {
    switch (currentNavigation) {
      case Navigation.HOME:
        return HomePage();
      case Navigation.TICKET:
        return DaftarTicketPage();
      case Navigation.SETTINGS:
        return UserSettingsPage();
      default:
        return HomePage();
    }
  }

  Widget customBottomNavigation() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: double.infinity,
        height: 72,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              offset: Offset(0, -5),
              blurRadius: 10,
              color: Colors.black12,
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CustomBottomNavigationItem(
              iconName: 'home',
              label: 'Beranda',
              routeName: Navigation.HOME,
            ),
            CustomBottomNavigationItem(
              iconName: 'ticket',
              label: 'Tiket',
              routeName: Navigation.TICKET,
            ),
            CustomBottomNavigationItem(
              iconName: 'profile',
              label: 'Profile',
              routeName: Navigation.SETTINGS,
            ),
          ],
        ),
      ),
    );
  }
}
