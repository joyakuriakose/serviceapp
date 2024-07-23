import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'expenditure_controller.dart';

class ExpenditureBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ExpenditureController>(
          () => ExpenditureController(),
    );
  }
}