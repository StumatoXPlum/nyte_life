import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class Filter extends StatelessWidget {
  const Filter({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20.w),
      child: Row(
        spacing: 14.w,
        children: [
          Container(
            decoration: BoxDecoration(),
            child: SvgPicture.asset(
              "assets/filter.svg",
              height: 15.h,
              width: 15.w,
              fit: BoxFit.scaleDown,
            ),
          ),
          FilterTile(title: "Genre", color: Color(0xffFC9AA3)),
          FilterTile(title: "Ratings", color: Color(0xffE2CF8E)),
          FilterTile(title: "Location", color: Color(0xffFC9AD6)),
          FilterTile(title: "Vibe", color: Color(0xff93EAB0)),
        ],
      ),
    );
  }
}

class FilterTile extends StatelessWidget {
  final String title;
  final Color color;
  const FilterTile({super.key, required this.title, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16.sp,
          color: Colors.black,
          fontFamily: 'britti',
        ),
      ),
    );
  }
}
