import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SvgPicture.asset(
          'assets/splash.svg',
          height: size.height * 0.2,
          width: size.width * 0.2,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
