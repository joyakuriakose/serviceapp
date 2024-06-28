
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../app.dart';
import '../../model/api_resp.dart';
import '../../model/notification_model.dart';
import '../../services/notification_services.dart';

class NotificationController extends GetxController {

  RxList<Notification> notifications = <Notification>[].obs;
  RxBool isScreenProgress = false.obs;
  RxBool isLoading = true.obs;
  final int customer_id;

  NotificationController(this.customer_id);

  @override
  void onInit() {
    super.onInit();
    initialNotificationList();
  }
  initialNotificationList() async {
    //Map body = customersListApiPayload;
    ApiResp resp = await NotificationServices.fetchNotificationList(customer_id);
    notifications.value = NotificationModel.fromJson(resp.rdata).notification!;
    App.notification = notifications.value;
    print(App.notification.first.id);
    return notifications;
  }

}

// initialAcListt() async {
//   try {
//     ApiResp? resp = await NotificationServices.fetchNotificationList(customer_id);
//     if (resp != null && resp.ok == true) {
//       var notificationModel = NotificationModel.fromJson(resp.rdata);
//       notifications.value = notificationModel.notification;
//
//       if (notifications.isNotEmpty) {
//         notifications.forEach((amc) => print(amc.code));
//       } else {
//         print("No AMC details found.");
//       }
//     } else {
//       print("Error: ${resp?.msgs?.first.msg}");
//     }
//   } catch (e) {
//     print("Error in initialVehicleListt: $e");
//   }
// }