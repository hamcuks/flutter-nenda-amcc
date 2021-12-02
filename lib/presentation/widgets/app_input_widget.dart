import 'package:flutter/material.dart';

import '../../constant.dart';

class AppInput extends StatelessWidget {
  final String? label;
  final String? hintText;
  final IconData? icon;
  final bool isPassword;
  final TextInputType? type;
  final TextEditingController? controller;
  final String? initialValue;

  const AppInput({
    Key? key,
    this.hintText,
    this.icon,
    this.controller,
    this.label,
    this.isPassword = false,
    this.type,
    this.initialValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) Text('$label', style: NendaStyles.fontMedium),
        SizedBox(
          height: 8,
        ),
        TextFormField(
          controller: controller,
          obscureText: isPassword,
          keyboardType: type == null ? TextInputType.text : type,
          validator: (val) => (val!.isEmpty) ? 'Isi $label' : null,
          decoration: InputDecoration(
            hintText: hintText!.isEmpty ? '' : hintText,
            hintStyle: NendaStyles.fontParagraph,
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
            prefixIcon: (icon != null)
                ? Icon(
                    icon,
                    color: kOrange,
                  )
                : null,
          ),
        ),
      ],
    );
  }
}
