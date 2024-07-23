import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:serviceapp/screens/service_history/service_controller.dart';

import '../../app.dart';

class ServiceHistoryBindings extends Bindings {
  @override
  void dependencies() {
    int? userId = App.user.id;
    Get.lazyPut<ServiceHistoryController>(
          () => ServiceHistoryController(userId!),
    );
  }
}