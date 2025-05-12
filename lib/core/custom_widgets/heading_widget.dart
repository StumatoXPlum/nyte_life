import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HeadingWidget extends StatelessWidget {
  final String heading;
  const HeadingWidget({super.key, required this.heading});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TriangleShape(direction: TriangleDirection.left),
        SizedBox(width: 8.w),
        Text(
          heading,
          style: TextStyle(fontSize: 30.sp, fontWeight: FontWeight.bold),
        ),
        SizedBox(width: 8.w),
        TriangleShape(direction: TriangleDirection.right),
      ],
    );
  }
}

enum TriangleDirection { left, right }

class TriangleShape extends StatelessWidget {
  final TriangleDirection direction;

  const TriangleShape({super.key, required this.direction});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: _TriangleClipper(direction),
      child: Container(width: 50.w, height: 10.h, color: Color(0xffD3AF37)),
    );
  }
}

class _TriangleClipper extends CustomClipper<Path> {
  final TriangleDirection direction;

  _TriangleClipper(this.direction);

  @override
  Path getClip(Size size) {
    final path = Path();
    if (direction == TriangleDirection.right) {
      path.moveTo(0, 0);
      path.lineTo(size.width, size.height / 2);
      path.lineTo(0, size.height);
    } else {
      path.moveTo(size.width, 0);
      path.lineTo(0, size.height / 2);
      path.lineTo(size.width, size.height);
    }
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
