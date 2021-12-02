import 'package:flutter/material.dart';
import 'package:nenda_invfest/constant.dart';
import 'package:nenda_invfest/cubit/navigation/navigation_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomBottomNavigationItem extends StatelessWidget {
  final String? iconName;
  final String? label;
  final Navigation? routeName;
  final bool? isSelected;

  CustomBottomNavigationItem({
    Key? key,
    this.iconName,
    this.label,
    this.routeName,
    this.isSelected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<NavigationCubit>().setNavigation(routeName!);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/icons/$iconName.png',
            width: 24,
            height: 24,
            color: (context.read<NavigationCubit>().state == routeName)
                ? kOrange
                : Colors.grey[400],
          ),
          SizedBox(
            height: 8,
          ),
          if (context.read<NavigationCubit>().state == routeName)
            Text(
              '$label',
              style: NendaStyles.fontParagraph.copyWith(color: kOrange),
            ),
        ],
      ),
    );
  }
}
