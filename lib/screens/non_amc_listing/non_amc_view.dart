import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:serviceapp/components/app_refresh.dart';
import '../../components/app_background.dart';
import '../../components/app_empty.dart';
import '../../components/rounded_loader.dart';
import '../../utils/my_theme.dart';
import '../../utils/my_utils.dart';
import '../../utils/routes.dart';
import 'non_amc_controller.dart';

class NonAmcView extends GetView<NonAmcController> {
  const NonAmcView({Key? key}) : super(key: key);

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
                    "Non-AMC Request View",
                    style: MyTheme.regularTextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: Get.height * 0.020,
                    ),
                  ),
                  SizedBox(height: Get.height * 0.01),
                  Expanded(
                    child: Obx(
                      () => controller.isScreenProgress.value
                          ? Center(child: RoundedLoader())
                          : controller.nonFeedbackList.isEmpty
                              ? Center(child: Text('No services found'))
                              : RefreshIndicator(
                                  onRefresh: () async {
                                    await controller
                                        .initialProductListt(); // Refresh function
                                  },
                                  child:
                                      BuildCardWidget(controller: controller),
                                ),
                    ),
                  )
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
  final NonAmcController controller;

  const BuildCardWidget({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: controller.nonFeedbackList.length,
      itemBuilder: (context, index) {
        final amcDetail = controller.nonFeedbackList[index];
        final isFeedbackSubmitted = controller.feedbackSubmitted[amcDetail.id] ?? false;

        return Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          width: double.infinity,
          height: Get.height * 0.2,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(17),
            border: Border.all(color: Colors.white, width: 1),
          ),
          child: Padding(
            padding: EdgeInsets.only(top: 10, right: 10, left: 20, bottom: 10),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    if (!isFeedbackSubmitted) {
                      // Navigate to the NonFeedbackView and pass the current NonAMC id
                      Get.toNamed(
                        Routes.nonamcFeedackrequest,
                        arguments: {
                          'nonamcserviceId': amcDetail.id,
                          // Passing the NonAMC id to the feedback page
                        },
                      );
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        isFeedbackSubmitted
                            ? "Thank you for your feedback"
                            : "Write Your Feedback",
                        style: MyTheme.regularTextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: Get.height * 0.018,
                          color: Colors.indigo,
                        ),
                      ),
                      if (!isFeedbackSubmitted) ...[
                        SizedBox(width: Get.width * 0.02),
                        Icon(
                          Icons.edit,
                          color: Colors.indigo,
                        ),
                      ],
                    ],
                  ),
                ),
                SizedBox(height: Get.height * 0.02),
                Row(
                  children: [
                    Container(
                      width: Get.width * 0.014,
                      height: Get.height * 0.05,
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
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Non-AMC id",
                                  style: MyTheme.regularTextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: Get.height * 0.018,
                                  ),
                                ),
                                SizedBox(height: Get.height * 0.001),
                                Container(
                                  width: Get.width * 0.4,
                                  child: Text(
                                    amcDetail.id != null && amcDetail.id! > 0
                                        ? amcDetail.id!.toString()
                                        : '-----',
                                    style: MyTheme.regularTextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: Get.height * 0.018,
                                    ),
                                  ),
                                ),
                              ],
                            ),
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
                                      Color.fromRGBO(34, 61, 192, 1),
                                    ],
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                  ),
                                ),
                              ),
                              SizedBox(width: Get.width * 0.01),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Service Date",
                                    style: MyTheme.regularTextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: Get.height * 0.018,
                                    ),
                                  ),
                                  SizedBox(height: Get.height * 0.001),
                                  Container(
                                    width: Get.width * 0.4,
                                    child: Text(
                                      amcDetail.serviceDate != null &&
                                          amcDetail.serviceDate!.isNotEmpty
                                          ? amcDetail.serviceDate!
                                          : '-----',
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
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: Get.height * 0.02),
                Row(
                  children: [
                    Container(
                      width: Get.width * 0.014,
                      height: Get.height * 0.05,
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
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "No of ACs Covered",
                                  style: MyTheme.regularTextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: Get.height * 0.018,
                                  ),
                                ),
                                SizedBox(height: Get.height * 0.001),
                                Container(
                                  width: Get.width * 0.4,
                                  child: Text(
                                    amcDetail.productCount != null &&
                                        amcDetail.productCount!.isNotEmpty
                                        ? amcDetail.productCount!
                                        : '-----',
                                    style: MyTheme.regularTextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: Get.height * 0.018,
                                    ),
                                  ),
                                ),
                              ],
                            ),
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
                                      Color.fromRGBO(34, 61, 192, 1),
                                    ],
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                  ),
                                ),
                              ),
                              SizedBox(width: Get.width * 0.01),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Service Demands",
                                    style: MyTheme.regularTextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: Get.height * 0.018,
                                    ),
                                  ),
                                  SizedBox(height: Get.height * 0.001),
                                  Container(
                                    width: Get.width * 0.4,
                                    child: Text(
                                      amcDetail.demand != null && amcDetail.demand!.isNotEmpty
                                          ? amcDetail.demand!
                                          : '-----',
                                      style: MyTheme.regularTextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: Get.height * 0.018,
                                      ),
                                      maxLines: 2, // Set the maximum number of lines
                                      overflow: TextOverflow.ellipsis, // Use ellipsis if the text overflows
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
                )
              ],
            ),
          ),
        );
      },
    );
  }
}


