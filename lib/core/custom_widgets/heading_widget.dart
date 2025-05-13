import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HeadingWidget extends StatelessWidget {
  final String heading;
  const HeadingWidget({super.key, required this.heading});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TriangleShape(direction: TriangleDirection.left),
          SizedBox(width: 8.w),
          Flexible(
            child: Text(
              heading,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(width: 8.w),
          TriangleShape(direction: TriangleDirection.right),
        ],
      ),
    );
  }
}

enum TriangleDirection { left, right }

class TriangleShape extends StatelessWidget {
  final TriangleDirection direction;

  const TriangleShape({super.key, required this.direction});

  @override
  Widget build(BuildContext context) {
    double triangleWidth = 30.w.clamp(20, 40);
    double triangleHeight = 10.h.clamp(6, 12);

    return ClipPath(
      clipper: _TriangleClipper(direction),
      child: Container(
        width: triangleWidth,
        height: triangleHeight,
        color: const Color(0xffD3AF37),
      ),
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
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
