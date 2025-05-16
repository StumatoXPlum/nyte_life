import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nytelife/screens/dining/view/dining_detail_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class TrendingDiningDeals extends StatefulWidget {
  const TrendingDiningDeals({super.key});

  @override
  State<TrendingDiningDeals> createState() => TrendingDiningDealsState();
}

class TrendingDiningDealsState extends State<TrendingDiningDeals> {
  final SupabaseClient supabase = Supabase.instance.client;
  final PageController _pageController = PageController(
    viewportFraction: 0.8,
    initialPage: 1,
  );
  List<Map<String, dynamic>> diningDeals = [];
  int currentPage = 1;

  @override
  void initState() {
    super.initState();
    fetchTrendingDiningDeals();
  }

  Future<void> fetchTrendingDiningDeals() async {
    final response =
        await supabase
                .from('trending_dining_deals')
                .select('image_url, title, rating, description')
            as List;

    setState(() {
      diningDeals =
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
    if (diningDeals.isEmpty) {
      return SizedBox(
        height: 200.h,
        child: Center(child: CircularProgressIndicator()),
      );
    }

    return Column(
      children: [
        SizedBox(
          height: 180.h,
          child: PageView.builder(
            controller: _pageController,
            itemCount: diningDeals.length,
            onPageChanged: (index) {
              setState(() {
                currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              final deal = diningDeals[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DiningDetailScreen(dining: deal),
                    ),
                  );
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.r),
                    child: Image.network(deal['image_url'], fit: BoxFit.cover),
                  ),
                ),
              );
            },
          ),
        ),
        SizedBox(height: 10.h),
        SmoothPageIndicator(
          controller: _pageController,
          count: diningDeals.length,
          effect: ExpandingDotsEffect(
            activeDotColor: Colors.black,
            dotHeight: 8.h,
            dotWidth: 8.w,
            expansionFactor: 3,
          ),
        ),
      ],
    );
  }
}
