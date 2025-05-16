// core/custom_widgets/custom_continue.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomContinue extends StatefulWidget {
  final VoidCallback onTap;
  final String? label;

  const CustomContinue({super.key, required this.onTap, this.label});

  @override
  State<CustomContinue> createState() => _CustomContinueState();
}

class _CustomContinueState extends State<CustomContinue>
    with SingleTickerProviderStateMixin {
  double _scale = 1.0;

  void _onTapDown(TapDownDetails details) {
    setState(() {
      _scale = 0.96;
    });
  }

  void _onTapUp(TapUpDetails details) {
    setState(() {
      _scale = 1.0;
    });
  }

  void _onTapCancel() {
    setState(() {
      _scale = 1.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150.w,
      height: 40.h,
      child: GestureDetector(
        onTapDown: _onTapDown,
        onTapUp: (details) {
          _onTapUp(details);
          HapticFeedback.selectionClick();
          widget.onTap();
        },
        onTapCancel: _onTapCancel,
        child: AnimatedScale(
          scale: _scale,
          duration: const Duration(milliseconds: 90),
          curve: Curves.easeOut,
          child: ElevatedButton(
            onPressed: () {
              HapticFeedback.selectionClick();
              widget.onTap();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              elevation: 4,
              shadowColor: Colors.black54,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
              splashFactory: InkRipple.splashFactory,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    widget.label ?? 'Continue',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontFamily: 'britti',
                      color: Colors.white,
                    ),
                  ),
                ),
                Icon(Icons.arrow_forward, size: 16.sp, color: Colors.white),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
