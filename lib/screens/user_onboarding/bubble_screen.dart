import 'dart:math';
import 'package:flutter/material.dart';
import 'package:nytelife/core/custom_back_button.dart';
import 'package:nytelife/core/custom_continue.dart';
import 'package:nytelife/screens/home_screen.dart';

class BubbleScreen extends StatefulWidget {
  final List<String> preferences;
  final String name;
  const BubbleScreen({
    super.key,
    required this.preferences,
    required this.name,
  });

  @override
  State<BubbleScreen> createState() => _BubbleScreenState();
}

class _BubbleScreenState extends State<BubbleScreen> {
  late List<Map<String, dynamic>> bubbles;
  final Random random = Random();
  late Set<String> selectedValues;

  @override
  void initState() {
    super.initState();
    bubbles = [];
    selectedValues = widget.preferences.toSet();
    WidgetsBinding.instance.addPostFrameCallback((_) => _generateBubbles());
  }

  void _generateBubbles() {
    final size = MediaQuery.of(context).size;
    final double screenWidth = size.width;
    final double screenHeight = size.height * 0.6;

    List<Rect> occupied = [];

    for (var value in widget.preferences) {
      double bubbleSize = random.nextDouble() * 50 + 50;

      Rect newRect;
      int attempts = 0;
      do {
        double left = random.nextDouble() * (screenWidth - bubbleSize);
        double top = random.nextDouble() * (screenHeight - bubbleSize);
        newRect = Rect.fromLTWH(left, top, bubbleSize, bubbleSize);
        attempts++;
      } while (_checkOverlap(newRect, occupied) && attempts < 300);

      if (attempts < 300) {
        occupied.add(newRect);
        bubbles.add({
          'value': value,
          'left': newRect.left,
          'top': newRect.top,
          'size': bubbleSize,
        });
      }
    }
  }

  bool _checkOverlap(Rect newRect, List<Rect> occupied) {
    for (var rect in occupied) {
      if (newRect.overlaps(rect.inflate(12))) {
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    double padding = size.width * 0.05;
    double fontSize = size.width * 0.045;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: padding * 2, top: padding * 2),
            child: CustomBackButton(onTap: () => Navigator.pop(context)),
          ),
          SizedBox(height: size.height * 0.02),
          Text(
            "Hey ${widget.name}! Thanks for choosing us",
            style: TextStyle(
              fontSize: fontSize * 1.3,
              fontFamily: 'britti',
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: size.height * 0.01),
          Text(
            "Deselect the bubble if it doesn't \napply to you",
            style: TextStyle(
              color: Color(0xffD3AF37),
              fontSize: fontSize,
              fontFamily: 'britti',
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          Expanded(
            child: Stack(
              children:
                  bubbles
                      .map(
                        (bubble) => _buildBubble(
                          bubble['value'],
                          bubble['left'],
                          bubble['top'],
                          bubble['size'],
                        ),
                      )
                      .toList(),
            ),
          ),
          CustomContinue(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
              );
            },
          ),
          SizedBox(height: size.height * 0.05),
        ],
      ),
    );
  }

  Widget _buildBubble(String value, double left, double top, double sizePx) {
    double fontSize = MediaQuery.of(context).size.width * 0.045;

    return Positioned(
      left: left,
      top: top,
      child: Container(
        width: sizePx,
        height: sizePx,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xffD3AF37),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            value,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: fontSize * 0.8,
              fontFamily: 'britti',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
