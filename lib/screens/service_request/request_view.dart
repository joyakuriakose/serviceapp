import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:serviceapp/screens/service_request/request_controller.dart';
import '../../components/app_background.dart';
import '../../components/app_buttons.dart';
import '../../components/app_dropdown.dart';
import '../../utils/my_theme.dart';
import '../../utils/my_utils.dart';
import '../../utils/routes.dart';

class RequestView extends GetView<RequestController> {
  const RequestView({Key? key}) : super(key: key);

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
            child: ListView(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        // IconButton(
                        //   onPressed: () {},
                        //   icon: Icon(
                        //     Icons.notifications_none_outlined,
                        //     color: Colors.white,
                        //   ),
                        // ),
                      ],
                    ),
                    SizedBox(height: Get.height * 0.02),
                    Text(
                      "Service Request",
                      style: MyTheme.regularTextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: Get.height * 0.027,
                      ),
                    ),
                    SizedBox(height: Get.height * 0.02),
                    Row(
                      children: [
                        // Container(
                        //   width: Get.width * 0.014,
                        //   height: Get.height * 0.05,
                        //   decoration: BoxDecoration(
                        //     gradient: LinearGradient(
                        //       colors: [
                        //         Color.fromRGBO(66, 94, 236, 1), // Start color
                        //         Color.fromRGBO(34, 61, 192, 1), // End color
                        //       ],
                        //       begin: Alignment.centerLeft,
                        //       end: Alignment.centerRight,
                        //     ),
                        //   ),
                        // ),
                        // SizedBox(width: Get.width * 0.02),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: Get.width * 0.014,
                                  height: Get.height * 0.04,
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
                                ),
                                SizedBox(width: Get.width * 0.02),
                                Text(
                                  "Service Request Type",
                                  style: MyTheme.regularTextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: Get.height * 0.018,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              width: Get.width * 0.45,
                              child: Obx(() {
                                return dropDownBox(
                                  controller: controller.serviceRequestController,
                                  FunctioOnchanged: (String? value) {
                                    controller.serviceRequestType.value = value!;
                                    if (value == 'AMC') {
                                      controller.initialAcListt();
                                    } else {
                                      controller.amcCodes.clear();
                                    }
                                  },
                                  ListItem: controller.servicetype.map<DropdownMenuItem<String>>((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          value,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                  ListValue: controller.servicetype.contains(controller.serviceRequestType.value)
                                      ? controller.serviceRequestType.value
                                      : (controller.servicetype.isNotEmpty ? controller.servicetype.first : ''),
                                );
                              }),

                            ),
                            SizedBox(height: Get.height * 0.04),
                            Obx(() {
                              if (controller.serviceRequestType.value == 'AMC') {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: Get.height * 0.02),
                                    Row(
                                      children: [
                                        Container(
                                          width: Get.width * 0.014,
                                          height: Get.height * 0.04,
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
                                        ),
                                        SizedBox(width: Get.width * 0.02),
                                        Text(
                                          "AMC Codes",
                                          style: MyTheme.regularTextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: Get.height * 0.018,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      width: Get.width * 0.45,
                                      child: dropDownBox(
                                        controller: TextEditingController(),
                                        FunctioOnchanged: (String? value) {
                                          if (value != null) {
                                            controller.selectedAmcCode.value = value;
                                          }
                                        },
                                        ListItem: [
                                          DropdownMenuItem<String>(
                                            value: '',
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Text(
                                                'Select', // Placeholder text
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ),
                                          ),
                                          ...controller.amcCodes.map<DropdownMenuItem<String>>((String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Text(
                                                  value,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.white,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ),
                                            );
                                          }).toList(),
                                        ],
                                        ListValue: controller.amcCodes.contains(controller.selectedAmcCode.value)
                                            ? controller.selectedAmcCode.value
                                            : '',
                                      ),
                                    ),

                                  ],
                                );
                              } else if (controller.serviceRequestType.value == 'Non-AMC') {
                                return
                                  Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(height: Get.height * 0.02),
                                          Row(
                                            children: [
                                              Container(
                                                width: Get.width * 0.014,
                                                height: Get.height * 0.04,
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
                                              ),
                                              SizedBox(width: Get.width * 0.02),
                                              Text(
                                                "Select Date",
                                                style: MyTheme.regularTextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: Get.height * 0.018,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: Get.height * 0.001),
                                          Container(
                                            width: Get.width * 0.5,
                                            child: TextFormField(
                                              controller: controller.dateCtrl,
                                              focusNode: controller.dateCtrlfNode,
                                              decoration: textBoxDecoration('').copyWith(
                                                suffixIcon: IconButton(
                                                  icon: Icon(
                                                    Icons.calendar_today,
                                                    color: Colors.indigo,
                                                  ),
                                                  onPressed: () {
                                                    controller.selectDate(context); // Call selectDate function here
                                                  },
                                                ),
                                              ),
                                              style: TextStyle(
                                                color: Colors.white, // Set the text color here
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  );
                              }
                              return SizedBox.shrink();
                            }),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: Get.height * 0.05),
                    Row(
                      children: [
                        // Container(
                        //   width: Get.width * 0.014,
                        //   height: Get.height * 0.05,
                        //   decoration: BoxDecoration(
                        //     gradient: LinearGradient(
                        //       colors: [
                        //         Color.fromRGBO(66, 94, 236, 1), // Start color
                        //         Color.fromRGBO(34, 61, 192, 1), // End color
                        //       ],
                        //       begin: Alignment.centerLeft,
                        //       end: Alignment.centerRight,
                        //     ),
                        //   ),
                        // ),
                        SizedBox(width: Get.width * 0.02),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: Get.width * 0.014,
                                  height: Get.height * 0.04,
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
                                ),
                                SizedBox(width: Get.width * 0.02),
                                Text(
                                  "Service Demands",
                                  style: MyTheme.regularTextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: Get.height * 0.018,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: Get.height * 0.001),
                            Padding(
                              padding: EdgeInsets.only(top: 0.0),
                              child: Container(
                                width: Get.width * 0.8,
                                height: Get.height * 0.08,
                                child: Padding(
                                  padding: EdgeInsets.only(bottom: 8.0),
                                  child: Container(
                                    child: TextFormField(
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 18,
                                      ),
                                      controller: controller.demandsController,
                                      maxLines: 100,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        filled: false,
                                        hintText: 'Enter your service demands',
                                        hintStyle: TextStyle(
                                          color: Colors.grey[700],
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    // SizedBox(height: Get.height * 0.040),
                    // Padding(
                    //   padding: EdgeInsets.only(left: 20),
                    //   child: Container(
                    //     width: Get.width * 0.8,
                    //     height: Get.height * 0.001,
                    //     decoration: BoxDecoration(
                    //       gradient: LinearGradient(
                    //         colors: [
                    //           Color.fromRGBO(221, 208, 208, 1), // Start color
                    //           Color.fromRGBO(221, 208, 208, 1), // End color
                    //         ],
                    //         begin: Alignment.centerLeft,
                    //         end: Alignment.centerRight,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                   // SizedBox(height: Get.height * 0.035),
                    Center(
                      child: MAButton(
                        text: 'Submit',
                        buttonPress: () async {
                          controller.submitServiceRequest();
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
                    SizedBox(height: Get.height * 0.030),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: (){
                            Get.toNamed(Routes.expenditureHistory);
                          },
                          child: Row(
                            children: [
                              Icon(
                                Icons.note_outlined,
                                color: Colors.indigo,
                              ),
                              SizedBox(width: Get.width * 0.010),
                              Text(
                                "Expenditure History",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            Get.toNamed(Routes.serviceHistory);
                          },
                          child: Row(
                            children: [
                              Icon(
                                Icons.note_outlined,
                                color: Colors.indigo,
                              ),
                              SizedBox(width: Get.width * 0.010),
                              Text(
                                "Service History",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
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
          ),
        ),
      ),
    );
  }
}

InputDecoration textBoxDecoration(String hintText) {
  return InputDecoration(
    hintText: hintText,
    hintStyle: MyTheme.regularTextStyle(
      fontSize: Get.height * .018,
      color: Colors.white,
      fontWeight: FontWeight.w700,
    ),
  );
}


//Row(
//   children: [
//     Container(
//       width: Get.width * 0.014,
//       height: Get.height * 0.05,
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           colors: [
//             Color.fromRGBO(66, 94, 236, 1),
//             // Start color
//             Color.fromRGBO(34, 61, 192, 1),
//             // End color
//           ],
//           begin: Alignment.centerLeft,
//           end: Alignment.centerRight,
//         ),
//       ),
//     ),
//     SizedBox(width: Get.width * 0.02),
//     Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           "AMC Package Name",
//           style: MyTheme.regularTextStyle(
//             fontWeight: FontWeight.w400,
//             fontSize: Get.height * 0.018,
//           ),
//         ),
//         SizedBox(height: Get.height * 0.001),
//         Container(
//           width: Get.width * 0.4,
//           child: Text(
//             "Free",
//             style: MyTheme.regularTextStyle(
//               fontWeight: FontWeight.w700,
//               fontSize: Get.height * 0.018,
//             ),
//           ),
//         ),
//       ],
//     ),
//   ],
// ),
// SizedBox(height: Get.height * 0.030),
// Row(
//   children: [
//     Container(
//       width: Get.width * 0.014,
//       height: Get.height * 0.05,
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           colors: [
//             Color.fromRGBO(66, 94, 236, 1),
//             // Start color
//             Color.fromRGBO(34, 61, 192, 1),
//             // End color
//           ],
//           begin: Alignment.centerLeft,
//           end: Alignment.centerRight,
//         ),
//       ),
//     ),
//     SizedBox(width: Get.width * 0.02),
//     Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           "No. of AC's Covered Under Package",
//           style: MyTheme.regularTextStyle(
//             fontWeight: FontWeight.w400,
//             fontSize: Get.height * 0.018,
//           ),
//         ),
//         SizedBox(height: Get.height * 0.001),
//         Container(
//           width: Get.width * 0.4,
//           child: Text(
//             "7",
//             style: MyTheme.regularTextStyle(
//               fontWeight: FontWeight.w700,
//               fontSize: Get.height * 0.018,
//             ),
//           ),
//         ),
//       ],
//     ),
//   ],
// ),

// Row(
// children: [
// Container(
// width: Get.width * 0.014,
// height: Get.height * 0.05,
// decoration: BoxDecoration(
// gradient: LinearGradient(
// colors: [
// Color.fromRGBO(66, 94, 236, 1),
// // Start color
// Color.fromRGBO(34, 61, 192, 1),
// // End color
// ],
// begin: Alignment.centerLeft,
// end: Alignment.centerRight,
// ),
// ),
// ),
// SizedBox(width: Get.width * 0.02),
// Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// Text(
// "Select Date",
// style: MyTheme.regularTextStyle(
// fontWeight: FontWeight.w400,
// fontSize: Get.height * 0.018,
// ),
// ),
// SizedBox(height: Get.height * 0.001),
// Container(
// width: Get.width * 0.4,
// child: TextFormField(
// controller: controller.dateCtrl,
// focusNode: controller.dateCtrlfNode,
// decoration: textBoxDecoration('').copyWith(
// suffixIcon: IconButton(
// icon: Icon(
// Icons.calendar_today,
// color: Colors.indigo,
// ),
// onPressed: () {
// controller.selectDate(context); // Call selectDate function here
// },
// ),
// ),
// style: TextStyle(
// color: Colors.white, // Set the text color here
// ),
// ),
// ),
// ],
// ),
// ],
// ),