import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';

import '../../app.dart';
import 'non_amc_controller.dart';

class NonAmcBindings extends Bindings {
  @override
  void dependencies() {
    int? userId = App.user.id; // Assuming App.user.id is globally accessible
    int? customer_id = App.user.id;
    Get.lazyPut<NonAmcController>(
          () => NonAmcController(userId!,customer_id!),
    );
  }
}