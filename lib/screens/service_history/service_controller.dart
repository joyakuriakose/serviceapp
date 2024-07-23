import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../app.dart';
import '../../model/api_resp.dart';
import '../../model/package_detail_model.dart';
import '../../model/service_history_model.dart';
import '../../services/service_history.dart';

class ServiceHistoryController extends GetxController {

  RxBool isScreenProgress = false.obs;
  Rx<AmcDetails> amcdetails = AmcDetails().obs;
  RxList<ServiceHistory> serviceHistory = <ServiceHistory>[].obs;

  final int customer_id;
  RxBool isLoading = true.obs;

  ServiceHistoryController(this.customer_id);

  initialVehicleListt() async {
    //Map body = customersListApiPayload;
    ApiResp resp = await ServiceHistoryServices.fetchServiceHistory(customer_id);
    serviceHistory.value = ServiceHistoryModel.fromJson(resp.rdata).serviceHistory!;
    App.serviceHistory = serviceHistory.value;
    //print(App.productLists.first.vehicleName);
    return serviceHistory;
  }

  @override
  void onInit() {
    super.onInit();
    initialVehicleListt();
  }
}