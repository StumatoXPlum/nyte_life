import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nytelife/core/custom_back_button.dart';
import 'package:nytelife/core/custom_continue.dart';
import 'package:nytelife/screens/user_onboarding/food_preferences.dart';

class BasicInfo extends StatefulWidget {
  const BasicInfo({super.key});

  @override
  State<BasicInfo> createState() => _BasicInfoState();
}

class _BasicInfoState extends State<BasicInfo> {
  String? selectedGender;
  DateTime? selectedDate;

  Widget buildTextField(String hint) {
    final hintTextStyle = TextStyle(
      fontFamily: 'britti',
      color: Colors.black.withValues(alpha: 0.6),
    );
    return TextField(
      cursorColor: Colors.black,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: hintTextStyle,
        filled: true,
        fillColor: const Color(0xffF0ECEC),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  String _formatDate(DateTime date) {
    int day = date.day;
    String suffix = 'th';
    if (day == 1 || day == 21 || day == 31) {
      suffix = 'st';
    } else if (day == 2 || day == 22) {
      suffix = 'nd';
    } else if (day == 3 || day == 23) {
      suffix = 'rd';
    }
    String month = DateFormat('MMMM').format(date);
    return '$day$suffix $month';
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    double padding = size.width * 0.05;
    double fontSize = size.width * 0.045;
    final hintTextStyle = TextStyle(
      fontFamily: 'britti',
      color: Colors.black.withValues(alpha: 0.6),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(left: size.width * 0.08, child: CustomBackButton()),
          Align(
            alignment: Alignment.bottomCenter,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: padding * 2),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: size.height * 0.1),
                    Center(
                      child: Text(
                        "Basic Information",
                        style: TextStyle(
                          fontSize: fontSize * 1.3,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'britti',
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.02),
                    Center(
                      child: Text(
                        "Lorem ipsum dolor sit amet, consectetur",
                        style: TextStyle(
                          fontSize: fontSize,
                          fontFamily: 'britti',
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.03),
                    buildTextField("Please Enter Your Name"),
                    SizedBox(height: size.height * 0.03),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: padding * 0.6,
                              vertical: padding * 0.1,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xffF0ECEC),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.grey),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                hint: Text('Gender', style: hintTextStyle),
                                value: selectedGender,
                                icon: const SizedBox.shrink(),
                                items:
                                    ['Male', 'Female', 'Prefer not to say']
                                        .map(
                                          (gender) => DropdownMenuItem(
                                            value: gender,
                                            child: Text(
                                              gender,
                                              style: TextStyle(
                                                fontFamily: 'britti',
                                              ),
                                            ),
                                          ),
                                        )
                                        .toList(),
                                onChanged: (value) {
                                  setState(() {
                                    selectedGender = value;
                                  });
                                },
                                dropdownColor: Color(0xffF0ECEC),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: size.width * 0.03),
                        Expanded(
                          child: GestureDetector(
                            onTap: () => _selectDate(context),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: padding,
                                vertical: padding * 0.90,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xffF0ECEC),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.grey),
                              ),
                              child: Text(
                                selectedDate != null
                                    ? _formatDate(selectedDate!)
                                    : "Your Birthday",
                                style:
                                    selectedDate != null
                                        ? TextStyle(
                                          fontFamily: 'britti',
                                          color: Colors.black,
                                          fontSize: fontSize,
                                        )
                                        : hintTextStyle,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: size.height * 0.03),
                    buildTextField("Address"),
                    SizedBox(height: size.height * 0.03),
                    CustomContinue(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FoodPreferences(),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: size.height * 0.05),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
