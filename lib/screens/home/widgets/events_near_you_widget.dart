import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../view/home_detail_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class EventsNearYouWidget extends StatefulWidget {
  const EventsNearYouWidget({super.key});

  @override
  State<EventsNearYouWidget> createState() => _EventsNearYouWidgetState();
}

class _EventsNearYouWidgetState extends State<EventsNearYouWidget> {
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
                .from('events_near_you')
                .select('image_url, title, rating, description')
            as List;

    setState(() {
      eventData =
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
    if (eventData.isEmpty) {
      return Center(child: CircularProgressIndicator());
    }

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TriangleShape(direction: TriangleDirection.left),
            SizedBox(width: 8.w),
            Text(
              "Places Near You",
              style: TextStyle(fontSize: 30.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(width: 8.w),
            TriangleShape(direction: TriangleDirection.right),
          ],
        ),
        SizedBox(height: 20.h),

        Padding(
          padding: EdgeInsets.only(left: 20.w),
          child: Row(
            spacing: 14.w,
            children: [
              Container(
                decoration: BoxDecoration(),
                child: SvgPicture.asset(
                  "assets/filter.svg",
                  height: 15.h,
                  width: 15.w,
                  fit: BoxFit.scaleDown,
                ),
              ),
              FilterWidget(title: "Continental"),
              FilterWidget(title: "Indian"),
              FilterWidget(title: "Asian"),
              FilterWidget(title: "Italian"),
            ],
          ),
        ),
        SizedBox(height: 20.h),
        ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
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
                              HomeDetailScreen(event: eventData[index]),
                    ),
                  );
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12.r),
                      child: Image.network(
                        eventData[index]['image_url'],
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

class FilterWidget extends StatelessWidget {
  final String title;
  const FilterWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Colors.black26, width: 1),
      ),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16.sp,
          color: Colors.black,
          fontFamily: 'britti',
        ),
      ),
    );
  }
}

enum TriangleDirection { left, right }

class TriangleShape extends StatelessWidget {
  final TriangleDirection direction;

  const TriangleShape({super.key, required this.direction});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: _TriangleClipper(direction),
      child: Container(width: 50.w, height: 10.h, color: Color(0xffD3AF37)),
    );
  }
}

class _TriangleClipper extends CustomClipper<Path> {
  final TriangleDirection direction;

  _TriangleClipper(this.direction);

  @override
  Path getClip(Size size) {
    final path = Path();
    if (direction == TriangleDirection.right) {
      path.moveTo(0, 0);
      path.lineTo(size.width, size.height / 2);
      path.lineTo(0, size.height);
    } else {
      path.moveTo(size.width, 0);
      path.lineTo(0, size.height / 2);
      path.lineTo(size.width, size.height);
    }
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
