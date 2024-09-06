import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:serviceapp/components/app_refresh.dart';
import 'package:serviceapp/screens/service_request/request_controller.dart';
import '../../components/app_background.dart';
import '../../components/app_buttons.dart';
import '../../components/app_dropdown.dart';
import '../../utils/my_theme.dart';
import '../../utils/my_utils.dart';
import '../../utils/routes.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class NonZeroInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // If the new value is a single digit '0', return the old value
    if (newValue.text == '0') {
      return oldValue;
    }
    return newValue;
  }
}

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
            child: AppRefresh(
              refreshFunction: () => controller.refresh(),
              child: ListView(
                children: [
                  Form(
                    key: controller.formKey,
                    child: Column(
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
                                      "Service Request Type",
                                      style: MyTheme.regularTextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: Get.height * 0.018,
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      // Rounded corners
                                      border: Border.all(
                                        color: Colors.blue, // Border color
                                        width: 2.0,
                                      ),borderRadius: BorderRadius.circular(10)

                                    ),

                                    width: Get.width * 0.83,
                                    child: Obx(() {
                                      return dropDownBox(
                                        controller:
                                            controller.serviceRequestController,
                                        FunctioOnchanged: (String? value) {
                                          controller.serviceRequestType.value =
                                              value!;
                                          if (value == 'AMC') {
                                            controller.initialAcListt();
                                          } else {
                                            controller.amcCodes.clear();
                                          }
                                        },
                                        ListItem: controller.servicetype
                                            .map<DropdownMenuItem<String>>(
                                                (String value) {
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
                                        ListValue: controller.servicetype
                                                .contains(controller
                                                    .serviceRequestType.value)
                                            ? controller.serviceRequestType.value
                                            : (controller.servicetype.isNotEmpty
                                                ? controller.servicetype.first
                                                : ''),
                                      );
                                    }),
                                  ),
                                ),
                                SizedBox(height: Get.height * 0.02),
                                Obx(() {
                                  if (controller.serviceRequestType.value ==
                                      'AMC') {
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                            Text(
                                              "AMC Codes",
                                              style: MyTheme.regularTextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: Get.height * 0.018,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: Colors.blue, // Border color
                                                  width: 2.0,
                                                ),borderRadius: BorderRadius.circular(10)
                                            ),
                                            width: Get.width * 0.83,

                                            child: dropDownBox(
                                              controller: TextEditingController(),
                                              FunctioOnchanged: (String? value) {
                                                if (value != null) {
                                                  controller.selectedAmcCode
                                                      .value = value;
                                                }
                                              },
                                              ListItem: [
                                                DropdownMenuItem<String>(
                                                  value: '',
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(8.0),
                                                    child: Text(
                                                      'Select',
                                                      // Placeholder text
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Colors.white,
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                ...controller.amcCodes.map<
                                                        DropdownMenuItem<String>>(
                                                    (String value) {
                                                  return DropdownMenuItem<String>(
                                                    value: value,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Text(
                                                        value,
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: Colors.white,
                                                          fontSize: 16,
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                }).toList(),
                                              ],
                                              ListValue: controller.amcCodes
                                                      .contains(controller
                                                          .selectedAmcCode.value)
                                                  ? controller
                                                      .selectedAmcCode.value
                                                  : '',
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  } else if (controller
                                          .serviceRequestType.value ==
                                      'Non-AMC') {
                                    return Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
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
                                                        Color.fromRGBO(
                                                            66, 94, 236, 1),
                                                        // Start color
                                                        Color.fromRGBO(
                                                            34, 61, 192, 1),
                                                        // End color
                                                      ],
                                                      begin:
                                                          Alignment.centerLeft,
                                                      end:
                                                          Alignment.centerRight,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                    width: Get.width * 0.02),
                                                Text(
                                                  "Select Date",
                                                  style:
                                                      MyTheme.regularTextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize:
                                                        Get.height * 0.018,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                                height: Get.height * 0.001),
                                            Container(
                                              width: Get.width * 0.5,
                                              child: TextFormField(
                                                controller: controller.dateCtrl,
                                                focusNode:
                                                    controller.dateCtrlfNode,
                                                decoration:
                                                    textBoxDecoration('')
                                                        .copyWith(
                                                  suffixIcon: IconButton(
                                                    icon: Icon(
                                                      Icons.calendar_today,
                                                      color: Colors.indigo,
                                                    ),
                                                    onPressed: () {
                                                      controller.selectDate(
                                                          context); // Call selectDate function here
                                                    },
                                                  ),
                                                ),
                                                style: TextStyle(
                                                  color: Colors
                                                      .white, // Set the text color here
                                                ),
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return 'Please add a date';
                                                  }
                                                  return null;
                                                },
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Container(
                                                  width: Get.width * 0.014,
                                                  height: Get.height * 0.04,
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
                                                      begin:
                                                          Alignment.centerLeft,
                                                      end:
                                                          Alignment.centerRight,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                    width: Get.width * 0.02),
                                                Text(
                                                  "Enter the number of AC's to service",
                                                  style:
                                                      MyTheme.regularTextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize:
                                                        Get.height * 0.018,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                                height: Get.height * 0.001),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(top: 0.0),
                                              child: Container(
                                                width: Get.width * 0.8,
                                                height: Get.height * 0.08,
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      bottom: 8.0),
                                                  child: Container(
                                                    child: TextFormField(
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 18,
                                                      ),
                                                      controller: controller
                                                          .countController,
                                                      maxLines: 1,
                                                      keyboardType:
                                                          TextInputType.number,
                                                      inputFormatters: [
                                                        FilteringTextInputFormatter
                                                            .digitsOnly,
                                                        LengthLimitingTextInputFormatter(
                                                            3),
                                                        NonZeroInputFormatter(),
                                                      ],
                                                      decoration:
                                                          InputDecoration(
                                                        border:
                                                            InputBorder.none,
                                                        filled: false,
                                                        hintText:
                                                            'Enter the no. of AC',
                                                        hintStyle: TextStyle(
                                                          color:
                                                              Colors.grey[700],
                                                          fontSize: 14.0,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ),
                                                      validator: (value) {
                                                        if (value == null ||
                                                            value.isEmpty) {
                                                          return 'Please add the number of AC';
                                                        }
                                                        return null;
                                                      },
                                                    ),
                                                  ),
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
                        //
                        // Padding(
                        //   padding: const EdgeInsets.only(top: 20.0),
                        //   child: Row(
                        //     children: [
                        //       Container(
                        //         width: Get.width * 0.014,
                        //         height: Get.height * 0.04,
                        //         decoration: BoxDecoration(
                        //           gradient: LinearGradient(
                        //             colors: [
                        //               Color.fromRGBO(66, 94, 236, 1), // Start color
                        //               Color.fromRGBO(34, 61, 192, 1), // End color
                        //             ],
                        //             begin: Alignment.centerLeft,
                        //             end: Alignment.centerRight,
                        //           ),
                        //         ),
                        //       ),
                        //       SizedBox(width: Get.width * 0.02),
                        //       Text(
                        //         "Service Executive Type",
                        //         style: MyTheme.regularTextStyle(
                        //           fontWeight: FontWeight.w400,
                        //           fontSize: Get.height * 0.018,
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        // Container(
                        //   width: Get.width * 0.8, // Adjust the width as needed
                        //   decoration: BoxDecoration(
                        //     color: Colors.black, // Background color for the dropdown button
                        //     borderRadius: BorderRadius.circular(5.0),
                        //   ),
                        //   child: Obx(() => DropdownButtonHideUnderline(
                        //     child: DropdownButton<String>(
                        //       isExpanded: true, // Ensure the dropdown button takes the full width
                        //       value: controller.serviceExecutiveType.value.isEmpty ? null : controller.serviceExecutiveType.value,
                        //       icon: Icon(
                        //         Icons.keyboard_arrow_down_outlined,
                        //         color: Colors.white, // Arrow color
                        //       ),
                        //       iconSize: 24,
                        //       elevation: 16,
                        //       style: TextStyle(color: Colors.white, fontSize: 16),
                        //       dropdownColor: Colors.black,
                        //       // Background color of the dropdown items
                        //       onChanged: (String? newValue) {
                        //         if (newValue != null) {
                        //           controller.serviceExecutiveType.value = newValue;
                        //         }
                        //       },
                        //       items: controller.executivetype.map<DropdownMenuItem<String>>((String value) {
                        //         return DropdownMenuItem<String>(
                        //           value: value,
                        //           child: Container(
                        //             width: Get.width * 0.7, // Ensure the dropdown item takes the full width
                        //             color: value == controller.serviceExecutiveType.value ? Colors.black : Colors.transparent,
                        //             padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                        //             child: Text(
                        //               value,
                        //               style: TextStyle(
                        //                 color: value == controller.serviceExecutiveType.value ? Colors.white : Colors.white,
                        //               ),
                        //
                        //             ),
                        //
                        //           ),
                        //         );
                        //       }).toList(),
                        //     ),
                        //   )),
                        //
                        // ),
                        //  SizedBox(height: Get.height * 0.05),
                        // Column(
                        //   crossAxisAlignment: CrossAxisAlignment.start,
                        //   children: [
                        //     Row(
                        //       children: [
                        //         Container(
                        //           width: Get.width * 0.014,
                        //           height: Get.height * 0.04,
                        //           decoration: BoxDecoration(
                        //             gradient: LinearGradient(
                        //               colors: [
                        //                 Color.fromRGBO(66, 94, 236, 1), // Start color
                        //                 Color.fromRGBO(34, 61, 192, 1), // End color
                        //               ],
                        //               begin: Alignment.centerLeft,
                        //               end: Alignment.centerRight,
                        //             ),
                        //           ),
                        //         ),
                        //         SizedBox(width: Get.width * 0.02),
                        //         Text(
                        //           "Enter the number of AC's to service",
                        //           style: MyTheme.regularTextStyle(
                        //             fontWeight: FontWeight.w400,
                        //             fontSize: Get.height * 0.018,
                        //           ),
                        //         ),
                        //       ],
                        //     ),
                        //     SizedBox(height: Get.height * 0.001),
                        //     Padding(
                        //       padding: EdgeInsets.only(top: 0.0),
                        //       child: Container(
                        //         width: Get.width * 0.8,
                        //         height: Get.height * 0.08,
                        //         child: Padding(
                        //           padding: EdgeInsets.only(bottom: 8.0),
                        //           child: Container(
                        //             child: TextFormField(
                        //               style: TextStyle(
                        //                 color: Colors.white,
                        //                 fontWeight: FontWeight.w400,
                        //                 fontSize: 18,
                        //               ),
                        //               controller: controller.countController,
                        //               maxLines: 1,
                        //               keyboardType: TextInputType.number,
                        //               inputFormatters: [
                        //                 FilteringTextInputFormatter.digitsOnly,
                        //                 LengthLimitingTextInputFormatter(3),
                        //                 NonZeroInputFormatter(),
                        //               ],
                        //               decoration: InputDecoration(
                        //                 border: InputBorder.none,
                        //                 filled: false,
                        //                 hintText: 'Enter the no. of AC',
                        //                 hintStyle: TextStyle(
                        //                   color: Colors.grey[700],
                        //                   fontSize: 14.0,
                        //                   fontWeight: FontWeight.w400,```

                        //                 ),
                        //               ),
                        //             ),
                        //           ),
                        //         ),
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        Obx(() {
                          // Define a boolean to track if "Other" is selected
                          bool isOtherSelected = controller.selectedDemands.contains('4');

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Your existing Row with heading
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
                                    "Select Service Demands / Complaints",
                                    style: MyTheme.regularTextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: Get.height * 0.018,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: Get.height * 0.02),
                              Container(
                                width: Get.width * 0.83,
                                padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(10.0), // Rounded corners
                                  border: Border.all(
                                    color: Colors.blue, // Border color
                                    width: 2.0,
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Wrap(
                                      spacing: 8.0, // Gap between chips
                                      runSpacing: 4.0, // Gap between rows
                                      children: controller.selectedDemands.map((demand) {
                                        return Chip(
                                          label: Text(
                                            controller.demandOption[demand] ?? demand,
                                            style: TextStyle(color: Colors.white),
                                          ),
                                          backgroundColor: Colors.blue,
                                          onDeleted: () {
                                            controller.selectedDemands.remove(demand);
                                          },
                                        );
                                      }).toList(),
                                    ),
                                    DropdownButtonHideUnderline(
                                      child: DropdownButton<String>(
                                        isExpanded: true,
                                        value: null, // To allow multiple selections, keep value null
                                        hint: Text(
                                          'Select',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white,
                                            fontSize: 16,
                                          ),
                                        ),
                                        items: [
                                          DropdownMenuItem<String>(
                                            value: '', // Set an empty string to represent the "Select" option
                                            child: Text(
                                              'Select', // Placeholder text
                                              style: TextStyle(color: Colors.white),
                                            ),
                                          ),
                                          ...controller.demandOption.entries
                                              .take((controller.demandOption.isNotEmpty
                                              ? controller.demandOption.length -
                                              (isOtherSelected ? 0 : 1)
                                              : 0))
                                              .map((entry) {
                                            return DropdownMenuItem<String>(
                                              value: entry.key,
                                              child: Text(
                                                entry.value,
                                                style: TextStyle(color: Colors.white), // Dropdown item text color
                                              ),
                                            );
                                          }).toList(),
                                          if (!isOtherSelected)
                                            DropdownMenuItem<String>(
                                              value: 'other', // Add 'other' value to the dropdown
                                              child: Text(
                                                'Other',
                                                style: TextStyle(color: Colors.white), // Dropdown item text color
                                              ),
                                            ),
                                        ],
                                        onChanged: (String? value) {
                                          if (value == null || value.isEmpty) {
                                            // When "Select" is clicked
                                            print("Select");
                                          } else if (value == 'other') {
                                            // When "Other" is selected
                                            if (!controller.selectedDemands.contains('4')) {
                                              controller.selectedDemands.add('4');
                                              controller.selectDemands.value = '4';
                                              print("Other");
                                            }
                                          } else {
                                            if (!controller.selectedDemands.contains(value)) {
                                              controller.selectedDemands.add(value);
                                              controller.selectDemands.value = controller.demandOption.keys
                                                  .toList()
                                                  .indexOf(value)
                                                  .toString();
                                              print(value); // Print the selected value
                                            }
                                          }
                                        },
                                        icon: Icon(
                                          Icons.keyboard_arrow_down_outlined,
                                          color: Colors.white, // Change the icon color to match your design
                                        ),
                                        dropdownColor: Colors.black, // Change the dropdown background color to black
                                      ),
                                    ),
                                    // Conditionally display the "Other" text field
                                    if (isOtherSelected)
                                      Padding(
                                        padding: const EdgeInsets.only(top: 8.0),
                                        child: TextFormField(
                                          controller: controller.otherDemandsController,
                                          decoration: InputDecoration(
                                            labelText: 'Please specify',
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(10.0),
                                            ),
                                            filled: true,
                                            fillColor: Colors.black,
                                            labelStyle: TextStyle(color: Colors.grey),
                                            hintStyle: TextStyle(color: Colors.grey),
                                          ),
                                          style: TextStyle(color: Colors.white),
                                          validator: (value) {
                                            if (value == null || value.isEmpty) {
                                              return 'This field is required';
                                            }
                                            return null;
                                          },
                                          onChanged: (text) {
                                            // Handle the text input here
                                            print("Other value: $text");
                                          },
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        }),



                        SizedBox(height: Get.height * 0.03),
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
                                  "Specify Your Service Demands / Complaints",
                                  style: MyTheme.regularTextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: Get.height * 0.018,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: Get.height * 0.02),
                            Padding(
                              padding: EdgeInsets.only(top: 0.0),
                              child: Container(
                                width: Get.width * 0.8,
                                height: Get.height * 0.13,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
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
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      bottom: 8.0, left: 10, right: 10),
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
                                          color: Colors.grey[400],
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
                        Center(
                          child: MAButton(
                            text: 'Submit',
                            buttonPress: () async {
                              if (controller.formKey.currentState!.validate()) {
                                controller.submitServiceRequest();
                              } else {
                                if (controller.dateCtrl.text.isEmpty) {
                                  Get.snackbar(
                                    "Error",
                                    "Please add a date",
                                    backgroundColor: Colors.red,
                                    snackPosition: SnackPosition.TOP,
                                    duration: Duration(seconds: 3),
                                  );
                                }
                                if (controller.countController.text.isEmpty) {
                                  Get.snackbar(
                                    "Error",
                                    "Please add the number of AC",
                                    backgroundColor: Colors.red,
                                    snackPosition: SnackPosition.TOP,
                                    duration: Duration(seconds: 3),
                                  );
                                }
                              }
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
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
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
                                onTap: () {
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
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
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
