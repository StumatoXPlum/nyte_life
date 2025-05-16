import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nytelife/screens/dining/widgets/dining_filter.dart';
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
  String selectedFilter = 'All';

  @override
  void initState() {
    super.initState();
    fetchDiningNearYou();
  }

  Future<void> fetchDiningNearYou() async {
    List response;

    if (selectedFilter == 'All') {
      response = await supabase
          .from('dining_near_you')
          .select('image_url, title, rating, description, type');
    } else {
      response = await supabase
          .from('dining_near_you')
          .select('image_url, title, rating, description, type')
          .eq('type', selectedFilter);
    }

    setState(() {
      diningData =
          response
              .map<Map<String, dynamic>>(
                (item) => {
                  'image_url': item['image_url'],
                  'title': item['title'],
                  'rating': item['rating'],
                  'description': item['description'],
                  'type': item['type'],
                },
              )
              .toList();
    });
  }

  void onFilterChanged(String newFilter) {
    setState(() {
      selectedFilter = newFilter;
    });
    fetchDiningNearYou();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DiningFilter(
          selectedFilter: selectedFilter,
          onFilterChange: onFilterChanged,
        ),
        SizedBox(height: 20.h),
        diningData.isEmpty
            ? Padding(
              padding: EdgeInsets.all(20.h),
              child: Center(child: CircularProgressIndicator()),
            )
            : ListView.builder(
              padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 60.h),
              itemCount: diningData.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final data = diningData[index];
                return Padding(
                  padding: EdgeInsets.only(bottom: 16.h),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => DiningDetailScreen(dining: data),
                        ),
                      );
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12.r),
                          child: Image.network(
                            data['image_url'],
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
                              data['title'],
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
                                '★ ${data['rating']}',
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
