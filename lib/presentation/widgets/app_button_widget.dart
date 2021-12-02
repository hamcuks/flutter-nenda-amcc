import 'package:flutter/material.dart';

import '../../constant.dart';

class AppButton extends StatelessWidget {
  final String? text;
  final double? width;
  final double? height;
  final List<BoxShadow>? shadow;
  final Function()? onPressed;
  final bool isLoading;
  final Color? color;

  const AppButton({
    Key? key,
    this.text,
    this.width,
    this.height,
    this.onPressed,
    this.isLoading = false,
    this.shadow,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color == null ? kOrange : color,
        borderRadius: BorderRadius.circular(50),
        boxShadow: shadow,
      ),
      child: TextButton(
        child: isLoading
            ? SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  backgroundColor:
                      color == null ? Colors.white : Colors.orangeAccent,
                  color: color == null ? Colors.orangeAccent : Colors.white,
                ),
              )
            : Text(
                '$text',
                style: NendaStyles.fontParagraph
                    .copyWith(color: color == null ? kWhite : Colors.black),
              ),
        onPressed: onPressed,
      ),
    );
  }
}
