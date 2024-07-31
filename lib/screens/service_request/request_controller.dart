import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:intl/intl.dart';
import 'package:serviceapp/utils/mydio.dart';
import 'package:serviceapp/utils/routes.dart';

import '../../model/api_resp.dart';
import '../../model/get_amclist_model.dart';
import '../../model/request_error_model.dart';
import '../../model/request_model.dart';
import '../../services/get_amclist_services.dart';
import '../../services/service_req_services.dart';
import '../../utils/my_utils.dart';

// class RequestController extends GetxController {
//   RxList<AmcList> amclist = <AmcList>[].obs;
//   RxList<String> amcCodes = <String>[].obs;
//   RxBool isScreenProgress = true.obs;
//
//   RxString serviceRequestType = 'Service Type '.obs;
//   List<String> servicetype = ['AMC', 'Non-AMC'].obs;
//
//   final TextEditingController serviceRequestController = TextEditingController();
//   //final TextEditingController dateCtrl = TextEditingController(text: '');
//  // final FocusNode dateCtrlfNode = FocusNode();
//   final demandsController = TextEditingController();
//   final int id;
//
//   RequestController(this.id);
//   // final int customer_id;
//   //
//   // RequestController(this.customer_id);
//
//   initialAcListt() async {
//     try {
//       ApiResp? resp = await AmcListServices.fetchAmcList(id);
//       if (resp != null && resp.ok == true) {
//         var packageListingModel = GetAmcList.fromJson(resp.rdata);
//         amclist.value = packageListingModel.amcList;
//
//         // Extract codes from amclist and update amcCodes
//         amcCodes.value = amclist.map((amc) => amc.code ?? '').toList();
//
//         if (amclist.isNotEmpty) {
//           amclist.forEach((amc) => print(amc.code));
//         } else {
//           print("No AMC details found.");
//         }
//       } else {
//         print("Error: ${resp?.msgs?.first.msg}");
//       }
//     } catch (e) {
//       print("Error in initialVehicleListt: $e");
//     }
//   }
//
//   Future<void> submitServiceRequest() async {
//     isScreenProgress.value = true;
//     try {
//       ApiResp resp = await ServiceRequestServices.fetchRequest(
//         customerId: id,
//         amcId: int.parse(serviceRequestController.text), // assuming amcId is provided as input
//         amcType: serviceRequestType.value,
//         demand: demandsController.text,
//       );
//       isScreenProgress.value = false;
//
//       if (resp.ok) {
//         Get.snackbar("Success", "Service request submitted successfully");
//       } else {
//         Get.snackbar("Failed", resp.msgs.first.msg);
//       }
//     } catch (e) {
//       isScreenProgress.value = false;
//       Get.snackbar("Error", "Failed to submit service request: $e");
//     }
//   }
//
//
//   @override
//   void onInit() {
//     super.onInit();
//     // Set the initial value of dateCtrl to the current date
//   //  dateCtrl.text = DateFormat('dd-MM-yyyy').format(DateTime.now());
//   }
//
//   // void selectDate(BuildContext context) async {
//   //   final DateTime? pickedDate = await showDatePicker(
//   //     context: context,
//   //     initialDate: DateTime.now(),
//   //     firstDate: DateTime(2020),
//   //     lastDate: DateTime(2101),
//   //   );
//   //
//   //   if (pickedDate != null) {
//   //     // Format the pickedDate to yyyy-MM-dd format
//   //     String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);
//   //     dateCtrl.text = formattedDate;
//   //   }
//   // }
// }
class RequestController extends GetxController {
  RxList<AmcList> amclist = <AmcList>[].obs;
  RxList<String> amcCodes = <String>[].obs;
  RxBool isScreenProgress = true.obs;
  final TextEditingController dateCtrl = TextEditingController(text: '');
  final FocusNode dateCtrlfNode = FocusNode();
  RxString serviceRequestType = 'Service Type '.obs;
  RxString serviceExecutiveType = 'Select'.obs; // Ensure initial value is one from the list
  RxString selectedAmcCode = ''.obs;
  Map<String, int> amcCodeToIdMap = {}; // Map to store amc_code to amc_id
  List<String> servicetype = ['Select', 'AMC', 'Non-AMC'];
  List<String> executivetype = ['Select', 'Technician', 'Service Man'];
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController serviceRequestController = TextEditingController();
  final TextEditingController serviceExecutiveController = TextEditingController();
  final TextEditingController demandsController = TextEditingController();
  final TextEditingController countController = TextEditingController();
  final int id;
  final int active;

  RequestController(this.id, this.active);

  @override
  void onInit() {
    super.onInit();
    dateCtrl.text = DateFormat('yyyy-MM-dd').format(DateTime.now());
    initialAcListt();
  }

  void initialAcListt() async {
    try {
      ApiResp? resp = await AmcListServices.fetchAmcList(id, active);
      if (resp != null && resp.ok == true) {
        var packageListingModel = GetAmcList.fromJson(resp.rdata);
        amclist.value = packageListingModel.amcList!;
        amcCodes.value = amclist.map((amc) {
          if (amc.code != null && amc.id != null) {
            amcCodeToIdMap[amc.code!] = amc.id!;
          }
          return amc.code ?? '';
        }).toList();
      } else {
        print("Error: ${resp.message}");
      }
    } catch (e) {
      print("Error in initialAcListt: $e");
    }
  }

  void selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(), // Restrict to today and future dates
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      dateCtrl.text = formattedDate;
    }
  }

  Future<void> submitServiceRequest() async {
    isScreenProgress.value = true;

    try {
      if (serviceRequestType.value == 'Service Type ') {
        Get.snackbar(
          "Error",
          "Please select a service request type",
          backgroundColor: Colors.red,
          snackPosition: SnackPosition.TOP,
          duration: Duration(seconds: 3),
        );
        isScreenProgress.value = false;
        return;
      }

      if (serviceRequestType.value == 'AMC' && selectedAmcCode.value.isEmpty) {
        Get.snackbar(
          "Error",
          "Please select an AMC code",
          backgroundColor: Colors.red,
          snackPosition: SnackPosition.TOP,
          duration: Duration(seconds: 3),
        );
        isScreenProgress.value = false;
        return;
      }

      if (serviceExecutiveType.value.isEmpty) {
        Get.snackbar(
          "Error",
          "Please select a service executive type",
          backgroundColor: Colors.red,
          snackPosition: SnackPosition.TOP,
          duration: Duration(seconds: 3),
        );
        isScreenProgress.value = false;
        return;
      }
      //int? productCount;

      ApiResp resp;

      String executiveType = serviceExecutiveType.value == 'Technician' ? '2' : '1';
      if (serviceRequestType.value == 'AMC') {
        int amcId = amcCodeToIdMap[selectedAmcCode.value]!;
        resp = await ServiceRequestServices.fetchUser(
          customer_id: id,
          amc_id: amcId,
          amc_type: 0,
          service_executive_type: executiveType, // Pass as String
          demand: demandsController.text,
        );
      } else {
        resp = await ServiceRequestServices.fetchUser(
          customer_id: id,
          amc_type: 1,
          demand: demandsController.text,
          service_executive_type: executiveType, // Pass as String
          product_count: countController.text,
          service_date: dateCtrl.text,
        );
      }
      isScreenProgress.value = false;

      print("Response: ${resp.toJson()}");

      if (resp.ok == true) {
        String successMessage = resp.message ?? "Success";
        String additionalMessage = resp.rdata != null ? resp.rdata['message'] ?? "" : "";
        String finalMessage = "$successMessage $additionalMessage".trim();

        print("Success Message: $finalMessage");

        Get.snackbar(
          "Success",
          finalMessage,
          backgroundColor: Colors.white,
          snackPosition: SnackPosition.TOP,
          duration: Duration(seconds: 3),
        );
        clearFields();
      } else {
        String errorMessage = resp.message ?? "Unknown error";
        String additionalMessage = resp.rdata != null ? resp.rdata['message'] ?? "" : "";
        String finalMessage = "$errorMessage $additionalMessage".trim();
        print("Error Message: $errorMessage");
        Get.snackbar(
          "Failed",
          errorMessage,
          backgroundColor: Colors.red,
          snackPosition: SnackPosition.TOP,
          duration: Duration(seconds: 3),
        );
      }
    } catch (e) {
      isScreenProgress.value = false;
      String errorMessage = '';
      if (e is DioError && e.response?.statusCode == 401) {
        errorMessage = await getErrorMessage(e.response?.data);
      } else if (e is DioError) {
        errorMessage = await getErrorMessage(e.response?.data);
      } else {
        errorMessage = "AMC completed";
      }
      print("Catch Error Message: $errorMessage");
      Get.snackbar(
        "Error",
        errorMessage,
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.TOP,
        duration: Duration(seconds: 3),
      );
    }
  }


  Future<String> getErrorMessage(dynamic responseData) async {
    try {
      final requestError = requestErrorFromJson(json.encode(responseData));
      return requestError.error;
    } catch (e) {
      return 'Unknown error occurred';
    }
  }

  void clearFields() {
    selectedAmcCode.value = '';
    demandsController.clear();
    dateCtrl.clear();
    serviceRequestType.value = '';
    serviceExecutiveType.value = '';
    countController.clear();
  }
}



  // Future<void> submitServiceRequest() async {
  //   isScreenProgress.value = true;
  //   try {
  //     ApiResp resp;
  //     if (serviceRequestType.value == 'AMC') {
  //       if (selectedAmcCode.value.isEmpty) {
  //         Get.snackbar("Error", "Please select an AMC code");
  //         isScreenProgress.value = false;
  //         return;
  //       }
  //       int amcId = amcCodeToIdMap[selectedAmcCode.value]!;
  //       resp = await ServiceRequestServices.fetchUser(
  //         customer_id: id,
  //         amc_id: amcId,
  //         amc_type: 0,
  //         demand: demandsController.text,
  //       );
  //     } else {
  //       resp = await ServiceRequestServices.fetchUser(
  //         customer_id: id,
  //         amc_type: 1,
  //         demand: demandsController.text,
  //         service_date: dateCtrl.text,
  //       );
  //     }
  //     isScreenProgress.value = false;
  //
  //     if (resp.ok == true) {
  //       Get.snackbar("Success", "Service request submitted successfully",
  //         backgroundColor: Colors.green,);
  //     } else {
  //       Get.snackbar("Failed", resp.msgs?.first.msg ?? 'Unknown error',
  //         backgroundColor: Colors.red,);
  //     }
  //   } catch (e) {
  //     isScreenProgress.value = false;
  //     Get.snackbar("Error", "Failed to submit service request: $e",
  //       backgroundColor: Colors.red,);
  //   }
  // }





