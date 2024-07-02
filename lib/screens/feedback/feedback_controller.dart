import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../model/api_feedback_resp.dart';
import '../../model/api_resp.dart';
import '../../services/feedback_services.dart';
import '../../utils/my_utils.dart';
import '../../utils/routes.dart';

class FeedbackController extends GetxController {
  TextEditingController feedbackController = TextEditingController();
  RxString selectedOption1 = ''.obs;
  RxString selectedOption2 = ''.obs;
  RxString selectedOption3 = ''.obs;
  RxInt rating = 0.obs;
  bool isFeedbackEmpty = true;
  final int amcId;
  final int serviceId; // Add this if needed

  FeedbackController(this.amcId, this.serviceId); // Adjust constructor if needed

  @override
  void onInit() {
    super.onInit();

    feedbackController.addListener(() {
      isFeedbackEmpty = feedbackController.text.isEmpty;
    });
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
    ApiResp resp = await FeedbackService.submitFeedback(
      customer_id: amcId, // Adjust parameter name if needed
      amc_id: amcId,
      // Add serviceId parameter if needed in your API call
      answer_1: selectedOption1.value,
      answer_2: selectedOption2.value,
      answer_3: selectedOption3.value,
      rating: rating.value.toString(),
      comment: feedbackController.text,
    );

    if (!resp.ok) {
      MyUtils.msg(resp.msgs);
      return;
    }

    ApiFeedbackResp feedresp = ApiFeedbackResp.fromJson(resp.rdata);
    if (feedresp.message == 'Feedback submitted successfully') {
      Get.snackbar(
        'Success',
        'Feedback submitted successfully',
        backgroundColor: Colors.white,
        colorText: Colors.black,
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  @override
  void onClose() {
    feedbackController.dispose();
    super.onClose();
  }
}

