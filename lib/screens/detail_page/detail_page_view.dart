import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:get_storage/get_storage.dart';

import '../../app.dart';
import '../../components/app_background.dart';
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
          padding: EdgeInsets.only(left: 20.0, right: 20),
          child: Obx(
            () => controller.isScreenProgress.value == true
                ? Column(
                    children: const [
                      Expanded(child: Center(child: RoundedLoader()))
                    ],
                  )
                : BuildCardWidget(controller: controller),
          ),
        ))));
  }
}

class BuildCardWidget extends StatelessWidget {
  final DetailPageController controller;

  const BuildCardWidget({Key? key, required this.controller}) : super(key: key);

  String _formatDate(DateTime? dateTime) {
    if (dateTime != null) {
      return "${dateTime.day}-${dateTime.month}-${dateTime.year}";
    } else {
      return "--------"; // Display a message for null values
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.notifications_none_outlined,
                color: Colors.white,
              ))
        ],
      ),
      SizedBox(height: Get.height * 0.02),
      Text(
        controller.amcdetails.value.amcCode.toString() ?? "",
        style: MyTheme.regularTextStyle(
          fontWeight: FontWeight.w500,
          fontSize: Get.height * 0.027,
        ),
      ),
      SizedBox(height: Get.height * 0.01),
      Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        width: double.infinity,
        height: Get.height * 0.780,
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
                              "Model Name",
                              style: MyTheme.regularTextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: Get.height * 0.018,
                              ),
                            ),
                            SizedBox(height: Get.height * 0.001),
                            Text(
                              controller.amcdetails.value.modelName ?? "------",
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
                                getStatusText(
                                    controller.amcdetails.value.amcStatus),
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
                              "Status of First AMC",
                              style: MyTheme.regularTextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: Get.height * 0.018,
                              ),
                            ),
                            SizedBox(height: Get.height * 0.001),
                            Text(
                              getStatusText(controller
                                  .amcdetails.value.serviceDates![0].status),
                              style: MyTheme.regularTextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: Get.height * 0.018,
                              ),
                            ),
                            SizedBox(height: Get.height * 0.001),
                            if (controller
                                    .amcdetails.value.serviceDates![0].status ==
                                "3")
                            Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Get.toNamed(Routes.feedback);
                                  },
                                  child: Text(
                                    "Write Your Feedback",
                                    style: MyTheme.regularTextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: Get.height * 0.018,
                                      color: Colors.indigo,
                                    ),
                                  ),
                                ),
                                SizedBox(width: Get.width * 0.02),
                                Icon(
                                  Icons.edit,
                                  color: Colors.indigo,
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
                              _formatDate(controller
                                  .amcdetails.value.serviceDates![0].date),
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
                              "Status of Second AMC",
                              style: MyTheme.regularTextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: Get.height * 0.018,
                              ),
                            ),
                            SizedBox(height: Get.height * 0.001),
                            Text(
                              getStatusText(controller
                                  .amcdetails.value.serviceDates![1].status),
                              style: MyTheme.regularTextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: Get.height * 0.018,
                              ),
                            ),
                            SizedBox(height: Get.height * 0.001),
                            if (controller
                                    .amcdetails.value.serviceDates![1].status ==
                                "3")
                              Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Get.toNamed(Routes.feedback);
                                    },
                                    child: Text(
                                      "Write Your Feedback",
                                      style: MyTheme.regularTextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: Get.height * 0.018,
                                        color: Colors.indigo,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: Get.width * 0.02),
                                  Icon(
                                    Icons.edit,
                                    color: Colors.indigo,
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
                              _formatDate(controller
                                  .amcdetails.value.serviceDates![1].date),
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
                                  .amcdetails.value.serviceDates![2].status),
                              style: MyTheme.regularTextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: Get.height * 0.018,
                              ),
                            ),
                            SizedBox(height: Get.height * 0.001),
                            if (controller
                                    .amcdetails.value.serviceDates![2].status ==
                                "3")
                            Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Get.toNamed(Routes.feedback);
                                  },
                                  child: Text(
                                    "Write Your Feedback",
                                    style: MyTheme.regularTextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: Get.height * 0.018,
                                      color: Colors.indigo,
                                    ),
                                  ),
                                ),
                                SizedBox(width: Get.width * 0.02),
                                Icon(
                                  Icons.edit,
                                  color: Colors.indigo,
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
                              _formatDate(controller
                                  .amcdetails.value.serviceDates![2].date),
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
                                  .amcdetails.value.serviceDates![3].status),
                              style: MyTheme.regularTextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: Get.height * 0.018,
                              ),
                            ),
                            SizedBox(height: Get.height * 0.001),
                            if (controller
                                    .amcdetails.value.serviceDates![3].status ==
                                "3")
                            Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Get.toNamed(Routes.feedback);
                                  },
                                  child: Text(
                                    "Write Your Feedback",
                                    style: MyTheme.regularTextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: Get.height * 0.018,
                                      color: Colors.indigo,
                                    ),
                                  ),
                                ),
                                SizedBox(width: Get.width * 0.02),
                                Icon(
                                  Icons.edit,
                                  color: Colors.indigo,
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
                              _formatDate(controller
                                  .amcdetails.value.serviceDates![3].date),
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
                          "No. of AC's Covered Under Package   ",
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
                              "AMC Start Date",
                              style: MyTheme.regularTextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: Get.height * 0.018,
                              ),
                            ),
                            SizedBox(height: Get.height * 0.001),
                            Text(
                              _formatDate(controller.amcdetails.value.amcStart),
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
      ),
    ]);
  }
}

String getStatusText(String? status) {
  switch (status) {
    case "1":
      return "Open";
    case "2":
      return "Ongoing";
    case "3":
      return "Closed";
    case "4":
      return "Expired";
    default:
      return "Unknown";
  }
}
