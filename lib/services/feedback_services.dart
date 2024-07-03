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
    int? amc_service_id, // Allow amc_service_id to be nullable
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
        handleErrorResponse(resp);
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
        msgs: [ApiMsg(msg: 'Error during submission: $e', title: 'Error', msgType: '')],
        message: '',
      );
    }

    return ApiResp(ok: false, rdata: '', msgs: [], message: '');
  }

  static void handleErrorResponse(DioError resp) {
    if (resp.response?.statusCode == 400) {
      showMsg("Invalid Details", "Submission Failed");
    } else if (resp.type == DioErrorType.connectTimeout) {
      showMsg('Connection timed-out. Check internet connection.', "Submission Failed");
    } else if (resp.type == DioErrorType.receiveTimeout) {
      showMsg('Unable to connect to the server', "Submission Failed");
    } else if (resp.type == DioErrorType.other) {
      showMsg('Something went wrong with server communication', "Submission Failed");
    }
  }

  static Future<String> getToken() async {
    return 'YOUR_AUTH_TOKEN';
  }
}

