import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';

import '../../app.dart';
import 'detail_page_controller.dart';


class DetailPageBindings extends Bindings {
  @override
  void dependencies() {
    int? userId = App.user.id;
    int? customer_id = App.user.id;
    Get.lazyPut<DetailPageController>(
          () => DetailPageController(userId!,customer_id!),
    );
  }
}