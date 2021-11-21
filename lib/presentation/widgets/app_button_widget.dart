import 'package:flutter/material.dart';

import '../../constant.dart';

class AppButton extends StatelessWidget {
  final String? text;
  final double? width;
  final double? height;
  final Function()? onPressed;

  const AppButton({
    Key? key,
    this.text,
    this.width,
    this.height,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 35),
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: kOrange,
        borderRadius: BorderRadius.circular(50),
      ),
      child: TextButton(
        child: Text(
          '$text',
          style: NendaStyles.fontParagraph.copyWith(color: kWhite),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
