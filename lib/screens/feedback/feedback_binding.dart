import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import '../../app.dart';
import 'feedback_controller.dart';

class FeedbackBindings extends Bindings {
  @override
  void dependencies() {
    final Map<String, dynamic> arguments = Get.arguments as Map<String, dynamic>? ?? {};
    final int amcId = arguments['amcId'] ?? 0;
    final int serviceId = arguments['serviceId'] ?? 0;
    int? userId = App.user.id;
    Get.lazyPut<FeedbackController>(
          () => FeedbackController(amcId, userId!, serviceId),
    );
  }
}



// final int amcId = arguments['amcId'] ?? 0; // Provide a default value or handle null case
// final int serviceId = arguments['serviceId'] ?? 0;