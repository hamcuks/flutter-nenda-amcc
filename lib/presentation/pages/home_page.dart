import 'package:flutter/material.dart';
import 'package:nenda_invfest/constant.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Halo,\nPendaki', style: NendaStyles.fontMedium,),
              SizedBox(height: 16,),
              Text('Ayo, rencanakan pendakianmu \nsekarang!', style: NendaStyles.fontParagraph,)
              
            ],
          ),
        ),
      ),
    );
  }
}
