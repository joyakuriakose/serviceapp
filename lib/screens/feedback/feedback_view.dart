import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

import '../../components/app_background.dart';
import '../../components/app_buttons.dart';
import '../../utils/my_theme.dart';
import '../../utils/my_utils.dart';
import '../../utils/routes.dart';
import 'feedback_controller.dart';

class FeedbackView extends GetView<FeedbackController> {
  const FeedbackView({Key? key}) : super(key: key);

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
                    child: ListView(children: [
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Get.toNamed(Routes.acListing);
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
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: Get.height * 0.02),
                            Text(
                              "Customer Feedback",
                              style: MyTheme.regularTextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: Get.height * 0.027,
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
                                      "AMC ID",
                                      style: MyTheme.regularTextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: Get.height * 0.018,
                                      ),
                                    ),
                                    SizedBox(height: Get.height * 0.001),
                                    Container(
                                      width: Get.width * 0.4,
                                      child: Text(
                                        "1101",
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
                            SizedBox(height: Get.height * 0.02),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: Get.width * 0.014,
                                      height: Get.height * 0.03,
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
                                    Text(
                                      "How satisfied are you with our service?",
                                      style: MyTheme.regularTextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: Get.height * 0.016,
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: 10, left: 10, right: 135),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            width: 12,
                                            height: 12,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                  color: Colors.white,
                                                  width: 1),
                                            ),
                                          ),
                                          SizedBox(width: Get.width * 0.02),
                                          Text(
                                            "Very Satisfied",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 13,
                                                fontWeight: FontWeight.w700),
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            width: 12,
                                            height: 12,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                  color: Colors.white,
                                                  width: 1),
                                            ),
                                          ),
                                          SizedBox(width: Get.width * 0.02),
                                          Text(
                                            "Satisfied",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 13,
                                                fontWeight: FontWeight.w700),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: 10, left: 10, right: 90),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            width: 12,
                                            height: 12,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                  color: Colors.white,
                                                  width: 1),
                                            ),
                                          ),
                                          SizedBox(width: Get.width * 0.02),
                                          Text(
                                            "Dissatisfied",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 13,
                                                fontWeight: FontWeight.w700),
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            width: 12,
                                            height: 12,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                  color: Colors.white,
                                                  width: 1),
                                            ),
                                          ),
                                          SizedBox(width: Get.width * 0.02),
                                          Text(
                                            "Very dissatisfied",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 13,
                                                fontWeight: FontWeight.w700),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(height: Get.height * 0.02),
                                Row(
                                  children: [
                                    Container(
                                      width: Get.width * 0.014,
                                      height: Get.height * 0.03,
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
                                    Container(
                                      width: Get.width * 0.8,
                                      child: Text(
                                        "How would you rate the professionalism of our service technician?",
                                        style: MyTheme.regularTextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: Get.height * 0.016,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: 10, left: 10, right: 160),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            width: 12,
                                            height: 12,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                  color: Colors.white,
                                                  width: 1),
                                            ),
                                          ),
                                          SizedBox(width: Get.width * 0.02),
                                          Text(
                                            "Excellent",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 13,
                                                fontWeight: FontWeight.w700),
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            width: 12,
                                            height: 12,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                  color: Colors.white,
                                                  width: 1),
                                            ),
                                          ),
                                          SizedBox(width: Get.width * 0.02),
                                          Text(
                                            "Good",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 13,
                                                fontWeight: FontWeight.w700),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: 10, left: 10, right: 160),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            width: 12,
                                            height: 12,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                  color: Colors.white,
                                                  width: 1),
                                            ),
                                          ),
                                          SizedBox(width: Get.width * 0.02),
                                          Text(
                                            "Fair",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 13,
                                                fontWeight: FontWeight.w700),
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            width: 12,
                                            height: 12,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                  color: Colors.white,
                                                  width: 1),
                                            ),
                                          ),
                                          SizedBox(width: Get.width * 0.02),
                                          Text(
                                            "Poor",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 13,
                                                fontWeight: FontWeight.w700),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(height: Get.height * 0.02),
                                Row(
                                  children: [
                                    Container(
                                      width: Get.width * 0.014,
                                      height: Get.height * 0.03,
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
                                    Container(
                                      width: Get.width * 0.8,
                                      child: Text(
                                        "How likely are you to recommend our service to others?",
                                        style: MyTheme.regularTextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: Get.height * 0.016,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: 10, left: 10, right: 155),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            width: 12,
                                            height: 12,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                  color: Colors.white,
                                                  width: 1),
                                            ),
                                          ),
                                          SizedBox(width: Get.width * 0.02),
                                          Text(
                                            "Very Likely",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 13,
                                                fontWeight: FontWeight.w700),
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            width: 12,
                                            height: 12,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                  color: Colors.white,
                                                  width: 1),
                                            ),
                                          ),
                                          SizedBox(width: Get.width * 0.02),
                                          Text(
                                            "Likely",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 13,
                                                fontWeight: FontWeight.w700),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: 10, left: 10, right: 150),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            width: 12,
                                            height: 12,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                  color: Colors.white,
                                                  width: 1),
                                            ),
                                          ),
                                          SizedBox(width: Get.width * 0.02),
                                          Text(
                                            "Unlikely",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 13,
                                                fontWeight: FontWeight.w700),
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            width: 12,
                                            height: 12,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                  color: Colors.white,
                                                  width: 1),
                                            ),
                                          ),
                                          SizedBox(width: Get.width * 0.02),
                                          Text(
                                            "Did not",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 13,
                                                fontWeight: FontWeight.w700),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: Get.height * 0.03),
                            Text(
                              "Rate Us",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 19),
                            ),
                            SizedBox(height: Get.height * 0.01),
                            Row(
                              children: [
                                Icon(
                                  Icons.star_border_purple500_outlined,
                                  color: Colors.white,
                                ),
                                SizedBox(width: Get.width * 0.01),
                                Icon(
                                  Icons.star_border_purple500_outlined,
                                  color: Colors.white,
                                ),
                                SizedBox(width: Get.width * 0.01),
                                Icon(
                                  Icons.star_border_purple500_outlined,
                                  color: Colors.white,
                                ),
                                SizedBox(width: Get.width * 0.01),
                                Icon(
                                  Icons.star_border_purple500_outlined,
                                  color: Colors.white,
                                ),
                                SizedBox(width: Get.width * 0.01),
                                Icon(
                                  Icons.star_border_purple500_outlined,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                            SizedBox(height: Get.height * 0.02),
                            Container(
                              width: double.infinity,
                              height: Get.height * 0.150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(17),
                                border: Border.all(color: Colors.white, width: 1),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: TextFormField(
                                  controller: controller.feedbackController,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: controller.isFeedbackEmpty
                                        ? "Write Your Feedback...."
                                        : null,
                                    hintStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: Get.height * 0.02),
                            Center(
                              child: MAButton(
                                text: 'Submit',
                                buttonPress: () async {
                                  Get.toNamed(Routes.acListing);
                                },
                                isEnabled: true,
                                padding: const EdgeInsets.all(30),
                                height: Get.height * 0.06,
                                width: Get.width * 0.4,
                                clipBehavior: 0,
                                radius: 30,
                                fontSize: 20,
                              ),
                            ),
                          ]),
                    ])))));
  }
}
