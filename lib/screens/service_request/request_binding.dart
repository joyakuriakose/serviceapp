import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:serviceapp/screens/service_request/request_controller.dart';

import '../../app.dart';


class RequestBindings extends Bindings {
  final int activeStatus;

  RequestBindings(this.activeStatus);

  @override
  void dependencies() {
    int? userId = App.user.id;
    if (userId != null) {
      Get.lazyPut<RequestController>(() => RequestController(userId, activeStatus));
    } else {
      // Handle the case where userId is null
      print('Error: userId is null');
    }
  }
}

