import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nytelife/core/custom_widgets/custom_continue.dart';
import 'package:nytelife/screens/booking/view/booking_details.dart';
import 'package:nytelife/screens/dining/models/reviews_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DiningDetailScreen extends StatefulWidget {
  final Map<String, dynamic> dining;

  const DiningDetailScreen({super.key, required this.dining});

  @override
  State<DiningDetailScreen> createState() => DiningDetailScreenState();
}

class DiningDetailScreenState extends State<DiningDetailScreen> {
  late Future<List<ReviewsModel>> _reviewsFuture;

  @override
  void initState() {
    super.initState();
    _reviewsFuture = fetchReviews();
  }

  Future<List<ReviewsModel>> fetchReviews() async {
    final response = await Supabase.instance.client
        .from('reviews')
        .select()
        .order('created_at', ascending: false);

    return (response as List)
        .map((reviewData) => ReviewsModel.fromJson(reviewData))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final customPadding = EdgeInsets.symmetric(horizontal: 20.w);
    final userId = Supabase.instance.client.auth.currentUser?.id ?? '';
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12.r),
                  child: Image.network(
                    widget.dining['image_url'],
                    height: 300.h,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  left: 20.w,
                  top: 50.h,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white70,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                        size: 24.sp,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: customPadding,
                  child: Text(
                    widget.dining['title'],
                    style: TextStyle(
                      fontSize: 26.sp,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'britti',
                    ),
                  ),
                ),
                Spacer(),
                Padding(
                  padding: customPadding,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                    child: Text(
                      '★ ${widget.dining['rating'].toString()}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'britti',
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            Padding(
              padding: customPadding,
              child: Text(
                widget.dining['description'],
                style: TextStyle(
                  fontSize: 18.sp,
                  color: Colors.black87,
                  fontFamily: 'britti',
                ),
              ),
            ),
            SizedBox(height: 20.h),
            Padding(
              padding: customPadding,
              child: Text(
                'Reviews',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'britti',
                ),
              ),
            ),
            FutureBuilder<List<ReviewsModel>>(
              future: _reviewsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                final reviews = snapshot.data!;
                return SizedBox(
                  height: 150.h,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: reviews.length,
                    padding: EdgeInsets.all(16.r),
                    itemBuilder: (context, index) {
                      final review = reviews[index];
                      return Container(
                        width: 280.w,
                        margin: EdgeInsets.only(right: 12.w),
                        padding: EdgeInsets.all(16.r),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(color: Colors.black12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withValues(alpha: 0.5),
                              spreadRadius: 1,
                              blurRadius: 4,
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 160.w,
                                  child: Text(
                                    review.reviewerName,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'britti',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.sp,
                                    ),
                                  ),
                                ),
                                Spacer(),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 10.w,
                                    vertical: 4.h,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4.r),
                                    color: Colors.black,
                                  ),
                                  child: Text(
                                    '★ ${review.rating}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'britti',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10.h),
                            Text(
                              review.review,
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'britti',
                                fontSize: 14.sp,
                                overflow: TextOverflow.ellipsis,
                              ),
                              maxLines: 2,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              },
            ),
            SizedBox(height: 20.h),
            Align(
              alignment: Alignment.center,
              child: CustomContinue(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => BookingDetails(
                            onDateSlotChanged: (String selectedDate) {},
                            onTimeSlotChanged: (String selectedTime) {},
                            dining: widget.dining,
                            userId: userId,
                          ),
                    ),
                  );
                },
                label: 'Book a Table',
              ),
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}
