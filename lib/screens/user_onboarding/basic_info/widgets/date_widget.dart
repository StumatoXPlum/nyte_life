import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class DatePickerService {
  static Future<void> selectDate({
    required BuildContext context,
    required TextEditingController controller,
    required ValueChanged<String> onDateChanged,
  }) async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(8.r)),
      ),
      backgroundColor: Colors.white,
      builder: (context) {
        return _CustomDatePicker(
          onDateSelected: (selectedDate) {
            String dayWithSuffix = _getDayWithSuffix(selectedDate.day);
            String formattedDisplayDate =
                "$dayWithSuffix ${DateFormat('MMMM').format(selectedDate)}";

            String formattedDate =
                "${selectedDate.year}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString().padLeft(2, '0')}";

            controller.text = formattedDisplayDate;
            onDateChanged(formattedDate);
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  static _getDayWithSuffix(int day) {
    if (day >= 11 && day <= 13) {
      return "${day}th";
    }
    switch (day % 10) {
      case 1:
        return "${day}st";
      case 2:
        return "${day}nd";
      case 3:
        return "${day}rd";
      default:
        return "${day}th";
    }
  }
}

class _CustomDatePicker extends StatefulWidget {
  final ValueChanged<DateTime> onDateSelected;

  const _CustomDatePicker({required this.onDateSelected});

  @override
  _CustomDatePickerState createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<_CustomDatePicker> {
  late List<String> _months;
  late List<int> _years;
  late int _selectedMonthIndex;
  late int _selectedYear;
  late int _selectedDay;

  final _monthController = FixedExtentScrollController();
  final _dayController = FixedExtentScrollController();
  final _yearController = FixedExtentScrollController();

  @override
  void initState() {
    super.initState();
    DateTime now = DateTime.now();
    _selectedMonthIndex = now.month - 1;
    _selectedYear = now.year;
    _selectedDay = now.day;

    _months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    _years = List.generate(100, (index) => now.year - index);

    _monthController.jumpToItem(_selectedMonthIndex);
    _yearController.jumpToItem(0);
    _dayController.jumpToItem(_selectedDay - 1);
  }

  int _getDaysInMonth(int year, int month) {
    return DateTime(year, month + 1, 0).day;
  }

  @override
  void dispose() {
    _monthController.dispose();
    _dayController.dispose();
    _yearController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int daysInMonth = _getDaysInMonth(_selectedYear, _selectedMonthIndex + 1);
    if (_selectedDay > daysInMonth) {
      _selectedDay = daysInMonth;
    }
    List<int> days = List.generate(daysInMonth, (index) => index + 1);
    return Padding(
      padding: EdgeInsets.only(
        bottom: 60.h,
        left: 30.w,
        right: 30.w,
        top: 50.h,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Select Date of Birth',
            style: TextStyle(
              fontSize: 16.sp,
              fontFamily: 'britti',
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 10.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildWheelPicker(
                controller: _monthController,
                items: _months,
                onSelectedItemChanged: (index) {
                  setState(() {
                    _selectedMonthIndex = index;
                  });
                },
                initialItem: _selectedMonthIndex,
              ),
              SizedBox(width: 10.w),
              _buildWheelPicker(
                controller: _dayController,
                items: days.map((day) => day.toString()).toList(),
                onSelectedItemChanged: (index) {
                  setState(() {
                    _selectedDay = days[index];
                  });
                },
                initialItem: _selectedDay - 1,
              ),
              SizedBox(width: 10.w),
              _buildWheelPicker(
                controller: _yearController,
                items: _years.map((year) => year.toString()).toList(),
                onSelectedItemChanged: (index) {
                  setState(() {
                    _selectedYear = _years[index];
                  });
                },
                initialItem: 0,
              ),
            ],
          ),
          SizedBox(height: 20.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(
                  'Cancel',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontFamily: 'britti',
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(width: 20.w),
              ElevatedButton(
                onPressed: () {
                  DateTime selectedDate = DateTime(
                    _selectedYear,
                    _selectedMonthIndex + 1,
                    _selectedDay,
                  );
                  widget.onDateSelected(selectedDate);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xffD3AF37),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 30.w,
                    vertical: 8.h,
                  ),
                ),
                child: Text(
                  'Select',
                  style: TextStyle(
                    fontFamily: 'britti',
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWheelPicker({
    required FixedExtentScrollController controller,
    required List<String> items,
    required ValueChanged<int> onSelectedItemChanged,
    required int initialItem,
  }) {
    return Container(
      width: 100.w,
      height: 200.h,
      decoration: BoxDecoration(
        color: Color(0xffF2DB8F),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: ListWheelScrollView.useDelegate(
        controller: controller,
        physics: const FixedExtentScrollPhysics(),
        diameterRatio: 1.5,
        useMagnifier: true,
        magnification: 1.3,
        itemExtent: 50,
        onSelectedItemChanged: onSelectedItemChanged,
        childDelegate: ListWheelChildBuilderDelegate(
          builder: (context, index) {
            bool isSelected = index == controller.selectedItem;
            return Center(
              child: Text(
                items[index],
                style: TextStyle(
                  fontSize: isSelected ? 16.sp : 12.sp,
                  fontFamily: 'britti',
                  color: isSelected ? Colors.black : Colors.white,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            );
          },
          childCount: items.length,
        ),
      ),
    );
  }
}

class CustomDateField extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onDateChanged;

  const CustomDateField({
    super.key,
    required this.controller,
    required this.onDateChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      readOnly: true,
      onTap:
          () => DatePickerService.selectDate(
            context: context,
            controller: controller,
            onDateChanged: onDateChanged,
          ),
      style: TextStyle(
        color: Colors.black,
        fontFamily: 'britti',
        fontSize: 16.sp,
      ),
      decoration: InputDecoration(
        hintText: "Your Birthday",
        hintStyle: TextStyle(color: Colors.black54, fontSize: 16.sp),
        filled: true,
        fillColor: const Color(0xffF0ECEC),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(color: Colors.grey),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(color: Colors.grey),
        ),
      ),
    );
  }
}
