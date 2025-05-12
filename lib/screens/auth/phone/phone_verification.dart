import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:nytelife/core/custom_widgets/custom_back_button.dart';
import 'package:nytelife/core/custom_widgets/custom_continue.dart';
import 'package:nytelife/screens/user_onboarding/preferences.dart';
import 'package:pinput/pinput.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../core/constants.dart';

class PhoneVerification extends StatefulWidget {
  final String phoneNumber;

  const PhoneVerification({super.key, required this.phoneNumber});

  @override
  State<PhoneVerification> createState() => _PhoneVerificationState();
}

class _PhoneVerificationState extends State<PhoneVerification> {
  final TextEditingController otpController = TextEditingController();
  bool isLoading = false;

  void showError(String message) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message, style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  Future<void> verifyOtp(
    String phoneNumber,
    String otpCode,
    BuildContext context,
  ) async {
    try {
      const String twilioAccountSID = AppSecrets.twilioAccountSID;
      const String twilioAuthToken = AppSecrets.twilioAuthToken;
      const String twilioServiceSid = AppSecrets.twilioServiceSid;

      final Uri url = Uri.parse(
        "https://verify.twilio.com/v2/Services/$twilioServiceSid/VerificationCheck",
      );

      final String basicAuth =
          'Basic ${base64Encode(utf8.encode('$twilioAccountSID:$twilioAuthToken'))}';

      print("Verifying OTP $otpCode for $phoneNumber");

      final response = await http.post(
        url,
        headers: {
          'Authorization': basicAuth,
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {'To': phoneNumber, 'Code': otpCode},
      );

      print("Status: ${response.statusCode}");
      print("Body: ${response.body}");

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final responseData = jsonDecode(response.body);

        if (responseData['status'] == 'approved') {
          final supabase = Supabase.instance.client;

          await supabase.from('users').upsert({'phone_number': phoneNumber});

          if (context.mounted) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => Preferences()),
            );
          }
        } else {
          showError("OTP not approved. Please check again.");
        }
      } else {
        showError("Verification failed. Please try again.");
      }
    } catch (e) {
      print("Error: $e");
      showError("Something went wrong. Please try again.");
    }
  }

  Future<void> resendOtp() async {
    const String twilioAccountSID = AppSecrets.twilioAccountSID;
    const String twilioAuthToken = AppSecrets.twilioAuthToken;
    const String twilioServiceSid = AppSecrets.twilioServiceSid;

    final Uri url = Uri.parse(
      "https://verify.twilio.com/v2/Services/$twilioServiceSid/Verifications",
    );

    final String basicAuth =
        'Basic ${base64Encode(utf8.encode('$twilioAccountSID:$twilioAuthToken'))}';

    final response = await http.post(
      url,
      headers: {
        'Authorization': basicAuth,
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: {'To': widget.phoneNumber, 'Channel': 'sms'},
    );

    if (response.statusCode >= 200 && response.statusCode < 300) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("New OTP Sent"),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.green,
        ),
      );
    } else {
      showError("Failed to send new OTP");
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    double fontSize = size.width * 0.05;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomBackButton(onTap: () => Navigator.pop(context)),
            SizedBox(height: 50.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              child: Text(
                "Verify your phone number",
                style: TextStyle(
                  fontSize: fontSize * 1.8,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: size.height * 0.02),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              child: Text(
                "We've sent an SMS with an activation code to your phone ${widget.phoneNumber}",
                style: TextStyle(fontSize: fontSize, color: Colors.black),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: size.height * 0.1),
            Pinput(
              controller: otpController,
              length: 6,
              defaultPinTheme: PinTheme(
                width: 50,
                height: 60,
                textStyle: TextStyle(fontSize: fontSize, color: Colors.black),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.black),
                ),
              ),
            ),
            SizedBox(height: size.height * 0.03),
            TextButton(
              onPressed: resendOtp,
              child: Text(
                "Didn't receive code? Resend",
                style: TextStyle(fontSize: fontSize * 0.8, color: Colors.black),
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
            isLoading
                ? CircularProgressIndicator(color: Colors.black)
                : CustomContinue(
                  onTap: () async {
                    String otp = otpController.text.trim();
                    if (otp.isEmpty || otp.length < 6) {
                      showError("Enter the 6-digit OTP");
                      return;
                    }
                    setState(() => isLoading = true);
                    await verifyOtp(widget.phoneNumber, otp, context);
                    setState(() => isLoading = false);
                  },
                  label: "Verify",
                ),
          ],
        ),
      ),
    );
  }
}
