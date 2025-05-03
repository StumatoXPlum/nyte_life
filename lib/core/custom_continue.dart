import 'package:flutter/material.dart';

class CustomContinue extends StatelessWidget {
  final VoidCallback onTap;
  const CustomContinue({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    double padding = size.width * 0.03;
    double fontSize = size.width * 0.05;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size.width * 0.4,
        padding: EdgeInsets.symmetric(
          horizontal: padding * 1,
          vertical: padding * 0.7,
        ),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Continue",
              style: TextStyle(
                fontSize: fontSize,
                fontFamily: 'britti',
                color: Colors.white,
              ),
            ),
            Icon(Icons.arrow_forward, size: fontSize, color: Colors.white),
          ],
        ),
      ),
    );
  }
}
