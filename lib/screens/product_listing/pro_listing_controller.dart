import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:serviceapp/services/product_list_services.dart';

import '../../app.dart';
import '../../model/api_resp.dart';
import '../../model/package_detail_model.dart';
import '../../model/product_list_model.dart';
import '../../services/buy_now_services.dart';

class ProductListController extends GetxController {
  RxBool isScreenProgress = false.obs;
  Rx<AmcDetails> amcdetails = AmcDetails().obs;
  RxList<ProductList> productList = <ProductList>[].obs;
  final int customer_id;
  RxBool isLoading = true.obs;

  final int productId;

  ProductListController(this.customer_id, this.productId);

  initialVehicleListt() async {
    //Map body = customersListApiPayload;
    ApiResp resp = await ProductListServices.fetchProductList(customer_id);
    productList.value = ProductListModel.fromJson(resp.rdata).productList!;
    App.productLists = productList.value;
    //print(App.productLists.first.vehicleName);
    return productList;
  }

  void buynowSubmit(int selectedProductId) async {
    try {
      isScreenProgress.value = true;
      ApiResp resp = await BuyNowService.submitBuynow(
        customer_id: customer_id,
        product_id: selectedProductId,
      );
      isScreenProgress.value = false;
      if (resp.ok == true) {
        Get.snackbar(
          "Success",
          "Product buy requested successfully",
          backgroundColor: Colors.white,
        );
      } else {
        Get.snackbar(
          "Failed",
          resp.message ?? 'Unknown error',
          backgroundColor: Colors.red,
        );
      }
    } catch (e) {
      isScreenProgress.value = false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    initialVehicleListt();
  }
}
