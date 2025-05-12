import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nytelife/screens/booking/view/booking_screen.dart';
import '../../screens/events/view/event_screen.dart';
import '../../screens/home/view/home_screen.dart';

class CustomBottomBar extends StatefulWidget {
  final int initialIndex;

  const CustomBottomBar({super.key, this.initialIndex = 0});

  @override
  CustomBottomBarState createState() => CustomBottomBarState();
}

class CustomBottomBarState extends State<CustomBottomBar>
    with SingleTickerProviderStateMixin {
  late int _selectedIndex;
  late List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
    _screens = [HomeScreen(), EventScreen(), BookingScreen()];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: const Color(0xff1F265E),
      body: IndexedStack(index: _selectedIndex, children: _screens),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final void Function(int) onTap;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
      child: Container(
        height: 90.h,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff000000), Color(0xff4F4F4F)],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            stops: [0, 1],
          ),
          borderRadius: BorderRadius.circular(52.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildSvgItem("assets/bottom_bar/dining.svg", 0),
            SizedBox(width: 40.w),
            _buildSvgItem("assets/bottom_bar/events.svg", 1),
            SizedBox(width: 40.w),
            _buildSvgItem("assets/bottom_bar/bookings.svg", 2),
          ],
        ),
      ),
    );
  }

  Widget _buildSvgItem(String asset, int index) {
    bool isSelected = currentIndex == index;
    return GestureDetector(
      onTap: () => onTap(index),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 8.h),
            child: Container(
              padding: EdgeInsets.all(12.r),
              decoration: BoxDecoration(
                color:
                    isSelected ? const Color(0xffD3AF37) : Colors.transparent,
                shape: BoxShape.circle,
              ),
              child: SvgPicture.asset(
                asset,
                width: 24.w,
                height: 30.h,
                fit: BoxFit.cover,
                colorFilter:
                    isSelected
                        ? ColorFilter.mode(Colors.black, BlendMode.srcIn)
                        : ColorFilter.mode(Colors.white, BlendMode.srcIn),
              ),
            ),
          ),
          SizedBox(height: 2.h),
          Text(
            index == 0
                ? "Dining"
                : index == 1
                ? "Events"
                : "Bookings",
            style: TextStyle(
              fontSize: 16.sp,
              fontFamily: 'britti',
              color: isSelected ? const Color(0xffD3AF37) : Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
