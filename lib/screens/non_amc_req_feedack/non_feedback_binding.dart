import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';

import '../../app.dart';
import 'non_feedback_controller.dart';

class NonFeedbackBindings extends Bindings {
  @override
  void dependencies() {
    final Map<String, dynamic> arguments = Get.arguments as Map<String, dynamic>? ?? {};
    int? userId = App.user.id;
    final int amcType = 1;  // Default amcType set to 1
    final int nonamcserviceId = arguments['serviceId'] ?? 0; // Use 0 as a default, but ideally, you should validate this

    Get.lazyPut<NonFeedbackController>(
          () => NonFeedbackController(amcType, userId!, nonamcserviceId),
    );
  }
}
