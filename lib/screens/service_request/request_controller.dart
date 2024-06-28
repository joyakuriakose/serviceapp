import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:intl/intl.dart';

import '../../model/api_resp.dart';
import '../../model/get_amclist_model.dart';
import '../../services/get_amclist_services.dart';
import '../../services/service_req_services.dart';

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
  List<String> servicetype = ['AMC', 'Non-AMC'];

  final TextEditingController serviceRequestController = TextEditingController();
  final TextEditingController demandsController = TextEditingController();
  final int id;

  RequestController(this.id);

  initialAcListt() async {
    try {
      ApiResp? resp = await AmcListServices.fetchAmcList(id);
      if (resp != null && resp.ok == true) {
        var packageListingModel = GetAmcList.fromJson(resp.rdata);
        amclist.value = packageListingModel.amcList;
        amcCodes.value = amclist.map((amc) => amc.code ?? '').toList();
      } else {
        print("Error: ${resp?.msgs?.first.msg}");
      }
    } catch (e) {
      print("Error in initialAcListt: $e");
    }
  }

  Future<void> submitServiceRequest() async {
    isScreenProgress.value = true;
    try {
      ApiResp resp;
      if (serviceRequestType.value == 'AMC') {
        resp = await ServiceRequestServices.fetchRequest(
          customerId: id,
          amcId: int.parse(serviceRequestController.text), // assuming amcId is provided as input
          amcType: serviceRequestType.value,
        );
      } else {
        resp = await ServiceRequestServices.fetchRequest(
          customerId: id,
          amcType: serviceRequestType.value,
          service_date: dateCtrl.text,
        );
      }
      isScreenProgress.value = false;

      if (resp.ok == true) {
        Get.snackbar("Success", "Service request submitted successfully");
      } else {
        Get.snackbar("Failed", resp.msgs?.first.msg);
      }
    } catch (e) {
      isScreenProgress.value = false;
      Get.snackbar("Error", "Failed to submit service request: $e");
    }
  }

  @override
  void onInit() {
    super.onInit();
    dateCtrl.text = DateFormat('dd-MM-yyyy').format(DateTime.now());
    initialAcListt(); // Call the method to fetch the AMC list
  }

  void selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      // Format the pickedDate to dd-MM-yyyy format
      String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);
      dateCtrl.text = formattedDate;
    }
  }
}
