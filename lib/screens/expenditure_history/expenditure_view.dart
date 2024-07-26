import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:serviceapp/screens/product_listing/pro_listing_controller.dart';

import '../../components/app_background.dart';
import '../../components/app_empty.dart';
import '../../components/app_refresh.dart';
import '../../components/rounded_loader.dart';
import '../../utils/my_theme.dart';
import '../../utils/my_utils.dart';
import 'expenditure_controller.dart';

class ExpenditureHistory extends GetView<ExpenditureController> {
  const ExpenditureHistory({Key? key}) : super(key: key);

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
                  "Expenditure History",
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
        ))));
  }
}

class BuildCardWidget extends StatelessWidget {
  final ExpenditureController controller;

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
      final expendHis = controller.expenditureHistoryy;
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
      } else if (expendHis.isEmpty) {
        return Center(
          child: MAResultEmpty(
            msg: 'Results Empty',
          ),
        );
      } else {
        return ListView.builder(
            itemCount: controller.expenditureHistoryy.length,
            itemBuilder: (BuildContext context, int index) {
              final expendHist = expendHis[index];
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
                              padding: EdgeInsets.only(left: 20.0, right: 20.0),
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
                                            expendHist.amcCode ?? "----",
                                            style: MyTheme.regularTextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: Get.height * 0.018,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(width: Get.width * 0.21),
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
                                            "Date",
                                            style: MyTheme.regularTextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: Get.height * 0.018,
                                            ),
                                          ),
                                          SizedBox(height: Get.height * 0.001),
                                          Text(
                                            expendHist.serviceDate ?? "----",
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
                                  left: 20.0, right: 20.0, top: 15),
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
                                            "No. of AC's Covered",
                                            style: MyTheme.regularTextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: Get.height * 0.018,
                                            ),
                                          ),
                                          SizedBox(height: Get.height * 0.001),
                                          Text(
                                            expendHist.productCount ?? "----",
                                            style: MyTheme.regularTextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: Get.height * 0.018,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(width: Get.width * 0.05),
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
                                            "Maintenance Fee",
                                            style: MyTheme.regularTextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: Get.height * 0.018,
                                            ),
                                          ),
                                          SizedBox(height: Get.height * 0.001),
                                          Text(
                                            expendHist.maintenenceCharge ??
                                                "----",
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
                                  left: 20.0, right: 20.0, top: 15),
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
                                            "Spare Part Fee",
                                            style: MyTheme.regularTextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: Get.height * 0.018,
                                            ),
                                          ),
                                          SizedBox(height: Get.height * 0.001),
                                          Text(
                                            expendHist.sparepartsCharge ??
                                                "----",
                                            style: MyTheme.regularTextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: Get.height * 0.018,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(width: Get.width * 0.14),
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
                                            "Any Other Charges",
                                            style: MyTheme.regularTextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: Get.height * 0.018,
                                            ),
                                          ),
                                          SizedBox(height: Get.height * 0.001),
                                          Text(
                                            expendHist.otherCharge ?? "----",
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
                                            "Status",
                                            style: MyTheme.regularTextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: Get.height * 0.018,
                                            ),
                                          ),
                                          SizedBox(height: Get.height * 0.001),
                                          Text(
                                            expendHist.status ?? "----",
                                            style: MyTheme.regularTextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: Get.height * 0.018,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(width: Get.width * 0.29),
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
                                            "Total Fee",
                                            style: MyTheme.regularTextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: Get.height * 0.018,
                                            ),
                                          ),
                                          SizedBox(height: Get.height * 0.001),
                                          Text(
                                            expendHist.totalCharge ?? "----",
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
                          ])));
            });
      }
    });
  }
}
