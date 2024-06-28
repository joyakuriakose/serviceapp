import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Background extends StatelessWidget {
  final Widget child;

  const Background({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(6, 6, 6, 1),
      // Set Scaffold background color to RGBA(6, 6, 6, 1)
      resizeToAvoidBottomInset: false,
      body: SizedBox(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
              top: Get.height * 0.157,
              right: Get.width * 0.480,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.transparent.withOpacity(0.06),
                  // Set container color to transparent
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 300,
                      color: Color.fromRGBO(66, 94, 236, 0.5).withOpacity(
                          0.4), // Blueish shadow color with 50% opacity
                    ),
                  ],
                ),
                width: 250,
                height: 250,
              ),
            ),
            Positioned(
              top: Get.height * 0.571,
              left: Get.width * 0.700,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.transparent.withOpacity(0.06),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 100,
                      color: Color.fromRGBO(66, 94, 236, 0.5).withOpacity(
                          0.4), // Blueish shadow color with 50% opacity
                    ),
                  ],
                ),
                width: 250,
                height: 250,
              ),
            ),
            SafeArea(child: child),
          ],
        ),
      ),
    );
  }
}
