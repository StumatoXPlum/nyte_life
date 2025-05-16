import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:nytelife/screens/events/view/event_detail_screen.dart';

class TrendingEvents extends StatefulWidget {
  const TrendingEvents({super.key});

  @override
  State<TrendingEvents> createState() => TrendingEventsState();
}

class TrendingEventsState extends State<TrendingEvents> {
  final SupabaseClient supabase = Supabase.instance.client;
  final PageController _pageController = PageController(
    viewportFraction: 0.8,
    initialPage: 1,
  );

  List<Map<String, dynamic>> trendingEvents = [];
  int currentPage = 1;

  @override
  void initState() {
    super.initState();
    fetchTrendingImages();
  }

  Future<void> fetchTrendingImages() async {
    final response =
        await supabase
                .from('trending_events')
                .select(
                  'url, title, rating, description, date, time, location, event_fee',
                )
            as List;

    setState(() {
      trendingEvents =
          response
              .map(
                (item) => {
                  'url': item['url'],
                  'title': item['title'],
                  'rating': item['rating'],
                  'description': item['description'],
                  'date': item['date'],
                  'time': item['time'],
                  'location': item['location'],
                  'event_fee': item['event_fee'],
                },
              )
              .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (trendingEvents.isEmpty) {
      return SizedBox(
        height: 200.h,
        child: const Center(child: CircularProgressIndicator()),
      );
    }

    return Column(
      children: [
        SizedBox(
          height: 180.h,
          child: PageView.builder(
            controller: _pageController,
            itemCount: trendingEvents.length,
            onPageChanged: (index) {
              setState(() {
                currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              final event = trendingEvents[index];

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => EventDetailScreen(event: event),
                    ),
                  );
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.r),
                    child: Image.network(event['url'], fit: BoxFit.cover),
                  ),
                ),
              );
            },
          ),
        ),
        SizedBox(height: 10.h),
        SmoothPageIndicator(
          controller: _pageController,
          count: trendingEvents.length,
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
