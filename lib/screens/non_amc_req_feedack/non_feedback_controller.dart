import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:serviceapp/screens/detail_page/detail_page_controller.dart';

import '../../model/api_feedback_resp.dart';
import '../../model/api_resp.dart';
import '../../model/nonamc_feedback.dart';
import '../../model/package_detail_model.dart';
import '../../services/feedback_services.dart';

import '../../services/nonamc_feedback_services.dart';
import '../../services/nonamc_service_request_feedback.dart';
import '../../services/package_detail_services.dart';
import '../../utils/my_utils.dart';
import '../../utils/routes.dart';
import '../non_amc_listing/non_amc_controller.dart';

class NonFeedbackController extends GetxController {
  final TextEditingController feedbackController = TextEditingController();
  final RxString selectedOption1 = ''.obs;
  final RxString selectedOption2 = ''.obs;
  final RxString selectedOption3 = ''.obs;
  final RxInt rating = 0.obs;
  final RxBool isFeedbackEmpty = true.obs;
  final int userId;
  int nonamcserviceId;
  final RxBool isScreenProgress = true.obs;
  final RxMap<String, bool> feedbackSubmitted = <String, bool>{}.obs;
  final int amcType;

  NonFeedbackController(this.amcType, this.userId, this.nonamcserviceId);

  @override
  void onInit() {
    super.onInit();

    feedbackController.addListener(() {
      isFeedbackEmpty.value = feedbackController.text.isEmpty;
    });
    fetchDetails();
  }

  void selectOption(int question, int option) {
    switch (question) {
      case 1:
        selectedOption1.value = option.toString();
        break;
      case 2:
        selectedOption2.value = option.toString();
        break;
      case 3:
        selectedOption3.value = option.toString();
        break;
    }
  }

  final RxBool isFeedbackSubmitted = false.obs;

  void feedbackSubmit() async {
    if (selectedOption1.value.isEmpty || selectedOption2.value.isEmpty || selectedOption3.value.isEmpty) {
      Get.snackbar(
        "Error",
        "Please select an option for all questions",
        backgroundColor: Colors.red,
      );
      return;
    }

    try {
      isScreenProgress.value = true;
      ApiResp resp = await NonFeedbackService.submitNonFeedback(
        customer_id: userId,
        non_amc_service_id: nonamcserviceId,
        answer_1: selectedOption1.value,
        answer_2: selectedOption2.value,
        answer_3: selectedOption3.value,
        rating: rating.value.toString(),
        comment: feedbackController.text,
      );
      isScreenProgress.value = false;

      if (resp.ok == true) {
        Get.snackbar(
          "Success",
          "Feedback submitted successfully",
          backgroundColor: Colors.white,
        );

        // Mark feedback as submitted in the NonAmcController
        Get.find<NonAmcController>().markFeedbackSubmitted(nonamcserviceId);

        // Set feedback submitted flag to true
        isFeedbackSubmitted.value = true;

        clearFields();
      } else {
        Get.snackbar(
          "Non AMC service request feedback has been already submitted",
          resp.message ?? 'Non AMC service request feedback has been already submitted',
          backgroundColor: Colors.red,
        );
      }
    } catch (e) {
      isScreenProgress.value = false;
      Get.snackbar(
        "Error",
        e.toString(),
        backgroundColor: Colors.red,
      );
    }
  }


  void clearFields() {
    selectedOption1.value = '';
    selectedOption2.value = '';
    selectedOption3.value = '';
    feedbackController.clear();
    rating.value = 0;
  }

  Future<String> getErrorMessage(dynamic responseData) async {
    try {
      final requestError = apiFeedbackRespFromJson(json.encode(responseData));
      return requestError.message ?? 'Unknown error occurred';
    } catch (e) {
      return 'Unknown error occurred';
    }
  }

  @override
  void onClose() {
    feedbackController.dispose();
    super.onClose();
  }

  void fetchDetails() async {
    await initialDataFetching(userId);
    nonamcserviceId = nonamcdetails.value.id!;  // Now this will work
  }


  RxList<NonamcServiceList> nonamcServiceList = <NonamcServiceList>[].obs;
  Rx<NonamcServiceList> nonamcdetails = NonamcServiceList().obs;

  Future<void> initialDataFetching(int customerId) async {
    isScreenProgress.value = true;
    final ApiResp itemDetailsResp = await NonAmcFeedbackServices.fetchNonamcFeedDetails(customerId);

    if (itemDetailsResp.ok == null || !itemDetailsResp.ok!) {
      isScreenProgress.value = false;
      return;
    } else {
      final List<NonamcServiceList> serviceList = (itemDetailsResp.rdata['nonamc_service_list'] as List)
          .map((e) => NonamcServiceList.fromJson(e))
          .toList();

      if (serviceList.isNotEmpty) {
        nonamcdetails.value = serviceList.first;
      }

      isScreenProgress.value = false;
    }
  }
}



