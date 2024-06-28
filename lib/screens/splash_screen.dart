import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:serviceapp/components/app_background.dart';
import '../app.dart';
import '../utils/local_store.dart';
import '../utils/my_theme.dart';
import '../utils/routes.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await FetchDataFromLocalStore().userData();
      App.token = App.user.apiToken ?? '';
      log("token>>${App.user.apiToken}");
      await checkAlreadyLogged();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Center(
              child: Padding(
                padding: EdgeInsets.only(top: Get.height * 0.35),
                child: Column(
                  children: [
                    Image.asset('assets/png/applogo.png'),
                    SizedBox(height: Get.height * 0.015),
                    Text(
                      "TIPS & PLANS".toUpperCase(),
                      style: MyTheme.regularTextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: Get.height * 0.037,
                      ),
                    ),
                    Text(
                      "air condition solutions".toUpperCase(),
                      style: MyTheme.regularTextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: Get.height * 0.018,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 25,
              child: Text(
                "Sign In To Continue",
                style: MyTheme.regularTextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: Get.height * 0.020,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  Future<void> checkAlreadyLogged() async {
    await Future.delayed(const Duration(milliseconds: 1400));

    if (App.token.isNotEmpty) {
      Get.offAllNamed(Routes.acListing);
    } else {
      Get.offAllNamed(Routes.login);
    }
  }
}