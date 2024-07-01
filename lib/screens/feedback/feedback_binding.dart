import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';

import '../../app.dart';
import 'feedback_controller.dart';


class FeedbackBindings extends Bindings {
  @override
  void dependencies() {
    final int userId = App.user.id!;
    Get.lazyPut<FeedbackController>(() => FeedbackController(userId, Get.arguments as int));
  }
}


// final int amcId = arguments['amcId'] ?? 0; // Provide a default value or handle null case
// final int serviceId = arguments['serviceId'] ?? 0;