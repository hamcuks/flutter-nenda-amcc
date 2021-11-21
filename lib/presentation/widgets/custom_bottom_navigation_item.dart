import 'package:flutter/material.dart';

class CustomBottomNavigationItem extends StatelessWidget {
  final String? iconName;
  final String? label;
  final int? indexNav;

  const CustomBottomNavigationItem({
    Key? key,
    this.iconName,
    this.label,
    this.indexNav,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/icons/$iconName.png'),
            ),
          ),
        ),
        SizedBox(
          height: 8,
        ),
        Text('$label'),
      ],
    );
  }
}
