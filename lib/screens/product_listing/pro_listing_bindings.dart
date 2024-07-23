import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:serviceapp/screens/product_listing/pro_listing_controller.dart';

import '../../app.dart';

class ProductListBindings extends Bindings {
  @override
  void dependencies() {
    int? userId = App.user.id;
    Get.lazyPut<ProductListController>(
          () => ProductListController(userId!),
    );
  }
}