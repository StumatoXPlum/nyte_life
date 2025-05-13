import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class CustomFilter extends StatelessWidget {
  const CustomFilter({super.key});

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
              FilterTile(title: "Continental"),
              FilterTile(title: "Indian"),
              FilterTile(title: "Asian"),
              FilterTile(title: "Italian"),
            ],
          ),
        );
  }
}


class FilterTile extends StatelessWidget {
  final String title;
  const FilterTile({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Colors.black26, width: 1),
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