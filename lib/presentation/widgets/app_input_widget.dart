import 'package:flutter/material.dart';

import '../../constant.dart';

class AppInput extends StatelessWidget {
  final String? label;
  final String? hintText;
  final IconData? icon;
  final TextEditingController? controller;

  const AppInput({
    Key? key,
    this.hintText,
    this.icon,
    this.controller,
    this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('$label', style: NendaStyles.fontMedium),
        SizedBox(
          height: 8,
        ),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: '$hintText',
            border: UnderlineInputBorder(
              borderSide: BorderSide(color: kOrange, width: 2),
            ),
            focusColor: kOrange,
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: kOrange, width: 2),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(width: 2, color: Colors.black26),
            ),
            prefixIcon: Icon(
              icon,
              color: kOrange,
            ),
          ),
        ),
      ],
    );
  }
}
