import 'dart:developer';

import 'package:dio/dio.dart';

import '../app.dart';
import '../model/api_msg.dart';
import '../model/api_resp.dart';
import '../presets/api_paths.dart';
import '../utils/err_m.dart';
import '../utils/mydio.dart';

abstract class FeedbackService {
  static Future<ApiResp> submitFeedback({
    required int customer_id,
    required int amc_id,
    required int amc_service_id,
    String? answer_1,
    String? answer_2,
    String? answer_3,
    String? rating,
    String? comment,
  }) async {
    try {
      String token = await getToken();
      dynamic resp;
      await errMAsync(() async {
        resp = await MyDio().customPost(
          ApiPaths.feedback,
          data: {
            'customer_id': customer_id,
            'amc_id': amc_id,
            'amc_service_id': amc_service_id,
            'answer_1': answer_1,
            'answer_2': answer_2,
            'answer_3': answer_3,
            'rating': rating,
            'comment': comment,
          },
          options: Options(
            headers: {
              'Authorization': 'Token ${App.user.apiToken}',
              'Content-Type': 'application/json',
            },
          ),
        );
      }, title: 'Feedback Submission Failed');

      if (resp is DioError) {
        return handleErrorResponse(resp);
      } else {
        return ApiResp(
          ok: true,
          rdata: resp,
          msgs: [],  // Assuming no messages on success
          message: 'Feedback submitted successfully',
        );
      }
    } catch (e) {
      return ApiResp(
        ok: false,
        rdata: '',
        msgs: ['Error during submission: AMC service request feedback has been already submitted'],
        message: '',
      );
    }
  }

  static ApiResp handleErrorResponse(DioError resp) {
    String message = '';
    if (resp.response?.statusCode == 401) {
      message = resp.response?.data['error'] ?? 'Unauthorized';
    } else if (resp.response?.statusCode == 400) {
      message = 'Invalid Details';
    } else if (resp.type == DioErrorType.connectTimeout) {
      message = 'Connection timed-out. Check internet connection.';
    } else if (resp.type == DioErrorType.receiveTimeout) {
      message = 'Unable to connect to the server';
    } else if (resp.type == DioErrorType.other) {
      message = 'Something went wrong with server communication';
    } else {
      message = 'Unexpected error occurred';
    }

    return ApiResp(
      ok: false,
      rdata: '',
      msgs: [message],
      message: message,
    );
  }

  static Future<String> getToken() async {
    // Implement your token retrieval logic here
    return 'YOUR_AUTH_TOKEN';
  }
}
