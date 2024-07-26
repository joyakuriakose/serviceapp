import 'dart:developer';

import 'package:dio/dio.dart';

import '../app.dart';
import '../model/api_msg.dart';
import '../model/api_resp.dart';
import '../presets/api_paths.dart';
import '../utils/err_m.dart';
import '../utils/mydio.dart';
abstract class ServiceRequestServices {
  static Future<ApiResp> fetchUser({
    required int customer_id,
    int? amc_id, // Keep amc_id as int
    required int amc_type,
    int? product_count,
    String? service_executive_type,
    String? demand,
    String? service_date,
  }) async {
    try {
      String token = await getToken();

      final Map<String, dynamic> data = {
        'customer_id': customer_id,
        'amc_type': amc_type,
        'product_count' : product_count,
        'service_executive_type' : service_executive_type,
        'demand': demand,
        if (amc_type == 0 && amc_id != null) 'amc_id': amc_id, // Pass as int
        if (amc_type == 1) 'service_date': service_date,
      };

      final resp = await MyDio().customPost(
        ApiPaths.serviceRequest,
        data: data,
        options: Options(
          headers: {
            'Authorization': 'Token ${App.user.apiToken}',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (resp is DioError) {
        _handleDioError(resp);
      } else {
        return ApiResp(
          ok: true,
          rdata: resp,
          msgs: [],
          message: '',
        );
      }
    } catch (e) {
      print('Error during fetchUser: $e');
      return ApiResp(
        ok: false,
        rdata: '',
        msgs: [],
        message: '',
      );
    }
    return ApiResp(ok: false, rdata: '', msgs: [], message: '');
  }

  static void _handleDioError(DioError resp) {
    if (resp.response?.statusCode == 400) {
      log('400 >> ${resp.response}');
      showMsg("Invalid Details", "Registration Failed");
    } else if (resp.type == DioErrorType.connectTimeout) {
      showMsg('Connection timed-out. Check internet connection.', "Registration Failed");
    } else if (resp.type == DioErrorType.receiveTimeout) {
      showMsg('Unable to connect to the server', "Registration Failed");
    } else if (resp.type == DioErrorType.other) {
      showMsg('Something went wrong with server communication', "Registration Failed");
    }
  }

  static Future<String> getToken() async {
    // Implement your token retrieval logic here
    return 'YOUR_AUTH_TOKEN';
  }
}