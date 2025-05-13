// core/custom_widgets/custom_bottom_bar.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nytelife/screens/booking/view/booking_screen.dart';
import '../../screens/events/view/event_screen.dart';
import '../../screens/home/view/home_screen.dart';
import 'package:flutter/cupertino.dart';

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
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.home),
            label: 'Dining',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.calendar),
            label: 'Events',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.ticket),
            label: 'Bookings',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        activeColor: Color(0xffD3AF37),
        inactiveColor: CupertinoColors.systemGrey,
        backgroundColor: CupertinoColors.systemBackground,
        iconSize: 28,
      ),
      tabBuilder: (context, index) {
        return _screens[index];
      },
    );
  }
}
