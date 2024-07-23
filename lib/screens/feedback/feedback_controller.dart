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
import '../../model/package_detail_model.dart';
import '../../services/feedback_services.dart';

import '../../services/package_detail_services.dart';
import '../../utils/my_utils.dart';
import '../../utils/routes.dart';

class FeedbackController extends GetxController {
  DetailPageController dcontroller = Get.find<DetailPageController>();
  TextEditingController feedbackController = TextEditingController();
  RxString selectedOption1 = ''.obs;
  RxString selectedOption2 = ''.obs;
  RxString selectedOption3 = ''.obs;
  RxInt rating = 0.obs;
  RxBool isFeedbackEmpty = true.obs;
  final int amcId;
  final int userId;
  final int serviceId;
  RxBool isScreenProgress = true.obs;

  FeedbackController(this.amcId, this.userId, this.serviceId);

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

  void feedbackSubmit() async {
    // Check if all required fields are filled
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
      ApiResp resp = await FeedbackService.submitFeedback(
        customer_id: userId,
        amc_id: amcId,
        amc_service_id: serviceId,
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
        // Clear fields if needed
         clearFields();
      } else {
        Get.snackbar(
          "Failed",
          resp.message ?? 'Unknown error',
          backgroundColor: Colors.red,
        );
      }
    } catch (e) {
      isScreenProgress.value = false;
      if (e is DioError && e.response?.statusCode == 401) {
        // Call the error API to get the error message
        final errorMessage = await getErrorMessage(e.response?.data);
        Get.snackbar(
          "Error",
          errorMessage,
          backgroundColor: Colors.red,
        );
      } else if (e is DioError) {
        // Call the error API to get the error message for other Dio errors
        final errorMessage = await getErrorMessage(e.response?.data);
        Get.snackbar(
          "Error",
          errorMessage,
          backgroundColor: Colors.red,
        );
      } else {
        // Handle other types of errors
        Get.snackbar(
          "Error",
          "AMC service request feedback has been already submited",
          backgroundColor: Colors.red,
        );
      }
    }
  }

  void clearFields() {
    selectedOption1.value = '';
    selectedOption2.value = '';
    selectedOption3.value = '';
    feedbackController.text = '';
    rating.value = 0;
  }


  Future<String> getErrorMessage(dynamic responseData) async {
    try {
      // Parse the response data
      final requestError = apiFeedbackRespFromJson(json.encode(responseData));
      return requestError.message;
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
    if (amcId != null) {
      await initialDataFetching(amcId!);
    } else {
      print("Error: amcId is null");
    }
  }

  Rx<AmcDetails> amcdetails = AmcDetails().obs;

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
}

