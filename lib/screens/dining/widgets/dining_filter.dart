import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class DiningFilter extends StatefulWidget {
  const DiningFilter({super.key});

  @override
  State<DiningFilter> createState() => _DiningFilterState();
}

class _DiningFilterState extends State<DiningFilter> {
  String selectedFilter = "All";
  final List<String> filters = [
    "All",
    "Continental",
    "Indian",
    "Asian",
    "Italian",
  ];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 8.w),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
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
            ...filters.map(
              (filter) => GestureDetector(
                onTap: () {
                  setState(() {
                    selectedFilter = filter;
                  });
                },
                child: DiningFilterTile(
                  title: filter,
                  isSelected: filter == selectedFilter,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DiningFilterTile extends StatelessWidget {
  final String title;
  final bool isSelected;
  const DiningFilterTile({
    super.key,
    required this.title,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      decoration: BoxDecoration(
        color: isSelected ? Colors.black : Colors.white,
        borderRadius: BorderRadius.circular(4.r),
        border: Border.all(color: Colors.black26, width: 1),
      ),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16.sp,
          color: isSelected ? Colors.white : Colors.black,
          fontFamily: 'britti',
        ),
      ),
    );
  }
}
