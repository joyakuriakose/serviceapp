import 'dart:developer';

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

class DetailPageController extends GetxController {
  RxBool isScreenProgress = false.obs;
  Rx<AmcDetails> amcdetails = AmcDetails().obs;
  Rx<NonamcServiceList> nonamcdetails = NonamcServiceList().obs;
  int? amcId; // Define amcId property to hold the current amcId
  int? serviceId; // Define amcId property to hold the current amcId
  late final int customer_id;
  RxList<NonamcServiceList> nonFeedbackList = <NonamcServiceList>[].obs;
  var isContainerVisible = false.obs;
  final int id;
  RxBool isLoading = true.obs;

  DetailPageController(this.id, this.customer_id); // Default to false

  var feedbackSubmitted = <String, bool>{}.obs;
  @override
  void onInit() {
    super.onInit();
    // Retrieve amcId from arguments
    amcId = Get.arguments as int?;
    fetchDetails();
    initialProductListt();
  }

  void fetchDetails() async {
    if (amcId != null) {
      await initialDataFetching(amcId!);
    } else {
      print("Error: amcId is null");
    }
  }

  initialProductListt() async {
    try {
      ApiResp resp = await NonAmcFeedbackServices.fetchNonamcFeedDetails(customer_id);
      if (resp.ok == true) {
        nonFeedbackList.value = GetNonAmcFeedback.fromJson(resp.rdata).nonamcServiceList ?? [];
        App.nonFeedLists = nonFeedbackList.value;
        isContainerVisible.value = nonFeedbackList.isNotEmpty; // Show container only if productList is not empty
      } else {
        isContainerVisible.value = false; // Hide container if API response is not ok
      }
    } catch (e) {
      isContainerVisible.value = false; // Hide container on error
      print("Error fetching product list: $e");
    }
  }

  Future<void> initialDataFetching(int amcId) async {
    isScreenProgress.value = true;
    final ApiResp itemDetailsResp = await PackageDetailServices.fetchPackageDetails(amcId);

    if (itemDetailsResp.ok == null || !itemDetailsResp.ok!) {
      isScreenProgress.value = false;
      return;
    } else {
      amcdetails.value = AmcDetails.fromJson(itemDetailsResp.rdata['amc_details']);
      // Log the response
      print('Item Response: ${itemDetailsResp.rdata}');
      isScreenProgress.value = false;
    }
  }

  @override
  Future<void> refresh() {
    return Future.delayed(Duration(seconds: 5), () => initialDataFetching(amcId!));
  }
}

