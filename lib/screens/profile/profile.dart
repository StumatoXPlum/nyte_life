// screens/profile/profile.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../core/custom_widgets/custom_back_button.dart';
import '../auth/sign_up_screen.dart/sign_up_screen.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final SupabaseClient supabase = Supabase.instance.client;

  Map<String, dynamic>? userData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    final user = supabase.auth.currentUser;
    if (user == null) {
      setState(() {
        isLoading = false;
      });
      return;
    }

    try {
      final data =
          await supabase.from('users').select().eq('id', user.id).single();

      setState(() {
        userData = Map<String, dynamic>.from(data);
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching user data: $e');
      setState(() {
        isLoading = false;
        userData = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (userData == null) {
      return const Center(child: Text('No user data found.'));
    }
    final foodPrefs = userData!['food_prefs'] as Map<String, dynamic>?;
    final drinkPrefs = userData!['drink_prefs'] as Map<String, dynamic>?;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomBackButton(onTap: () => Navigator.pop(context)),
            SizedBox(height: 20.h),
            Container(
              height: 100.h,
              width: 100.w,
              decoration: BoxDecoration(shape: BoxShape.circle),
              child: ClipOval(
                child: Image.network(
                  'https://plus.unsplash.com/premium_photo-1732757787074-0f95bf19cf73?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NXx8dXNlciUyMGF2YXRhcnxlbnwwfHwwfHx8MA%3D%3D',
                  fit: BoxFit.cover,
                  width: 100.w,
                  height: 100.h,
                ),
              ),
            ),
            SizedBox(height: 10.h),
            Text(
              userData!['name'] ?? 'No Name',
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 40.h),
            _buildInfoField(
              'Phone Number',
              userData!['phone_number'] ?? 'Not Available',
            ),
            SizedBox(height: 20.h),
            _buildInfoField(
              'Date of Birth',
              userData!['date_of_birth'] ?? 'Not Available',
            ),
            SizedBox(height: 20.h),
            _buildInfoField('Gender', userData!['gender'] ?? 'Not Available'),
            SizedBox(height: 20.h),
            _buildInfoField(
              'Location',
              userData!['location'] ?? 'Not Available',
            ),

            if (foodPrefs != null) ...[
              SizedBox(height: 20.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "🍱 Food Preferences",
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      if (foodPrefs['cuisines'] != null)
                        Text(
                          "Cuisines: ${(foodPrefs['cuisines'] as List).join(', ')}",
                        ),
                      if (foodPrefs['food_prefs'] != null)
                        ...((foodPrefs['food_prefs'] as Map<String, dynamic>)
                            .entries
                            .map((e) => Text("${e.key}: ${e.value}"))),
                    ],
                  ),
                ),
              ),
            ],
            if (drinkPrefs != null) ...[
              SizedBox(height: 20.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "🍷 Drinking & Outdoor Preferences",
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      if (drinkPrefs['drinking'] != null)
                        Text("Drinking: ${drinkPrefs['drinking']}"),
                      if (drinkPrefs['smoking'] != null)
                        Text("Smoking: ${drinkPrefs['smoking']}"),
                      if (drinkPrefs['outdoor_settings'] != null)
                        Text(
                          "Outdoor Settings: ${(drinkPrefs['outdoor_settings'] as List).join(', ')}",
                        ),
                    ],
                  ),
                ),
              ),
            ],
            SizedBox(height: 40.h),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignUpScreen()),
                );
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  "Log out",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.sp,
                    fontFamily: 'britti',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: 50.h),
          ],
        ),
      ),
    );
  }
}

Widget _buildInfoField(String label, String value) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 18.w),
    child: Container(
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.5),
            spreadRadius: 1,
            blurRadius: 5,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.black54,
              fontSize: 14.sp,
              fontFamily: 'britti',
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: Colors.black,
              fontSize: 14.sp,
              fontFamily: 'britti',
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    ),
  );
}
