import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:serviceapp/screens/service_request/request_controller.dart';

import '../../app.dart';



class RequestBindings extends Bindings {
  @override
  void dependencies() {
    int? userId = App.user.id;
  //  int amcId = App.amcuser.id ?? 42; // Use 0 as a default value if null
    Get.lazyPut<RequestController>(() => RequestController(userId!));
  }
}
