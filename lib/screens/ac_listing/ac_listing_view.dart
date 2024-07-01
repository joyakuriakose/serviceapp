import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

import '../../app.dart';
import '../../components/app_background.dart';
import '../../components/app_buttons.dart';
import '../../components/rounded_loader.dart';
import '../../model/package_listing_model.dart';
import '../../utils/my_theme.dart';
import '../../utils/my_utils.dart';
import '../../utils/routes.dart';
import 'ac_listing_controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';


class AcListingView extends GetView<AcListingController> {
  const AcListingView({Key? key}) : super(key: key);
  String _formatDate(DateTime? dateTime) {
    if (dateTime != null) {
      return "${dateTime.year}-${dateTime.month}-${dateTime.day}";
    } else {
      return "--------"; // Display a message for null values
    }
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          MyUtils.hideKeyboard();
        },
        child: Scaffold(
            body: Stack(children: [
          RefreshIndicator(
            key: controller.refreshIndicatorKey,
            onRefresh: () async {
              controller.refresh();
            },
            color: Colors.yellow,
            backgroundColor: Colors.red,
            strokeWidth: 5,
            displacement: 200,
            edgeOffset: 20,
            triggerMode: RefreshIndicatorTriggerMode.onEdge,
            child: Background(
              child: Padding(
                padding: EdgeInsets.only(left: 20.0, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(
                          'assets/png/applogo.png',
                          width: Get.width * 0.12,
                        ),
                        IconButton(
                          onPressed: () {
                            Get.toNamed(Routes.notificationsPage);
                          },
                          icon: Icon(
                            Icons.notifications_none_outlined,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: Get.height * 0.05),
                    Text(
                      "Customer Details",
                      style: MyTheme.regularTextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: Get.height * 0.019,
                      ),
                    ),
                    SizedBox(height: Get.height * 0.03),
                    Obx(() {
                      if (controller.isScreenProgress.value) {
                        return Center(child: RoundedLoader());
                      } else {
                        if (controller.customer.isNotEmpty) {
                          final customer = controller.customer[0];
                          return Column(
                            children: [
                              Row(
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
                                              Color.fromRGBO(34, 61, 192, 1),
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
                                            "Name",
                                            style: MyTheme.regularTextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: Get.height * 0.018,
                                            ),
                                          ),
                                          SizedBox(height: Get.height * 0.001),
                                          Container(
                                            width: Get.width * 0.4,
                                            child: Text(
                                              "${customer.name ?? ''}",
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
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Email",
                                            style: MyTheme.regularTextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: Get.height * 0.018,
                                            ),
                                          ),
                                          SizedBox(height: Get.height * 0.001),
                                          Container(
                                            width: Get.width * 0.4,
                                            child: Text(
                                              "${customer.email ?? ''}",
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
                              SizedBox(height: Get.height * 0.01),
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
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Mobile",
                                        style: MyTheme.regularTextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: Get.height * 0.018,
                                        ),
                                      ),
                                      SizedBox(height: Get.height * 0.001),
                                      Container(
                                        width: Get.width * 0.4,
                                        child: Text(
                                          "${customer.phone ?? ''}",
                                          style: MyTheme.regularTextStyle(
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white,
                                            fontSize: Get.height * 0.018,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          );
                        } else {
                          return Center(
                            child: RoundedLoader(),
                          );
                        }
                      }
                    }),
                    SizedBox(height: Get.height * 0.02),
                    // Add some space before the ListView
                    Expanded(
                      child: Stack(children: [
                        Obx(() {
                          if (controller.amcdetail.isEmpty) {
                            return Center(child: RoundedLoader());
                          } else {
                            return ListView.builder(
                              itemCount: controller.amcdetail.length,
                              itemBuilder: (context, index) {
                                final amcDetail = controller.amcdetail[index];
                                return InkWell(
                                  onTap: () {
                                    Get.toNamed(Routes.detailPage,
                                        arguments: amcDetail.amcId,preventDuplicates: true);
                                  //  Get.toNamed(Routes.detailPage, arguments: amcDetail.amcId);
                                  },

                                  child: Container(
                                      margin: EdgeInsets.symmetric(vertical: 10),
                                      width: double.infinity,
                                      height: Get.height * 0.380,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(17),
                                        border: Border.all(
                                            color: Colors.white, width: 1),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            top: 30,
                                            right: 10,
                                            left: 20,
                                            bottom: 10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  "AMC ID : ",
                                                  style: MyTheme.regularTextStyle(
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: Get.height * 0.019,
                                                  ),
                                                ),
                                                Text(
                                                  amcDetail.code != null && amcDetail.code!.isNotEmpty
                                                      ? amcDetail.code!
                                                      : '-----',
                                                  style: MyTheme.regularTextStyle(
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: Get.height * 0.019,
                                                  ),
                                                ),

                                              ],
                                            ),
                                            SizedBox(height: Get.height * 0.023),
                                            Row(
                                              children: [
                                                Container(
                                                  width: Get.width * 0.014,
                                                  height: Get.height * 0.05,
                                                  decoration: BoxDecoration(
                                                    gradient: LinearGradient(
                                                      colors: [
                                                        Color.fromRGBO(
                                                            66, 94, 236, 1),
                                                        // Start color
                                                        Color.fromRGBO(
                                                            34, 61, 192, 1),
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
                                                      "AMC Package Name",
                                                      style: MyTheme
                                                          .regularTextStyle(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize:
                                                            Get.height * 0.018,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                        height:
                                                            Get.height * 0.001),
                                                    Container(
                                                      width: Get.width * 0.4,
                                                      child: Text(
                                                        amcDetail.packageName != null && amcDetail.packageName!.isNotEmpty
                                                            ? amcDetail.packageName!
                                                            : '-----',
                                                        style: MyTheme
                                                            .regularTextStyle(
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          fontSize:
                                                              Get.height * 0.018,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: Get.height * 0.03),
                                            Row(
                                              children: [
                                                Container(
                                                  width: Get.width * 0.014,
                                                  height: Get.height * 0.05,
                                                  decoration: BoxDecoration(
                                                    gradient: LinearGradient(
                                                      colors: [
                                                        Color.fromRGBO(
                                                            66, 94, 236, 1),
                                                        // Start color
                                                        Color.fromRGBO(
                                                            34, 61, 192, 1),
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
                                                      "No. of AC's Covered Under Package   ",
                                                      style: MyTheme
                                                          .regularTextStyle(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize:
                                                            Get.height * 0.018,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                        height:
                                                            Get.height * 0.001),
                                                    Container(
                                                      width: Get.width * 0.4,
                                                      child: Text(
                                                        amcDetail.productCount != null && amcDetail.productCount! > 0
                                                            ? amcDetail.productCount!.toString()
                                                            : '------',
                                                        style: MyTheme
                                                            .regularTextStyle(
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          fontSize:
                                                              Get.height * 0.018,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: Get.height * 0.03),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Container(
                                                      width: Get.width * 0.014,
                                                      height: Get.height * 0.05,
                                                      decoration: BoxDecoration(
                                                        gradient: LinearGradient(
                                                          colors: [
                                                            Color.fromRGBO(
                                                                66, 94, 236, 1),
                                                            // Start color
                                                            Color.fromRGBO(
                                                                34, 61, 192, 1),
                                                            // End color
                                                          ],
                                                          begin: Alignment
                                                              .centerLeft,
                                                          end: Alignment
                                                              .centerRight,
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                        width: Get.width * 0.02),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          "AMC Start Date",
                                                          style: MyTheme
                                                              .regularTextStyle(
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize: Get.height *
                                                                0.018,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                            height: Get.height *
                                                                0.001),
                                                        Text(
                                                         // ' ${_formatDate(amcDetail.startDate) ?? ''}',
                                                          amcDetail.startDate != null
                                                              ? _formatDate(amcDetail.startDate!)
                                                              : '-----',

                                                          style: MyTheme
                                                              .regularTextStyle(
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            fontSize: Get.height *
                                                                0.018,
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
                                                            Color.fromRGBO(
                                                                66, 94, 236, 1),
                                                            // Start color
                                                            Color.fromRGBO(
                                                                34, 61, 192, 1),
                                                            // End color
                                                          ],
                                                          begin: Alignment
                                                              .centerLeft,
                                                          end: Alignment
                                                              .centerRight,
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                        width: Get.width * 0.02),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          "AMC End Date",
                                                          style: MyTheme
                                                              .regularTextStyle(
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize: Get.height *
                                                                0.018,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                            height: Get.height *
                                                                0.001),
                                                        Text(
                                                          amcDetail.endDate != null
                                                              ? _formatDate(amcDetail.endDate!)
                                                              : '-----',

                                                          style: MyTheme
                                                              .regularTextStyle(
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            fontSize: Get.height *
                                                                0.018,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: Get.height * 0.019),
                                            Text(
                                              "If you have any specific service request\nplease add here",
                                              style: MyTheme.regularTextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: Get.height * 0.018,
                                              ),
                                            ),
                                          ],
                                        ),
                                      )),
                                );
                              },
                            );
                          }
                        }),
                        Positioned(
                          bottom: 5,
                          left: 20,
                          right: 20,
                          child: Center(
                            child: MAButton(
                              text: 'Service Request',
                              buttonPress: () async {
                                Get.toNamed(Routes.service);
                              },
                              isEnabled: true,
                              padding: const EdgeInsets.all(30),
                              height: Get.height * 0.06,
                              width: Get.width * 0.5,
                              clipBehavior: 0,
                              radius: 30,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ]),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ])));
  }
}



// class AcListingView extends StatelessWidget {
//   final AcListingController acListingController =
//       Get.find<AcListingController>();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Customer Details'),
//       ),
//       body: Obx(() {
//         if (acListingController.amcdetail.isEmpty &&
//             acListingController.customer.isEmpty) {
//           return Center(child: CircularProgressIndicator());
//         } else {
//           return ListView.builder(
//             itemCount: acListingController.customer.length,
//             itemBuilder: (context, index) {
//               final customer = acListingController.customer[index];
//               final amcDetail = acListingController.amcdetail[index];
//               return ListTile(
//                 title: Text(customer.name.toString() ?? ''),
//                 subtitle: Text(customer.email ?? ''),
//                 trailing: Column(
//                   crossAxisAlignment: CrossAxisAlignment.end,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text('AMC Code: ${amcDetail.code ?? ''}'),
//                     Text(
//                         'Package Name: ${amcDetail.packageName.toString() ?? ''}'),
//                   ],
//                 ),
//               );
//             },
//           );
//         }
//       }),
//     );
//   }
// }