import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';

import '../../app.dart';
import 'ac_listing_controller.dart';

class AcListingBindings extends Bindings {
  @override
  void dependencies() {
    int? userId = App.user.id; // Assuming App.user.id is globally accessible
    Get.lazyPut<AcListingController>(
          () => AcListingController(userId!),
    );
  }
}
