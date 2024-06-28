import 'dart:developer';

import 'package:dio/dio.dart';

import '../model/api_msg.dart';
import '../model/api_resp.dart';
import '../presets/api_paths.dart';
import '../utils/err_m.dart';
import '../utils/mydio.dart';

abstract class ServiceRequestServices {
  static Future<ApiResp> fetchRequest({
    required int customerId,
    int? amcId, // Make amcId optional
    String? service_date, // Make service_date optional
    String? demand, // Make demand optional
    required String amcType,
  }) async {
    dynamic resp;
    await errMAsync(
          () async {
        // Construct the data object based on the provided parameters
        Map<String, dynamic> data = {
          'customer_id': customerId,
          'amc_type': amcType,
        };

        // Add optional parameters based on the type
        if (amcType == 'AMC' && amcId != null) {
          data['amc_id'] = amcId;
        } else if (amcType != 'AMC' && service_date != null) {
          data['service_date'] = service_date;
        }

        if (demand != null) {
          data['demand'] = demand;
        }

        resp = await MyDio().customPost(
          ApiPaths.serviceRequest,
          data: data,
        );
      },
      title: 'Shop Register Failed',
    );

    if (resp is DioError) {
      if (resp.response?.statusCode == 400) {
        log('400 >> ${resp.response}');
        showMsg("Invalid Details", "Registration Failed");
      }
      if (resp.type == DioErrorType.connectTimeout) {
        showMsg(
            'Connection timed-out. Check internet connection.',
            "Registration Failed"
        );
      }
      if (resp.type == DioErrorType.receiveTimeout) {
        showMsg('Unable to connect to the server', "Registration Failed");
      }
      if (resp.type == DioErrorType.other) {
        showMsg(
            'Something went wrong with server communication',
            "Registration Failed"
        );
      }
    } else {
      respNew = resp != null
          ? ApiResp(
        ok: true,
        rdata: resp,
        msgs: [
          ApiMsg(
            msg: "",
            msgType: "",
            title: "Success",
          )
        ],
      )
          : ApiResp(
        ok: false,
        rdata: "",
        msgs: [
          ApiMsg(
            msg: "Server response failed",
            msgType: "0",
            title: "Failed",
          )
        ],
      );
    }
    return respNew;
  }
}

