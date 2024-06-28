import 'package:flutter/material.dart';

import '../utils/my_theme.dart';


class MAButton extends StatelessWidget {
  final String text;
  final VoidCallback? buttonPress;
  final bool isEnabled;
  final double height;
  final double width;
  final EdgeInsets padding;
  final double clipBehavior;
  final double radius;
  final double fontSize;



  const MAButton({
    Key? key,
    required this.text,
    this.buttonPress,
    this.isEnabled = true,
    required this.height,
    this.padding = const EdgeInsets.all(16),
    required this.width,
    required this.clipBehavior,
    required this.radius,
    required this.fontSize,

  }) : super(key: key);
  //var icon;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding, //const EdgeInsets.symmetric(horizontal: 20),
      child: GestureDetector(
        onTap: buttonPress,
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(30)),
          child: Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(66, 94, 236, 1), // Start color
                  Color.fromRGBO(34, 61, 192, 1), // End color
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              //  Icon(icon, color: Colors.white,),
                SizedBox(width: 5,),
                Text(
                  text,
                  style:
                      MyTheme.regularTextStyle(color: Colors.white, fontSize: fontSize),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
