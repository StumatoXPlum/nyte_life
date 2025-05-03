import 'package:flutter/material.dart';

class CustomBackButton extends StatelessWidget {
  final VoidCallback? onTap;
  const CustomBackButton({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    double padding = size.width * 0.08;
    double fontSize = size.width * 0.05;
    return Padding(
      padding: EdgeInsets.only(top: padding * 2),
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          children: [
            Icon(Icons.arrow_back, size: fontSize),
            SizedBox(width: size.width * 0.02),
            Text(
              'Back',
              style: TextStyle(
                fontFamily: 'britti',
                fontWeight: FontWeight.bold,
                fontSize: fontSize,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
