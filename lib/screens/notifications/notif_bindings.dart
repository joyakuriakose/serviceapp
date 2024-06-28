import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import '../../app.dart';
import 'notif_controller.dart';


class NotificationBindings extends Bindings {
  @override
  void dependencies() {
    int? userId = App.user.id;
    Get.lazyPut<NotificationController>(
          () => NotificationController(userId!),
    );
  }
}