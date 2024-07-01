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
  RxString selectedAmcCode = ''.obs;
  Map<String, int> amcCodeToIdMap = {}; // Map to store amc_code to amc_id
  List<String> servicetype = ['Select','AMC', 'Non-AMC'];

  final TextEditingController serviceRequestController = TextEditingController();
  final TextEditingController demandsController = TextEditingController();
  final int id;

  RequestController(this.id);

  @override
  void onInit() {
    super.onInit();
    dateCtrl.text = DateFormat('yyyy-MM-dd').format(DateTime.now());
    initialAcListt();

  }

  void initialAcListt() async {
    try {
      ApiResp? resp = await AmcListServices.fetchAmcList(id);
      if (resp != null && resp.ok == true) {
        var packageListingModel = GetAmcList.fromJson(resp.rdata);
        amclist.value = packageListingModel.amcList;
        amcCodes.value = amclist.map((amc) {
          if (amc.code != null && amc.id != null) {
            amcCodeToIdMap[amc.code!] = amc.id!;
          }
          return amc.code ?? '';
        }).toList();
      } else {
        print("Error: ${resp?.msgs?.first.msg}");
      }
    } catch (e) {
      print("Error in initialAcListt: $e");
    }
  }

  void selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
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
      ApiResp resp;
      if (serviceRequestType.value == 'AMC') {
        if (selectedAmcCode.value.isEmpty) {
          Get.snackbar("Error", "Please select an AMC code");
          isScreenProgress.value = false;
          return;
        }
        int amcId = amcCodeToIdMap[selectedAmcCode.value]!;
        resp = await ServiceRequestServices.fetchUser(
          customer_id: id,
          amc_id: amcId,
          amc_type: 0,
          demand: demandsController.text,
        );
      } else {
        resp = await ServiceRequestServices.fetchUser(
          customer_id: id,
          amc_type: 1,
          demand: demandsController.text,
          service_date: dateCtrl.text,
        );
      }
      isScreenProgress.value = false;

      if (resp.ok == true) {
        Get.snackbar("Success", "Service request submitted successfully",
          backgroundColor: Colors.green,);
        clearFields();
      } else {
        Get.snackbar("Failed", resp.msgs?.first.msg ?? 'Unknown error',
          backgroundColor: Colors.red,);
      }
    } catch (e) {
      isScreenProgress.value = false;
      if (e is DioError && e.response?.statusCode == 401) {
        // Call the error API to get the error message
        final errorMessage = await getErrorMessage(e.response?.data);
        Get.snackbar("Error", errorMessage,
          backgroundColor: Colors.red,);
      } else if (e is DioError) {
        // Call the error API to get the error message for other Dio errors
        final errorMessage = await getErrorMessage(e.response?.data);
        Get.snackbar("Error", errorMessage,
          backgroundColor: Colors.red,);
      }
      else {
        // Handle other types of errors
        Get.snackbar("Error", "AMC Services already is on",
          backgroundColor: Colors.red,);
      }
    }
  }

// Method to get the error message from the error API
  Future<String> getErrorMessage(dynamic responseData) async {
    try {
      // Parse the response data
      final requestError = requestErrorFromJson(json.encode(responseData));
      return requestError.error;
    } catch (e) {
      return 'Unknown error occurred';
    }
  }

// Method to clear all fields after successful submission
  void clearFields() {
    selectedAmcCode.value = '';
    demandsController.clear();
    dateCtrl.clear();
    serviceRequestType.value = '';
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
}




