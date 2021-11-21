import 'package:flutter/material.dart';

import '../../constant.dart';

class AppSearchBar extends StatelessWidget {
  final String? hintText;
  final TextEditingController? controller;

  const AppSearchBar({
    Key? key,
    this.hintText,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        fillColor: kLightGrey,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        filled: true,
        hintText: '$hintText',
        suffixIcon: Icon(
          Icons.search,
          color: kOrange,
        ),
      ),
    );
  }
}
