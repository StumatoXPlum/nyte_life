import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
      style: TextStyle(fontFamily: 'britti'),
      cursorColor: Colors.black,
      controller: _nameController,
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
          Positioned(
            left: size.width * 0.08,
            child: CustomBackButton(onTap: Navigator.of(context).pop),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: padding * 2),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomPageIndicator(
                      controller: widget.pageController,
                      pageCount: 3,
                    ),
                    SizedBox(height: size.height * 0.03),
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
                          child: CustomDateField(
                            controller: _dateOfBirthController,
                            onDateChanged: widget.onDateOfBirthChanged,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: size.height * 0.03),
                    TextField(
                      controller: _addressController,
                      readOnly: true,
                      onTap: _getAddress,
                      decoration: InputDecoration(
                        hintText: isLoading ? 'Fetching Address...' : 'Address',
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
                    ),
                    SizedBox(height: size.height * 0.03),
                    CustomContinue(
                      onTap: () {
                        final name = _nameController.text.trim();
                        if (name.isNotEmpty) {
                          context.read<OnboardingCubit>().setName(name);
                          widget.goToNext();
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Please enter your name')),
                          );
                        }
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
