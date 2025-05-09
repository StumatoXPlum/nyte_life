import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/custom_back_button.dart';
import '../../../../core/custom_continue.dart';
import '../widgets/location_service.dart';
import '../../cubit/on_boarding_cubit.dart';
import '../../page_view_screen.dart';
import '../widgets/date_widget.dart';

class BasicInfo extends StatefulWidget {
  final VoidCallback goToNext;
  final PageController pageController;
  final ValueChanged<String> onDateOfBirthChanged;
  const BasicInfo({
    super.key,
    required this.goToNext,
    required this.pageController,
    required this.onDateOfBirthChanged,
  });

  @override
  State<BasicInfo> createState() => _BasicInfoState();
}

class _BasicInfoState extends State<BasicInfo> {
  final TextEditingController _dateOfBirthController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  bool isLoading = false;
  String? selectedGender;
  DateTime? selectedDate;

  Future<void> _getAddress() async {
    setState(() {
      isLoading = true;
    });

    try {
      String address = await LocationService.getAddress();
      setState(() {
        _addressController.text = address;
      });
    } catch (e) {
      setState(() {
        _addressController.text = "Address Unavailable";
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Widget buildTextField(String hint) {
    final hintTextStyle = TextStyle(
      fontFamily: 'britti',
      color: Colors.black.withValues(alpha: 0.6),
    );
    return TextField(
      style: TextStyle(fontFamily: 'britti', fontSize: 16.sp),
      cursorColor: Colors.black,
      controller: _nameController,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: hintTextStyle,
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

  @override
  Widget build(BuildContext context) {
    final hintTextStyle = TextStyle(
      fontSize: 16.sp,
      fontFamily: 'britti',
      color: Colors.black.withValues(alpha: 0.6),
    );
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomBackButton(onTap: Navigator.of(context).pop),
            SizedBox(height: 50.h),
            CustomPageIndicator(
              controller: widget.pageController,
              pageCount: 3,
            ),
            SizedBox(height: 22.h),
            Center(
              child: Text(
                "Basic Information",
                style: TextStyle(
                  fontSize: 26.sp,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'britti',
                ),
              ),
            ),
            SizedBox(height: 10.h),
            Center(
              child: Text(
                "Lorem ipsum dolor sit amet, consectetur",
                style: TextStyle(fontSize: 18.sp, fontFamily: 'britti'),
              ),
            ),
            SizedBox(height: 40.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.w),
              child: Column(
                children: [
                  buildTextField("Please Enter Your Name"),
                  SizedBox(height: 15.h),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          decoration: BoxDecoration(
                            color: const Color(0xffF0ECEC),
                            borderRadius: BorderRadius.circular(8.r),
                            border: Border.all(color: Colors.grey),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              hint: Text(
                                'Gender',
                                style: TextStyle(
                                  fontFamily: 'britti',
                                  fontSize: 16.sp,
                                ),
                              ),
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
                                              fontSize: 16.sp,
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
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: CustomDateField(
                          controller: _dateOfBirthController,
                          onDateChanged: widget.onDateOfBirthChanged,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  TextField(
                    controller: _addressController,
                    readOnly: true,
                    onTap: _getAddress,
                    style: TextStyle(fontFamily: 'britti', fontSize: 16.sp),
                    decoration: InputDecoration(
                      hintText: isLoading ? 'Fetching Address...' : 'Address',
                      hintStyle: hintTextStyle,
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
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(bottom: 50.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomContinue(
              onTap: () {
                final name = _nameController.text.trim();
                if (name.isNotEmpty) {
                  context.read<OnboardingCubit>().setName(name);
                  widget.goToNext();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Please enter your name.',
                        style: TextStyle(fontFamily: 'britti', fontSize: 18.sp),
                      ),
                      backgroundColor: Colors.red.shade600,
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
