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
          msgs: [ApiMsg(msg: "", msgType: "", title: "Success")],
          message: '',
        );
      }
    } catch (e) {
      return ApiResp(
        ok: false,
        rdata: '',
        msgs: [ApiMsg(msg: 'Error during submission: AMC service request feedback has been already submited', title: 'Error', msgType: '')],
        message: '',
      );
    }
  }

  static ApiResp handleErrorResponse(DioError resp) {
    if (resp.response?.statusCode == 401) {
      final errorMsg = resp.response?.data['error'] ?? 'Unauthorized';
      return ApiResp(
        ok: false,
        rdata: '',
        msgs: [],
        message: errorMsg,
      );
    } else if (resp.response?.statusCode == 400) {
      return ApiResp(
        ok: false,
        rdata: '',
        msgs: [ApiMsg(msg: 'Invalid Details', title: 'Submission Failed', msgType: '')],
        message: '',
      );
    } else if (resp.type == DioErrorType.connectTimeout) {
      return ApiResp(
        ok: false,
        rdata: '',
        msgs: [ApiMsg(msg: 'Connection timed-out. Check internet connection.', title: 'Submission Failed', msgType: '')],
        message: '',
      );
    } else if (resp.type == DioErrorType.receiveTimeout) {
      return ApiResp(
        ok: false,
        rdata: '',
        msgs: [ApiMsg(msg: 'Unable to connect to the server', title: 'Submission Failed', msgType: '')],
        message: '',
      );
    } else if (resp.type == DioErrorType.other) {
      return ApiResp(
        ok: false,
        rdata: '',
        msgs: [ApiMsg(msg: 'Something went wrong with server communication', title: 'Submission Failed', msgType: '')],
        message: '',
      );
    } else {
      return ApiResp(
        ok: false,
        rdata: '',
        msgs: [],
        message: 'Unexpected error occurred',
      );
    }
  }

  static Future<String> getToken() async {
    return 'YOUR_AUTH_TOKEN';
  }
}
