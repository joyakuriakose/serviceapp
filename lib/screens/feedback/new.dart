// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:get/get_state_manager/src/simple/get_view.dart';
//
// import '../../components/app_background.dart';
// import '../../components/app_buttons.dart';
// import '../../utils/my_theme.dart';
// import '../../utils/my_utils.dart';
// import '../../utils/routes.dart';
// import 'feedback_controller.dart';
//
//
// class FeedbackView extends GetView<FeedbackController> {
//   const FeedbackView({Key? key}) : super(key: key);
//
//   Widget buildOption(int question, int option, String text) {
//     return Obx(() {
//       bool isSelected = false;
//       switch (question) {
//         case 1:
//           isSelected = controller.selectedOption1.value == option.toString();
//           break;
//         case 2:
//           isSelected = controller.selectedOption2.value == option.toString();
//           break;
//         case 3:
//           isSelected = controller.selectedOption3.value == option.toString();
//           break;
//       }
//
//       return GestureDetector(
//         onTap: () {
//           controller.selectOption(question, option);
//         },
//         child: Row(
//           children: [
//             Container(
//               width: 12,
//               height: 12,
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 border: Border.all(
//                   color: Colors.white,
//                   width: 1,
//                 ),
//                 color: isSelected ? Colors.green : Colors.transparent,
//               ),
//             ),
//             SizedBox(width: Get.width * 0.02),
//             Text(
//               text,
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 13,
//                 fontWeight: FontWeight.w700,
//               ),
//             )
//           ],
//         ),
//       );
//     });
//   }
//
//   Widget buildStar(int starIndex) {
//     return GestureDetector(
//       onTap: () {
//         // Set the rating value in the controller
//         controller.rating.value = starIndex;
//       },
//       child: Obx(() => Icon(
//         starIndex <= controller.rating.value
//             ? Icons.star
//             : Icons.star_border_purple500_outlined,
//         color: starIndex <= controller.rating.value
//             ? Colors.green // Color the selected stars green
//             : Colors.white,
//       )),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         MyUtils.hideKeyboard();
//       },
//       child: Scaffold(
//         body: Background(
//           child: Column(
//             children: [
//               // Question 1
//               Row(
//                 children: [
//                   Container(
//                     width: Get.width * 0.014,
//                     height: Get.height * 0.03,
//                     decoration: BoxDecoration(
//                       gradient: LinearGradient(
//                         colors: [
//                           Color.fromRGBO(66, 94, 236, 1),
//                           Color.fromRGBO(34, 61, 192, 1),
//                         ],
//                         begin: Alignment.centerLeft,
//                         end: Alignment.centerRight,
//                       ),
//                     ),
//                   ),
//                   SizedBox(width: Get.width * 0.02),
//                   Text(
//                     "How satisfied are you with our service?",
//                     style: MyTheme.regularTextStyle(
//                       fontWeight: FontWeight.w400,
//                       fontSize: Get.height * 0.016,
//                     ),
//                   ),
//                 ],
//               ),
//               Padding(
//                 padding: EdgeInsets.only(top: 10, left: 10, right: 135),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     buildOption(1, 1, "Very Satisfied"),
//                     buildOption(1, 2, "Satisfied"),
//                   ],
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsets.only(top: 10, left: 10, right: 90),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     buildOption(1, 3, "Dissatisfied"),
//                     buildOption(1, 4, "Very dissatisfied"),
//                   ],
//                 ),
//               ),
//               SizedBox(height: Get.height * 0.02),
//               // Question 2
//               Row(
//                 children: [
//                   Container(
//                     width: Get.width * 0.014,
//                     height: Get.height * 0.03,
//                     decoration: BoxDecoration(
//                       gradient: LinearGradient(
//                         colors: [
//                           Color.fromRGBO(66, 94, 236, 1),
//                           Color.fromRGBO(34, 61, 192, 1),
//                         ],
//                         begin: Alignment.centerLeft,
//                         end: Alignment.centerRight,
//                       ),
//                     ),
//                   ),
//                   SizedBox(width: Get.width * 0.02),
//                   Container(
//                     width: Get.width * 0.8,
//                     child: Text(
//                       "How would you rate the professionalism of our service technician?",
//                       style: MyTheme.regularTextStyle(
//                         fontWeight: FontWeight.w400,
//                         fontSize: Get.height * 0.016,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               Padding(
//                 padding: EdgeInsets.only(top: 10, left: 10, right: 160),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     buildOption(2, 1, "Excellent"),
//                     buildOption(2, 2, "Good"),
//                   ],
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsets.only(top: 10, left: 10, right: 160),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     buildOption(2, 3, "Fair"),
//                     buildOption(2, 4, "Poor"),
//                   ],
//                 ),
//               ),
//               SizedBox(height: Get.height * 0.02),
//               // Question 3
//               Row(
//                 children: [
//                   Container(
//                     width: Get.width * 0.014,
//                     height: Get.height * 0.03,
//                     decoration: BoxDecoration(
//                       gradient: LinearGradient(
//                         colors: [
//                           Color.fromRGBO(66, 94, 236, 1),
//                           Color.fromRGBO(34, 61, 192, 1),
//                         ],
//                         begin: Alignment.centerLeft,
//                         end: Alignment.centerRight,
//                       ),
//                     ),
//                   ),
//                   // Add your third question here
//                 ],
//               ),
//               // Star rating
//               SizedBox(height: Get.height * 0.02),
//               Row(
//                 children: List.generate(5, (index) => buildStar(index + 1)),
//               ),
//               SizedBox(height: Get.height * 0.02),
//               Container(
//                 width: double.infinity,
//                 height: Get.height * 0.150,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(17),
//                   border: Border.all(color: Colors.white, width: 1),
//                 ),
//                 child: Padding(
//                   padding: EdgeInsets.all(8.0),
//                   child: TextFormField(
//                     controller: controller.feedbackController,
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 17,
//                       fontWeight: FontWeight.w400,
//                     ),
//                     decoration: InputDecoration(
//                       hintText: controller.isFeedbackEmpty.value
//                           ? "Write Your Feedback...."
//                           : null,
//                       hintStyle: TextStyle(
//                         color: Colors.white,
//                         fontSize: 17,
//                         fontWeight: FontWeight.w400,
//                       ),
//                       border: InputBorder.none,
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(height: Get.height * 0.02),
//               Center(
//                 child: MAButton(
//                   text: 'Submit',
//                   buttonPress: () async {
//                     controller.feedbackSubmit();
//                   },
//                   isEnabled: true,
//                   padding: const EdgeInsets.all(30),
//                   height: Get.height * 0.06,
//                   width: Get.width * 0.4,
//                   clipBehavior: 0,
//                   radius: 30,
//                   fontSize: 20,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }