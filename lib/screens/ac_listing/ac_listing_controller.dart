import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../app.dart';
import '../../model/api_resp.dart';
import '../../model/notification_model.dart';
import '../../model/package_listing_model.dart';
import '../../services/notification_services.dart';
import '../../services/package_listing_services.dart';
import '../../utils/routes.dart';

class AcListingController extends GetxController {
  RxList<AmcDetail> amcdetail = <AmcDetail>[].obs;
  RxList<Customer> customer = <Customer>[].obs;
  RxBool isScreenProgress = false.obs;
  RxBool isLoading = true.obs;
  RxList<Notificationss> notifications = <Notificationss>[].obs;

  final int id;

  AcListingController(this.id);

  @override
  void onInit() {
    super.onInit();
    fetchNotifications();
    initialAcListt();
  }

  Future<void> fetchNotifications() async {
    try {
      ApiResp? resp = await NotificationServices.fetchNotificationList(id);
      if (resp != null && resp.ok == true) {
        var notificationModel = NotificationModel.fromJson(resp.rdata);
        notifications.value = notificationModel.notification;

        // Print notifications for debug purposes
        notifications.forEach((notification) {
          print("Notification - ID: ${notification.id}, Description: ${notification.description}, Status: ${notification.status}");
        });
      } else {
        print("Error fetching notifications: ${resp?.msgs?.first.msg}");
      }
    } catch (e) {
      print("Error fetching notifications: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> initialAcListt() async {
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
    } finally {
      isLoading.value = false;
    }
  }

  @override
  Future<void> refresh() async {
    await fetchNotifications();
    await initialAcListt();
  }
}


