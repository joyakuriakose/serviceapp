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
    String? product_count,
    String? service_executive_type,
    String? demand,
    String? service_date,
    List<String>? demand_option_fk, // Updated to accept a list of strings
    String? other_demand,
  }) async {
    try {
      String token = await getToken();

      // Convert the list of selected demands to a comma-separated string
      String? demandOptionString = demand_option_fk?.join(',');

      final Map<String, dynamic> data = {
        'customer_id': customer_id,
        'amc_type': amc_type,
        'product_count': product_count,
        'service_executive_type': service_executive_type,
        'demand': demand,
        'demand_option_fk': demandOptionString, // Send as comma-separated string
        'other_demand': other_demand,
        if (amc_type == 0 && amc_id != null) 'amc_id': amc_id, // Pass as int
        if (amc_type == 1) 'service_date': service_date,
      };

      final resp = await MyDio().customPost(
        ApiPaths.serviceRequest,
        data: data,
        options: Options(
          headers: {
            'Authorization': 'Token $token',
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
      showMsg("Invalid Details", "Request Failed");
    } else if (resp.type == DioErrorType.connectTimeout) {
      showMsg('Connection timed-out. Check internet connection.', "Request Failed");
    } else if (resp.type == DioErrorType.receiveTimeout) {
      showMsg('Unable to connect to the server', "Request Failed");
    } else if (resp.type == DioErrorType.other) {
      showMsg('Something went wrong with server communication', "Request Failed");
    }
  }

  static Future<String> getToken() async {
    // Implement your token retrieval logic here
    return 'YOUR_AUTH_TOKEN';
  }
}
