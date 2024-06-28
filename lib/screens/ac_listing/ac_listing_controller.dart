import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../app.dart';
import '../../model/api_resp.dart';
import '../../model/package_listing_model.dart';
import '../../services/package_listing_services.dart';
import '../../utils/routes.dart';

class AcListingController extends GetxController {
  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey =
  GlobalKey<RefreshIndicatorState>();
  RxList<AmcDetail> amcdetail = <AmcDetail>[].obs;
  RxList<Customer> customer = <Customer>[].obs;
  RxBool isScreenProgress = false.obs;

  final int id;

  AcListingController(this.id);

  initialAcListt() async {
    try {
      ApiResp? resp = await PackageListServices.fetchPackageList(id);
      if (resp != null && resp.ok == true) {
        var packageListingModel = PackageListingModel.fromJson(resp.rdata);
        amcdetail.value = packageListingModel.amcDetails;
        customer.value = packageListingModel.customer;

        if (amcdetail.isNotEmpty) {
          amcdetail.forEach((amc) => print(amc.code));
        } else {
          print("No AMC details found.");
        }

        if (customer.isNotEmpty) {
          customer.forEach((cust) => print(cust.name));
        } else {
          print("No customers found.");
        }
      } else {
        print("Error: ${resp?.msgs?.first.msg}");
      }
    } catch (e) {
      print("Error in initialVehicleListt: $e");
    }
  }

  @override
  Future<void> refresh() {
    return Future.delayed(Duration(seconds: 5),
        initialAcListt());
  }

  @override
  void onInit() {
    super.onInit();
    initialAcListt();
  }
}
