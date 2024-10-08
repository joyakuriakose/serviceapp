import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:get_storage/get_storage.dart';
import 'package:serviceapp/components/app_refresh.dart';

import '../../app.dart';
import '../../components/app_background.dart';
import '../../components/app_empty.dart';
import '../../components/rounded_loader.dart';
import '../../utils/my_theme.dart';
import '../../utils/my_utils.dart';
import '../../utils/routes.dart';
import 'detail_page_controller.dart';

class DetailView extends GetView<DetailPageController> {
  const DetailView({Key? key}) : super(key: key);

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
                      // IconButton(
                      //     onPressed: () {},
                      //     icon: Icon(
                      //       Icons.notifications_none_outlined,
                      //       color: Colors.white,
                      //     ))
                    ],
                  ),
                  SizedBox(height: Get.height * 0.02),
                  Obx(() => controller.isScreenProgress.value
                      ? Container()
                      : Container(
                          width: Get.width * 0.4,
                          child: Text(
                            controller.amcdetails.value.amcCode.toString() ??
                                "",
                            style: MyTheme.regularTextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: Get.height * 0.018,
                            ),
                          ),
                        )),
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
  final DetailPageController controller;

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
    return ListView.builder(
      itemCount: 1,
      itemBuilder: (BuildContext context, int index) {
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
                Image.asset(
                  'assets/png/ac.png',
                  //width: Get.width * 0.10
                ),
                SizedBox(height: Get.height * 0.010),
                Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Row(
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "AMC Package Name",
                            style: MyTheme.regularTextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: Get.height * 0.018,
                            ),
                          ),
                          SizedBox(height: Get.height * 0.001),
                          Container(
                            width: Get.width * 0.4,
                            child: Text(
                              controller.amcdetails.value.packageName ?? "",
                              style: MyTheme.regularTextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: Get.height * 0.018,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: Get.height * 0.017),
                Padding(
                  padding: EdgeInsets.only(left: 20.0, right: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Brand Name",
                                style: MyTheme.regularTextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: Get.height * 0.018,
                                ),
                              ),
                              SizedBox(height: Get.height * 0.001),
                              Text(
                                controller.amcdetails.value.brandName ?? "",
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
                SizedBox(height: Get.height * 0.017),
                Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Row(
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "AMC",
                            style: MyTheme.regularTextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: Get.height * 0.018,
                            ),
                          ),
                          SizedBox(height: Get.height * 0.001),
                          Container(
                            child: Row(
                              children: [
                                Text(
                                  getStatusText(controller
                                      .amcdetails.value.amcStatus
                                      .toString()),
                                  style: MyTheme.regularTextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: Get.height * 0.018,
                                  ),
                                ),
                                SizedBox(
                                  width: Get.width * 0.04,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      controller.amcdetails.value.remainingCount
                                              .toString() ??
                                          "",
                                      style: MyTheme.regularTextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: Get.height * 0.018,
                                          color: Colors.indigo),
                                    ),
                                    Text(
                                      " Out of 3 Free Services",
                                      style: MyTheme.regularTextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: Get.height * 0.018,
                                          color: Colors.indigo),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: Get.height * 0.017),
                Padding(
                  padding: EdgeInsets.only(left: 20.0, right: 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: Get.width * 0.014,
                            height: Get.height * 0.06,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Color.fromRGBO(66, 94, 236, 1),
                                  Color.fromRGBO(34, 61, 192, 1),
                                ],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                            ),
                          ),
                          SizedBox(width: Get.width * 0.02),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Status of First AMC",
                                style: MyTheme.regularTextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: Get.height * 0.018,
                                ),
                              ),
                              SizedBox(height: Get.height * 0.001),
                              Text(
                                getStatusText(controller
                                    .amcdetails.value.serviceDates![0].status
                                    .toString()),
                                style: MyTheme.regularTextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: Get.height * 0.018,
                                ),
                              ),
                              SizedBox(height: Get.height * 0.001),
                              if (controller.amcdetails.value.serviceDates![0]
                                      .status ==
                                  "3")
                                Row(
                                  children: [
                                    controller.amcdetails.value.serviceDates![0]
                                                .feedbackStatus ==
                                            1
                                        ? Text(
                                            "Thank you for your feedback",
                                            style: MyTheme.regularTextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: Get.height * 0.016,
                                              color: Colors.indigo,
                                            ),
                                          )
                                        : InkWell(
                                            onTap: () {
                                              Get.toNamed(Routes.feedback,
                                                  arguments: {
                                                    'amcId':
                                                        controller.amcId ?? 0,
                                                    'serviceId': controller
                                                            .amcdetails
                                                            .value
                                                            .serviceDates![0]
                                                            .serviceId ??
                                                        0,
                                                  });
                                            },
                                            child: Row(
                                              children: [
                                                Text(
                                                  "Write Your Feedback",
                                                  style:
                                                      MyTheme.regularTextStyle(
                                                    fontWeight: FontWeight.w700,
                                                    fontSize:
                                                        Get.height * 0.018,
                                                    color: Colors.indigo,
                                                  ),
                                                ),
                                                SizedBox(
                                                    width: Get.width * 0.02),
                                                Icon(
                                                  Icons.edit,
                                                  color: Colors.indigo,
                                                ),
                                              ],
                                            ),
                                          ),
                                  ],
                                ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(width: Get.width * 0.04),
                      Row(
                        children: [
                          Container(
                            width: Get.width * 0.014,
                            height: Get.height * 0.06,
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Date",
                                style: MyTheme.regularTextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: Get.height * 0.018,
                                ),
                              ),
                              SizedBox(height: Get.height * 0.001),
                              Text(
                                controller.amcdetails.value.serviceDates![0]
                                            .date !=
                                        null
                                    ? _formatDate(controller
                                        .amcdetails.value.serviceDates![0].date)
                                    : '',
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
                SizedBox(height: Get.height * 0.015),
                Padding(
                  padding: EdgeInsets.only(
                    left: 20.0,right: 5
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: Get.width * 0.014,
                            height: Get.height * 0.06,
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Status of Second AMC",
                                style: MyTheme.regularTextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: Get.height * 0.018,
                                ),
                              ),
                              SizedBox(height: Get.height * 0.001),
                              Text(
                                getStatusText(controller
                                    .amcdetails.value.serviceDates![1].status
                                    .toString()),
                                style: MyTheme.regularTextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: Get.height * 0.018,
                                ),
                              ),
                              SizedBox(height: Get.height * 0.001),
                              if (controller.amcdetails.value.serviceDates![1]
                                      .status ==
                                  "3")
                                Row(
                                  children: [
                                    controller.amcdetails.value.serviceDates![1]
                                                .feedbackStatus ==
                                            1
                                        ? Text(
                                            "Thank you for your feedback",
                                            style: MyTheme.regularTextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: Get.height * 0.016,
                                              color: Colors.indigo,
                                            ),
                                          )
                                        : InkWell(
                                            onTap: () {
                                              Get.toNamed(Routes.feedback,
                                                  arguments: {
                                                    'amcId':
                                                        controller.amcId ?? 0,
                                                    // Provide a default value if amcId might be null
                                                    'serviceId': controller
                                                            .amcdetails
                                                            .value
                                                            .serviceDates![1]
                                                            .serviceId ??
                                                        0,
                                                  });
                                            },
                                            child: Row(
                                              children: [
                                                Text(
                                                  "Write Your Feedback",
                                                  style:
                                                      MyTheme.regularTextStyle(
                                                    fontWeight: FontWeight.w700,
                                                    fontSize:
                                                        Get.height * 0.018,
                                                    color: Colors.indigo,
                                                  ),
                                                ),
                                                SizedBox(
                                                    width: Get.width * 0.02),
                                                Icon(
                                                  Icons.edit,
                                                  color: Colors.indigo,
                                                ),
                                              ],
                                            ),
                                          ),
                                  ],
                                ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(width: Get.width * 0.04),
                      Row(
                        children: [
                          Container(
                            width: Get.width * 0.014,
                            height: Get.height * 0.06,
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Date",
                                style: MyTheme.regularTextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: Get.height * 0.018,
                                ),
                              ),
                              SizedBox(height: Get.height * 0.001),
                              Text(
                                controller.amcdetails.value.serviceDates![1]
                                            .date !=
                                        null
                                    ? _formatDate(controller
                                        .amcdetails.value.serviceDates![1].date)
                                    : '.....',
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
                SizedBox(height: Get.height * 0.015),
                Padding(
                  padding: EdgeInsets.only(left: 20.0, right: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: Get.width * 0.014,
                            height: Get.height * 0.06,
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Status of Third AMC",
                                style: MyTheme.regularTextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: Get.height * 0.018,
                                ),
                              ),
                              SizedBox(height: Get.height * 0.001),
                              Text(
                                getStatusText(controller
                                    .amcdetails.value.serviceDates![2].status
                                    .toString()),
                                style: MyTheme.regularTextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: Get.height * 0.018,
                                ),
                              ),
                              SizedBox(height: Get.height * 0.001),
                              if (controller.amcdetails.value.serviceDates![2]
                                      .status ==
                                  "3")
                                Row(
                                  children: [
                                    controller.amcdetails.value.serviceDates![2]
                                                .feedbackStatus ==
                                            1
                                        ? Text(
                                            "Thank you for your feedback",
                                            style: MyTheme.regularTextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: Get.height * 0.016,
                                              color: Colors.indigo,
                                            ),
                                          )
                                        : InkWell(
                                            onTap: () {
                                              Get.toNamed(Routes.feedback,
                                                  arguments: {
                                                    'amcId':
                                                        controller.amcId ?? 0,
                                                    // Provide a default value if amcId might be null
                                                    'serviceId': controller
                                                            .amcdetails
                                                            .value
                                                            .serviceDates![2]
                                                            .serviceId ??
                                                        0,
                                                  });
                                            },
                                            child: Row(
                                              children: [
                                                Text(
                                                  "Write Your Feedback",
                                                  style:
                                                      MyTheme.regularTextStyle(
                                                    fontWeight: FontWeight.w700,
                                                    fontSize:
                                                        Get.height * 0.018,
                                                    color: Colors.indigo,
                                                  ),
                                                ),
                                                SizedBox(
                                                    width: Get.width * 0.02),
                                                Icon(
                                                  Icons.edit,
                                                  color: Colors.indigo,
                                                ),
                                              ],
                                            ),
                                          ),
                                  ],
                                ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            width: Get.width * 0.014,
                            height: Get.height * 0.06,
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Date",
                                style: MyTheme.regularTextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: Get.height * 0.018,
                                ),
                              ),
                              SizedBox(height: Get.height * 0.001),
                              Text(
                                controller.amcdetails.value.serviceDates![2]
                                            .date !=
                                        null
                                    ? _formatDate(controller
                                        .amcdetails.value.serviceDates![2].date)
                                    : '.....',
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
                SizedBox(height: Get.height * 0.015),
                Padding(
                  padding: EdgeInsets.only(left: 20.0, right: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: Get.width * 0.014,
                            height: Get.height * 0.06,
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Paid AMC Status",
                                style: MyTheme.regularTextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: Get.height * 0.018,
                                ),
                              ),
                              SizedBox(height: Get.height * 0.001),
                              Text(
                                getStatusText(controller
                                    .amcdetails.value.serviceDates![3].status
                                    .toString()),
                                style: MyTheme.regularTextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: Get.height * 0.018,
                                ),
                              ),
                              SizedBox(height: Get.height * 0.001),
                              if (controller.amcdetails.value.serviceDates![3]
                                      .status ==
                                  "3")
                                Row(
                                  children: [
                                    controller.amcdetails.value.serviceDates![3]
                                                .feedbackStatus ==
                                            1
                                        ? Text(
                                            "Thank you for your feedback",
                                            style: MyTheme.regularTextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: Get.height * 0.018,
                                              color: Colors.indigo,
                                            ),
                                          )
                                        : InkWell(
                                            onTap: () {
                                              Get.toNamed(Routes.feedback,
                                                  arguments: {
                                                    'amcId':
                                                        controller.amcId ?? 0,
                                                    // Provide a default value if amcId might be null
                                                    'serviceId': controller
                                                            .amcdetails
                                                            .value
                                                            .serviceDates![3]
                                                            .serviceId ??
                                                        0,
                                                  });
                                            },
                                            child: Row(
                                              children: [
                                                Text(
                                                  "Write Your Feedback",
                                                  style:
                                                      MyTheme.regularTextStyle(
                                                    fontWeight: FontWeight.w700,
                                                    fontSize:
                                                        Get.height * 0.018,
                                                    color: Colors.indigo,
                                                  ),
                                                ),
                                                SizedBox(
                                                    width: Get.width * 0.02),
                                                Icon(
                                                  Icons.edit,
                                                  color: Colors.indigo,
                                                ),
                                              ],
                                            ),
                                          ),
                                  ],
                                ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            width: Get.width * 0.014,
                            height: Get.height * 0.06,
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Date",
                                style: MyTheme.regularTextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: Get.height * 0.018,
                                ),
                              ),
                              SizedBox(height: Get.height * 0.001),
                              Text(
                                controller.amcdetails.value.serviceDates![3]
                                            .date !=
                                        null
                                    ? _formatDate(controller
                                        .amcdetails.value.serviceDates![3].date)
                                    : '.....',
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
                SizedBox(height: Get.height * 0.02),
                // Padding(
                //   padding: const EdgeInsets.only(left: 15.0),
                //   child: Text(
                //     "Complete Non-AMC Feedback",
                //     style: MyTheme.regularTextStyle(
                //       fontWeight: FontWeight.w400,
                //       fontSize: Get.height * 0.022,
                //       color: Colors.cyan
                //     ),
                //   ),
                // ),
                // SizedBox(height: Get.height * 0.02),
                // Padding(
                //   padding: EdgeInsets.only(left: 10.0, right: 10.0),
                //   child: Obx(() {
                //     bool isLoading = controller.isLoading.value;
                //     final NonFeedDetail = controller.nonFeedbackList;
                //     if (isLoading) {
                //       Future.delayed(Duration(seconds: 2), () {
                //         controller.isLoading.value = false;
                //       });
                //       return Center(
                //         child: Padding(
                //           padding: EdgeInsets.only(top: Get.height * 0.3),
                //           child: RoundedLoader(),
                //         ),
                //       );
                //     } else if (NonFeedDetail.isEmpty) {
                //       return Center(
                //         child: MAResultEmpty(
                //           msg: 'Results Empty',
                //         ),
                //       );
                //     } else {
                //       return ListView.builder(
                //         shrinkWrap: true,
                //         physics: NeverScrollableScrollPhysics(),
                //         itemCount: controller.nonFeedbackList.length,
                //         itemBuilder: (context, index) {
                //           final amcDetail = controller.nonFeedbackList[index];
                //           return Container(
                //             margin: EdgeInsets.symmetric(vertical: 10),
                //             width: double.infinity,
                //             height: Get.height * 0.13,
                //             decoration: BoxDecoration(
                //               borderRadius: BorderRadius.circular(17),
                //               border: Border.all(color: Colors.white, width: 1),
                //             ),
                //             child: Padding(
                //               padding: EdgeInsets.only(top: 10, right: 10, left: 20, bottom: 10),
                //               child: Column(
                //                 children: [
                //                   GestureDetector(
                //                     onTap: () {
                //                       Get.toNamed(
                //                         Routes.nonamcFeedackrequest,
                //                         arguments: {
                //                           'id': amcDetail.amcType, // Pass the id to the feedback page
                //                         },
                //                       );
                //                     },
                //                     child: Row(
                //                       mainAxisAlignment: MainAxisAlignment.end,
                //                       children: [
                //                         Text(
                //                           "Write Your Feedback",
                //                           style: MyTheme.regularTextStyle(
                //                             fontWeight: FontWeight.w700,
                //                             fontSize: Get.height * 0.018,
                //                             color: Colors.indigo,
                //                           ),
                //                         ),
                //                         SizedBox(width: Get.width * 0.02),
                //                         Icon(
                //                           Icons.edit,
                //                           color: Colors.indigo,
                //                         ),
                //                       ],
                //                     ),
                //                   ),
                //                   SizedBox(height: Get.height * 0.02),
                //                   Row(
                //                     children: [
                //                       Container(
                //                         width: Get.width * 0.014,
                //                         height: Get.height * 0.05,
                //                         decoration: BoxDecoration(
                //                           gradient: LinearGradient(
                //                             colors: [
                //                               Color.fromRGBO(66, 94, 236, 1),
                //                               Color.fromRGBO(34, 61, 192, 1),
                //                             ],
                //                             begin: Alignment.centerLeft,
                //                             end: Alignment.centerRight,
                //                           ),
                //                         ),
                //                       ),
                //                       SizedBox(width: Get.width * 0.02),
                //                       Expanded(
                //                         child: Row(
                //                           children: [
                //                             Expanded(
                //                               child: Column(
                //                                 crossAxisAlignment: CrossAxisAlignment.start,
                //                                 children: [
                //                                   Text(
                //                                     "Non-AMC id",
                //                                     style: MyTheme.regularTextStyle(
                //                                       fontWeight: FontWeight.w400,
                //                                       fontSize: Get.height * 0.018,
                //                                     ),
                //                                   ),
                //                                   SizedBox(height: Get.height * 0.001),
                //                                   Container(
                //                                     width: Get.width * 0.4,
                //                                     child: Text(
                //                                       amcDetail.id != null && amcDetail.id! > 0
                //                                           ? amcDetail.id!.toString()
                //                                           : '-----',
                //                                       style: MyTheme.regularTextStyle(
                //                                         fontWeight: FontWeight.w700,
                //                                         fontSize: Get.height * 0.018,
                //                                       ),
                //                                     ),
                //                                   ),
                //                                 ],
                //                               ),
                //                             ),
                //                             Row(
                //                               children: [
                //                                 Container(
                //                                   width: Get.width * 0.014,
                //                                   height: Get.height * 0.05,
                //                                   decoration: BoxDecoration(
                //                                     gradient: LinearGradient(
                //                                       colors: [
                //                                         Color.fromRGBO(66, 94, 236, 1),
                //                                         Color.fromRGBO(34, 61, 192, 1),
                //                                       ],
                //                                       begin: Alignment.centerLeft,
                //                                       end: Alignment.centerRight,
                //                                     ),
                //                                   ),
                //                                 ),
                //                                 SizedBox(width: Get.width * 0.01),
                //                                 Column(
                //                                   crossAxisAlignment: CrossAxisAlignment.start,
                //                                   children: [
                //                                     Text(
                //                                       "Service Date",
                //                                       style: MyTheme.regularTextStyle(
                //                                         fontWeight: FontWeight.w400,
                //                                         fontSize: Get.height * 0.018,
                //                                       ),
                //                                     ),
                //                                     SizedBox(height: Get.height * 0.001),
                //                                     Container(
                //                                       width: Get.width * 0.4,
                //                                       child: Text(
                //                                         amcDetail.serviceDate != null &&
                //                                             amcDetail.serviceDate!.isNotEmpty
                //                                             ? amcDetail.serviceDate!
                //                                             : '-----',
                //                                         style: MyTheme.regularTextStyle(
                //                                           fontWeight: FontWeight.w700,
                //                                           fontSize: Get.height * 0.018,
                //                                         ),
                //                                       ),
                //                                     ),
                //                                   ],
                //                                 ),
                //                               ],
                //                             ),
                //                           ],
                //                         ),
                //                       ),
                //                     ],
                //                   ),
                //                 ],
                //               ),
                //             ),
                //           );
                //         },
                //       );
                //     }
                //   }),
                // ),
                SizedBox(height: Get.height * 0.015),
                Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Row(
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "No. of AC's Covered Under Package ",
                            style: MyTheme.regularTextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: Get.height * 0.018,
                            ),
                          ),
                          SizedBox(height: Get.height * 0.001),
                          Container(
                            width: Get.width * 0.4,
                            child: Text(
                              controller.amcdetails.value.productCount
                                      ?.toString() ??
                                  "",
                              style: MyTheme.regularTextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: Get.height * 0.018,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: Get.height * 0.017),
                Padding(
                  padding:
                      EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "AMC Start Date",
                                style: MyTheme.regularTextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: Get.height * 0.018,
                                ),
                              ),
                              SizedBox(height: Get.height * 0.001),
                              Text(
                                _formatDate(
                                    controller.amcdetails.value.amcStart),
                                style: MyTheme.regularTextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: Get.height * 0.018,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "AMC End Date",
                                style: MyTheme.regularTextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: Get.height * 0.018,
                                ),
                              ),
                              SizedBox(height: Get.height * 0.001),
                              Text(
                                _formatDate(controller.amcdetails.value.amcEnd),
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
              ],
            ),
          ),
        );
      },
    );
  }
}

String getStatusText(String? status) {
  switch (status) {
    case "1":
      return "Open";
    case "2":
      return "Processing";
    case "3":
      return "Closed";
    case "4":
      return "Expired";
    case "5":
      return "Assigned";
    default:
      return "Unknown";
  }
}
