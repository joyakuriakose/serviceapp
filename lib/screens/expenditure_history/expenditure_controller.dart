import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../app.dart';
import '../../model/api_resp.dart';
import '../../model/expenditure_hist_model.dart';
import '../../model/package_detail_model.dart';
import '../../services/expenditure_history.dart';

class ExpenditureController extends GetxController {

  RxBool isScreenProgress = false.obs;
  Rx<AmcDetails> amcdetails = AmcDetails().obs;
  RxList<ExpenditureHistory> expenditureHistoryy = <ExpenditureHistory>[].obs;

  final int customer_id;
  RxBool isLoading = true.obs;

  ExpenditureController(this.customer_id);

  initialVehicleListt() async {
    //Map body = customersListApiPayload;
    ApiResp resp = await ExpenditureHistoryServices.fetchExpenditureHistory(customer_id);
    expenditureHistoryy.value = ExpenditureModel.fromJson(resp.rdata).expenditureHistory!;
    App.expenditureHistory = expenditureHistoryy.value;
    //print(App.productLists.first.vehicleName);
    return expenditureHistoryy;
  }

  @override
  void onInit() {
    super.onInit();
    initialVehicleListt();
  }
}