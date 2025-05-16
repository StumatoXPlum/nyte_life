import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class GoodEventsWidget extends StatefulWidget {
  const GoodEventsWidget({super.key});

  @override
  State<GoodEventsWidget> createState() => GoodEventsWidgetState();
}

class GoodEventsWidgetState extends State<GoodEventsWidget> {
  final SupabaseClient supabase = Supabase.instance.client;
  final PageController _pageController = PageController(
    viewportFraction: 0.8,
    initialPage: 1,
  );
  List<String> imageUrls = [];
  int currentPage = 1;

  @override
  void initState() {
    super.initState();
    fetchTrendingImages();
  }

  Future<void> fetchTrendingImages() async {
    final response =
        await supabase.from('good_events_images').select('url') as List;

    final List<String> urls =
        response.map((item) => item['url'] as String).toList();

    setState(() {
      imageUrls = urls;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (imageUrls.isEmpty) {
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
            itemCount: imageUrls.length,
            onPageChanged: (index) {
              setState(() {
                currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.r),
                  child: Image.network(imageUrls[index], fit: BoxFit.cover),
                ),
              );
            },
          ),
        ),
        SizedBox(height: 10.h),
        SmoothPageIndicator(
          controller: _pageController,
          count: imageUrls.length,
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
