import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:serviceapp/services/product_list_services.dart';

import '../../app.dart';
import '../../model/api_resp.dart';
import '../../model/package_detail_model.dart';
import '../../model/product_list_model.dart';

class ProductListController extends GetxController {

  RxBool isScreenProgress = false.obs;
  Rx<AmcDetails> amcdetails = AmcDetails().obs;
  RxList<ProductList> productList = <ProductList>[].obs;
  final int customer_id;
  RxBool isLoading = true.obs;

  ProductListController(this.customer_id);

  initialVehicleListt() async {
    //Map body = customersListApiPayload;
    ApiResp resp = await ProductListServices.fetchProductList(customer_id);
    productList.value = ProductListModel.fromJson(resp.rdata).productList!;
    App.productLists = productList.value;
    //print(App.productLists.first.vehicleName);
    return productList;
  }

  @override
  void onInit() {
    super.onInit();
    initialVehicleListt();
  }
}