import 'package:flutter/material.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../core/custom_widgets/custom_back_button.dart';
import '../../../core/custom_widgets/custom_continue.dart';
import 'country_picker.dart';
import 'phone_verification.dart';

class PhoneNumber extends StatefulWidget {
  const PhoneNumber({super.key});

  @override
  State<PhoneNumber> createState() => _PhoneNumberState();
}

class _PhoneNumberState extends State<PhoneNumber> {
  Country selectedCountry = Country(
    phoneCode: "91",
    countryCode: "IN",
    e164Sc: 0,
    geographic: true,
    level: 1,
    name: "India",
    example: "2012345678",
    displayName: "India (IN) [+91]",
    displayNameNoCountryCode: "India",
    e164Key: "",
  );

  final TextEditingController phoneController = TextEditingController();
  bool isPhoneEnter = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    phoneController.addListener(() {
      setState(() => isPhoneEnter = phoneController.text.isNotEmpty);
    });
  }

  void _pickCountry() async {
    final selected = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ChooseCountryScreen()),
    );

    if (selected != null && selected is Country) {
      setState(() => selectedCountry = selected);
    }
  }

  Future<void> sendOtp(String phoneNumber) async {
    try {
      await Supabase.instance.client.auth.signInWithOtp(phone: phoneNumber);

      if (context.mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PhoneVerification(phoneNumber: phoneNumber),
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red.shade600,
            behavior: SnackBarBehavior.floating,
            content: Text("Failed to send OTP: $e"),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    double padding = size.width * 0.03;
    double iconSize = size.width * 0.05;
    double fontSize = size.width * 0.05;

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomBackButton(onTap: () => Navigator.pop(context)),
          SizedBox(height: size.height * 0.03),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 50.h),
                Text(
                  "Hi there!",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: fontSize * 1.6,
                    fontFamily: 'britti',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: size.height * 0.01),
                Text(
                  "Please enter your phone number",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: fontSize,
                    fontFamily: 'britti',
                  ),
                ),
                SizedBox(height: size.height * 0.04),
                Row(
                  children: [
                    InkWell(
                      onTap: _pickCountry,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: padding,
                          vertical: padding * 1.3,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              selectedCountry.flagEmoji,
                              style: TextStyle(fontSize: fontSize),
                            ),
                            SizedBox(width: size.width * 0.04),
                            Text(
                              "+${selectedCountry.phoneCode}",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: fontSize * 0.9,
                              ),
                            ),
                            SizedBox(width: size.width * 0.02),
                            Icon(
                              Icons.arrow_drop_down,
                              color: Colors.black,
                              size: iconSize * 1.2,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: size.width * 0.02),
                    Expanded(
                      child: TextField(
                        cursorColor: Colors.black,
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          hintText: "Enter phone number",
                          hintStyle: TextStyle(color: Colors.black87),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.r),
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.r),
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.r),
                            borderSide: BorderSide(color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 100.h),
          isLoading
              ? const CircularProgressIndicator(color: Colors.black)
              : CustomContinue(
                onTap: () async {
                  if (phoneController.text.trim().isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: Colors.green.shade600,
                        content: Text("Please enter your phone number"),
                      ),
                    );
                    return;
                  }
                  setState(() {
                    isLoading = true;
                  });
                  String phone =
                      "+${selectedCountry.phoneCode}${phoneController.text.trim()}";
                  await sendOtp(phone);
                  setState(() {
                    isLoading = false;
                  });
                },

                label: 'Send OTP',
              ),
        ],
      ),
    );
  }
}
