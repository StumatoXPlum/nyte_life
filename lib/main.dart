import 'package:flutter/material.dart';
import 'package:nytelife/screens/sign_up_screen.dart/sign_up_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'NyteLife',
      home: SignUpScreen(),
    );
  }
}
