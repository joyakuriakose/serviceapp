// To parse this JSON data, do
//
//     final packageListingModel = packageListingModelFromJson(jsonString);

import 'dart:convert';

PackageListingModel packageListingModelFromJson(String str) => PackageListingModel.fromJson(json.decode(str));

String packageListingModelToJson(PackageListingModel data) => json.encode(data.toJson());

class PackageListingModel {
  String message;
  List<Customer> customer;
  List<AmcDetail> amcDetails;

  PackageListingModel({
    required this.message,
    required this.customer,
    required this.amcDetails,
  });

  factory PackageListingModel.fromJson(Map<String, dynamic> json) => PackageListingModel(
    message: json["message"],
    customer: List<Customer>.from(json["customer"].map((x) => Customer.fromJson(x))),
    amcDetails: List<AmcDetail>.from(json["amc_details"].map((x) => AmcDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "customer": List<dynamic>.from(customer.map((x) => x.toJson())),
    "amc_details": List<dynamic>.from(amcDetails.map((x) => x.toJson())),
  };
}

class AmcDetail {
  int? amcId;
  String? code;
  DateTime? startDate;
  DateTime? endDate;
  String? packageName;
  int? productCount;
  String? productCategory;

  AmcDetail({
    this.amcId,
    this.code,
    this.startDate,
    this.endDate,
    this.packageName,
    this.productCount,
    this.productCategory,
  });

  factory AmcDetail.fromJson(Map<String, dynamic> json) => AmcDetail(
    amcId: json["amc_id"],
    code: json["code"],
  //  startDate: DateTime.parse(json["start_date"]),
    startDate: json["start_date"] != null
        ? DateTime.parse(json["start_date"])
        : null,
   // endDate: DateTime.parse(json["end_date"]),
    endDate: json["end_date"] != null
        ? DateTime.parse(json["end_date"])
        : null,
    packageName: json["package_name"],
    productCount: json["product_count"],
    productCategory: json["product_category"],
  );

  Map<String, dynamic> toJson() => {
    "amc_id": amcId,
    "code": code,
   // "start_date": "${startDate!.year.toString().padLeft(4, '0')}-${startDate!.month.toString().padLeft(2, '0')}-${startDate!.day.toString().padLeft(2, '0')}",
    "start_date": startDate != null
        ? startDate!.toIso8601String()
        : null,
   // "end_date": "${endDate!.year.toString().padLeft(4, '0')}-${endDate!.month.toString().padLeft(2, '0')}-${endDate!.day.toString().padLeft(2, '0')}",
    "end_date": endDate != null
        ? endDate!.toIso8601String()
        : null,
    "package_name": packageName,
    "product_count": productCount,
    "product_category": productCategory,
  };
}

class Customer {
  int? id;
  String? name;
  DateTime? dob;
  String? gender;
  String? phone;
  String? email;
  String? profilePic;

  Customer({
    this.id,
    this.name,
    this.dob,
    this.gender,
    this.phone,
    this.email,
    this.profilePic,
  });

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
    id: json["id"],
    name: json["name"],
    dob: DateTime.parse(json["dob"]),
    gender: json["gender"],
    phone: json["phone"],
    email: json["email"],
    profilePic: json["profile_pic"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "dob": "${dob!.year.toString().padLeft(4, '0')}-${dob!.month.toString().padLeft(2, '0')}-${dob!.day.toString().padLeft(2, '0')}",
    "gender": gender,
    "phone": phone,
    "email": email,
    "profile_pic": profilePic,
  };
}
