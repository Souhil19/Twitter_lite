import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:twitter/main.dart';

class splashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Column(
        children: [
          Image.asset('assets/images/twitter.png'),
        ],
      ),
      backgroundColor: Colors.white,
      nextScreen: MyHomePage(),
      splashIconSize: 250,
      //duration: 3000,
      splashTransition: SplashTransition.slideTransition,
    );
  }
}
