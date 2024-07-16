import 'dart:developer';

import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../model/api_resp.dart';
import '../../model/package_detail_model.dart';
import '../../services/package_detail_services.dart';

class DetailPageController extends GetxController {
  RxBool isScreenProgress = false.obs;
  Rx<AmcDetails> amcdetails = AmcDetails().obs;
  int? amcId; // Define amcId property to hold the current amcId
  int? serviceId; // Define amcId property to hold the current amcId

  @override
  void onInit() {
    super.onInit();
    // Retrieve amcId from arguments
    amcId = Get.arguments as int?;
    fetchDetails();
  }

  void fetchDetails() async {
    if (amcId != null) {
      await initialDataFetching(amcId!);
    } else {
      print("Error: amcId is null");
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

