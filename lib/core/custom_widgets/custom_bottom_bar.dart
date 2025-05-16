// core/custom_widgets/custom_bottom_bar.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nytelife/screens/booking/view/booking_screen.dart';
import '../../screens/events/view/event_screen.dart';
import '../../screens/dining/view/dining_screen.dart';

class CustomBottomBar extends StatefulWidget {
  final int initialIndex;
  final Map<String, dynamic>? booking;

  const CustomBottomBar({super.key, this.initialIndex = 0, this.booking});

  @override
  CustomBottomBarState createState() => CustomBottomBarState();
}

class CustomBottomBarState extends State<CustomBottomBar> {
  late int _selectedIndex;
  late List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
    _screens = [DiningScreen(), EventScreen(), BookingScreen()];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  BottomNavigationBarItem buildNavItem(String asset, String label, int index) {
    bool isSelected = _selectedIndex == index;

    return BottomNavigationBarItem(
      icon: SvgPicture.asset(
        asset,
        width: 24.w,
        height: 30.h,
        colorFilter: ColorFilter.mode(
          isSelected ? const Color(0xffD3AF37) : Colors.black,
          BlendMode.srcIn,
        ),
      ),
      label: label,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: const Color(0xff1F265E),
      body: IndexedStack(index: _selectedIndex, children: _screens),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: Colors.grey.shade300, width: 1.0),
          ),
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          backgroundColor: Colors.white,
          elevation: 8,
          selectedItemColor: const Color(0xffD3AF37),
          unselectedItemColor: Colors.black,
          selectedLabelStyle: TextStyle(
            color: const Color(0xffD3AF37),
            fontSize: 12.sp,
            fontWeight: FontWeight.bold,
          ),
          unselectedLabelStyle: TextStyle(
            color: Colors.black,
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
          ),
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          items: [
            buildNavItem("assets/bottom_bar/dining.svg", "Dining", 0),
            buildNavItem("assets/bottom_bar/events.svg", "Events", 1),
            buildNavItem("assets/bottom_bar/bookings.svg", "Bookings", 2),
          ],
        ),
      ),
    );
  }
}
