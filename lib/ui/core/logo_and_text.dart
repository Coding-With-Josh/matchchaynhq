import 'package:flutter/material.dart';

class LogoAndText extends StatelessWidget {
  const LogoAndText({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Image.asset("assets/images/logo.png",width: 75,height: 75,),
        Text('MATCHCHAYN', style: Theme.of(context).textTheme.headlineSmall),
      ],
    );
  }
}
