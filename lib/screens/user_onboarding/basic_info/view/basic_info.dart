import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/custom_widgets/custom_back_button.dart';
import '../../../../core/custom_widgets/custom_continue.dart';
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

  Future<void> _getAddress() async {
    setState(() => isLoading = true);
    try {
      final address = await LocationService.getAddress();
      _addressController.text = address;
      context.read<OnboardingCubit>().setAddress(address);
    } catch (e) {
      _addressController.text = "Address Unavailable";
    } finally {
      setState(() => isLoading = false);
    }
  }

  Widget buildTextField(String hint) {
    return TextField(
      style: TextStyle(fontFamily: 'britti', fontSize: 16.sp),
      cursorColor: Colors.black,
      controller: _nameController,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
          fontFamily: 'britti',
          color: Colors.black.withAlpha(150),
        ),
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

  void _validateAndProceed() {
    final name = _nameController.text.trim();
    final gender = selectedGender;
    final dob = _dateOfBirthController.text.trim();
    final address = _addressController.text.trim();

    if (name.isEmpty || gender == null || dob.isEmpty || address.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please fill in all fields.',
            style: TextStyle(fontFamily: 'britti', fontSize: 18.sp),
          ),
          backgroundColor: Colors.red.shade600,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    final cubit = context.read<OnboardingCubit>();
    cubit.setName(name);
    cubit.setGender(gender);
    cubit.setDateOfBirth(dob);
    cubit.setAddress(address);
    widget.onDateOfBirthChanged(dob);
    widget.goToNext();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          CustomBackButton(onTap: Navigator.of(context).pop),
          SizedBox(height: 50.h),
          CustomPageIndicator(controller: widget.pageController, pageCount: 3),
          SizedBox(height: 22.h),
          Text(
            "Basic Information",
            style: TextStyle(
              fontSize: 26.sp,
              fontWeight: FontWeight.bold,
              fontFamily: 'britti',
            ),
          ),
          SizedBox(height: 10.h),
          Text(
            "Lorem ipsum dolor sit amet, consectetur",
            style: TextStyle(fontSize: 18.sp, fontFamily: 'britti'),
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
                            onChanged:
                                (value) =>
                                    setState(() => selectedGender = value),
                            dropdownColor: const Color(0xffF0ECEC),
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
                    hintStyle: TextStyle(
                      fontSize: 16.sp,
                      fontFamily: 'britti',
                      color: Colors.black.withAlpha(150),
                    ),
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
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(bottom: 50.h),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [CustomContinue(onTap: _validateAndProceed)],
        ),
      ),
    );
  }
}
