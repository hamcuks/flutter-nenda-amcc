import 'package:flutter/material.dart';

import '../../constant.dart';

class ContentLoadingWidget extends StatelessWidget {
  const ContentLoadingWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        backgroundColor: kOrange,
        color: kWhite,
      ),
    );
  }
}
