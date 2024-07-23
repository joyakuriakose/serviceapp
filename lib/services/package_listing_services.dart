import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';

import '../app.dart';
import '../model/api_msg.dart';
import '../model/api_resp.dart';
import '../model/package_listing_model.dart';
import '../presets/api_paths.dart';
import '../utils/err_m.dart';
import '../utils/mydio.dart';
import 'package:http/http.dart' as http;


abstract class PackageListServices {
  static Future<ApiResp> fetchPackageList(int id) async {
    dynamic resp;
    await errMAsync(() async {
      resp = await MyDio().get('https://seowebsites.in/service_management/api/v1/get-customer?id=$id');
    });
    respNew = resp != null
        ? ApiResp(
      ok: true,
      rdata: resp,
      msgs: [

      ], message: '',
    )
        : ApiResp(
      ok: false,
      rdata: resp,
      msgs: [

      ], message: '',
    );
    return respNew;
  }
}

