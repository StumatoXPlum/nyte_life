// import 'package:flutter/material.dart';
// import 'package:bubble_chart/bubble_chart.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import '../../core/custom_back_button.dart';
// import '../../core/custom_continue.dart';
// import '../home_screen.dart';

// class BubbleScreen extends StatefulWidget {
//   final List<String> preferences;
//   final String name;
//   const BubbleScreen({
//     super.key,
//     required this.preferences,
//     required this.name,
//   });

//   @override
//   State<BubbleScreen> createState() => _BubbleScreenState();
// }

// class _BubbleScreenState extends State<BubbleScreen> {
//   late List<BubbleNode> bubbles;

//   @override
//   void initState() {
//     super.initState();

//     bubbles =
//         widget.preferences.map((preference) {
//           return BubbleNode.leaf(
//             value: preference.length.toDouble(),
//             options: BubbleOptions(
//               color: Color(0xffD3AF37),
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Center(
//                   child: Text(
//                     preference,
//                     style: TextStyle(color: Colors.white, fontFamily: 'britti'),
//                     textAlign: TextAlign.center,
//                   ),
//                 ),
//               ),
//             ),
//           );
//         }).toList();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Column(
//         children: [
//           CustomBackButton(onTap: () => Navigator.pop(context)),
//           SizedBox(height: 180.h),
//           Text(
//             "Hey ${widget.name}! Thanks for choosing us",
//             style: TextStyle(
//               fontSize: 64.sp,
//               fontFamily: 'britti',
//               fontWeight: FontWeight.bold,
//             ),
//             textAlign: TextAlign.center,
//           ),
//           SizedBox(height: 40.h),
//           Text(
//             "Deselect the bubble if it doesn't \napply to you",
//             style: TextStyle(
//               color: Color(0xffD3AF37),
//               fontSize: 58.sp,
//               fontFamily: 'britti',
//               fontWeight: FontWeight.w500,
//             ),
//             textAlign: TextAlign.center,
//           ),
//           SizedBox(height: 80.h),
//           Expanded(
//             child: Padding(
//               padding: EdgeInsets.symmetric(horizontal: 182.w),
//               child: BubbleChartLayout(padding: 1, children: bubbles),
//             ),
//           ),
//           Spacer(),
//           Align(
//             alignment: Alignment.center,
//             child: CustomContinue(
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => HomeScreen()),
//                 );
//               },
//             ),
//           ),
//           SizedBox(height: 153.h),
//         ],
//       ),
//     );
//   }
// }
