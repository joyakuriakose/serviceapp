
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../app.dart';
import '../../model/api_resp.dart';
import '../../model/nonamc_feedback.dart';
import '../../model/package_detail_model.dart';
import '../../services/nonamc_feedback_services.dart';
import '../../services/package_detail_services.dart';

class NonAmcController extends GetxController {
  RxBool isScreenProgress = false.obs;
  Rx<AmcDetails> amcdetails = AmcDetails().obs;
  final int customer_id;
  RxList<NonamcServiceList> nonFeedbackList = <NonamcServiceList>[].obs;
  var isContainerVisible = false.obs;
  final int id;
  final RxMap<int, bool> feedbackSubmitted = <int, bool>{}.obs;

  NonAmcController(this.id, this.customer_id);

  @override
  void onInit() {
    super.onInit();
    initialProductListt();
  }

  @override
  Future<void> refresh() async {
    // Ensure proper refresh logic
    return initialProductListt();
  }

  Future<void> initialProductListt() async {
    try {
      isScreenProgress.value = true; // Show progress indicator
      ApiResp resp = await NonAmcFeedbackServices.fetchNonamcFeedDetails(customer_id);
      if (resp.ok == true) {
        nonFeedbackList.value = GetNonAmcFeedback.fromJson(resp.rdata).nonamcServiceList ?? [];
        App.nonFeedLists = nonFeedbackList.value;
        isContainerVisible.value = nonFeedbackList.isNotEmpty; // Show container only if productList is not empty

        // Update feedbackSubmitted map based on feedbackStatus
        for (var item in nonFeedbackList) {
          feedbackSubmitted[item.id!] = (item.feedbackStatus == 1);
        }

      } else {
        isContainerVisible.value = false; // Hide container if API response is not ok
      }
    } catch (e) {
      isContainerVisible.value = false; // Hide container on error
      print("Error fetching product list: $e");
    } finally {
      isScreenProgress.value = false; // Hide progress indicator
    }
  }


  void markFeedbackSubmitted(int serviceId) {
    feedbackSubmitted[serviceId] = true;
    update();
  }
}
