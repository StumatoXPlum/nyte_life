import 'package:flutter/material.dart';
import 'package:nytelife/core/custom_back_button.dart';
import 'package:nytelife/core/custom_continue.dart';
import 'package:nytelife/screens/home_screen.dart';

class BubbleScreen extends StatefulWidget {
  const BubbleScreen({super.key});

  @override
  State<BubbleScreen> createState() => _BubbleScreenState();
}

class _BubbleScreenState extends State<BubbleScreen> {
  final List<Map<String, dynamic>> bubbles = [
    {
      'title': 'Gender',
      'value': 'Male',
      'left': 0.0,
      'top': 0.11,
      'size': 0.22,
    },
    {'title': 'Name', 'value': 'John', 'left': 0.22, 'top': 0.05, 'size': 0.35},
    {
      'title': 'Birthday',
      'value': '25th May',
      'left': 0.59,
      'top': 0.07,
      'size': 0.22,
    },
    {
      'title': 'Favourite',
      'value': 'Mexican',
      'left': 0.04,
      'top': 0.21,
      'size': 0.4,
    },
    {'title': 'Drinker', 'value': 'No', 'left': 0.45, 'top': 0.18, 'size': 0.4},
    {'title': 'Smoker', 'value': 'No', 'left': 0.38, 'top': 0.36, 'size': 0.24},
  ];

  Set<String> selectedValues = {};

  @override
  void initState() {
    super.initState();
    selectedValues = bubbles.map((b) => b['value'] as String).toSet();
  }

  void toggleSelection(String value) {
    setState(() {
      if (selectedValues.contains(value)) {
        selectedValues.remove(value);
      } else {
        selectedValues.add(value);
      }
    });
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
            padding: EdgeInsets.only(left: padding * 2),
            child: CustomBackButton(onTap: () => Navigator.pop(context)),
          ),
          SizedBox(height: size.height * 0.05),
          Text(
            "Hey John! Thanks for choosing us",
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
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: padding),
                child: Stack(
                  children:
                      bubbles
                          .map(
                            (bubble) => _buildBubble(
                              bubble['title'],
                              bubble['value'],
                              bubble['left'],
                              bubble['top'],
                              bubble['size'],
                            ),
                          )
                          .toList(),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: CustomContinue(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              },
            ),
          ),
          SizedBox(height: size.height * 0.05),
        ],
      ),
    );
  }

  Widget _buildBubble(
    String title,
    String value,
    double leftFactor,
    double topFactor,
    double sizeFactor,
  ) {
    final isSelected = selectedValues.contains(value);
    final size = MediaQuery.of(context).size;
    double padding = size.width * 0.03;
    double fontSize = size.width * 0.05;
    final bubbleSize = size.width * sizeFactor;

    return Positioned(
      left: size.width * leftFactor,
      top: size.height * topFactor,
      child: GestureDetector(
        onTap: () => toggleSelection(value),
        child: Container(
          width: bubbleSize,
          height: bubbleSize,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isSelected ? Color(0xffD3AF37) : Colors.grey[300],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(title, style: TextStyle(fontFamily: 'britti')),
              SizedBox(height: size.height * 0.01),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: padding * 0.6,
                  vertical: padding * 0.2,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(32),
                ),
                child: Text(
                  value,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: fontSize * 0.8,
                    fontFamily: 'britti',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
