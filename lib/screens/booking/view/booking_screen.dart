import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nytelife/screens/booking/event_view/event_tab.dart';
import '../dining_view/dining_tab.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  String _selectedSegment = 'Dining';

  
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final arg = ModalRoute.of(context)?.settings.arguments;
    if (arg != null && arg is String && arg == 'Events') {
      _selectedSegment = 'Events';
    }
  }

  final Map<String, Widget> _segmentWidgets = const {
    'Dining': Text('Dining', style: TextStyle(fontSize: 16)),
    'Events': Text('Events', style: TextStyle(fontSize: 16)),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 50.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(4.r),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: CupertinoSegmentedControl<String>(
                  groupValue: _selectedSegment,
                  selectedColor: Colors.black,
                  unselectedColor: Colors.grey.shade200,
                  borderColor: Colors.transparent,
                  children: _segmentWidgets,
                  onValueChanged: (value) {
                    setState(() => _selectedSegment = value);
                  },
                ),
              ),
            ),
            if (_selectedSegment == 'Dining') const DiningTab(),
            if (_selectedSegment == 'Events') const EventsTab(),
          ],
        ),
      ),
    );
  }
}
