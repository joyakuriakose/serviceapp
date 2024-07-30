import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:serviceapp/screens/product_listing/pro_listing_controller.dart';
import 'package:serviceapp/screens/service_history/service_controller.dart';

import '../../components/app_background.dart';
import '../../components/app_empty.dart';
import '../../components/app_refresh.dart';
import '../../components/rounded_loader.dart';
import '../../utils/my_theme.dart';
import '../../utils/my_utils.dart';
import '../../utils/routes.dart';

class ServiceHistory extends GetView<ServiceHistoryController> {
  const ServiceHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          MyUtils.hideKeyboard();
        },
        child: Scaffold(
            body: Background(
                child: Padding(
          padding: EdgeInsets.only(left: 17.0, right: 17),
          child: AppRefresh(
            refreshFunction: () => controller.refresh(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Image.asset(
                        'assets/png/applogo.png',
                        width: Get.width * 0.12,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: Get.height * 0.02),
                Text(
                  "Service History",
                  style: MyTheme.regularTextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: Get.height * 0.027,
                  ),
                ),
                SizedBox(height: Get.height * 0.01),
                Expanded(
                  child: Obx(
                    () => controller.isScreenProgress.value
                        ? Center(child: RoundedLoader())
                        : BuildCardWidget(controller: controller),
                  ),
                ),
              ],
            ),
          ),
        )),
          bottomNavigationBar: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              backgroundColor: Color.fromRGBO(34, 61, 192, 1),
              // Blue background color
              // Make the background transparent to show the container's color
              elevation: 0,
              // Remove sh adow
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 30,
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home_outlined,
                    color: Colors.white,
                    size: 30,
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.menu,
                    color: Colors.white,
                    size: 30,
                  ),
                  label: '',
                ),
              ],
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.white70,
              onTap: (index) {
                switch (index) {
                  case 0:
                    Get.back(); // Replace with your home route
                    break;
                  case 1:
                    Get.toNamed(Routes.acListing);
                    break;
                  case 2:
                    Get.toNamed(Routes
                        .productListView); // Replace with your settings route
                    break;
                }
              },
            ),
          ),
        ));
  }
}

class BuildCardWidget extends StatelessWidget {
  final ServiceHistoryController controller;

  const BuildCardWidget({Key? key, required this.controller}) : super(key: key);

  String _formatDate(DateTime? dateTime) {
    if (dateTime != null) {
      return "${dateTime.year}-${dateTime.month}-${dateTime.day}";
    } else {
      return "--------"; // Display a message for null values
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      bool isLoading = controller.isLoading.value;
      final serviseHis = controller.serviceHistory;
      if (isLoading) {
        Future.delayed(Duration(seconds: 2), () {
          controller.isLoading.value = false;
        });
        return Center(
          child: Padding(
            padding: EdgeInsets.only(top: Get.height * 0.3),
            child: RoundedLoader(),
          ),
        );
      } else if (serviseHis.isEmpty) {
        return Center(
          child: MAResultEmpty(
            msg: 'Results Empty',
          ),
        );
      } else {
        return ListView.builder(
        itemCount:controller.serviceHistory.length,
        itemBuilder: (BuildContext context, int index) {
          final SerHis = serviseHis[index];
          return Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              width: double.infinity,
              //height: Get.height * 0.780,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(17),
                border: Border.all(color: Colors.white, width: 1),
              ),
              child: Padding(
                  padding: EdgeInsets.only(top: 15.0, left: 0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 20.0, right: 15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: Get.width * 0.014,
                                    height: Get.height * 0.05,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Color.fromRGBO(66, 94, 236, 1),
                                          // Start color
                                          Color.fromRGBO(34, 61, 192, 1),
                                          // End color
                                        ],
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: Get.width * 0.02),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "AMC Code",
                                        style: MyTheme.regularTextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: Get.height * 0.018,
                                        ),
                                      ),
                                      SizedBox(height: Get.height * 0.001),
                                      Text(
                                        SerHis.amcCode ?? "----",
                                        style: MyTheme.regularTextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: Get.height * 0.018,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(width: Get.width * 0.18),
                              Row(
                                children: [
                                  Container(
                                    width: Get.width * 0.014,
                                    height: Get.height * 0.05,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Color.fromRGBO(66, 94, 236, 1),
                                          // Start color
                                          Color.fromRGBO(34, 61, 192, 1),
                                          // End color
                                        ],
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: Get.width * 0.02),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Service Date",
                                        style: MyTheme.regularTextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: Get.height * 0.018,
                                        ),
                                      ),
                                      SizedBox(height: Get.height * 0.001),
                                      Text(
                                        SerHis.serviceDate ?? "----",
                                        style: MyTheme.regularTextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: Get.height * 0.018,
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: 20.0, right: 20.0, top: 15, bottom: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: Get.width * 0.014,
                                    height: Get.height * 0.05,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Color.fromRGBO(66, 94, 236, 1),
                                          // Start color
                                          Color.fromRGBO(34, 61, 192, 1),
                                          // End color
                                        ],
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: Get.width * 0.02),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "No.of AC's Covered",
                                        style: MyTheme.regularTextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: Get.height * 0.018,
                                        ),
                                      ),
                                      SizedBox(height: Get.height * 0.001),
                                      Text(
                                        SerHis.productCount ?? "----",
                                        style: MyTheme.regularTextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: Get.height * 0.018,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(width: Get.width * 0.03),
                              Row(
                                children: [
                                  Container(
                                    width: Get.width * 0.014,
                                    height: Get.height * 0.05,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Color.fromRGBO(66, 94, 236, 1),
                                          // Start color
                                          Color.fromRGBO(34, 61, 192, 1),
                                          // End color
                                        ],
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: Get.width * 0.02),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Service Request Type",
                                        style: MyTheme.regularTextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: Get.height * 0.018,
                                        ),
                                      ),
                                      SizedBox(height: Get.height * 0.001),
                                      Text(
                                        SerHis.amcType ?? "----",
                                        style: MyTheme.regularTextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: Get.height * 0.018,
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: 20.0, right: 20.0, bottom: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: Get.width * 0.014,
                                    height: Get.height * 0.05,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Color.fromRGBO(66, 94, 236, 1),
                                          // Start color
                                          Color.fromRGBO(34, 61, 192, 1),
                                          // End color
                                        ],
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: Get.width * 0.02),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Service Demands",
                                        style: MyTheme.regularTextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: Get.height * 0.018,
                                        ),
                                      ),
                                      SizedBox(height: Get.height * 0.001),
                                      Text(
                                        SerHis.demand ?? "----",
                                        style: MyTheme.regularTextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: Get.height * 0.018,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ])));
        });}});
  }
}
