import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nytelife/screens/events/view/event_detail_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class GigsWidget extends StatefulWidget {
  const GigsWidget({super.key});

  @override
  State<GigsWidget> createState() => GigsWidgetState();
}

class GigsWidgetState extends State<GigsWidget> {
  final SupabaseClient supabase = Supabase.instance.client;
  List<Map<String, dynamic>> eventData = [];

  @override
  void initState() {
    super.initState();
    fetchEventData();
  }

  Future<void> fetchEventData() async {
    final response =
        await supabase
                .from('gig_images')
                .select('url, title,rating,description')
            as List;

    setState(() {
      eventData =
          response
              .map(
                (item) => {
                  'url': item['url'],
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
    if (eventData.isEmpty) {
      return Center(child: CircularProgressIndicator());
    }

    return Column(
      children: [
        ListView.builder(
          padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 120.h),
          itemCount: eventData.length,
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
                              EventDetailScreen(event: eventData[index]),
                    ),
                  );
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12.r),
                      child: Image.network(
                        eventData[index]['url'],
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
                          eventData[index]['title'],
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
                            '★ ${eventData[index]['rating']}',
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
