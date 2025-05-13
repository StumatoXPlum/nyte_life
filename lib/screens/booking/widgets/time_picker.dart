import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TimePickerService {
  static Future<void> selectTime({
    required BuildContext context,
    required TextEditingController controller,
    required ValueChanged<String> onTimeChanged,
  }) async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(8.r)),
      ),
      backgroundColor: Colors.white,
      builder: (context) {
        return _CustomTimePicker(
          onTimeSelected: (selectedTime) {
            int hour = selectedTime.hourOfPeriod;
            String period = selectedTime.period == DayPeriod.am ? "AM" : "PM";
            String formattedDisplayTime =
                "${hour == 0 ? 12 : hour}:${selectedTime.minute.toString().padLeft(2, '0')} $period";
            String formattedTime =
                "${selectedTime.hour.toString().padLeft(2, '0')}:${selectedTime.minute.toString().padLeft(2, '0')}:00";
            controller.text = formattedDisplayTime;
            onTimeChanged(formattedTime);
            Navigator.of(context).pop();
          },
        );
      },
    );
  }
}

class _CustomTimePicker extends StatefulWidget {
  final ValueChanged<TimeOfDay> onTimeSelected;

  const _CustomTimePicker({required this.onTimeSelected});

  @override
  _CustomTimePickerState createState() => _CustomTimePickerState();
}

class _CustomTimePickerState extends State<_CustomTimePicker> {
  late int _selectedHour;
  late int _selectedMinute;
  late bool _isPM;

  @override
  void initState() {
    super.initState();
    final now = TimeOfDay.now();
    _selectedHour = now.hourOfPeriod;
    _selectedMinute = now.minute;
    _isPM = now.period == DayPeriod.pm;
  }

  void _incrementHour() {
    setState(() {
      _selectedHour = _selectedHour == 12 ? 1 : _selectedHour + 1;
    });
  }

  void _decrementHour() {
    setState(() {
      _selectedHour = _selectedHour == 1 ? 12 : _selectedHour - 1;
    });
  }

  void _incrementMinute() {
    setState(() {
      _selectedMinute = _selectedMinute == 59 ? 0 : _selectedMinute + 1;
    });
  }

  void _decrementMinute() {
    setState(() {
      _selectedMinute = _selectedMinute == 0 ? 59 : _selectedMinute - 1;
    });
  }

  void _togglePeriod() {
    setState(() {
      _isPM = !_isPM;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    double fontSize = size.width * 0.05;
    double padding = size.width * 0.03;

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: size.width * 0.03,
        right: size.width * 0.03,
        top: size.height * 0.02,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Select Time',
            style: TextStyle(
              fontSize: fontSize * 1.2,
              fontFamily: 'britti',
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: size.height * 0.02),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildTimeColumn(
                value: _selectedHour,
                onIncrement: _incrementHour,
                onDecrement: _decrementHour,
              ),
              SizedBox(width: size.width * 0.02),
              Text(
                ':',
                style: TextStyle(
                  fontSize: fontSize * 3,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: size.width * 0.02),
              _buildTimeColumn(
                value: _selectedMinute,
                onIncrement: _incrementMinute,
                onDecrement: _decrementMinute,
              ),
              SizedBox(width: size.width * 0.05),
              GestureDetector(
                onTap: _togglePeriod,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: padding,
                    horizontal: padding * 1.5,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.white24, width: 1),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'AM',
                        style: TextStyle(
                          color: !_isPM ? Colors.black : Colors.black26,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'britti',
                        ),
                      ),
                      SizedBox(height: size.height * 0.02),
                      Text(
                        'PM',
                        style: TextStyle(
                          color: _isPM ? Colors.black : Colors.black26,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'britti',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: size.height * 0.05),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(
                  'Cancel',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(width: size.width * 0.05),
              ElevatedButton(
                onPressed: () {
                  int hour =
                      _isPM
                          ? (_selectedHour == 12 ? 12 : _selectedHour + 12)
                          : (_selectedHour == 12 ? 0 : _selectedHour);

                  widget.onTimeSelected(
                    TimeOfDay(hour: hour, minute: _selectedMinute),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xffD3AF37),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: padding * 2,
                    vertical: padding,
                  ),
                ),
                child: Text(
                  'Select',
                  style: TextStyle(
                    fontFamily: 'britti',
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: size.height * 0.03),
        ],
      ),
    );
  }

  Widget _buildTimeColumn({
    required int value,
    required VoidCallback onIncrement,
    required VoidCallback onDecrement,
  }) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.25,
      height: size.height * 0.2,
      decoration: BoxDecoration(
        color: const Color(0xffF2DB8F),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: Icon(
              Icons.keyboard_arrow_up,
              color: Colors.black,
              size: size.height * 0.04,
            ),
            onPressed: onIncrement,
          ),
          Text(
            value.toString().padLeft(2, '0'),
            style: TextStyle(
              fontSize: size.height * 0.04,
              color: Colors.black,
              fontFamily: 'britti',
              fontWeight: FontWeight.bold,
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.keyboard_arrow_down,
              color: Colors.black,
              size: size.height * 0.04,
            ),
            onPressed: onDecrement,
          ),
        ],
      ),
    );
  }
}

class CustomTimeField extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onTimeChanged;

  const CustomTimeField({
    super.key,
    required this.controller,
    required this.onTimeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      readOnly: true,
      onTap:
          () => TimePickerService.selectTime(
            context: context,
            controller: controller,
            onTimeChanged: onTimeChanged,
          ),
      style: TextStyle(
        color: Colors.black,
        fontSize: 16.sp,
        fontFamily: 'britti',
        fontWeight: FontWeight.bold,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xff202938)),
          borderRadius: BorderRadius.circular(8.r),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xff202938)),
          borderRadius: BorderRadius.circular(8.r),
        ),
      ),
    );
  }
}
