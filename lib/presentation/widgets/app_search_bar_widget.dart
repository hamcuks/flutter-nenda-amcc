import 'package:flutter/material.dart';

import '../../constant.dart';

class AppSearchBar extends StatelessWidget {
  final String? hintText;
  final TextEditingController? controller;
  final Function(String)? onChanged;

  const AppSearchBar({
    Key? key,
    this.hintText,
    this.controller,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
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
