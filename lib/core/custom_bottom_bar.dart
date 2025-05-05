import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nytelife/screens/booking_screen.dart';
import 'package:nytelife/screens/event_screen.dart';
import 'package:nytelife/screens/home_screen.dart';

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
  late AnimationController controller;
  late Animation<Offset> slideAnimation;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
    _screens = [
      HomeScreen(),
      EventScreen(),
      BookingScreen(),
    ];

    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(controller);
    controller.forward();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: const Color(0xff1F265E),
      body: IndexedStack(index: _selectedIndex, children: _screens),
      bottomNavigationBar: SlideTransition(
        position: slideAnimation,
        child: CustomBottomNavBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
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
    final Size size = MediaQuery.of(context).size;
    double padding = size.width * 0.04;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding * 3, vertical: padding),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(70),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: Container(
            height: size.height * 0.08,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.1),
              border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
              borderRadius: BorderRadius.circular(70),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildSvgItem(context, "assets/home_assets/home.svg", 0),
                _buildSvgItem(context, "assets/home_assets/bookmark.svg", 1),
                _buildSvgItem(context, "assets/home_assets/profile.svg", 2),
                _buildSvgItem(context, "assets/home_assets/admin_icon.svg", 3),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSvgItem(BuildContext context, String asset, int index) {
    bool isSelected = currentIndex == index;
    final Size size = MediaQuery.of(context).size;
    double padding = size.width * 0.04;

    return GestureDetector(
      onTap: () => onTap(index),
      child: Padding(
        padding: EdgeInsets.all(padding * 0.5),
        child: Container(
          padding: EdgeInsets.all(padding),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xff8E97FD) : Colors.transparent,
            shape: BoxShape.circle,
          ),
          child: SvgPicture.asset(
            asset,
            width: size.width * 0.03,
            height: size.height * 0.03,
            colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
          ),
        ),
      ),
    );
  }
}