import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../view/dining_detail_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DiningNearYouWidget extends StatefulWidget {
  const DiningNearYouWidget({super.key});

  @override
  State<DiningNearYouWidget> createState() => DiningNearYouWidgetState();
}

class DiningNearYouWidgetState extends State<DiningNearYouWidget> {
  final SupabaseClient supabase = Supabase.instance.client;
  List<Map<String, dynamic>> diningData = [];

  @override
  void initState() {
    super.initState();
    fetchDiningNearYou();
  }

  Future<void> fetchDiningNearYou() async {
    final response =
        await supabase
                .from('dining_near_you')
                .select('image_url, title, rating, description')
            as List;

    setState(() {
      diningData =
          response
              .map(
                (item) => {
                  'image_url': item['image_url'],
                  'title': item['title'],
                  'rating': item['rating'],
                  'description': item['description'],
                },
              )
              .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (diningData.isEmpty) {
      return Center(child: CircularProgressIndicator());
    }

    return Column(
      children: [
        ListView.builder(
          padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 60.h),
          itemCount: diningData.length,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(bottom: 16.h),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) =>
                              HomeDetailScreen(dining: diningData[index]),
                    ),
                  );
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12.r),
                      child: Image.network(
                        diningData[index]['image_url'],
                        height: 180.h,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          diningData[index]['title'],
                          style: TextStyle(
                            fontSize: 22.sp,
                            fontFamily: 'britti',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            '★ ${diningData[index]['rating']}',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontFamily: 'britti',
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
