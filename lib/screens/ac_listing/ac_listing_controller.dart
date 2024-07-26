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
import '../../model/product_list_model.dart';
import '../../services/notification_services.dart';
import '../../services/package_listing_services.dart';
import '../../services/product_list_services.dart';
import '../../utils/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AcListingController extends GetxController {
  RxList<AmcDetail> amcdetail = <AmcDetail>[].obs;
  RxList<Customer> customer = <Customer>[].obs;
  RxBool isScreenProgress = false.obs;
  RxBool isLoading = true.obs;
  final int id;
  RxList<Notificationss> notifications = <Notificationss>[].obs;
  RxInt unseenNotificationCount = 0.obs;
  RxList<ProductList> productList = <ProductList>[].obs;
  AcListingController(this.id, this.customer_id);
  var isContainerVisible = true.obs;
  final int customer_id;


  initialProductListt() async {
    //Map body = customersListApiPayload;
    ApiResp resp = await ProductListServices.fetchProductList(customer_id);
    productList.value = ProductListModel.fromJson(resp.rdata).productList!;
    App.productLists = productList.value;
    //print(App.productLists.first.vehicleName);
    return productList;
  }


  Future<void> fetchNotifications() async {
    try {
      ApiResp? resp = await NotificationServices.fetchNotificationList(id);
      if (resp != null && resp.ok == true) {
        var notificationModel = NotificationModel.fromJson(resp.rdata);
        notifications.value = notificationModel.notification;

        // Get the previously seen notification count from SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        int seenCount = prefs.getInt('seenNotificationCount') ?? 0;

        // Calculate the number of unseen notifications
        int newUnseenCount = notifications
            .where((notification) => notification.status == '0')
            .length - seenCount;

        unseenNotificationCount.value = newUnseenCount < 0 ? 0 : newUnseenCount;
      } else {
        print("Error fetching notifications: ${resp.message}");
      }
    } catch (e) {
      print("Error fetching notifications: $e");
    }
  }

  Future<void> markNotificationsAsSeen() async {
    notifications.forEach((notification) {
      notification.status = '1'; // Mark all as seen
    });
    unseenNotificationCount.value = 0; // Reset the unseen count

    // Save the count of seen notifications in SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('seenNotificationCount', notifications.length);
  }
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
        print("Error: ${resp.message}");
      }
    } catch (e) {
      print("Error in initialVehicleListt: $e");
    }
  }

  @override
  Future<void> refresh() async {
    await fetchNotifications(); // Refresh notifications when refreshing the screen
    await initialAcListt(); // Also refresh your main data
  }

  @override
  void onInit() {
    super.onInit();
    fetchNotifications();
    initialAcListt();
    initialProductListt();
  }
}
