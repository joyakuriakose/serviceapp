import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import '../../components/app_background.dart';
import '../../components/app_empty.dart';
import '../../components/rounded_loader.dart';
import '../../utils/my_theme.dart';
import '../../utils/my_utils.dart';
import '../../utils/routes.dart';
import 'notif_controller.dart';

class NotificationView extends GetView<NotificationController> {
  const NotificationView({Key? key}) : super(key: key);

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
                  "Notification",
                  style: MyTheme.regularTextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: Get.height * 0.027,
                  ),
                ),
                SizedBox(height: Get.height * 0.02),
                Obx(() {
                  bool isLoading = controller.isLoading.value;
                  final notifications = controller.notifications;
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
                  } else if (notifications.isEmpty) {
                    return Center(
                      child: MAResultEmpty(
                        msg: 'Results Empty',
                      ),
                    );
                  } else {
                    return Container(
                      height: Get.height * 0.7, // Adjust the height as per your requirements
                      child: ListView.builder(
                        itemCount: notifications.length,
                        itemBuilder: (context, index) {
                          final notification = notifications[index];
                          return Padding(
                            padding: EdgeInsets.only(bottom: 8.0, top: 8.0),
                            child: Row(
                              children: [
                                Container(
                                  width: Get.width * 0.014,
                                  height: Get.height * 0.07,
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
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        notification.description != null &&
                                            notification.description!.isNotEmpty
                                            ? notification.description!
                                            : '',
                                        style: MyTheme.regularTextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: Get.height * 0.019,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  }
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}





// child: RichText(
//   text: TextSpan(
//     style:
//         MyTheme.regularTextStyle(
//       fontWeight: FontWeight.w400,
//       fontSize:
//           Get.height * 0.018,
//       color: Colors
//           .white, // Set default text color
//     ),
//     children: <TextSpan>[
//       TextSpan(
//         text:
//             "Your AMC is ending on ",
//       ),
//       TextSpan(
//         text: "26-05-2024 ",
//         // Text to be colored differently
//         style: TextStyle(
//           color: Colors.indigo,
//           // Set color to red
//           fontWeight:
//               FontWeight.w600,
//           fontSize:
//               Get.height * 0.018,
//         ),
//       ),
//       TextSpan(
//         text:
//             ".  \nService executive has been assigned for your service appointment scheduled for ",
//       ),
//       TextSpan(
//         text:
//             "25-05-2024.", // Another date
//       ),
//       // Add more TextSpan for additional parts of the text
//     ],
//   ),
// ),