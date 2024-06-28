// import 'package:dio/dio.dart';
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:dio/dio.dart' as dio; // Import Dio's Response class with prefix 'dio'
//
// void main() async {
//   await GetStorage.init();
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       title: 'Customer Details App',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       home: CustomerView(),
//     );
//   }
// }
//
// class CustomerView extends StatelessWidget {
//   final CustomerController _customerController = Get.put(CustomerController());
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Customer Details'),
//       ),
//       body: Obx(
//             () => _customerController.customer.value.id != 0
//             ? Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text('Name: ${_customerController.customer.value.phone}'),
//             Text('Date of Birth: ${_customerController.customer.value.email}'),
//             SizedBox(height: 20),
//             Text('AMC Details:'),
//             Text('Code: ${_customerController.amc.value.endDate}'),
//             Text('Start Date: ${_customerController.amc.value.startDate}'),
//             Text('End Date: ${_customerController.amc.value.code}'),
//           ],
//         )
//             : CircularProgressIndicator(),
//       ),
//     );
//   }
// }
//
// class CustomerController extends GetxController {
//   final ApiService _apiService = ApiService();
//   final storage = GetStorage();
//
//   var customer = Customer(
//     id: 0,
//     name: '',
//     dob: '',
//     gender: '',
//     phone: '',
//     email: '',
//     profilePic: '',
//   ).obs;
//   var amc = AMC(
//     code: '',
//     startDate: '',
//     endDate: '',
//     packageName: '',
//     productCount: 0,
//     productCategory: '',
//   ).obs;
//
//   @override
//   void onInit() {
//     fetchCustomerData();
//     super.onInit();
//   }
//
//   void fetchCustomerData() async {
//     String? token = storage.read('token');
//
//     if (token != null) {
//       print('Token found: $token'); // Print token for debugging
//
//       try {
//         Map<String, dynamic> data = await _apiService.getCustomerData(42, token);
//         customer.value = Customer.fromJson(data['customer'][0]);
//         amc.value = AMC.fromJson(data['amc_details'][0]);
//       } catch (e) {
//         print('Exception while fetching customer data: $e');
//       }
//     } else {
//       print('Token is null');
//     }
//   }
// }
//
//
// class ApiService {
//   final Dio _dio = Dio();
//
//   Future<Map<String, dynamic>> getCustomerData(int id, String token) async {
//     try {
//       dio.Response response = await _dio.get(
//         'https://seowebsites.in/service_management/api/v1/get-customer/$id',
//         queryParameters: {'id': id},
//         options: Options(headers: {'Authorization': 'Bearer $token'}),
//       );
//
//       if (response.statusCode == 200) {
//         return response.data;
//       } else {
//         print('Request failed with status: ${response.statusCode}');
//         print('Response message: ${response.statusMessage}');
//         throw Exception('Failed to load customer data');
//       }
//     } catch (error) {
//       print('Error in API call: $error');
//       throw Exception('Failed to load customer data: $error');
//     }
//   }
// }
//
// class Customer {
//   final int id;
//   final String name;
//   final String dob;
//   final String gender;
//   final String phone;
//   final String email;
//   final String profilePic;
//
//   Customer({
//     required this.id,
//     required this.name,
//     required this.dob,
//     required this.gender,
//     required this.phone,
//     required this.email,
//     required this.profilePic,
//   });
//
//   factory Customer.fromJson(Map<String, dynamic> json) {
//     return Customer(
//       id: json['id'],
//       name: json['name'],
//       dob: json['dob'],
//       gender: json['gender'],
//       phone: json['phone'],
//       email: json['email'],
//       profilePic: json['profile_pic'],
//     );
//   }
// }
//
// class AMC {
//   final String code;
//   final String startDate;
//   final String endDate;
//   final String packageName;
//   final int productCount;
//   final String productCategory;
//
//   AMC({
//     required this.code,
//     required this.startDate,
//     required this.endDate,
//     required this.packageName,
//     required this.productCount,
//     required this.productCategory,
//   });
//
//   factory AMC.fromJson(Map<String, dynamic> json) {
//     return AMC(
//       code: json['code'],
//       startDate: json['start_date'],
//       endDate: json['end_date'],
//       packageName: json['package_name'],
//       productCount: json['product_count'],
//       productCategory: json['product_category'],
//     );
//   }
// }
